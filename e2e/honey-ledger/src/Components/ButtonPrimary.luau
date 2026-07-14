-- button-primary from DESIGN.roblox.md (Honey Ledger): flat green strip,
-- white stroked label, sharp corners, NO bevel -- "feels like a stamp, not a
-- candy button." Often mounted centered inside a blue window-info frame
-- flanked by pager arrows (see Shop/Dialog stories). Motion: no squash in
-- this taste; press feedback is a brief fill darken at durations.instant
-- (Theme.derived.primaryPressed), released with settle. Pressed/disabled
-- states were not observed in the source shots -- disabled desaturates the
-- fill one step (inferred, matches the toggle-disabled convention).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local PRESS_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local PRESS_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ButtonPrimary(props)
	local fillRef = React.useRef(nil)
	local disabled = props.disabled or false

	local restColor = if disabled then Theme.derived.toggleOnDisabled else Theme.colors.primary
	local pressColor = if disabled then Theme.derived.toggleOnDisabled else Theme.derived.primaryPressed

	local function tweenTo(color, info)
		local fill = fillRef.current
		if fill then
			TweenService:Create(fill, info, { BackgroundColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = restColor,
		Size = props.size or UDim2.fromOffset(230, 44), -- ~5:1 aspect at reference
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not disabled then
				tweenTo(pressColor, PRESS_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			if not disabled then
				tweenTo(restColor, PRESS_OUT)
			end
		end,
		[React.Event.MouseLeave] = function()
			if not disabled then
				tweenTo(restColor, PRESS_OUT)
			end
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		-- rounded.none -- sharp corners, no UICorner instance needed.
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = props.text or "Craft",
			FontFace = Theme.typography.label.font,
			TextScaled = true,
			TextColor3 = Theme.colors.white,
			ZIndex = (props.zIndex or 1) + 1,
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
			}),
		}),
	})
end

return ButtonPrimary
