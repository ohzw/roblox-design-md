-- button-primary / button-secondary / button-buy from DESIGN.roblox.md: one
-- anatomy, three variants (component-level tokens only differ in gradient
-- colors, stroke, and aspect -- generation-procedure.md's "one component with
-- a variant prop beats near-duplicate modules" rule). Anatomy: squared slab,
-- vertical two-tone gradient (bright stop on top), stud emboss, white
-- outlined label, no bevel (Elevation prose: "there are no drop shadows and
-- no bevels anywhere" -- unlike cartoon-chunky, THIS taste's press feedback
-- is squash-only).
--
-- button-primary: green go-slab (Enter/Spin/Equip), outline stroke.
-- button-secondary: cyan robux-tier sibling, rim-light stroke instead of ink
--   (Elevation #1: "Gradient slab buttons on dark backgrounds instead take
--   {strokes.rim-light}"). The "Buy 5" tier reuses this anatomy in
--   accent-rare magenta (Colors prose) -- variant "tierRare".
-- button-buy: purple price pill, icon chip left + amount right, rounded.md
--   (not rounded.sm like the other two), always inside a row/card.
--
-- hero variant (oversized full-width Equip slab, Components prose): shifts
-- the top gradient stop toward lime and steps up to rounded.lg.
--
-- Motion (Motion section, press feedback): squash to 0.94 at durations.instant
-- while held, restore with settle. No bevel to collapse -- squash carries all
-- the feedback (see also Do's and Don'ts / Elevation: no bevels anywhere).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local StudField = require(script.Parent.StudField)

local e = React.createElement

local VARIANTS = {
	primary = {
		gradient = Theme.gradients.buttonPrimary,
		stroke = Theme.strokes.outline,
		rounded = Theme.rounded.sm,
		aspect = Theme.metrics.buttonPrimaryAspect,
		pressedTint = Theme.derived.primaryPressed,
	},
	primaryHero = {
		gradient = Theme.gradients.buttonPrimaryHero,
		stroke = Theme.strokes.outline,
		rounded = Theme.rounded.lg, -- Components prose: hero steps up to rounded.lg
		aspect = Theme.metrics.buttonPrimaryAspect,
		pressedTint = Theme.derived.primaryPressed,
	},
	secondary = {
		gradient = Theme.gradients.buttonSecondary,
		stroke = Theme.strokes.rimLight, -- Elevation #1: rim-light on gradient slabs over dark ground
		rounded = Theme.rounded.sm,
		aspect = Theme.metrics.buttonSecondaryAspect,
		pressedTint = Theme.derived.secondaryPressed,
	},
	tierRare = {
		gradient = Theme.gradients.buttonTierRare,
		stroke = Theme.strokes.rimLight,
		rounded = Theme.rounded.sm,
		aspect = Theme.metrics.buttonSecondaryAspect,
		pressedTint = Theme.derived.tierRarePressed,
	},
	buy = {
		gradient = Theme.gradients.buttonBuy,
		stroke = Theme.strokes.outline,
		rounded = Theme.rounded.md, -- button-buy token: rounded.md (not .sm like its siblings)
		aspect = Theme.metrics.buttonBuyAspect,
		pressedTint = Theme.derived.buyPressed,
	},
}

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

local function GradientButton(props)
	local scaleRef = React.useRef(nil)
	local fillRef = React.useRef(nil)

	local variant = VARIANTS[props.variant or "primary"]

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local function liftFill(toPressed)
		-- Color-only press lift is safe to tween directly (props never drive
		-- BackgroundColor3 here) -- motion-implementation.md.
		local fill = fillRef.current
		if fill and not props.disabled then
			local target = toPressed and variant.pressedTint or variant.gradient[1]
			TweenService:Create(fill, if toPressed then SQUASH_IN else SQUASH_OUT, { BackgroundColor3 = target }):Play()
		end
	end

	local topColor = if props.disabled then Theme.derived.disabledFill else variant.gradient[1]
	local bottomColor = if props.disabled then Theme.derived.disabledGradientBottom else variant.gradient[2]

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = topColor,
		Size = props.size or UDim2.fromOffset(220, 220 / variant.aspect),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not props.disabled then
				squash(0.94, SQUASH_IN)
				liftFill(true)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
			liftFill(false)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
			liftFill(false)
		end,
		[React.Event.Activated] = function()
			if not props.disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = variant.rounded }),
		Stroke = e("UIStroke", {
			Thickness = variant.stroke.thickness,
			Color = variant.stroke.color,
			ApplyStrokeMode = variant.stroke.mode,
		}),
		Fill = e("Frame", {
			ref = fillRef,
			BackgroundColor3 = topColor,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = variant.rounded }),
			Gradient = e("UIGradient", {
				Color = ColorSequence.new(topColor, bottomColor),
				Rotation = 90,
			}),
			Emboss = e(StudField, { zIndex = 3 }),
		}),
		Content = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 4,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.sm),
			}),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.md),
				PaddingRight = UDim.new(0, Theme.spacing.md),
			}),
			Icon = props.icon and e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon,
				ImageColor3 = Theme.colors.onSurface,
				Size = UDim2.fromOffset(28, 28),
				LayoutOrder = 1,
			}) or nil,
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 1, 0),
				Text = props.text or "Button",
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				LayoutOrder = 2,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
			}),
		}),
	})
end

return GradientButton
