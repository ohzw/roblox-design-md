-- Standard showcase HUD (standard-showcase.md): currency display showing
-- 12,400 soft + 99 hard currency, three launcher buttons (SHOP/ITEMS/
-- SETTINGS, uppercase per this taste's typography.label rule) with a
-- notification badge showing 3 on one of them, one contextual primary action
-- labeled PLAY, reserved zones (bottom-left joystick / bottom-right jump)
-- respected.
--
-- Screen Patterns (HUD): "side-buttons column on the left edge (vertically
-- centered, out of the joystick zone), currency pills top-right under the
-- safe-area inset, primary contextual action ... bottom-center, lifted clear
-- of the jump zone." The taste's own canned example names the primary action
-- "HATCH" (a hatch/reward verb specific to the pet-collector genre); PLAY is
-- used here per standard-showcase.md so this story is content-comparable
-- with every other taste's HUD.story (substitution noted here, not a
-- contradiction — the DESIGN.md's HUD prose never rules out a generic
-- launch verb, it just gives a genre-specific example).
--
-- Launcher icons and currency icons are real image assets (Theme.assets,
-- asset-sourcing.md) via SideButton/CurrencyBar's `icon` prop.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local SideButton = require(script.Parent.Parent.Components.SideButton)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local ChunkyButton = require(script.Parent.Parent.Components.ChunkyButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		SoftCurrency = 12400,
		HardCurrency = 99,
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Left side-button column, vertically centered, clear of the
			-- bottom-left joystick zone (Screen Patterns + layout-rules.md #5).
			SideButtons = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(80, 260),
				Position = UDim2.new(0, Theme.spacing.md, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, Theme.spacing.md),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Shop = e(SideButton, {
					text = "SHOP",
					icon = Theme.assets.iconShop,
					iconColor = Theme.colors.onSurface,
					-- standard-showcase.md: notification badge showing 3 on one launcher.
					badge = 3,
					layoutOrder = 1,
				}),
				Items = e(SideButton, {
					text = "ITEMS",
					icon = Theme.assets.iconItems,
					iconColor = Theme.colors.onSurface,
					layoutOrder = 2,
				}),
				Settings = e(SideButton, {
					text = "SETTINGS",
					icon = Theme.assets.iconSettings,
					iconColor = Theme.colors.onSurface,
					layoutOrder = 3,
				}),
			}),
			-- Top-right currency pills, under the safe-area inset (Screen Patterns).
			Currencies = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(190, 100),
				Position = UDim2.new(1, -Theme.spacing.md, 0, Theme.spacing.md),
				AnchorPoint = Vector2.new(1, 0),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, Theme.spacing.sm),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Coins = e(CurrencyBar, {
					kind = "soft",
					amount = props.controls.SoftCurrency,
					icon = Theme.assets.iconCurrencySoft,
					layoutOrder = 1,
				}),
				Gems = e(CurrencyBar, {
					kind = "hard",
					amount = props.controls.HardCurrency,
					icon = Theme.assets.iconCurrencyPremium,
					layoutOrder = 2,
				}),
			}),
			-- Bottom-center contextual primary action (PLAY — see header note),
			-- lifted clear of the bottom-right jump zone.
			Play = e(ChunkyButton, {
				text = "PLAY",
				variant = "primary",
				size = UDim2.fromOffset(240, 72),
				position = UDim2.new(0.5, 0, 1, -Theme.spacing.lg),
				anchorPoint = Vector2.new(0.5, 1),
			}),
		})
	end,
}
