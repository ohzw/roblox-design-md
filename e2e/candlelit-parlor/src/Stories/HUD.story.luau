-- Standard showcase: HUD.story (standard-showcase.md).
-- Currency display: 12,400 soft currency via CurrencyDisplay (this taste has
-- no hard-currency token — Colors prose only defines one soft-currency
-- system — so a single pill is shown, per "SILENCE is not contradiction").
-- Three launcher tiles SHOP / ITEMS / SETTINGS as IconTiles (button-icon,
-- Screen Patterns "Lobby menu": "a row of square launcher tiles"), real
-- image assets tinted candle-cream via ImageColor3 (asset-sourcing.md's
-- tinting rule). Notification badge (3) attached to Items — this taste's
-- badge-slot is documented for hotbar slots (a different host), transplanted
-- onto a launcher here for comparability per standard-showcase.md ("attach
-- it to a launcher anyway ... and note the transplant").
-- PLAY via ParlorButton (button-primary, "the lobby play strip ... one per
-- screen, maximum" — the taste's dominant CTA, unmodified verb), placed
-- bottom-center per the taste's own Lobby-menu placement (CTA sits above the
-- launcher row there; centered bottom-ish here since the HUD slice has no
-- launcher-row anchor point to stack under). Reserved zones (bottom-left
-- joystick / bottom-right jump) stay clear. Top strip (layout-rules.md #5):
-- Currency and Launchers are top-docked, so both offset their Y by the live
-- `GuiService:GetGuiInset().Y` (queried at render, never hardcoded) to clear
-- the mount harness's full-bleed topbar -- this taste never got the earlier
-- standard-showcase.md topbar-clearance fix applied to the other tastes.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyDisplay = require(script.Parent.Parent.Components.CurrencyDisplay)
local IconTile = require(script.Parent.Parent.Components.IconTile)
local ParlorButton = require(script.Parent.Parent.Components.ParlorButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Currency = 12400,
		ItemsBadge = 3,
	},
	story = function(props)
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Currency display, top-left (HUD chrome convention: passive
			-- readouts sit top; this taste's Screen Patterns don't map a full
			-- HUD, so top-left keeps clear of the reserved bottom zones).
			Currency = e(CurrencyDisplay, {
				amount = props.controls.Currency,
				position = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md + topInset),
			}),
			-- Launcher row: SHOP / ITEMS / SETTINGS, top-right (mirrors the
			-- currency display across the top strip, keeping bottom-left/
			-- bottom-right reserved zones clear per layout-rules.md #5).
			-- Labeled variant (props.text): icon + condensed-caps Oswald label,
			-- widening to ~2.4:1 per the button-icon token.
			Launchers = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(163 * 3 + Theme.spacing.md * 2, 68),
				Position = UDim2.new(1, -Theme.spacing.md, 0, Theme.spacing.md + topInset),
				AnchorPoint = Vector2.new(1, 0),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Shop = e(IconTile, {
					image = Theme.assets.iconShop,
					text = "Shop",
					layoutOrder = 1,
				}),
				Items = e(IconTile, {
					image = Theme.assets.iconItems,
					text = "Items",
					badge = props.controls.ItemsBadge,
					layoutOrder = 2,
				}),
				Settings = e(IconTile, {
					image = Theme.assets.iconSettings,
					text = "Settings",
					layoutOrder = 3,
				}),
			}),
			-- Contextual primary action, bottom-center; joystick/jump zones
			-- (bottom-left / bottom-right) stay clear per layout-rules.md #5.
			Play = e(ParlorButton, {
				text = "Play",
				icon = "\u{25B6}",
				size = UDim2.fromOffset(340, 68),
				position = UDim2.new(0.5, 0, 1, -Theme.spacing.lg),
				anchorPoint = Vector2.new(0.5, 1),
			}),
		})
	end,
}
