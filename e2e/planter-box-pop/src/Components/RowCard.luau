-- row-card from DESIGN.roblox.md: the taste's core molecule. Dark brown
-- (surface-deep) full-width row, square lighter (surface-well) well left
-- holding the item render, heading-size name top (the row IS the product
-- page), muted stock caption, currency-green price, rarity-chip
-- bottom-right, optional muted description right-aligned. Limited items pin
-- a red "Limited!" ribbon over the row's top-left corner.
-- Layout prose: rows are Scale-first full-width children of a scrolling
-- frame with UIListLayout; well is square (UIAspectRatioConstraint 1) and
-- spans the row height minus row UIPadding. Density: rows are tall, ~3.5:1
-- width-to-height.
-- buy-control (standard-showcase.md): Screen Patterns is explicit -- "No
-- footer CTA -- purchases happen in-row" -- there is no distinct button-buy
-- voice for the soft-currency path in this taste (button-buy/-disabled are
-- the premium-purple pair reserved for the separate expanded purchase row,
-- Components prose). The row itself is therefore the buy control: root is a
-- TextButton firing `onActivated`/`onBuy`, and the currency-green Price
-- label is the visible affordance a player reads as "tap to buy."
-- itemIcon (asset-sourcing.md): the well renders a real ImageLabel
-- (Theme.assets.item*) when `icon` is supplied, falling back to the flat
-- color swatch used before asset sourcing for any caller that hasn't been
-- updated.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local RarityChip = require(script.Parent.RarityChip)

local e = React.createElement

local function RowCard(props)
	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.surfaceDeep,
		Size = props.size or UDim2.new(1, 0, 0, 128), -- ~3.5:1 width:height at reference row width (~450)
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 1,
		[React.Event.Activated] = function()
			if props.onBuy then
				props.onBuy()
			elseif props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
			PaddingTop = UDim.new(0, Theme.spacing.md),
			PaddingBottom = UDim.new(0, Theme.spacing.md),
		}),
		-- Limited! ribbon pinned over the row's top-left corner.
		LimitedRibbon = props.limited and e("TextLabel", {
			BackgroundColor3 = Theme.colors.danger,
			Size = UDim2.fromOffset(84, 22),
			Position = UDim2.new(0, -6, 0, -6),
			Text = "LIMITED!",
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 4,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			TextStroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
		}) or nil,
		-- Well: square, spans row height minus padding, left-anchored.
		Well = e("Frame", {
			BackgroundColor3 = Theme.colors.surfaceWell,
			Size = UDim2.new(0, 100, 1, 0),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			Ratio = e("UIAspectRatioConstraint", { AspectRatio = 1, DominantAxis = Enum.DominantAxis.Height }),
			-- Real image asset per asset-sourcing.md when `icon` is supplied;
			-- falls back to the flat color swatch for any caller predating it.
			ItemRender = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					ScaleType = Enum.ScaleType.Fit,
					Size = UDim2.fromScale(0.78, 0.78),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					ZIndex = 3,
				})
				else e("Frame", {
					BackgroundColor3 = props.itemColor or Theme.colors.secondary,
					Size = UDim2.fromScale(0.62, 0.62),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					ZIndex = 3,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
				}),
			-- Info badge: the ONLY circular silhouette in the taste (Shapes prose).
			InfoBadge = props.infoBadge and e("TextLabel", {
				BackgroundColor3 = Theme.colors.surfaceDeep,
				Size = UDim2.fromOffset(20, 20),
				Position = UDim2.new(1, -2, 1, -2),
				AnchorPoint = Vector2.new(1, 1),
				Text = "i",
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 4,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outlineWhite.thickness,
					Color = Theme.strokes.outlineWhite.color,
					ApplyStrokeMode = Theme.strokes.outlineWhite.mode,
				}),
			}) or nil,
		}),
		-- Info column: name, stock caption, price -- right of the well.
		Info = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(100 + Theme.spacing.md), 1, 0),
			Position = UDim2.new(0, 100 + Theme.spacing.md, 0, 0),
			ZIndex = 2,
		}, {
			Name = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 32),
				Text = props.name or "Item Name", -- Title Case per Typography prose
				FontFace = Theme.typography.heading.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
			}),
			Stock = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 20),
				Position = UDim2.new(0, 0, 0, 34),
				Text = props.stockText or "x5 Stock",
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurfaceMuted,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 3,
			}, {
				-- Typography prose: "every piece of text in this taste is
				-- outlined ... no exceptions" (self-review fix: was missing).
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
			}),
			-- Price: currency-soft green ONLY (Do's and Don'ts: never reuse for non-price text).
			Price = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 26),
				Position = UDim2.new(0, 0, 1, -26),
				Text = props.price or "$100\u{00A2}", -- cent glyph per Components prose
				FontFace = Theme.typography.body.font,
				TextScaled = true,
				TextColor3 = Theme.colors.currencySoft,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.body.textSize }),
			}),
			Description = props.description and e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.5, 0, 0, 40),
				Position = UDim2.new(1, 0, 0, 0),
				AnchorPoint = Vector2.new(1, 0),
				Text = props.description,
				FontFace = Theme.typography.body.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurfaceMuted,
				TextXAlignment = Enum.TextXAlignment.Right,
				TextWrapped = true,
				ZIndex = 3,
			}, {
				-- Typography prose: "every piece of text in this taste is
				-- outlined ... no exceptions" (self-review fix: was missing).
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.body.textSize }),
			}) or nil,
			Chip = e(RarityChip, {
				rarity = props.rarity or "common",
				size = UDim2.fromOffset(96, 26),
				position = UDim2.new(1, 0, 1, 0),
				anchorPoint = Vector2.new(1, 1),
				zIndex = 3,
			}),
		}),
	})
end

return RowCard
