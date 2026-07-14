-- Standard showcase: HUD.story (standard-showcase.md).
-- Screen Patterns (desktop): "twin resource bars (currency-bar +
-- progress-bar) centered at the very top; white glyph icon toolbar ...
-- top-left as a horizontal row." No hard-currency accent was observed in
-- this taste (DESIGN.md notes) -- only the single soft-currency bar is
-- shown, per the taste's own grammar (identical CONTENT across tastes is
-- only required where the taste defines the slot; this is a documented
-- taste-level omission, not a skipped standard-showcase requirement).
-- Reserved zones: bottom-left (joystick) / bottom-right (jump) stay clear;
-- the contextual PLAY action sits bottom-center per this taste's CTA
-- convention (button-primary mounted centered, here floating directly since
-- no window-info frame applies to a bare HUD action).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local ProgressBar = require(script.Parent.Parent.Components.ProgressBar)
local LauncherButton = require(script.Parent.Parent.Components.LauncherButton)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Coins = 12400,
		Progress = 68,
		ItemsBadge = 3,
	},
	story = function(props)
		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. Both top-docked containers below (TopBars, Toolbar)
		-- must offset by the live gui inset (queried at render, never
		-- hardcoded) to clear it.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Twin resource bars centered at the very top.
			TopBars = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(190, 34 * 2 + Theme.spacing.xs),
				Position = UDim2.new(0.5, 0, 0, Theme.spacing.md + topInset),
				AnchorPoint = Vector2.new(0.5, 0),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.xs),
				}),
				Coins = e(CurrencyBar, {
					amount = props.controls.Coins,
					glyph = "$",
					layoutOrder = 1,
				}),
				Quest = e(ProgressBar, {
					current = props.controls.Progress,
					max = 100,
					layoutOrder = 2,
				}),
			}),
			-- White-glyph icon toolbar, top-left horizontal row.
			Toolbar = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(64 * 3 + Theme.spacing.md * 2, 64),
				Position = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md + topInset),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Shop = e(LauncherButton, {
					text = "Shop",
					icon = Theme.assets.iconShop,
					layoutOrder = 1,
				}),
				Items = e(LauncherButton, {
					text = "Items",
					icon = Theme.assets.iconItems,
					badge = props.controls.ItemsBadge,
					layoutOrder = 2,
				}),
				Settings = e(LauncherButton, {
					text = "Settings",
					icon = Theme.assets.iconSettings,
					layoutOrder = 3,
				}),
			}),
			-- Contextual primary action, bottom-center; joystick/jump zones
			-- (bottom-left / bottom-right) stay clear per layout-rules.md #5.
			Play = e(ButtonPrimary, {
				text = "Play",
				position = UDim2.new(0.5, 0, 1, -Theme.spacing.lg),
				anchorPoint = Vector2.new(0.5, 1),
			}),
		})
	end,
}
