-- button-primary / button-secondary / button-buy / button-cta from
-- DESIGN.roblox.md (Loud Slab): flat color slab, white outlined label, no
-- bevel/gradient/shadow. "Pressed state not observed -- implementers use the
-- motion squash, not a color shift." Squash is the ONLY press affordance.
--
-- Variants (component-level tokens):
--   primary   -- green slab, rounded.sm, Title Case label.
--   secondary -- light-gray slab, rounded.none, Title Case label
--               ("Regenerate"-class utilities).
--   buy       -- green slab, rounded.sm, wide pill spanning most of its card;
--               leading white currency glyph then the price ("price sticker").
--   cta       -- mustard slab, rounded.none, heading-tier text, ~0.35 window
--               width, one per window at most (footer commitment).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local VARIANTS = {
	primary = { fill = Theme.colors.primary, rounded = Theme.rounded.sm, typography = Theme.typography.label },
	secondary = { fill = Theme.colors.secondary, rounded = Theme.rounded.none, typography = Theme.typography.label },
	buy = { fill = Theme.colors.primary, rounded = Theme.rounded.sm, typography = Theme.typography.label },
	cta = { fill = Theme.colors.cta, rounded = Theme.rounded.none, typography = Theme.typography.heading },
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

local function ButtonPrimary(props)
	local scaleRef = React.useRef(nil)
	local variant = VARIANTS[props.variant or "primary"]
	local disabled = props.disabled

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local text = props.text or "Button"
	if variant.typography == Theme.typography.heading then
		text = string.upper(text)
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = variant.fill,
		BackgroundTransparency = disabled and 0.4 or 0,
		Size = props.size or UDim2.fromOffset(220, 56), -- >= 44px tap target (chunky-adjacent taste: prefers 56px+)
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not disabled then
				squash(0.92, SQUASH_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = variant.rounded }),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.xs),
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
		}),
		-- buy variant: leading white currency glyph before the price ("price sticker").
		CurrencyGlyph = (props.variant == "buy") and e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = "$",
			FontFace = variant.typography.font,
			TextSize = variant.typography.textSize,
			TextColor3 = Theme.colors.onSurface, -- component-level token: button-buy.textColor is "#FFFFFF" == colors.on-surface
			LayoutOrder = 1,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}) or nil,
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = text,
			FontFace = variant.typography.font,
			TextSize = variant.typography.textSize,
			TextColor3 = Theme.colors.onSurface, -- component-level token: every button variant's textColor is "#FFFFFF" == colors.on-surface
			LayoutOrder = 2,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
	})
end

return ButtonPrimary
