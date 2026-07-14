-- button-close from DESIGN.roblox.md: "a brick-red square docked INSIDE the
-- right end of the header band, matching its height, never overlapping a
-- corner." Square, 0 radius, no stroke, no bevel -- "the only red chrome."
-- Pressed state not observed: implementers use the motion squash (UIScale),
-- never a color shift (Do's-and-Don'ts + Components prose).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local SQUASH_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local SQUASH_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ButtonClose(props)
	local scaleRef = React.useRef(nil)

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.danger,
		Size = props.size or UDim2.fromOffset(56, 56), -- matches window-header height at reference; >= 44px tap target
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			squash(0.92, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "X",
			FontFace = Theme.typography.heading.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface, -- component-level token (button-close.textColor: "#FFFFFF" == colors.on-surface)
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.sm),
				PaddingRight = UDim.new(0, Theme.spacing.sm),
				PaddingTop = UDim.new(0, Theme.spacing.sm),
				PaddingBottom = UDim.new(0, Theme.spacing.sm),
			}),
		}),
	})
end

return ButtonClose
