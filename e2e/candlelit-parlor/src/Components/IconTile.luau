-- button-icon from DESIGN.roblox.md (Candlelit Parlor): square launcher tile —
-- 80%-opaque dark fill, cream glyph, 2px cream stroke, 20px corners ("dark
-- keys on a key rack"). A labeled variant (props.text) widens to ~2.4:1 with
-- icon + condensed-caps Oswald label; props.featured deepens the fill to
-- near-black #000000CC (observed on the store tile). No shadow, no bevel.
-- Press feedback: brightness lift toward cream candlelight, never a squash.
-- Icon slot accepts a real image asset (props.image, a Theme.assets.* id,
-- asset-sourcing.md) tinted candle-cream via ImageColor3 — the taste's "one
-- ink" rule applied to imagery, not just text/strokes. props.icon (a text
-- glyph) remains supported as a fallback for callers without an image slot.
-- A badge-slot count tag (props.badge) may overlap the tile's top-right
-- corner: dark fill, bright cream stroke, cream numeral (Components prose).

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

local function IconTile(props)
	local rootRef = React.useRef(nil)

	local fill = if props.featured then Theme.featuredLauncher.color else Theme.colors.surfaceDark
	local fillTransparency = if props.featured
		then Theme.featuredLauncher.transparency
		else Theme.surfaceDarkTransparency
	local pressedFill = if props.featured then Theme.derived.featuredPressed else Theme.derived.surfaceDarkPressed
	local disabled = props.disabled

	local function lift(color, info)
		local rbx = rootRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	local labeled = props.text ~= nil
	local labelText = props.text
	if labeled and Theme.typography.cta.uppercase then
		labelText = string.upper(labelText)
	end

	-- Icon glyph slot: a real image asset (tinted candle-cream via
	-- ImageColor3) when props.image is supplied, else the text-glyph fallback.
	local function iconElement(size, layoutOrder)
		if props.image then
			return e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.image,
				ImageColor3 = Theme.colors.primary,
				ImageTransparency = if disabled then Theme.derived.disabledTransparency else 0,
				ScaleType = Enum.ScaleType.Fit,
				Size = size,
				LayoutOrder = layoutOrder,
				ZIndex = 2,
			})
		end
		return e("TextLabel", {
			BackgroundTransparency = 1,
			Size = size,
			Text = props.icon or "\u{25C6}",
			FontFace = Theme.typography.cta.font,
			TextScaled = true,
			TextColor3 = Theme.colors.primary,
			TextTransparency = if disabled then Theme.derived.disabledTransparency else 0,
			LayoutOrder = layoutOrder,
			ZIndex = 2,
		})
	end

	local content
	if labeled then
		content = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.sm),
			}),
			Icon = iconElement(UDim2.fromScale(0.28, 0.55), 1),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(0.55, 0.62),
				Text = labelText,
				FontFace = Theme.typography.cta.font,
				TextScaled = true, -- cta scales within its container
				TextColor3 = Theme.colors.primary,
				TextTransparency = if disabled then Theme.derived.disabledTransparency else 0,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 2,
			}, {
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.cta.textSize }),
			}),
		})
	else
		content = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.55, 0.55),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 2,
		}, {
			Icon = iconElement(UDim2.fromScale(1, 1), 1),
		})
	end

	return e("TextButton", {
		ref = rootRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = fill,
		BackgroundTransparency = if disabled then Theme.derived.disabledTransparency else fillTransparency,
		Size = props.size or (if labeled then UDim2.fromOffset(163, 68) else UDim2.fromOffset(68, 68)),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			if not disabled then
				lift(pressedFill, LIFT_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			lift(fill, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(fill, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			Transparency = Theme.strokes.outline.transparency,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		-- size token: 1:1 square; labeled variant widens to ~2.4:1
		Aspect = e("UIAspectRatioConstraint", {
			AspectRatio = if labeled then 2.4 else 1,
		}),
		Content = content,
		-- badge-slot: dark fill, 3px bright cream stroke, cream numeral —
		-- "the brightest edge in the HUD ... the interaction hint" (Components).
		Badge = if props.badge and props.badge > 0
			then e("TextLabel", {
				BackgroundColor3 = Theme.colors.surfaceDark,
				BackgroundTransparency = Theme.surfaceDarkTransparency,
				Size = UDim2.fromOffset(28, 28),
				Position = UDim2.fromScale(1, 0),
				AnchorPoint = Vector2.new(0.6, 0.35),
				Text = tostring(props.badge),
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.primary,
				ZIndex = 4,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outlineHeavy.thickness,
					Color = Theme.strokes.outlineHeavy.color,
					Transparency = Theme.strokes.outlineHeavy.transparency,
					ApplyStrokeMode = Theme.strokes.outlineHeavy.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = 16 }),
			})
			else nil,
	})
end

return IconTile
