-- card-grid from DESIGN.roblox.md: square inset card on surface-deep wells.
-- Rarity shows as a corner ribbon (accent color), never as an outline change;
-- selection upgrades to the heavy outline + lighter fill.
--
-- Item render: a real image asset (Theme.assets.item*, asset-sourcing.md) via
-- the `icon` prop; falls back to the original colored-circle placeholder when
-- no icon is supplied (keeps the older pet-shop call sites, e.g.
-- Window.story's Card grid, working unmodified).
--
-- Rarity ladder: `rarity` may be either a Theme.rarity key (lowercase
-- "common"/"rare"/"epic"/"legendary" — the standard-showcase.md vocabulary)
-- or a free display string with an explicit `rarityColor` (the older
-- Window.story usage, e.g. "LEGEND"). An explicit `rarityColor` always wins;
-- otherwise the ladder is looked up by lowercased key and FAILS SOFT to
-- Theme.colors.accentRare on an unrecognized key (never nil-crash — see
-- standard-showcase.md's "rarity components must fail soft on unknown keys").
-- The "legendary + emphasized" treatment (standard-showcase.md's Crown rung)
-- reuses this taste's card-grid-selected heavy-outline + lighter-fill upgrade
-- plus a slight decorative tilt (DESIGN.md Shapes: "decorative rotation ...
-- welcome on reward reveals") to read as the top/exclusive rung.
--
-- Buy control: an optional in-card `price` renders a small button-primary
-- (Screen Patterns, Shop: "price on button-primary per card (icon + amount)")
-- so the standard Shop story's six items are each independently purchasable.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ChunkyButton = require(script.Parent.ChunkyButton)

local e = React.createElement

local function abbreviatePrice(n)
	if n >= 1_000_000 then
		return string.format("%.1fM", n / 1_000_000)
	elseif n >= 10_000 then
		return string.format("%.1fK", n / 1_000)
	end
	return tostring(n)
end

local function Card(props)
	local isLegendary = string.lower(props.rarity or "") == "legendary"
	local emphasized = props.selected or isLegendary
	local stroke = if emphasized then Theme.strokes.outlineHeavy else Theme.strokes.outline
	local fill = if emphasized then Color3.fromHex("#FFEFC2") else Theme.colors.surfaceDeep
	local rarityColor = props.rarityColor or (props.rarity and Theme.rarity[string.lower(props.rarity)]) or Theme.colors.accentRare
	local hasPrice = props.price ~= nil

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = fill,
		Size = props.size or (if hasPrice then UDim2.fromOffset(150, 190) else UDim2.fromOffset(110, 110)),
		LayoutOrder = props.layoutOrder,
		-- Decorative tilt is scoped to the legendary rung itself (not generic
		-- `selected`) so the pre-existing Window.story selected-card visual
		-- (UNICORN, selected=true but rarity="LEGEND" mismatched-case) is
		-- unchanged by this retrofit; only a `rarity` value that normalizes
		-- to "legendary" (the standard-showcase.md Crown rung) gets the tilt.
		Rotation = if isLegendary and props.tilt ~= false then 2 else 0,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Stroke = e("UIStroke", {
			Thickness = stroke.thickness,
			Color = stroke.color,
			ApplyStrokeMode = stroke.mode,
		}),
		Ratio = if not hasPrice then e("UIAspectRatioConstraint", { AspectRatio = 1 }) else nil,
		Render = e("Frame", {
			BackgroundTransparency = 1,
			Size = if hasPrice then UDim2.new(1, 0, 0, 96) else UDim2.fromScale(1, 1),
			Position = if hasPrice then UDim2.fromOffset(0, Theme.spacing.sm) else UDim2.fromScale(0, 0),
			ZIndex = 2,
		}, {
			Icon = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					-- itemColor tints monochrome/tintable assets; full-color
					-- assets (itemAcorn, itemLantern, itemCrown — see
					-- Theme.assets provenance) pass no itemColor and render
					-- at native color via the Theme.colors.white no-op tint.
					ImageColor3 = props.itemColor or Theme.colors.white,
					Size = UDim2.fromOffset(80, 80),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
				})
				else e("Frame", {
					BackgroundColor3 = props.itemColor or Theme.colors.secondary,
					Size = UDim2.fromScale(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.45),
					AnchorPoint = Vector2.new(0.5, 0.5),
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
					Stroke = e("UIStroke", {
						Thickness = 2,
						Color = Theme.strokes.outline.color,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					}),
				}),
		}),
		Name = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = if hasPrice then UDim2.new(1, -16, 0, 24) else UDim2.new(1, -8, 0, 16),
			Position = if hasPrice then UDim2.new(0.5, 0, 0, 106) else UDim2.new(0.5, 0, 1, -6),
			AnchorPoint = if hasPrice then Vector2.new(0.5, 0) else Vector2.new(0.5, 1),
			Text = props.text or "ITEM",
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
		}),
		Buy = if hasPrice
			then e(ChunkyButton, {
				text = abbreviatePrice(props.price),
				variant = "primary",
				size = UDim2.new(1, -Theme.spacing.sm * 2, 0, 44),
				position = UDim2.new(0.5, 0, 1, -Theme.spacing.sm),
				anchorPoint = Vector2.new(0.5, 1),
				layoutOrder = 3,
				onActivated = props.onBuy,
			})
			else nil,
		Ribbon = if props.rarity
			then e("TextLabel", {
				BackgroundColor3 = rarityColor,
				Size = UDim2.new(0, 52, 0, 18),
				Position = UDim2.new(0, -4, 0, -4),
				Text = string.upper(props.rarity),
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.white,
				ZIndex = 3,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
				Stroke = e("UIStroke", {
					Thickness = 2,
					Color = Theme.strokes.outline.color,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				}),
				TextStroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = 12 }),
			})
			else nil,
	})
end

return Card
