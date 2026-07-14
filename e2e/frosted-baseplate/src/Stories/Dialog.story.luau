-- Standard showcase Dialog (standard-showcase.md): a small confirm popup
-- over the taste's backdrop treatment (blur + faint dim per Elevation
-- prose), title CONFIRM, one body line ("Buy Crown for 2,500?"), a primary
-- confirm and the taste's dismiss affordance.
--
-- "Tastes rarely define a bespoke dialog anatomy: reuse the closest existing
-- window variant at a smaller size" -- this taste's Window IS that reuse:
-- same floating title-tab + free-floating cross + inset-column anatomy,
-- just sized down (no separate Dialog component). Dismiss affordance is the
-- window's own free-floating cross (Components: button-close) -- this
-- taste's Do's and Don'ts explicitly bans a heavy dark backdrop and relies
-- on the camera blur to carry focus, so `showDim` stays on (per the taste's
-- own faint-dim + blur anatomy) but is not itself the dismiss trigger's only
-- notable feature -- Window's Dim layer IS tap-to-dismiss already (see
-- Window.luau's requestClose wiring), which doubles as the taste's
-- "dim-tap" affordance alongside the cross.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local Button = require(script.Parent.Parent.Components.Button)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Body = "Buy Crown for 2,500?",
	},
	story = function(props)
		-- Responsive window pattern / floating-chrome clamp: this taste's
		-- free-floating close cross sits ~59.5px ABOVE the panel's own top
		-- edge (Theme.metrics.closeCrossSize * 0.85, from Window.luau's Close
		-- position + AnchorPoint centering) -- the previous default centered
		-- position (fromScale(0.5, 0.52)) put the panel top at ~45px at
		-- 667x375, clipping the cross ~14.5px above y=0. A fixed top offset
		-- (clearing the cross with an 8px margin) keeps the floating tab/
		-- cross fully on-screen at phone landscape while the 300px-tall
		-- panel still comfortably fits above the bottom edge -- this is a
		-- position clamp only, NOT the topbar-clearance pattern Shop.story
		-- uses (this dialog is far smaller than the topbar inset would
		-- matter for), so it does not add GuiInset here.
		local PANEL_TOP = 68 -- clears the free-floating cross (~59.5px above the panel top) with margin
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = "Confirm", -- Title Case per Typography prose (never ALL CAPS); matches standard-showcase's CONFIRM semantically
				icon = "\u{2713}", -- status glyph (tofu-tested ASCII/geometric per verification.md)
				size = UDim2.fromOffset(520, 300),
				position = UDim2.new(0.5, 0, 0, PANEL_TOP),
				anchorPoint = Vector2.new(0.5, 0),
				showDim = true,
			}, {
				Column = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, Theme.spacing.lg),
					}),
					-- Inset well holding the body line -- same surface-deep, no-
					-- stroke row anatomy used elsewhere in this taste (Elevation
					-- prose: "no strokes on rows").
					Well = e("Frame", {
						BackgroundColor3 = Theme.colors.surfaceDeep,
						Size = UDim2.new(1, 0, 0, 64),
						LayoutOrder = 1,
					}, {
						Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
						Body = e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(0.92, 0.92),
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Text = props.controls.Body,
							FontFace = Theme.typography.body.font,
							TextSize = Theme.typography.body.textSize,
							TextColor3 = Theme.colors.onSurface,
							TextWrapped = true,
							ZIndex = 2,
						}, {
							Stroke = e("UIStroke", {
								Thickness = Theme.strokes.textOutline.thickness,
								Color = Theme.strokes.textOutline.color,
								ApplyStrokeMode = Theme.strokes.textOutline.mode,
							}),
						}),
					}),
					Confirm = e(Button, {
						text = "Confirm",
						size = UDim2.fromOffset(240, 68),
						layoutOrder = 2,
					}),
				}),
			}),
		})
	end,
}
