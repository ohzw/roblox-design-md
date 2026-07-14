-- Standard showcase: Shop.story (standard-showcase.md).
-- Screen Patterns ("Shop / crafting"): "left third = scrolling column of
-- list-row items on a white panel with a thin scrollbar; center = the 3D
-- world shows the selected item; right = blue info card stack (title band,
-- price sub-band, long stat list in white stroked text...); bottom-center =
-- blue CTA frame containing button-primary flanked by square arrow paddles
-- for prev/next." The honey `window` hosts the list column (its own family,
-- "SHOP" titled per the taste's shop word); the info stack and CTA frame are
-- the `window-info` family per the anatomy's blue-family rules.
-- Fixed catalog set (standard-showcase.md): Acorn/Feather (common),
-- Crystal/Lantern (rare), Compass (epic), Crown (legendary + emphasis) at
-- 25/40/120/150/600/2500. Crown gets this taste's ONE emphasis device: a
-- surfaceHeader honey-yellow row fill (list-row `emphasized` prop), matching
-- the Premium-offers pattern's "Item tiers titled in the header yellow ink."

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ListRow = require(script.Parent.Parent.Components.ListRow)
local ButtonBuy = require(script.Parent.Parent.Components.ButtonBuy)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

local ITEMS = {
	{ key = "Acorn", title = "Acorn", tier = "Common", price = 25, icon = "itemAcorn" },
	{ key = "Feather", title = "Feather", tier = "Common", price = 40, icon = "itemFeather" },
	{ key = "Crystal", title = "Crystal", tier = "Rare", price = 120, icon = "itemCrystal" },
	{ key = "Lantern", title = "Lantern", tier = "Rare", price = 150, icon = "itemLantern" },
	{ key = "Compass", title = "Compass", tier = "Epic", price = 600, icon = "itemCompass" },
	{ key = "Crown", title = "Crown", tier = "Legendary", price = 2500, icon = "itemCrown", emphasized = true },
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Selected = "Crown",
	},
	story = function(props)
		local selectedKey, setSelectedKey = React.useState(props.controls.Selected)
		local selectedItem = nil
		for _, item in ITEMS do
			if item.key == selectedKey then
				selectedItem = item
			end
		end

		-- Responsive window pattern: this Shop screen composes THREE
		-- independent windows (ShopWindow, InfoCard, CtaFrame) that used
		-- fixed desktop offsets (360x560 at 20,20 / 380x300 at top-right /
		-- 360x72 at bottom-center) -- all three together never fit a
		-- 667x375 phone-landscape viewport at their desktop sizes, let alone
		-- side by side. Each window keeps its own Scale-first size + MaxSize
		-- (its prior fixed desktop dimensions as the ceiling), but the
		-- POSITIONS are re-derived as a two-column layout (ShopWindow left,
		-- InfoCard+CtaFrame stacked right) using Scale fractions of the
		-- root instead of fixed spacing.lg offsets from the edges -- so at
		-- viewports >= the combined desktop footprint, Scale resolves back
		-- toward the original absolute layout (clamped per-window by
		-- MaxSize), while at phone landscape all three stay visible,
		-- non-overlapping, and on-screen.
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Left column: the honey `window`, titled with the taste's own
			-- shop word, hosting the scrolling list-row column.
			ShopWindow = e(Window, {
				variant = "honey",
				title = "Shop",
				size = UDim2.fromScale(0.42, 0.93),
				maxSize = Vector2.new(360, 560),
				position = UDim2.fromScale(0.02, 0.02),
				scrollable = true,
				instant = true, -- catalog snapshot: hard cut, period-correct per Motion prose
			}, (function()
				local children = {}
				for i, item in ITEMS do
					children[item.key] = e(ListRow, {
						title = item.title,
						description = item.tier,
						icon = Theme.assets[item.icon],
						emphasized = item.emphasized,
						selected = item.key == selectedKey,
						layoutOrder = i,
						onActivated = function()
							setSelectedKey(item.key)
						end,
					}, {
						Buy = e(ButtonBuy, {
							price = item.price,
							zIndex = 5,
						}),
					})
				end
				return children
			end)()),
			-- Right column, top: blue info card stack -- title band, price
			-- sub-band, stat list.
			InfoCard = e(Window, {
				variant = "info",
				title = selectedItem and selectedItem.title or "Item",
				size = UDim2.fromScale(0.42, 0.62),
				maxSize = Vector2.new(380, 300),
				position = UDim2.new(0.98, 0, 0.02, 0),
				anchorPoint = Vector2.new(1, 0),
				instant = true,
			}, {
				PriceRow = e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceInfoDeep,
					Size = UDim2.new(1, 0, 0, 40),
					LayoutOrder = 1,
				}, {
					Label = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Text = selectedItem and ("Price: " .. tostring(selectedItem.price)) or "",
						FontFace = Theme.typography.utility.font,
						TextScaled = true,
						TextColor3 = Theme.colors.white,
						ZIndex = 2,
					}, {
						Stroke = e("UIStroke", {
							Thickness = Theme.strokes.textOutline.thickness,
							Color = Theme.strokes.textOutline.color,
							ApplyStrokeMode = Theme.strokes.textOutline.mode,
						}),
						MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.utility.textSize }),
					}),
				}),
				StatRow = e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceInfoDeep,
					Size = UDim2.new(1, 0, 0, 96),
					LayoutOrder = 2,
				}, {
					Label = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -Theme.spacing.md * 2, 1, -Theme.spacing.md * 2),
						Position = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
						Text = selectedItem and (selectedItem.tier .. " tier collectible. Adds to your ledger tally.")
							or "",
						FontFace = Theme.typography.body.font,
						TextSize = Theme.typography.body.textSize,
						TextColor3 = Theme.colors.white,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
						ZIndex = 2,
					}, {
						Stroke = e("UIStroke", {
							Thickness = Theme.strokes.textOutline.thickness,
							Color = Theme.strokes.textOutline.color,
							ApplyStrokeMode = Theme.strokes.textOutline.mode,
						}),
					}),
				}),
			}),
			-- Right column, bottom: blue CTA frame -- button-primary flanked
			-- by square arrow paddles for prev/next (Pager pattern: paddle
			-- color follows the host window family -- blue on shop CTA
			-- frames). Re-anchored under InfoCard in the right column
			-- (rather than bottom-center of the whole screen) so it never
			-- overlaps ShopWindow's list at phone-landscape widths.
			CtaFrame = e("Frame", {
				BackgroundColor3 = Theme.colors.surfaceInfo,
				Size = UDim2.fromScale(0.42, 0.24),
				Position = UDim2.new(0.98, 0, 0.98, 0),
				AnchorPoint = Vector2.new(1, 1),
			}, {
				MaxSize = e("UISizeConstraint", { MaxSize = Vector2.new(360, 72) }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.frame.thickness,
					Color = Theme.strokes.frame.color,
					ApplyStrokeMode = Theme.strokes.frame.mode,
				}),
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Prev = e("TextButton", {
					Text = "<",
					AutoButtonColor = false,
					BackgroundColor3 = Theme.colors.secondary,
					Size = UDim2.fromOffset(44, 44),
					FontFace = Theme.typography.label.font,
					TextScaled = true,
					TextColor3 = Theme.colors.white,
					LayoutOrder = 1,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
				}),
				Buy = e(ButtonPrimary, {
					text = "Craft",
					layoutOrder = 2,
				}),
				Next = e("TextButton", {
					Text = ">",
					AutoButtonColor = false,
					BackgroundColor3 = Theme.colors.secondary,
					Size = UDim2.fromOffset(44, 44),
					FontFace = Theme.typography.label.font,
					TextScaled = true,
					TextColor3 = Theme.colors.white,
					LayoutOrder = 3,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
				}),
			}),
		})
	end,
}
