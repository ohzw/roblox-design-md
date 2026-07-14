-- Standard showcase: HUD.story (standard-showcase.md). Fixed content: 12,400
-- soft currency, SHOP/ITEMS/SETTINGS launchers (badge 3 on Items), one PLAY
-- CTA.
--
-- Taste-fit notes (Indigo Quartermaster's own Screen Patterns never describe
-- a LOBBY HUD -- its only documented HUD is the divergent In-match one, kept
-- separately as this taste's fourth story, InMatchHUD.story):
--   - currency-bar: the taste's own dark-pill token, top-center -- the
--     nearest thing this taste has to a persistent lobby currency readout
--     (documented for the event-hub header band; reused bare here since the
--     standard set has no hub window on this screen).
--   - launcher/side-button: DERIVED (Components/Launcher.luau) from this
--     taste's own button-primary + badge-slot + surface-dark grammar, since
--     no lobby icon toolbar is documented. Badge transplanted onto Items per
--     standard-showcase.md's explicit allowance.
--   - PLAY: this taste's OWN dominant CTA anatomy is button-cta ("the lobby
--     PLAY slab... exactly one per screen, center stage" -- its literal
--     label in the DESIGN.md prose is "PLAY", no substitution needed),
--     bottom-center per the standard set's placement default.
--   - Reserved zones (layout-rules.md #5): bottom-left/right stay clear;
--     launchers sit top-left, currency top-center, PLAY bottom-center.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local Launcher = require(script.Parent.Parent.Components.Launcher)
local ButtonCta = require(script.Parent.Parent.Components.ButtonCta)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Currency = 12400,
		ItemsBadge = 3,
	},
	story = function(props)
		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. Both top-docked elements below (Currency, Launchers)
		-- must offset by the live gui inset (queried at render, never
		-- hardcoded) to clear it.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Top-center: soft-currency pill (this taste's currency-bar token).
			Currency = e(CurrencyBar, {
				amount = props.controls.Currency,
				position = UDim2.new(0.5, 0, 0, Theme.spacing.lg + topInset),
				anchorPoint = Vector2.new(0.5, 0),
			}),
			-- Top-left: SHOP / ITEMS / SETTINGS launchers.
			Launchers = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(72 * 3 + Theme.spacing.md * 2, 72),
				Position = UDim2.new(0, Theme.spacing.lg, 0, Theme.spacing.lg + topInset),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Shop = e(Launcher, {
					text = "Shop",
					icon = Theme.assets.iconShop,
					layoutOrder = 1,
				}),
				Items = e(Launcher, {
					text = "Items",
					icon = Theme.assets.iconItems,
					badge = props.controls.ItemsBadge,
					layoutOrder = 2,
				}),
				Settings = e(Launcher, {
					text = "Settings",
					icon = Theme.assets.iconSettings,
					layoutOrder = 3,
				}),
			}),
			-- Bottom-center: the one-per-screen PLAY mega-slab. Reserved
			-- bottom-left/right zones (joystick/jump) stay clear since this is
			-- centered, not corner-anchored.
			Play = e(ButtonCta, {
				text = "Play",
				position = UDim2.new(0.5, 0, 1, -Theme.spacing.xl),
				anchorPoint = Vector2.new(0.5, 1),
			}),
		})
	end,
}
