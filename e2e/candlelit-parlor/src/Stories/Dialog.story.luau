-- Standard showcase: Dialog.story (standard-showcase.md).
-- No bespoke "dialog" anatomy exists in this taste's DESIGN.md — reusing the
-- closest existing window variant at a smaller size is "the expected answer,
-- not a workaround" (standard-showcase.md's own guidance). ParlorWindow at
-- popup size (offset 420x220 instead of the Shop window's larger scale-based
-- footprint), same near-black translucent panel, 2px cream stroke, bare
-- cream X close (no red circle, ever — Do's and Don'ts). Dim backdrop:
-- ParlorWindow's own dim-tap-to-dismiss layer (Elevation prose: "Popup
-- layering: dim -> window -> floating text" — Dialog IS a popup, so the dim
-- is in-bounds here even though it's not exercised by the Shop window).
-- Primary confirm: ParlorButton (button-primary) reused for CONFIRM — this
-- taste's Do's and Don'ts caps the cream CTA fill at "no more than one
-- element per screen," which this dialog respects (the only cream-filled
-- surface in the popup). Dismiss affordance: the window's own bare-X, per
-- this taste's prose ("closing is a bare cream ✕") — no separate Cancel
-- button was invented.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ParlorWindow = require(script.Parent.Parent.Components.ParlorWindow)
local ParlorButton = require(script.Parent.Parent.Components.ParlorButton)

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
			Dialog = e(ParlorWindow, {
				title = "Confirm",
				size = UDim2.fromOffset(420, 220),
			}, {
				-- Content delegates stacking to UIListLayout (layout-rules.md
				-- #1) — ParlorWindow's Content frame is a bare passthrough, so
				-- the composing story supplies its own layout instance here.
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				Body = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 48),
					LayoutOrder = 1,
					Text = props.controls.Body, -- serif flavor voice, sentence case
					FontFace = Theme.typography.body.font,
					TextSize = Theme.typography.body.textSize,
					TextColor3 = Theme.colors.onSurface,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 2,
				}),
				Confirm = e(ParlorButton, {
					text = "Confirm",
					size = UDim2.new(1, 0, 0, 56),
					layoutOrder = 2,
				}),
			}),
		})
	end,
}
