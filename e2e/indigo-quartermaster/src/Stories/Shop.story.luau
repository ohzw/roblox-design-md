-- Standard showcase: Shop.story (standard-showcase.md). Fixed content:
-- exactly six items (Acorn/Feather/Crystal/Lantern/Compass/Crown) at fixed
-- tiers and prices (25/40/120/150/600/2500), Crown emphasized.
--
-- Taste-fit notes:
--   - Window: hub variant (full-screen, 130px integrated header band, dark
--     currency pill left of the bare X) -- this is this taste's own anatomy
--     for "Event hub (shop/missions)" Screen Patterns, reused bare (no
--     Missions tab; a single Shop tab strip entry, since the standard set
--     has no missions content). Title uses the taste's own shop word "Shop"
--     (Screen Patterns literally calls this surface the "Shop" tab).
--   - card-grid: this taste's own item-card anatomy (art well, ALL-CAPS name
--     in accent-info, button-buy pill, full-width verdict-color bottom
--     strip). Grid density is this taste's own 4-column desktop hub density
--     (Layout prose: "4 columns on desktop hubs, cells near-square") --
--     six items leaves an orphan row of 2, per standard-showcase.md's "flex
--     only when the taste states none" (this taste explicitly states 4).
--   - Crown (legendary + emphasized/limited): premium-currency pricing
--     (button-buy swaps to {colors.primary} green, per the Components
--     prose: "premium-currency prices swap the fill to primary -- this
--     taste's green also means 'price you can afford'") PLUS CardGrid's
--     `emphasized` prop, which applies the taste's own {strokes.selection}
--     2px white stroke ("marks the selected cell in a grid... inferred for
--     lobby grids") directly on the card -- since this taste has no
--     dedicated rarity-glow/ribbon token to reach for. Verdict band on Crown
--     reads "owned" (green) to pair with the premium pricing color instead
--     of the default red "cost" band the other five items use, keeping
--     green/red separated per Do's-and-Don'ts (never green+red on the same
--     element).
--   - Activating a card opens a Buy confirm popup: the SAME anatomy as
--     Dialog.story (Window's popup variant, 48px band, dim wash, green
--     button-primary bottom-right) -- demonstrating both Window footer
--     conventions (verdict-band cards vs. green-CTA popups) from one story,
--     same as the prior EventHub.story did (folded in here per this
--     retrofit's scope call: EventHub's Missions tab is out-of-scope for
--     the standard set and dropped; its Shop-tab + confirm-popup pairing is
--     exactly what Shop.story needs, so it's preserved instead of
--     duplicated as a fourth story).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local CardGrid = require(script.Parent.Parent.Components.CardGrid)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

-- Fixed standard-showcase catalog: identical content across every taste.
local ITEMS = {
	{ name = "Acorn", price = 25, currency = "soft", verdict = "cost", icon = "itemAcorn" },
	{ name = "Feather", price = 40, currency = "soft", verdict = "cost", icon = "itemFeather" },
	{ name = "Crystal", price = 120, currency = "soft", verdict = "cost", icon = "itemCrystal" },
	{ name = "Lantern", price = 150, currency = "soft", verdict = "cost", icon = "itemLantern" },
	{ name = "Compass", price = 600, currency = "soft", verdict = "cost", icon = "itemCompass" },
	{
		name = "Crown",
		price = 2500,
		currency = "premium",
		verdict = "owned", -- green band pairs with the premium-green price; never red+green together
		icon = "itemCrown",
		emphasized = true,
	},
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		CurrencyAmount = 12400,
	},
	story = function(props)
		local confirmItem, setConfirmItem = React.useState(nil)

		-- Responsive window pattern: content region is a ScrollingFrame
		-- whenever its natural height can exceed the panel. This taste's own
		-- 4-column desktop hub density leaves an orphan row of 2 for 6 items
		-- (2 rows at 244px cells), which always exceeds a phone-landscape
		-- panel's available height once the 130px hub header is subtracted.
		-- CanvasSize is bound to the UIGridLayout's own AbsoluteContentSize
		-- (not a hardcoded row count) so it stays correct at any column
		-- count the grid actually wraps to.
		local gridLayoutRef = React.useRef(nil)
		local scrollingFrameRef = React.useRef(nil)

		React.useEffect(function()
			local layout = gridLayoutRef.current
			local scrollingFrame = scrollingFrameRef.current
			if not layout or not scrollingFrame then
				return
			end
			local function sync()
				scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
			end
			sync()
			local conn = layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(sync)
			return function()
				conn:Disconnect()
			end
		end, {})

		local children = {
			Layout = e("UIGridLayout", {
				ref = gridLayoutRef,
				-- CellSize fixed-offset at CardGrid's own 0.9 aspect ratio
				-- (220x244) so UIGridLayout and the card's internal
				-- UIAspectRatioConstraint agree (layout-rules.md #4.5).
				CellSize = UDim2.fromOffset(220, 244),
				CellPadding = UDim2.fromOffset(Theme.spacing.lg, Theme.spacing.lg),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}
		for i, item in ipairs(ITEMS) do
			children["Item_" .. item.name] = e(CardGrid, {
				name = item.name,
				price = item.price,
				currency = item.currency,
				verdict = item.verdict,
				icon = Theme.assets[item.icon],
				emphasized = item.emphasized,
				layoutOrder = i,
				onActivated = function()
					setConfirmItem(item)
				end,
			})
		end

		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. This taste's hub Window variant defaults to a
		-- full-screen fromScale(1,1) panel, which puts its 130px integrated
		-- header band (title/subtitle/tabs/currency pill/close, all "reaching
		-- the top edge" per the DESIGN.md's own hub anatomy) directly under the
		-- topbar -- same rule as HUD containers applies to this window header.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Hub = e(Window, {
				variant = "hub",
				title = "Shop",
				subtitle = "Six items, one legendary",
				tabs = { { key = "shop", label = "Shop" } },
				activeTab = "shop",
				currencyAmount = props.controls.CurrencyAmount,
				showDim = false,
				dismissible = false,
				-- Anchored top-center with a computed offset (instead of the
				-- default full-screen fromScale(1,1) top-left) so the header
				-- band's title/subtitle/close clear the live topbar inset.
				size = UDim2.new(1, 0, 1, -topInset),
				position = UDim2.new(0.5, 0, 0, topInset),
				anchorPoint = Vector2.new(0.5, 0),
			}, {
				Grid = e("ScrollingFrame", {
					ref = scrollingFrameRef,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ScrollBarThickness = 6,
					ScrollBarImageColor3 = Theme.colors.onSurface,
					ScrollBarImageTransparency = 0.3,
				}, children),
			}),
			-- Buy confirm popup: Window's OTHER anatomy (48px band, dim wash,
			-- green button-primary footer bottom-right) layered above the hub.
			Confirm = if confirmItem
				then e(Window, {
					variant = "popup",
					title = "Buy " .. confirmItem.name,
					size = UDim2.fromOffset(420, 260),
					zIndex = 20, -- popups/toasts band (layout-rules.md #4)
					onClose = function()
						setConfirmItem(nil)
					end,
				}, {
					Description = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 60),
						Text = string.format(
							"Confirm your purchase to add %s to your locker.",
							confirmItem.name
						),
						FontFace = Theme.typography.body.font,
						TextSize = Theme.typography.body.textSize,
						TextColor3 = Theme.colors.onSurfaceMuted,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					}),
					Confirm = e(ButtonPrimary, {
						text = "Confirm",
						variant = "primary",
						size = UDim2.fromOffset(160, 44),
						position = UDim2.new(1, 0, 1, 0),
						anchorPoint = Vector2.new(1, 1),
						onActivated = function()
							setConfirmItem(nil)
						end,
					}),
				})
				else nil,
		})
	end,
}
