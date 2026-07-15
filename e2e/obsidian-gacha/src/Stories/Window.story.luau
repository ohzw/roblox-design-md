-- The signature window: Aura Storage. Left detail column (a bracketed preview
-- well + a bracketed action well with Equip/Lock/Enter/Salvage), right rarity
-- grid of aura cards with one selected, footer with Total Value / Storage and
-- the Normal|Hardcore segmented tabs. Every panel and well wears the corner
-- brackets; buttons speak through their stroke color.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local AuraCard = require(script.Parent.Parent.Components.AuraCard)
local ActionButton = require(script.Parent.Parent.Components.ActionButton)
local SegmentedTabs = require(script.Parent.Parent.Components.SegmentedTabs)
local CornerBrackets = require(script.Parent.Parent.Components.CornerBrackets)

local e = React.createElement

local AURAS = {
	{ name = "Tranquility", rarity = "common", qty = nil },
	{ name = "Telekinesis", rarity = "epic", qty = nil },
	{ name = "Flow", rarity = "rare", selected = true },
	{ name = "Prodigy", rarity = "rare", qty = nil },
	{ name = "Kinesis", rarity = "common", qty = 2 },
	{ name = "Atmos", rarity = "common", qty = nil },
	{ name = "Reborn", rarity = "rare", qty = 3 },
	{ name = "Acceleration", rarity = "legendary", qty = 4 },
}

local function well(children, order)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDeep,
		Size = UDim2.new(1, 0, 0, 0),
		LayoutOrder = order,
	}, children)
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		local gridChildren = {
			Layout = e("UIGridLayout", {
				CellSize = UDim2.fromOffset(118, 118),
				CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}
		for i, a in AURAS do
			gridChildren["Card" .. i] = e(AuraCard, {
				name = a.name,
				rarity = a.rarity,
				qty = a.qty,
				selected = a.selected,
				layoutOrder = i,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Win = e(Window, {
				title = "Aura Storage",
				icon = Theme.assets.iconGem,
				iconColor = Theme.colors.primary,
				search = true,
			}, {
				Body = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
				}, {
					-- Left detail column.
					Left = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(0.34, -Theme.spacing.md, 1, 0),
					}, {
						Layout = e("UIListLayout", {
							FillDirection = Enum.FillDirection.Vertical,
							Padding = UDim.new(0, Theme.spacing.md),
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),
						Preview = e("Frame", {
							BackgroundColor3 = Theme.derived.cardFill,
							Size = UDim2.new(1, 0, 0.5, -Theme.spacing.sm),
							LayoutOrder = 1,
						}, {
							Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
							Brackets = e(CornerBrackets, { color = Theme.colors.outline, arm = 22, inset = 7, zIndex = 3 }),
							Name = e("TextLabel", {
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0, 40),
								Position = UDim2.fromScale(0.5, 0.42),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Text = "Flow",
								FontFace = Theme.typography.display.font,
								TextColor3 = Theme.colors.primary,
								TextSize = Theme.typography.display.textSize,
								ZIndex = 2,
							}),
							Rarity = e("TextLabel", {
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0, 24),
								Position = UDim2.fromScale(0.5, 0.64),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Text = "1 / 5,600,000",
								FontFace = Theme.typography.body.font,
								TextColor3 = Theme.colors.onSurfaceDim,
								TextSize = Theme.typography.body.textSize,
								ZIndex = 2,
							}),
							Count = e("TextLabel", {
								BackgroundTransparency = 1,
								Size = UDim2.fromOffset(40, 20),
								Position = UDim2.new(1, -Theme.spacing.sm, 1, -Theme.spacing.sm),
								AnchorPoint = Vector2.new(1, 1),
								Text = "x1",
								FontFace = Theme.typography.caption.font,
								TextColor3 = Theme.colors.onSurface,
								TextSize = Theme.typography.caption.textSize,
								ZIndex = 2,
							}),
						}),
						Actions = e("Frame", {
							BackgroundColor3 = Theme.derived.cardFill,
							Size = UDim2.new(1, 0, 0.5, -Theme.spacing.sm),
							LayoutOrder = 2,
						}, {
							Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
							Brackets = e(CornerBrackets, { color = Theme.colors.outline, arm = 22, inset = 7, zIndex = 3 }),
							-- layout on an inner Content frame, not on the bracketed well
							-- (the brackets frame would otherwise be a layout item).
							Content = e("Frame", {
								BackgroundTransparency = 1,
								Size = UDim2.fromScale(1, 1),
							}, {
								Pad = e("UIPadding", {
									PaddingLeft = UDim.new(0, Theme.spacing.md),
									PaddingRight = UDim.new(0, Theme.spacing.md),
									PaddingTop = UDim.new(0, Theme.spacing.md),
									PaddingBottom = UDim.new(0, Theme.spacing.md),
								}),
								Layout = e("UIListLayout", {
									FillDirection = Enum.FillDirection.Vertical,
									Padding = UDim.new(0, Theme.spacing.sm),
									SortOrder = Enum.SortOrder.LayoutOrder,
								}),
								Equip = e(ActionButton, { variant = "confirm", text = "Equip", size = UDim2.new(1, 0, 0, 44), layoutOrder = 1, zIndex = 2 }),
								Lock = e(ActionButton, { variant = "favorite", text = "Lock", size = UDim2.new(1, 0, 0, 40), layoutOrder = 2, zIndex = 2 }),
								Enter = e(ActionButton, { variant = "neutral", text = "Enter", size = UDim2.new(1, 0, 0, 40), layoutOrder = 3, zIndex = 2 }),
								Salvage = e(ActionButton, { variant = "danger", text = "Salvage Mode", size = UDim2.new(1, 0, 0, 40), layoutOrder = 4, zIndex = 2 }),
							}),
						}),
					}),
					-- Right grid + footer.
					Right = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(0.66, -Theme.spacing.md, 1, 0),
						Position = UDim2.new(0.34, Theme.spacing.md, 0, 0),
					}, {
						Layout = e("UIListLayout", {
							FillDirection = Enum.FillDirection.Vertical,
							Padding = UDim.new(0, Theme.spacing.sm),
							SortOrder = Enum.SortOrder.LayoutOrder,
						}),
						Heading = e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 24),
							Text = "Normal Auras",
							FontFace = Theme.typography.body.font,
							TextColor3 = Theme.colors.onSurfaceDim,
							TextSize = Theme.typography.body.textSize,
							TextXAlignment = Enum.TextXAlignment.Left,
							LayoutOrder = 1,
						}),
						Grid = e("ScrollingFrame", {
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 1, -84),
							CanvasSize = UDim2.new(0, 0, 0, 396),
							ScrollBarThickness = 4,
							ScrollBarImageColor3 = Theme.colors.onSurfaceDim,
							LayoutOrder = 2,
						}, gridChildren),
						Footer = e("Frame", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 52),
							LayoutOrder = 3,
						}, {
							Layout = e("UIListLayout", {
								FillDirection = Enum.FillDirection.Horizontal,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								Padding = UDim.new(0, Theme.spacing.lg),
								SortOrder = Enum.SortOrder.LayoutOrder,
							}),
							Total = e("TextLabel", {
								BackgroundTransparency = 1,
								AutomaticSize = Enum.AutomaticSize.X,
								Size = UDim2.new(0, 0, 1, 0),
								Text = "Total Value  1.04B",
								FontFace = Theme.typography.body.font,
								TextColor3 = Theme.colors.onSurface,
								TextSize = Theme.typography.body.textSize,
								LayoutOrder = 1,
							}),
							Storage = e("TextLabel", {
								BackgroundTransparency = 1,
								AutomaticSize = Enum.AutomaticSize.X,
								Size = UDim2.new(0, 0, 1, 0),
								Text = "Storage  30 / 30",
								FontFace = Theme.typography.body.font,
								TextColor3 = Theme.colors.onSurfaceDim,
								TextSize = Theme.typography.body.textSize,
								LayoutOrder = 2,
							}),
							Tabs = e(SegmentedTabs, {
								options = { "Normal", "Hardcore" },
								selectedIndex = 1,
								size = UDim2.fromOffset(220, 40),
								layoutOrder = 3,
							}),
						}),
					}),
				}),
			}),
		})
	end,
}
