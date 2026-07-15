-- Buttons showcase: the semantic-stroke button family (confirm/favorite/danger/
-- buy/neutral + disabled), the Roll hero, and the IconTile rail/cluster tiles.
-- Every button is one dark fill wearing a different stroke.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ActionButton = require(script.Parent.Parent.Components.ActionButton)
local IconTile = require(script.Parent.Parent.Components.IconTile)
local RollButton = require(script.Parent.Parent.Components.RollButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Disabled = false,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Pad = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.xl),
				PaddingTop = UDim.new(0, Theme.spacing.xl),
			}),
			Rows = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, Theme.spacing.lg),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				-- Semantic-stroke buttons.
				ActionRow = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 48),
					LayoutOrder = 1,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, Theme.spacing.md),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Equip = e(ActionButton, { variant = "confirm", text = "Equip", disabled = props.controls.Disabled, size = UDim2.fromOffset(150, 48), layoutOrder = 1 }),
					Lock = e(ActionButton, { variant = "favorite", text = "Lock", disabled = props.controls.Disabled, size = UDim2.fromOffset(120, 48), layoutOrder = 2 }),
					Salvage = e(ActionButton, { variant = "danger", text = "Salvage", disabled = props.controls.Disabled, size = UDim2.fromOffset(150, 48), layoutOrder = 3 }),
					Enter = e(ActionButton, { variant = "neutral", text = "Enter", disabled = props.controls.Disabled, size = UDim2.fromOffset(120, 48), layoutOrder = 4 }),
					Buy = e(ActionButton, { variant = "buy", price = "499", icon = Theme.assets.iconRobux, disabled = props.controls.Disabled, size = UDim2.fromOffset(130, 48), layoutOrder = 5 }),
				}),
				-- Roll hero + roll-cluster tiles (IconTile with tags/labels).
				ClusterRow = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 200),
					LayoutOrder = 2,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, Theme.spacing.lg),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Auto = e(IconTile, { side = 96, icon = Theme.assets.iconSettings, iconColor = Theme.colors.onSurface, topTag = "Free", topTagColor = Theme.colors.secondary, label = "Auto", layoutOrder = 1 }),
					Roll = e(RollButton, { label = "Roll", layoutOrder = 2 }),
					Skip = e(IconTile, { side = 96, icon = Theme.assets.iconGem, iconColor = Theme.colors.onSurface, topTag = "Join Group", topTagColor = Theme.colors.primary, label = "Skip", layoutOrder = 3 }),
					Shop = e(IconTile, { side = 66, icon = Theme.assets.iconShop, iconColor = Theme.colors.danger, variant = "danger", badge = 3, layoutOrder = 4 }),
				}),
			}),
		})
	end,
}
