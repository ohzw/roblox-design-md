-- Standard showcase: HUD.story (standard-showcase.md).
-- Screen Patterns (desktop, observed): green Shop launcher on the left edge
-- at mid-height; hotbar of 9-10 badge-slot tiles bottom-center; oversized
-- currency-counter bottom-left; translucent leaderboard top-right. Only ONE
-- launcher ("Shop") was directly observed; standard-showcase.md's three
-- launchers (SHOP/ITEMS/SETTINGS) are realized here as a vertical stack of
-- side-button plates on the same left edge (Components prose gives no
-- anatomy reason Items/Settings would differ from Shop's side-button token
-- -- derived-token rule, generation-procedure.md). The notification badge
-- (standard-showcase.md) is this taste's badge-slot dot, documented for
-- hotbar tiles in the DESIGN.md -- transplanted onto the Items launcher here
-- for comparability (standard-showcase.md's own transplant allowance), noted.
-- Currency: 12,400 soft currency via currency-counter, bottom-left, its
-- documented HUD position -- no hard-currency token exists in this taste
-- (Colors prose: currency-hard is "exclusively the premium price button"
-- inside shop rows, never a HUD readout), so no second HUD amount is shown.
-- PLAY: never mentioned in this taste's HUD prose (silence, not
-- contradiction) -- included per standard-showcase.md's inference rule,
-- reusing button-primary's dominant CTA anatomy, placed bottom-center; this
-- is an inferred placement/addition, noted.
-- Reserved zones (layout-rules.md #5): hotbar sits bottom-center (not
-- corner-anchored); PLAY sits bottom-center above it; bottom-left/right
-- corners stay clear except for the currency-counter, which the DESIGN.md's
-- own Screen Patterns explicitly docks at bottom-left.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local SideButton = require(script.Parent.Parent.Components.SideButton)
local CurrencyCounter = require(script.Parent.Parent.Components.CurrencyCounter)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

local HOTBAR_SLOTS = 9

-- badge-slot: translucent dark brown square hotbar tile, tiny outlined item
-- text, slot number top-left, red notification dot bottom-right (Components
-- prose). Local to this story: no standalone module was part of this
-- slice's required component set beyond the standard showcase's own list.
local function BadgeSlot(props)
	return e("Frame", {
		BackgroundColor3 = Theme.storyComponents.badgeSlot,
		BackgroundTransparency = Theme.badgeSlotTransparency,
		Size = UDim2.fromOffset(56, 56),
		LayoutOrder = props.layoutOrder,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		SlotNumber = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(0, 2, 0, 2),
			Text = tostring(props.slot),
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
	})
end

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
		-- Roblox topbar. The Leaderboard panel below previously hardcoded a
		-- 66px offset as a stand-in for the topbar inset -- replaced with the
		-- live queried value (never hardcode 58/66) so it stays correct if the
		-- inset changes.
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		local slots = {}
		slots.Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, Theme.spacing.sm),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		for i = 1, HOTBAR_SLOTS do
			slots["Slot" .. i] = e(BadgeSlot, { slot = i, layoutOrder = i })
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = true,
		}, {
			-- Left-edge vertical stack: SHOP / ITEMS / SETTINGS launchers. Button
			-- height 88->56 and inter-button gap md->sm at 667x375: vertically
			-- centered with the original 88px anatomy has no room in this
			-- viewport (3*88 + 2*12 = 288px vs only ~220px available between the
			-- topbar clearance and the bottom cluster -- proven impossible by
			-- pure position/gap tuning; solving for zero overlap needs <44px
			-- buttons, under the generic tap-target floor). 56px lands exactly on
			-- this taste's own documented chunky tap-target minimum
			-- (layout-rules.md #5), not an arbitrary shrink.
			LeftRail = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(96, 56 * 3 + Theme.spacing.sm * 2),
				Position = UDim2.new(0, Theme.spacing.md, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.sm),
				}),
				Shop = e(SideButton, {
					text = "Shop",
					icon = Theme.assets.iconShop,
					size = UDim2.fromOffset(96, 56),
					layoutOrder = 1,
				}),
				Items = e(SideButton, {
					text = "Items",
					icon = Theme.assets.iconItems,
					badge = props.controls.ItemsBadge,
					size = UDim2.fromOffset(96, 56),
					layoutOrder = 2,
				}),
				Settings = e(SideButton, {
					text = "Settings",
					icon = Theme.assets.iconSettings,
					size = UDim2.fromOffset(96, 56),
					layoutOrder = 3,
				}),
			}),
			-- Hotbar of badge-slot tiles, bottom-center.
			Hotbar = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset((56 + 8) * HOTBAR_SLOTS, 56),
				Position = UDim2.new(0.5, 0, 1, -Theme.spacing.lg),
				AnchorPoint = Vector2.new(0.5, 1),
			}, slots),
			-- Oversized currency-counter, bottom-left (this taste's own documented
			-- HUD position for it) -- shifted right of the LeftRail's own footprint
			-- (rail right edge = spacing.md + 96 = 108) and narrowed from 280px to
			-- 120px: measured in-engine, the TextScaled numerals render identically
			-- at both widths (TextBounds ~112-116px either way, since the 64px
			-- HEIGHT is the binding constraint, not width) -- the extra reserved
			-- width was what pushed this box into the LeftRail's Settings button
			-- (verified failure mode). Still bottom-left of screen center (667/2),
			-- just clear of the rail column.
			Currency = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(120, 64),
				Position = UDim2.new(0, Theme.spacing.md + 96 + Theme.spacing.sm, 1, -(Theme.spacing.lg + 56 + Theme.spacing.md)),
				AnchorPoint = Vector2.new(0, 1),
			}, {
				Counter = e(CurrencyCounter, { amount = props.controls.Currency, size = UDim2.fromOffset(120, 64) }),
			}),
			-- Contextual primary action: never mentioned in this taste's HUD
			-- prose (silence, not contradiction) -- inferred bottom-center
			-- placement above the hotbar, reusing button-primary's anatomy.
			Play = e(ButtonPrimary, {
				text = "PLAY",
				size = UDim2.fromOffset(180, 56),
				position = UDim2.new(0.5, 0, 1, -(Theme.spacing.lg + 56 + Theme.spacing.lg + Theme.spacing.md)),
				anchorPoint = Vector2.new(0.5, 1),
			}),
			-- Translucent dark leaderboard panel, top-right under the topbar inset.
			Leaderboard = e("Frame", {
				BackgroundColor3 = Theme.colors.outline,
				BackgroundTransparency = 0.35,
				Size = UDim2.fromOffset(220, 140),
				Position = UDim2.new(1, -Theme.spacing.lg, 0, topInset + Theme.spacing.sm), -- clears the live topbar inset (queried, not hardcoded)
				AnchorPoint = Vector2.new(1, 0),
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outline.thickness,
					Color = Theme.strokes.outline.color,
					ApplyStrokeMode = Theme.strokes.outline.mode,
				}),
				Title = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 24),
					Text = "LEADERBOARD",
					FontFace = Theme.typography.caption.font,
					TextScaled = true,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = 2,
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
