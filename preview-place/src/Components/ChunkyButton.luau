-- button-primary / button-secondary from DESIGN.roblox.md.
-- Anatomy: root (bevel color) > Face (fill, sits 5px short of the bottom) > Label.
-- Pressing stretches the Face over the bevel: the button visually depresses.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement
local BEVEL = 5

local VARIANTS = {
	primary = { fill = Theme.colors.primary, bevel = Theme.bevels.primary },
	secondary = { fill = Theme.colors.secondary, bevel = Theme.bevels.secondary },
}

-- Press squash (DESIGN.md Motion): 0.92 at durations.instant, restore with settle.
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

local function ChunkyButton(props)
	local pressed, setPressed = React.useState(false)
	local scaleRef = React.useRef(nil)

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local variant = VARIANTS[props.variant or "primary"]
	local fill = variant.fill
	local bevel = variant.bevel
	if props.disabled then
		-- Disabled desaturates fill AND bevel; never drop the bevel (reads as pressed)
		fill = Theme.disabledFill
		bevel = Theme.bevels.disabled
	end
	local depressed = pressed and not props.disabled

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = bevel,
		Size = props.size or UDim2.fromOffset(220, 68),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
			if not props.disabled then
				squash(0.92, SQUASH_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if not props.disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = fill,
			Size = if depressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = string.upper(props.text or "BUTTON"),
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.white,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.md),
					PaddingRight = UDim.new(0, Theme.spacing.md),
					PaddingTop = UDim.new(0, Theme.spacing.sm),
					PaddingBottom = UDim.new(0, Theme.spacing.sm),
				}),
			}),
		}),
	})
end

return ChunkyButton
