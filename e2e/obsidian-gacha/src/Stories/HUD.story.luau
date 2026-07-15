-- Standard-showcase HUD through the Obsidian Gacha grammar.
-- Screen Patterns (HUD): currency pill top-LEFT under the topbar; a left
-- vertical rail of ~66px side-buttons; a bottom-center action cluster — the
-- Roll hero flanked by Auto (green "Free" tag) and Skip (blue "Join Group"
-- tag) with three roll counters stacked above.
--
-- standard-showcase.md mappings + substitutions (noted): the fixed primary
-- action "PLAY" -> the taste's own verb "Roll" (its whole HUD is built around
-- the Roll lever; PLAY would contradict the prose). Currency sits top-LEFT
-- (this taste's placement) not top-right. Soft = gems 12,400; hard currency
-- (Robux 99) is shown for content parity though this taste normally keeps only
-- gems on the HUD. Notification badge (3) on the Shop launcher. Top containers
-- clear the topbar via GuiService inset (never hardcode 58); bottom cluster is
-- lifted clear of the jump zone.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local IconTile = require(script.Parent.Parent.Components.IconTile)
local RollButton = require(script.Parent.Parent.Components.RollButton)

local e = React.createElement

local function counter(text, color, order)
	return e("TextLabel", {
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Text = text,
		FontFace = Theme.typography.label.font,
		TextColor3 = color,
		TextSize = Theme.typography.label.textSize,
		LayoutOrder = order,
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Gems = 260000,
		Robux = 99,
	},
	story = function(props)
		local inset = GuiService:GetGuiInset().Y

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Top-left currency stack, cleared under the topbar.
			Currencies = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(220, 120),
				Position = UDim2.new(0, Theme.spacing.md, 0, inset + Theme.spacing.md),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, Theme.spacing.sm),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Gems = e(CurrencyBar, { kind = "soft", amount = props.controls.Gems, layoutOrder = 1 }),
				Robux = e(CurrencyBar, { kind = "hard", amount = props.controls.Robux, size = UDim2.fromOffset(150, 44), layoutOrder = 2 }),
			}),
			-- Left rail of side-buttons, vertically centered, clear of the
			-- bottom-left joystick zone.
			Rail = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(66, 240),
				Position = UDim2.new(0, Theme.spacing.md, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, Theme.spacing.md),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Shop = e(IconTile, { side = 66, icon = Theme.assets.iconShop, iconColor = Theme.colors.danger, variant = "danger", badge = 3, layoutOrder = 1 }),
				Items = e(IconTile, { side = 66, icon = Theme.assets.iconItems, iconColor = Theme.colors.secondary, variant = "buy", layoutOrder = 2 }),
				Settings = e(IconTile, { side = 66, icon = Theme.assets.iconSettings, iconColor = Theme.colors.onSurfaceDim, layoutOrder = 3 }),
			}),
			-- Bottom-center action cluster: counters over [Auto | Roll | Skip].
			Cluster = e("Frame", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.fromOffset(420, 0),
				Position = UDim2.new(0.5, 0, 1, -Theme.spacing.lg),
				AnchorPoint = Vector2.new(0.5, 1),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0, Theme.spacing.xs),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Counters = e("Frame", {
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.new(0, 120, 0, 0),
					LayoutOrder = 1,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					C1 = counter("66 / 800", Theme.colors.accentGold, 1),
					C2 = counter("66 / 100", Theme.colors.accentRare, 2),
					C3 = counter("6 / 10", Theme.colors.secondary, 3),
				}),
				Row = e("Frame", {
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.new(0, 420, 0, 0),
					LayoutOrder = 2,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Bottom,
						Padding = UDim.new(0, Theme.spacing.lg),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Auto = e(IconTile, { side = 96, icon = Theme.assets.iconSettings, iconColor = Theme.colors.onSurface, topTag = "Free", topTagColor = Theme.colors.secondary, label = "Auto", layoutOrder = 1 }),
					Roll = e(RollButton, { label = "Roll", layoutOrder = 2 }),
					Skip = e(IconTile, { side = 96, icon = Theme.assets.iconGem, iconColor = Theme.colors.onSurface, topTag = "Join Group", topTagColor = Theme.colors.primary, label = "Skip", layoutOrder = 3 }),
				}),
			}),
		})
	end,
}
