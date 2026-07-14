-- Standard showcase: HUD.story (standard-showcase.md).
-- Screen Patterns (Loud Slab): left-edge vertical rail of ~90px side-button
-- slabs; bottom-left the mega cash counter with a boost caption; bottom-
-- center a numbered hotbar; top-right a translucent leaderboard plate;
-- bottom-right a tiny timer badge. Reserved zones (layout-rules.md #5):
-- bottom-left/right stay clear of the joystick/jump footprint by docking the
-- cash counter and timer badge ABOVE the very corner, and the hotbar is
-- centered, not corner-anchored.
--
-- This taste has no dedicated PLAY button in its own Screen Patterns prose
-- (collector/PvP sim HUDs put PLAY as a side-button-class rail entry, not a
-- standalone CTA) -- the standard showcase's "one contextual primary action
-- labeled PLAY" is realized here as a button-cta slab bottom-center-ish above
-- the hotbar, since {colors.cta} mustard is this taste's "one big commitment"
-- voice and a live HUD is exactly one such moment (queueing into a match).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local SideButton = require(script.Parent.Parent.Components.SideButton)
local CurrencyDisplay = require(script.Parent.Parent.Components.CurrencyDisplay)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

local HOTBAR_SLOTS = 10

local function HotbarSlot(props)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDark,
		BackgroundTransparency = 0.15,
		Size = UDim2.fromOffset(52, 52),
		LayoutOrder = props.layoutOrder,
		ZIndex = 1,
	}, {
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.slotOutline.thickness,
			Color = Theme.strokes.slotOutline.color,
			ApplyStrokeMode = Theme.strokes.slotOutline.mode,
		}),
		-- badge-slot: white outlined number tucked in the slot's corner.
		Badge = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromOffset(2, 2),
			Text = tostring(props.slotNumber),
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = 2,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}),
	})
end

-- Column width fractions (0.4 / 0.2 / 0.2 / 0.2) sum to exactly 1.0 of the
-- row's own width, but the row's UIListLayout ALSO inserts horizontal
-- Padding (spacing.sm) between the 4 columns -- 3 gaps the fractions never
-- accounted for, which is what pushed the Cash column (last, right-docked)
-- past the row's own bounds and off the right edge in 720p captures (root
-- cause of the leaderboard truncation, distinct from the plate's own width,
-- which was also widened -- see the Leaderboard frame comment below). Each
-- column's Size now carries a small NEGATIVE offset proportional to its
-- fraction share of the 3 gaps (3 * spacing.sm = 24px total), so the
-- fraction-plus-gap math sums back to exactly 1.0 of the row width:
-- Player (0.4 share) eats 0.4 * 24 = 9.6px, each 0.2 column eats 4.8px.
local GAP_TOTAL = Theme.spacing.sm * 3
local function LeaderboardRow(props)
	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 22),
		LayoutOrder = props.layoutOrder,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.sm),
		}),
		Player = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.4, -GAP_TOTAL * 0.4, 1, 0),
			Text = props.player,
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.onSurface,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = 1,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = 2,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			}),
		}),
		Steals = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.2, -GAP_TOTAL * 0.2, 1, 0),
			Text = tostring(props.steals),
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.accentValue,
			LayoutOrder = 2,
			ZIndex = 2,
		}),
		Rebirths = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.2, -GAP_TOTAL * 0.2, 1, 0),
			Text = tostring(props.rebirths),
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.onSurface,
			LayoutOrder = 3,
			ZIndex = 2,
		}),
		Cash = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.2, -GAP_TOTAL * 0.2, 1, 0),
			Text = tostring(props.cash),
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.currencySoft,
			LayoutOrder = 4,
			ZIndex = 2,
		}),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Cash = 12400,
		Badge = 3,
	},
	story = function(props)
		-- standard-showcase.md's topbar-clearance rule: the mount harness's
		-- ScreenGui is full-bleed (IgnoreGuiInset=true), so y=0 sits UNDER the
		-- Roblox topbar. LeftRail and Leaderboard below are top-docked and must
		-- offset by the live gui inset (queried at render, never hardcoded) to
		-- clear it -- this taste never got the earlier standard-showcase.md
		-- topbar-clearance fix (verified failure mode: LeftRail Shop trueY=28,
		-- Leaderboard trueY=12, both inside the topbar zone).
		local topInset = game:GetService("GuiService"):GetGuiInset().Y
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = true,
		}, {
			-- Left-edge vertical rail of ~90px side-button slabs. At 667x375, vertically
			-- centered with the original 88px anatomy + sm gaps has no room: 3*88 +
			-- 2*8 = 280px vs only ~200px available between the topbar clearance and
			-- the (also-repositioned) CashCorner above the hotbar -- proven
			-- impossible by pure position/gap tuning alone. Top-anchored (was
			-- vertically centered) with button height 88->44 (this taste has no
			-- "chunky" tap-target designation, so the generic 44px floor applies,
			-- layout-rules.md #5) and gap sm->xs is the smallest combination that
			-- clears CashCorner below it (verified failure mode: CashCorner
			-- overlapped LeftRail Settings and Hotbar Slot1 overlapped CashCorner's
			-- Caption line).
			LeftRail = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(90, 44 * 3 + Theme.spacing.xs * 2),
				Position = UDim2.fromOffset(Theme.spacing.md, topInset + Theme.spacing.xs),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.xs),
				}),
				Shop = e(SideButton, {
					text = "Shop",
					icon = Theme.assets.iconShop,
					size = UDim2.fromOffset(90, 44),
					layoutOrder = 1,
				}),
				Items = e(SideButton, {
					text = "Items",
					icon = Theme.assets.iconItems,
					badge = props.controls.Badge,
					size = UDim2.fromOffset(90, 44),
					layoutOrder = 2,
				}),
				Settings = e(SideButton, {
					text = "Settings",
					icon = Theme.assets.iconSettings,
					size = UDim2.fromOffset(90, 44),
					layoutOrder = 3,
				}),
			}),
			-- Top-right translucent leaderboard plate, docked at this taste's
			-- edge-dock margin (Theme.spacing.md) inside the 1280px viewport. The
			-- real truncation bug lived in LeaderboardRow's own column sizing
			-- (see the GAP_TOTAL comment above) -- the 4 columns' width
			-- FRACTIONS summed to exactly 1.0 of the row width without leaving
			-- room for the row's own UIListLayout Padding (3 gaps = 24px), so the
			-- Cash column (last, right-docked) overflowed past the row AND past
			-- this plate's own right edge, clipped only by the viewport itself in
			-- 720p captures. With the row fix, this frame's original 260px width
			-- already fits its content correctly.
			Leaderboard = e("Frame", {
				BackgroundColor3 = Theme.colors.surfaceDark,
				BackgroundTransparency = 0.3,
				Size = UDim2.fromOffset(260, 120),
				Position = UDim2.new(1, -Theme.spacing.md, 0, Theme.spacing.md + topInset),
				AnchorPoint = Vector2.new(1, 0),
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.slotOutline.thickness,
					Color = Theme.strokes.slotOutline.color,
					ApplyStrokeMode = Theme.strokes.slotOutline.mode,
				}),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.sm),
					PaddingRight = UDim.new(0, Theme.spacing.sm),
					PaddingTop = UDim.new(0, Theme.spacing.xs),
					PaddingBottom = UDim.new(0, Theme.spacing.xs),
				}),
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Row1 = e(LeaderboardRow, { player = "Kai", steals = 41, rebirths = 3, cash = "82K", layoutOrder = 1 }),
				Row2 = e(LeaderboardRow, { player = "Miku", steals = 37, rebirths = 2, cash = "65K", layoutOrder = 2 }),
				Row3 = e(LeaderboardRow, { player = "Jax", steals = 29, rebirths = 2, cash = "58K", layoutOrder = 3 }),
			}),
			-- Bottom-left mega cash counter with boost caption (money corner) --
			-- documented desktop placement is flush at spacing.lg from the bottom
			-- edge, but at 667x375 that put its Caption line inside the Hotbar row
			-- below (verified failure mode: CashCorner-Caption overlapped Hotbar
			-- Slot1). Bottom-anchor offset raised so the block's real footprint
			-- (74px, tightened to its own text metrics -- see CurrencyDisplay.luau)
			-- clears BOTH the LeftRail above it and the Hotbar row below it; still
			-- bottom-left, just lifted off the exact corner (matching this taste's
			-- own Screen Patterns note that bottom corners dock "ABOVE the very
			-- corner", not flush in it).
			CashCorner = e(CurrencyDisplay, {
				amount = props.controls.Cash,
				caption = "2x Cash Boost Active",
				position = UDim2.new(
					0,
					Theme.spacing.lg,
					1,
					-- 94px = distance from the screen bottom up to the Hotbar row's own
					-- top edge (measured in-engine: Hotbar sits at trueY 285 in a
					-- 375px-tall viewport, so 375-285=90) plus spacing.xs breathing
					-- room, so CashCorner's real 74px-tall footprint (tightened in
					-- CurrencyDisplay.luau) lands entirely above Hotbar instead of
					-- overlapping its first slot (verified failure mode).
					-90 - Theme.spacing.xs
				),
				anchorPoint = Vector2.new(0, 1),
			}),
			-- Bottom-right tiny timer badge.
			TimerBadge = e("Frame", {
				BackgroundColor3 = Theme.colors.surfaceDark,
				BackgroundTransparency = 0.15,
				Size = UDim2.fromOffset(72, 32),
				Position = UDim2.new(1, -Theme.spacing.lg, 1, -Theme.spacing.lg),
				AnchorPoint = Vector2.new(1, 1),
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.slotOutline.thickness,
					Color = Theme.strokes.slotOutline.color,
					ApplyStrokeMode = Theme.strokes.slotOutline.mode,
				}),
				Text = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = "02:14",
					FontFace = Theme.typography.caption.font,
					TextScaled = true,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = 2,
				}, {
					Stroke = e("UIStroke", {
						Thickness = 2,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
					}),
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = 16 }),
				}),
			}),
			-- Bottom-center: PLAY commitment slab above the hotbar (button-cta
			-- voice: mustard, one per window/screen at most) + the numbered hotbar.
			BottomCenter = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(HOTBAR_SLOTS * 52 + (HOTBAR_SLOTS - 1) * Theme.spacing.sm, 130),
				Position = UDim2.new(0.5, 0, 1, -Theme.spacing.lg),
				AnchorPoint = Vector2.new(0.5, 1),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.sm),
				}),
				Play = e(ButtonPrimary, {
					variant = "cta",
					text = "Play",
					size = UDim2.new(0, 220, 0, 52),
					layoutOrder = 1,
				}),
				Hotbar = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 52),
					LayoutOrder = 2,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, Theme.spacing.sm),
					}),
					Slot1 = e(HotbarSlot, { slotNumber = 1, layoutOrder = 1 }),
					Slot2 = e(HotbarSlot, { slotNumber = 2, layoutOrder = 2 }),
					Slot3 = e(HotbarSlot, { slotNumber = 3, layoutOrder = 3 }),
					Slot4 = e(HotbarSlot, { slotNumber = 4, layoutOrder = 4 }),
					Slot5 = e(HotbarSlot, { slotNumber = 5, layoutOrder = 5 }),
					Slot6 = e(HotbarSlot, { slotNumber = 6, layoutOrder = 6 }),
					Slot7 = e(HotbarSlot, { slotNumber = 7, layoutOrder = 7 }),
					Slot8 = e(HotbarSlot, { slotNumber = 8, layoutOrder = 8 }),
					Slot9 = e(HotbarSlot, { slotNumber = 9, layoutOrder = 9 }),
					Slot10 = e(HotbarSlot, { slotNumber = 10, layoutOrder = 10 }),
				}),
			}),
		})
	end,
}
