-- Tokens reference: the palette (semantic color chips), the type ladder, and
-- the corner-radius steps + corner-bracket motif — the taste at a glance.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CornerBrackets = require(script.Parent.Parent.Components.CornerBrackets)

local e = React.createElement

local CHIPS = {
	{ "primary", Theme.colors.primary },
	{ "secondary", Theme.colors.secondary },
	{ "danger", Theme.colors.danger },
	{ "currency-soft", Theme.colors.currencySoft },
	{ "accent-gold", Theme.colors.accentGold },
	{ "accent-rare", Theme.colors.accentRare },
	{ "surface", Theme.colors.surface },
	{ "surface-deep", Theme.colors.surfaceDeep },
	{ "surface-dark", Theme.colors.surfaceDark },
	{ "outline", Theme.colors.outline },
	{ "on-surface", Theme.colors.onSurface },
	{ "on-surface-dim", Theme.colors.onSurfaceDim },
}

local TYPE = {
	{ "display", Theme.typography.display },
	{ "heading", Theme.typography.heading },
	{ "label", Theme.typography.label },
	{ "body", Theme.typography.body },
	{ "caption", Theme.typography.caption },
}

local function chip(name, color, order)
	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(120, 84),
		LayoutOrder = order,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, Theme.spacing.xs),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		Swatch = e("Frame", {
			BackgroundColor3 = color,
			Size = UDim2.fromOffset(120, 56),
			LayoutOrder = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.panel.thickness,
				Color = Theme.strokes.panel.color,
				ApplyStrokeMode = Theme.strokes.panel.mode,
				Transparency = 0.4,
			}),
		}),
		Name = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(120, 16),
			Text = name,
			FontFace = Theme.typography.caption.font,
			TextColor3 = Theme.colors.onSurfaceDim,
			TextSize = Theme.typography.caption.textSize,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 2,
		}),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		local chipChildren = {
			Layout = e("UIGridLayout", {
				CellSize = UDim2.fromOffset(120, 84),
				CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}
		for i, c in CHIPS do
			chipChildren["Chip" .. i] = chip(c[1], c[2], i)
		end

		local typeChildren = {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, Theme.spacing.sm),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}
		for i, t in TYPE do
			typeChildren["Type" .. i] = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				Text = t[1] .. " - Obsidian Gacha",
				FontFace = t[2].font,
				TextColor3 = Theme.colors.onSurface,
				TextSize = t[2].textSize,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = i,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Panel = e("Frame", {
				-- white base: panel gradient multiplies with BackgroundColor3 (Theme.white).
				BackgroundColor3 = Theme.white,
				Size = UDim2.fromOffset(560, 620),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.panel.thickness,
					Color = Theme.strokes.panel.color,
					ApplyStrokeMode = Theme.strokes.panel.mode,
				}),
				Gradient = e("UIGradient", {
					Color = ColorSequence.new(Theme.gradients.window.top, Theme.gradients.window.bottom),
					Rotation = 90,
				}),
				Brackets = e(CornerBrackets, { color = Theme.colors.outline, arm = 26, inset = 8, zIndex = 6 }),
				-- Layout lives on an inner Content frame, never on a bracketed
				-- container: CornerBrackets renders a full-size Frame, which a
				-- UIListLayout on the same parent would treat as a layout item and
				-- shove the real content off-panel.
				Content = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
				}, {
					Pad = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.xl),
						PaddingRight = UDim.new(0, Theme.spacing.xl),
						PaddingTop = UDim.new(0, Theme.spacing.xl),
						PaddingBottom = UDim.new(0, Theme.spacing.xl),
					}),
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0, Theme.spacing.lg),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Palette = e("Frame", {
						BackgroundTransparency = 1,
						-- auto-height so the 4-row grid isn't clipped into the type ladder
						AutomaticSize = Enum.AutomaticSize.Y,
						Size = UDim2.new(1, 0, 0, 0),
						LayoutOrder = 1,
					}, chipChildren),
					Type = e("Frame", {
						BackgroundTransparency = 1,
						AutomaticSize = Enum.AutomaticSize.Y,
						Size = UDim2.new(1, 0, 0, 0),
						LayoutOrder = 2,
					}, typeChildren),
				}),
			}),
		})
	end,
}
