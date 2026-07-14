-- Shop-style window: dim overlay, header band proud of the top edge, close
-- button on the corner, card grid + primary buy button in the content area.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local Card = require(script.Parent.Parent.Components.Card)
local ChunkyButton = require(script.Parent.Parent.Components.ChunkyButton)

local e = React.createElement

local ITEMS = {
	{ text = "DOG", itemColor = Color3.fromHex("#C58F5A") },
	{ text = "CAT", itemColor = Color3.fromHex("#8A8A8A"), rarity = "RARE", rarityColor = Color3.fromHex("#4FA8F5") },
	{ text = "DRAGON", itemColor = Color3.fromHex("#F24E4E"), rarity = "EPIC", rarityColor = Color3.fromHex("#B96BF5") },
	{ text = "UNICORN", itemColor = Color3.fromHex("#FF8A3D"), rarity = "LEGEND", rarityColor = Color3.fromHex("#FF8A3D"), selected = true },
	{ text = "BUNNY", itemColor = Color3.fromHex("#F5A8D0") },
	{ text = "BEAR", itemColor = Color3.fromHex("#7A5230") },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "PET SHOP",
	},
	story = function(props)
		local cards = {}
		cards.Layout = e("UIGridLayout", {
			CellSize = UDim2.fromOffset(110, 110),
			CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		for i, item in ipairs(ITEMS) do
			cards[item.text] = e(Card, {
				text = item.text,
				itemColor = item.itemColor,
				rarity = item.rarity,
				rarityColor = item.rarityColor,
				selected = item.selected,
				layoutOrder = i,
			})
		end

		return e("Frame", {
			BackgroundColor3 = Color3.fromHex("#87CEEB"),
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = props.controls.Title,
				size = UDim2.fromOffset(560, 460),
			}, {
				Grid = e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceDeep,
					Size = UDim2.new(1, 0, 1, -84),
					ZIndex = 13,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
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
					Cards = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 13,
					}, cards),
				}),
				Buy = e(ChunkyButton, {
					text = "BUY",
					variant = "primary",
					size = UDim2.fromOffset(200, 62),
					position = UDim2.new(0.5, 0, 1, -4),
					anchorPoint = Vector2.new(0.5, 1),
				}),
			}),
		})
	end,
}
