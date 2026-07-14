-- Standard showcase: Shop.story (standard-showcase.md).
-- Screen Patterns (Loud Slab): "Shop/vendor windows: themed header band +
-- close, then stacked sections labeled by yellow uppercase headings, each a
-- grid of cards with green price pills." Grid delegated to UIGridLayout,
-- {spacing.md} cell gaps, per Layout prose ("card-grid: 4 columns in a
-- ~0.7-wide window; near-square cells" -- this shop uses 3 columns since the
-- standard set is 6 items, keeping cells comfortably near-square).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ItemCard = require(script.Parent.Parent.Components.ItemCard)

local e = React.createElement

-- Fixed standard-showcase catalog: identical content across every taste.
local ITEMS = {
	{ name = "Acorn", rarity = "common", price = 25, icon = "itemAcorn" },
	{ name = "Feather", rarity = "common", price = 40, icon = "itemFeather" },
	{ name = "Crystal", rarity = "rare", price = 120, icon = "itemCrystal" },
	{ name = "Lantern", rarity = "rare", price = 150, icon = "itemLantern" },
	{ name = "Compass", rarity = "epic", price = 600, icon = "itemCompass" },
	{ name = "Crown", rarity = "legendary", price = 2500, icon = "itemCrown" },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		-- Responsive window pattern: content region is a ScrollingFrame
		-- whenever its natural height can exceed the panel. The column count
		-- this taste's 200px-wide cells actually fit is viewport-dependent
		-- (3 columns at the ~832px desktop MaxSize, but only 1 column fits
		-- the ~433px panel width at 667x375 phone landscape) -- a canvas
		-- height hardcoded for one column count went stale under the other
		-- (verified failure mode: assuming 2 rows undersized the canvas to
		-- 492px when the grid actually wrapped to a 1500px single column at
		-- mobile width, stranding Crown off the bottom of the scroll area).
		-- Bind CanvasSize to the UIGridLayout's own AbsoluteContentSize
		-- instead, so it always matches however many columns actually fit.
		-- The SectionHeading label stays a fixed sibling above the scroll
		-- area (it is chrome for the grid, not part of its scrollable
		-- content).
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

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			WindowRoot = e(Window, {
				title = "Shop",
				-- Responsive window pattern: Scale-first size + Window's own
				-- UISizeConstraint MaxSize (this taste's prior fixed desktop
				-- fraction, expressed as pixels at the 1280x720 budget other
				-- stories in this taste target) so the panel never exceeds
				-- the viewport at phone landscape.
				size = UDim2.fromScale(0.65, 0.8),
				maxSize = Vector2.new(832, 576),
				showDim = true,
				dismissible = false,
			}, {
				SectionHeading = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 32),
					Text = "FEATURED",
					FontFace = Theme.typography.heading.font,
					TextSize = Theme.typography.heading.textSize,
					TextColor3 = Theme.colors.accentValue, -- yellow uppercase section heading (token)
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 1,
					ZIndex = 2,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
				}),
				Grid = e("ScrollingFrame", {
					ref = scrollingFrameRef,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, -40),
					Position = UDim2.new(0, 0, 0, 40),
					ScrollBarThickness = 6,
					ScrollBarImageColor3 = Theme.colors.onSurface,
					ScrollBarImageTransparency = 0.3,
					LayoutOrder = 2,
				}, {
					Layout = e("UIGridLayout", {
						ref = gridLayoutRef,
						CellSize = UDim2.new(0, 200, 0, 240),
						CellPadding = UDim2.new(0, Theme.spacing.md, 0, Theme.spacing.md),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Acorn = e(ItemCard, {
						name = ITEMS[1].name,
						rarity = ITEMS[1].rarity,
						price = ITEMS[1].price,
						icon = Theme.assets[ITEMS[1].icon],
						layoutOrder = 1,
					}),
					Feather = e(ItemCard, {
						name = ITEMS[2].name,
						rarity = ITEMS[2].rarity,
						price = ITEMS[2].price,
						icon = Theme.assets[ITEMS[2].icon],
						layoutOrder = 2,
					}),
					Crystal = e(ItemCard, {
						name = ITEMS[3].name,
						rarity = ITEMS[3].rarity,
						price = ITEMS[3].price,
						icon = Theme.assets[ITEMS[3].icon],
						layoutOrder = 3,
					}),
					Lantern = e(ItemCard, {
						name = ITEMS[4].name,
						rarity = ITEMS[4].rarity,
						price = ITEMS[4].price,
						icon = Theme.assets[ITEMS[4].icon],
						layoutOrder = 4,
					}),
					Compass = e(ItemCard, {
						name = ITEMS[5].name,
						rarity = ITEMS[5].rarity,
						price = ITEMS[5].price,
						icon = Theme.assets[ITEMS[5].icon],
						layoutOrder = 5,
					}),
					Crown = e(ItemCard, {
						name = ITEMS[6].name,
						rarity = ITEMS[6].rarity,
						price = ITEMS[6].price,
						icon = Theme.assets[ITEMS[6].icon],
						emphasized = true,
						layoutOrder = 6,
					}),
				}),
			}),
		})
	end,
}
