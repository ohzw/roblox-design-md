-- button-primary from DESIGN.roblox.md (Candlelit Parlor): the lobby "play"
-- strip — the ONLY large cream-filled surface in the taste (one per screen,
-- maximum). Dark chocolate condensed-caps Oswald label with an optional
-- leading glyph. Strokeless, shadowless, 12px corners, ~5:1 strip.
-- Press feedback (Motion prose): a brightness lift, never a squash/bounce.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local LIFT_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local LIFT_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ParlorButton(props)
	local rootRef = React.useRef(nil)

	-- Brightness lift via TweenService on the Instance; the rendered
	-- BackgroundColor3 prop never changes between renders, so React does not
	-- fight the tween (frozen-value pattern).
	local function lift(color, info)
		local rbx = rootRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	local disabled = props.disabled
	local labelText = props.text or "Play"
	if Theme.typography.cta.uppercase then
		labelText = string.upper(labelText)
	end
	if props.icon then
		labelText = props.icon .. "  " .. labelText
	end

	return e("TextButton", {
		ref = rootRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.primary,
		BackgroundTransparency = if disabled then Theme.derived.disabledTransparency else 0,
		Size = props.size or UDim2.fromOffset(340, 68),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not disabled then
				lift(Theme.derived.primaryPressed, LIFT_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			lift(Theme.colors.primary, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(Theme.colors.primary, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		-- aspectRatio: 5 (front matter) — keeps the wide-strip silhouette
		Aspect = e("UIAspectRatioConstraint", { AspectRatio = 5 }),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = labelText,
			FontFace = Theme.typography.cta.font,
			TextScaled = true, -- cta scales within its container (Typography prose)
			TextColor3 = Theme.inks.onPrimary,
			TextTransparency = if disabled then Theme.derived.disabledTransparency else 0,
			ZIndex = 2,
		}, {
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.cta.textSize }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.md),
				PaddingRight = UDim.new(0, Theme.spacing.md),
				PaddingTop = UDim.new(0, Theme.spacing.sm),
				PaddingBottom = UDim.new(0, Theme.spacing.sm),
			}),
		}),
	})
end

return ParlorButton
