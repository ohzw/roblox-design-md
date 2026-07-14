-- Standard showcase HUD (standard-showcase.md): currency display (12,400
-- soft currency -- this taste defines no hard/premium HUD counter, only the
-- shop's dual price pills, so no second HUD pill is added), three launchers
-- labeled Shop / Items / Settings (Title Case per Typography prose, not ALL
-- CAPS -- this taste's own casing rule), a notification badge showing 3 on
-- one launcher, and one contextual primary action labeled Play.
--
-- Screen Patterns ("HUD (desktop observed)"): "Left rail: currency pill at
-- the very top, 2x2 launcher grid under it." The taste's own grid is 2x2 with
-- FOUR destinations (Shop/Codes/Quests/Daily observed); the standard set asks
-- for exactly three (Shop/Items/Settings). Per standard-showcase.md's slot
-- table ("launcher/side-button: HUD entry buttons") the requirement is three
-- comparable launchers, not this taste's own four -- Settings moves up into
-- the launcher grid here (it lives in the taste's own bottom-left cluster
-- normally; the standard's own reserved third launcher is exactly the
-- taste-native "Settings" destination, so this is a placement substitution,
-- not a new destination). The bottom-left keybind cluster (Settings/Emote,
-- 80px) from the taste-native HUD is dropped for this exact story since
-- Settings now lives in the launcher grid -- noted here as a scope
-- reduction to the standard's three-launcher content, not a silent omission.
--
-- Real image icons (Theme.assets.icon*) replace the glyph placeholders that
-- shipped in the previous slice for the three standard launchers.
--
-- PLAY action: DESIGN.md's HUD prose never mentions a contextual play/action
-- button (SILENCE, not a rule against one per standard-showcase.md) --
-- placed bottom-center reusing button-primary, this taste's dominant CTA
-- voice, which is exactly the standard's instruction for the silent case.
-- Bottom-center/right stay clear for gameplay per Screen Patterns, so Play
-- is anchored bottom-center only (not a persistent gameplay obstruction --a
-- single button, not a bar).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local SideButton = require(script.Parent.Parent.Components.SideButton)
local Button = require(script.Parent.Parent.Components.Button)

local e = React.createElement

-- Thousands-comma formatting (CurrencyBar.amount accepts either a number or a
-- preformatted string; the standard set's 12,400 is presentational, not a
-- Theme concern, so it is derived here at the story/screen layer).
local function withCommas(n)
	local formatted = tostring(math.floor(n))
	local sign, int = formatted:match("^(-?)(%d+)$")
	sign = sign or ""
	int = int or formatted
	local out = int:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	out = out:gsub("^,", "")
	return sign .. out
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Currency = 12400,
		Badge = "3",
	},
	story = function(props)
		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. Top-docked containers must offset by the live gui
		-- inset (queried at render, never hardcoded) to clear it.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Left rail (Screen Patterns: "Left rail: currency pill at the very
			-- top, 2x2 launcher grid under it"). Safe-area inset stands in for
			-- ScreenGui.ScreenInsets, which only applies to a real ScreenGui root.
			LeftRail = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(230, 280),
				Position = UDim2.fromOffset(24, 24 + topInset),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Currency = e(CurrencyBar, {
					amount = withCommas(props.controls.Currency),
					layoutOrder = 1,
				}),
				-- Standard set: exactly three launchers (Shop / Items / Settings).
				Launchers = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromOffset(
						Theme.metrics.sideButtonSize * 2 + Theme.spacing.md,
						Theme.metrics.sideButtonSize * 2 + Theme.spacing.md
					),
					LayoutOrder = 2,
				}, {
					Grid = e("UIGridLayout", {
						CellSize = UDim2.fromOffset(Theme.metrics.sideButtonSize, Theme.metrics.sideButtonSize),
						CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Shop = e(SideButton, {
						text = "Shop",
						image = Theme.assets.iconShop,
						color = Theme.derived.launcherHues[1],
						layoutOrder = 1,
					}),
					Items = e(SideButton, {
						text = "Items",
						image = Theme.assets.iconItems,
						color = Theme.derived.launcherHues[3],
						layoutOrder = 2,
						-- Notification badge (standard-showcase.md: "showing 3 on one
						-- of them"). badge-slot is documented for keybind squares in
						-- this taste (Not-observed note: "badge-notification counters"
						-- was never captured) -- reused here on a launcher, which is
						-- already the badge's documented host, so no transplant.
						badge = props.controls.Badge,
					}),
					Settings = e(SideButton, {
						text = "Settings",
						image = Theme.assets.iconSettings,
						color = Theme.colors.secondary,
						layoutOrder = 3,
					}),
				}),
			}),
			-- Contextual primary action (standard-showcase.md): DESIGN.md's HUD
			-- prose is silent on a persistent action button -- included per the
			-- standard's silence rule, bottom-center, reusing button-primary.
			Play = e(Button, {
				text = "Play",
				size = UDim2.fromOffset(260, 80),
				position = UDim2.new(0.5, 0, 1, -40),
				anchorPoint = Vector2.new(0.5, 1),
			}),
		})
	end,
}
