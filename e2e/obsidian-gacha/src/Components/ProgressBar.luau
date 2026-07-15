-- progress-bar from DESIGN.roblox.md: "full-rounded dark track (~14px) with a
-- primary horizontal-gradient fill; used for achievement completion." Fill
-- tweens with settle easing on value change, never snaps (Motion prose:
-- "Progress fills: tween the fill's Size"). Driven through a useBinding + a
-- tweened NumberValue so high-frequency updates don't storm re-renders
-- (motion-implementation.md).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local FILL_TWEEN = TweenInfo.new(
	Theme.motion.durations.normal,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function clamp01(n)
	return math.clamp(n or 0, 0, 1)
end

local function ProgressBar(props)
	local fillScale, setFillScale = React.useBinding(clamp01(props.value))

	React.useEffect(function()
		local target = clamp01(props.value)
		local nv = Instance.new("NumberValue")
		nv.Value = fillScale:getValue()
		local conn = nv.Changed:Connect(function(v)
			setFillScale(v)
		end)
		local tween = TweenService:Create(nv, FILL_TWEEN, { Value = target })
		tween:Play()
		return function()
			conn:Disconnect()
			tween:Cancel()
			nv:Destroy()
		end
	end, { props.value })

	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDeep,
		Size = props.size or UDim2.new(1, 0, 0, 14),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.panel.thickness,
			Color = Theme.strokes.panel.color,
			ApplyStrokeMode = Theme.strokes.panel.mode,
		}),
		Clip = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = true,
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			Fill = e("Frame", {
				-- white base: fill color comes from the UIGradient (multiplies).
				BackgroundColor3 = Theme.white,
				Size = fillScale:map(function(v)
					return UDim2.new(v, 0, 1, 0)
				end),
				ZIndex = (props.zIndex or 1) + 1,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Gradient = e("UIGradient", {
					Color = ColorSequence.new(Theme.gradients.progress.from, Theme.gradients.progress.to),
					Rotation = 0,
				}),
			}),
		}),
	})
end

return ProgressBar
