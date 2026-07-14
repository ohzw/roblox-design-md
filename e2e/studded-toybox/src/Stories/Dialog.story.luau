-- Standard showcase Dialog (standard-showcase.md): a small confirm popup
-- over the taste's backdrop treatment, title CONFIRM, body "Buy Crown for
-- 2,500?", a primary confirm and the taste's dismiss affordance.
--
-- Screen Patterns ("Input dialog"): "compact window, header with a status
-- icon, inset outlined input well on the translucent body, single centered
-- green confirm slab." This taste's dismiss affordance is the window's own
-- flush close slab (Components: button-close) -- there is no separate
-- cancel-button or dim-tap-only convention documented, and Elevation prose
-- says windows self-dim via their own well rather than a tap-dismiss
-- backdrop, so `showDim` here is a thin non-dismissing veil (tap-to-close
-- would contradict "let the window body do the dimming; don't add a separate
-- backdrop layer" if it became load-bearing) -- the X slab is the one and
-- only dismiss path, matching this taste's own anatomy.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local GradientButton = require(script.Parent.Parent.Components.GradientButton)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Body = "Buy Crown for 2,500?",
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(Window, {
				title = "Confirm", -- Title Case per Typography prose (never all-caps), matches standard-showcase's CONFIRM title semantically
				icon = "\u{2713}", -- status icon per "Input dialog" pattern (checkmark, tofu-tested ASCII/geometric per verification.md)
				showDim = true,
				size = UDim2.fromOffset(560, 360),
			}, {
				Column = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 5,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, Theme.spacing.lg),
					}),
					-- Inset outlined well holding the body line (Screen Patterns:
					-- "inset outlined input well on the translucent body" -- reused
					-- here as a message well since this dialog confirms rather than
					-- collects text).
					Well = e("Frame", {
						BackgroundColor3 = Theme.colors.outline,
						BackgroundTransparency = 0.5,
						Size = UDim2.new(1, 0, 0, 72),
						LayoutOrder = 1,
					}, {
						Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
						Stroke = e("UIStroke", {
							Thickness = Theme.strokes.outline.thickness,
							Color = Theme.strokes.outline.color,
							ApplyStrokeMode = Theme.strokes.outline.mode,
						}),
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
					Confirm = e(GradientButton, {
						variant = "primary",
						text = "Confirm",
						size = UDim2.fromOffset(260, 70),
						layoutOrder = 2,
					}),
				}),
			}),
		})
	end,
}
