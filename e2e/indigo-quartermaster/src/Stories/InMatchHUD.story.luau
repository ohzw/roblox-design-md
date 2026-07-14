-- Taste-specific fourth story (standard-showcase.md: "Tastes may ADD a
-- fourth story showcasing something unique... clearly named after it").
-- Indigo Quartermaster's Screen Patterns describe TWO distinct HUD voices:
-- a lobby HUD (now the standard HUD.story) and this one -- the in-match
-- HUD -- which switches its base chrome from the lobby indigo to
-- {colors.hud-ink} navy specifically so it recedes against bright game
-- worlds ("Colors" section: "In-match HUD chrome switches to
-- {colors.hud-ink} navy -- colder and darker than the lobby indigo"). That
-- token swap, the badge-slot keybind tags, and the centered
-- interaction-prompt are load-bearing anatomy the standard HUD set can't
-- express (it has no "world gameplay chrome" slot), so they're preserved
-- here rather than folded into HUD.story.
--
-- Screen Patterns: "In-match HUD" -- timer/kill-counter/team-roster hud-pills
-- top-center; hotbar bottom-center as translucent slate squares with
-- badge-slot keybind tags; a centered interaction-prompt floats
-- center-right of the crosshair. Corners stay quiet; bottom-left/right
-- (joystick/jump) reserved zones stay empty (layout-rules.md #5).
-- Backdrop stands in for a bright game world so hud-ink and translucent
-- chrome read in context (this taste has no world-facing token itself).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local HudPill = require(script.Parent.Parent.Components.HudPill)

local e = React.createElement

local HOTBAR_SLOTS = 5

local function HotbarSlot(props)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDark,
		BackgroundTransparency = 0.35, -- in-match chrome is semi-transparent over the world
		Size = UDim2.fromOffset(56, 56),
		LayoutOrder = props.layoutOrder,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		-- badge-slot: tiny dark square keybind tag pinned to the slot's top-left corner.
		Badge = e("Frame", {
			BackgroundColor3 = Theme.colors.surfaceDark,
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.fromOffset(-2, -2),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.none }),
			Key = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = tostring(props.keybind or 1),
				FontFace = Theme.typography.caption.font,
				TextSize = Theme.typography.caption.textSize,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}),
		}),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Timer = "01:47",
		Kills = "3",
		SelectedSlot = 1,
	},
	story = function(props)
		local selected = props.controls.SelectedSlot

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			-- Top-center HUD pill row.
			TopHud = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 420, 0, 48),
				Position = UDim2.new(0.5, 0, 0, 24),
				AnchorPoint = Vector2.new(0.5, 0),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Timer = e(HudPill, {
					text = props.controls.Timer,
					mono = true,
					layoutOrder = 1,
				}),
				Kills = e(HudPill, {
					text = props.controls.Kills .. " kills",
					layoutOrder = 2,
				}),
				Roster = e(HudPill, {
					roster = {
						{ color = Theme.colors.primary, count = 3 },
						{ color = Theme.colors.accentInfo, count = 2 },
						{ color = Theme.colors.danger, count = 1 },
					},
					layoutOrder = 3,
				}),
			}),
			-- Centered interaction-prompt: dark translucent rounded rect,
			-- keybind chip left, muted cost line + bold action line right.
			InteractionPrompt = e("Frame", {
				BackgroundColor3 = Color3.fromHex("#26262B"), -- DESIGN.md-inlined literal (component token itself)
				BackgroundTransparency = 0.25, -- DESIGN.md-inlined literal (component token itself)
				Size = UDim2.fromOffset(320, 64),
				Position = UDim2.new(0.62, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.md),
					PaddingRight = UDim.new(0, Theme.spacing.md),
				}),
				KeyChip = e("Frame", {
					BackgroundColor3 = Theme.colors.onSurface,
					Size = UDim2.fromOffset(36, 36),
					LayoutOrder = 1,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
					Glyph = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Text = "E",
						FontFace = Theme.typography.label.font,
						TextSize = Theme.typography.label.textSize,
						TextColor3 = Color3.fromHex("#26262B"),
					}),
				}),
				Lines = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, -52, 1, 0),
					LayoutOrder = 2,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Cost = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 20),
						Text = "Costs 50",
						FontFace = Theme.typography.body.font,
						TextSize = Theme.typography.body.textSize,
						TextColor3 = Theme.colors.onSurfaceMuted,
						TextXAlignment = Enum.TextXAlignment.Left,
						LayoutOrder = 1,
					}),
					Action = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 22),
						Text = "Open crate",
						FontFace = Theme.typography.label.font,
						TextSize = Theme.typography.label.textSize,
						TextColor3 = Theme.colors.onSurface,
						TextXAlignment = Enum.TextXAlignment.Left,
						LayoutOrder = 2,
					}),
				}),
			}),
			-- Bottom-center hotbar; bottom-left (joystick) / bottom-right
			-- (jump) reserved zones stay empty per layout-rules.md #5.
			Hotbar = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0, HOTBAR_SLOTS * 56 + (HOTBAR_SLOTS - 1) * 8, 0, 56),
				Position = UDim2.new(0.5, 0, 1, -32),
				AnchorPoint = Vector2.new(0.5, 1),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.sm),
				}),
				Slot1 = e(HotbarSlot, { keybind = 1, layoutOrder = 1, selected = selected == 1 }),
				Slot2 = e(HotbarSlot, { keybind = 2, layoutOrder = 2, selected = selected == 2 }),
				Slot3 = e(HotbarSlot, { keybind = 3, layoutOrder = 3, selected = selected == 3 }),
				Slot4 = e(HotbarSlot, { keybind = 4, layoutOrder = 4, selected = selected == 4 }),
				Slot5 = e(HotbarSlot, { keybind = 5, layoutOrder = 5, selected = selected == 5 }),
			}),
		})
	end,
}
