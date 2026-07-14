-- Standard showcase HUD (standard-showcase.md): currency display (soft +
-- hard), three launcher buttons (SHOP/ITEMS/SETTINGS) with a notification
-- badge on one, one contextual primary action (PLAY), reserved zones clear.
--
-- Screen Patterns (HUD): "launcher tiles in a 2-column grid on the left edge
-- (upper half, clear of the joystick zone)... currency stack (icon + naked
-- outlined number + '+' tile per currency) bottom-left corner above the safe
-- inset... Bottom-right stays clear for the jump button." A wide green
-- primary CTA slab sits bottom-center per the same pattern's general chrome
-- density, standing in for the contextual PLAY action requested by
-- standard-showcase.md (this taste's Screen Patterns section does not name a
-- specific bottom-center CTA beyond hotbar slots, so PLAY reuses
-- button-primary's hero anatomy -- a reasonable, taste-consistent
-- substitution, not a contradiction, so no note is required beyond this one).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local CurrencyBar = require(script.Parent.Parent.Components.CurrencyBar)
local SideButton = require(script.Parent.Parent.Components.SideButton)
local GradientButton = require(script.Parent.Parent.Components.GradientButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		SoftCurrency = 12400,
		HardCurrency = 99,
	},
	story = function(props)
		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. LauncherGrid below is top-docked and must offset by
		-- the live gui inset (queried at render, never hardcoded) to clear it.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Left rail: launcher grid, upper-left, clear of the joystick zone
			-- (Screen Patterns). At 667x375, a 2-COLUMN grid wraps 3 items to 2 ROWS
			-- (Shop+Items, then Settings alone): even with a tight top margin, the
			-- 2-row content (140*2 + one CellPadding gap = 292px) reaches down to
			-- trueY~370, deep enough to overlap CurrencyStack below it (verified
			-- failure mode, distinct from the original 7px viewport-overflow
			-- finding). Re-wrapped to 3 COLUMNS / 1 ROW instead -- layout-rules.md's
			-- own responsive-grid principle ("grids MAY re-wrap columns... cell
			-- shape outranks the taste's stated desktop column count") -- fits
			-- easily in the 667px width (3*140 + 2*md = 444px) and needs only ONE
			-- row of vertical room, clearing CurrencyStack with margin to spare.
			-- Cell size/tile anatomy is completely unchanged; only the column
			-- count responds to the viewport.
			LauncherGrid = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(140 * 3 + Theme.spacing.md * 2, 140),
				Position = UDim2.fromOffset(Theme.spacing.xl, Theme.spacing.xl + topInset),
			}, {
				Grid = e("UIGridLayout", {
					CellSize = UDim2.fromOffset(140, 140),
					CellPadding = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Shop = e(SideButton, {
					text = "Shop", -- Title Case per this taste's typography rules (never all-caps)
					image = Theme.assets.iconShop,
					isNew = false,
					badge = 3, -- standard-showcase.md: notification badge showing 3 on one launcher
					layoutOrder = 1,
				}),
				Items = e(SideButton, {
					text = "Items",
					image = Theme.assets.iconItems,
					layoutOrder = 2,
				}),
				Settings = e(SideButton, {
					text = "Settings",
					image = Theme.assets.iconSettings,
					layoutOrder = 3,
				}),
			}),
			-- Bottom-left currency stack, containerless, above the safe inset
			-- (Screen Patterns). Bar width narrowed from CurrencyBar's 220px default
			-- to 150px: measured in-engine, the actual content (44px icon + 8px gap
			-- + ~48px "12.4K" AutomaticSize text + 8px gap + 35.2px plus-tile =
			-- ~143px) never needed the full 220px -- the extra reserved width is
			-- what pushed this stack's right edge into PlayAction's footprint at
			-- 667x375 (verified failure mode).
			CurrencyStack = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(150, Theme.metrics.currencyBarHeight * 2 + Theme.spacing.sm),
				Position = UDim2.new(0, Theme.spacing.xl, 1, -Theme.spacing.xl),
				AnchorPoint = Vector2.new(0, 1),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.sm),
				}),
				Soft = e(CurrencyBar, {
					kind = "soft",
					amount = props.controls.SoftCurrency,
					size = UDim2.fromOffset(150, Theme.metrics.currencyBarHeight),
					layoutOrder = 1,
				}),
				Hard = e(CurrencyBar, {
					kind = "hard",
					amount = props.controls.HardCurrency,
					size = UDim2.fromOffset(150, Theme.metrics.currencyBarHeight),
					layoutOrder = 2,
				}),
			}),
			-- Bottom-center contextual primary action (PLAY), clear of both the
			-- joystick (bottom-left) and jump button (bottom-right) reserved
			-- zones (layout-rules.md #5). Nudged right by (spacing.md + spacing.sm
			-- = 20px) from true center: at 667x375 a dead-center 320px-wide slab's
			-- left edge reached into the (narrowed) currency stack's right edge;
			-- the small rightward offset clears it while leaving ample margin
			-- before the bottom-right jump zone (verified failure mode -- Currency
			-- Soft chip x[32,252] overlapped PlayAction x[174,494]).
			PlayAction = e(GradientButton, {
				variant = "primaryHero",
				text = "Play",
				icon = nil,
				size = UDim2.fromOffset(320, 90),
				position = UDim2.new(0.5, Theme.spacing.md + Theme.spacing.sm, 1, -Theme.spacing.xl),
				anchorPoint = Vector2.new(0.5, 1),
			}),
		})
	end,
}
