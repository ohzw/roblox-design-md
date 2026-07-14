-- Standard showcase: Dialog.story (standard-showcase.md).
-- Reuses the Window anatomy at a small popup size -- this taste's Window
-- component IS the confirm-popup anatomy (square slab, chrome header band,
-- brick-red close square docked in the band). Dismiss affordance is the
-- close button (per-taste "the close button... is the only red chrome");
-- dim-tap is also wired since the Window's dim-overlay is dismissible by
-- default. Primary confirm uses button-buy (this taste's buy-grammar voice)
-- since the action IS a purchase confirmation.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Components.Window)
local ButtonPrimary = require(script.Parent.Parent.Components.ButtonPrimary)

local e = React.createElement

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {},
	story = function()
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			WindowRoot = e(Window, {
				title = "Confirm",
				-- Responsive window pattern: size the dialog to its content
				-- instead of a raw viewport fraction. The previous
				-- fromScale(0.32, 0.34) resolved to ~213x128 at 667x375 --
				-- undersized for its own content: HEADER_HEIGHT (72) alone
				-- left ~56px for a 60px Body label plus a 52px Confirm button,
				-- so "CONFIRM" truncated, the body clipped, and Confirm was
				-- pushed out of the panel entirely. 340x260 fits
				-- HEADER_HEIGHT(72) + Content padding(20+20) + Body(60) +
				-- gap(20) + Confirm button(52) with margin, and gives the
				-- fixed-TextSize "CONFIRM" heading (36px, not TextScaled)
				-- enough width to avoid AtEnd truncation. Still Scale+MaxSize
				-- per the pattern: scales down further only if the viewport
				-- itself is smaller than this.
				size = UDim2.fromScale(0.51, 0.693),
				maxSize = Vector2.new(340, 260),
				showDim = true,
				dismissible = true,
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.lg),
				}),
				Body = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 60),
					Text = "Buy Crown for 2,500?",
					FontFace = Theme.typography.body.font,
					TextSize = Theme.typography.body.textSize,
					TextColor3 = Theme.colors.onSurface,
					TextWrapped = true,
					LayoutOrder = 1,
					ZIndex = 2,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
				}),
				Confirm = e(ButtonPrimary, {
					variant = "buy",
					text = "2,500",
					size = UDim2.new(0.8, 0, 0, 52),
					layoutOrder = 2,
				}),
			}),
		})
	end,
}
