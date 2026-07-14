-- button-primary / button-primary-disabled from DESIGN.roblox.md (Frosted
-- Baseplate): flat green rounded rect ("Redeem", "Claim", "Spin"), white
-- outlined label (Components prose). Disabled/claimed state goes flat gray
-- `#A2A2A2` and KEEPS its label (observed on claimed reward cards) -- unlike
-- a beveled taste, there is no bevel to preserve here; disabled is purely a
-- fill swap. rounded.md, aspectRatio 2.8. This is the taste's dominant CTA
-- voice (standard-showcase.md "button-primary" slot) -- used for the HUD's
-- PLAY action and the Dialog's CONFIRM button.
--
-- Press feedback: flat-fill component, no bevel token in this taste, so press
-- reads as squash + brightness lift (Motion prose: pressed frame not
-- captured, inferred from taste family; same pattern as SideButton/
-- CloseCross/TogglePill elsewhere in this slice).

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

local function Button(props)
	local scaleRef = React.useRef(nil)
	local fillRef = React.useRef(nil)

	local fill = if props.disabled then Theme.inks.disabledFill else Theme.colors.primary
	-- Disabled keeps a flat lift target equal to its own fill (no-op tween):
	-- disabled buttons do not participate in press feedback.
	local pressedFill = if props.disabled then fill else Theme.derived.primaryPressed

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local function lift(color, info)
		local rbx = fillRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = fill,
		Size = props.size or UDim2.fromOffset(220, 220 / Theme.metrics.buttonPrimaryAspect),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not props.disabled then
				squash(0.93, SQUASH_IN)
				lift(pressedFill, SQUASH_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
			lift(fill, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
			lift(fill, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if not props.disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Aspect = if not props.size then e("UIAspectRatioConstraint", { AspectRatio = Theme.metrics.buttonPrimaryAspect }) else nil,
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = props.text or "Play", -- Title Case per Typography prose, never ALL CAPS
			FontFace = Theme.typography.label.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
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

return Button
