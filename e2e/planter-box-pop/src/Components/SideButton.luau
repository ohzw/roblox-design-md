-- side-button from DESIGN.roblox.md: bright green world-anchored launcher
-- ("Shop" + basket icon) on the HUD's left edge; rectangle, not circle
-- (Shapes prose: "the close button is a rounded SQUARE... anything selected
-- keeps its rectangle"). Reused here for all three standard-showcase HUD
-- launchers (SHOP/ITEMS/SETTINGS): the DESIGN.md only names one ("Shop"),
-- but Components prose gives no anatomy reason the other two would differ,
-- so the single side-button token covers all three per generation-
-- procedure.md's derived-token rule. Real icon asset per asset-sourcing.md
-- (Theme.assets.icon*), white so it reads on the green fill; label below in
-- {typography.label} uppercase per Typography prose ("action text is ALL
-- CAPS"). Optional badge-slot notification dot, top-right corner, per
-- standard-showcase.md's HUD badge requirement (badge-slot itself is
-- documented for hotbar tiles -- transplanted onto a launcher here for
-- comparability, noted per standard-showcase.md's own transplant rule).
-- Press feedback: squash + bevel collapse, same convention as every other
-- plate in this taste (Elevation prose, inferred).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local BEVEL_HEIGHT = 3 -- same bevel convention as button-primary/button-close (no dedicated side-button bevel token)

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

local function badgeText(count)
	if count > 99 then
		return "99+"
	end
	return tostring(count)
end

local function SideButton(props)
	local pressed, setPressed = React.useState(false)
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
		BackgroundColor3 = Theme.derived.rarityBevels.uncommon, -- darker-green bevel (same ratio as the rarity-chip uncommon bevel)
		Size = props.size or UDim2.fromOffset(96, 88),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 1,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
			squash(Theme.derived.pressSquash, SQUASH_IN)
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
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = Theme.storyComponents.sideButton,
			Size = if pressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL_HEIGHT),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Icon = e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon or "",
				ImageColor3 = Theme.colors.onSurface, -- monochrome asset tinted via the palette (asset-sourcing.md)
				ScaleType = Enum.ScaleType.Fit,
				Size = UDim2.new(1, -Theme.spacing.md * 2, 0, 40),
				Position = UDim2.new(0.5, 0, 0, Theme.spacing.xs),
				AnchorPoint = Vector2.new(0.5, 0),
				ZIndex = 3,
			}),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 22),
				Position = UDim2.new(0.5, 0, 1, -Theme.spacing.xs),
				AnchorPoint = Vector2.new(0.5, 1),
				Text = string.upper(props.text or "SHOP"),
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
			}),
			-- badge-slot notification dot, transplanted onto the launcher's
			-- top-right corner per standard-showcase.md's transplant rule.
			Badge = (props.badge and props.badge > 0) and e("Frame", {
				BackgroundColor3 = Theme.colors.danger,
				Size = UDim2.fromOffset(26, 26),
				Position = UDim2.new(1, 4, 0, -4),
				AnchorPoint = Vector2.new(1, 0),
				ZIndex = 4,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outlineWhite.thickness,
					Color = Theme.strokes.outlineWhite.color,
					ApplyStrokeMode = Theme.strokes.outlineWhite.mode,
				}),
				Count = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = badgeText(props.badge),
					FontFace = Theme.typography.caption.font,
					TextScaled = true,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = 5,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = 14 }),
				}),
			}) or nil,
		}),
	})
end

return SideButton
