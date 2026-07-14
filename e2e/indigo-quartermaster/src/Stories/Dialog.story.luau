-- Standard showcase: Dialog.story (standard-showcase.md). Fixed content:
-- title CONFIRM, body "Buy Crown for 2,500?", primary confirm + dismiss.
--
-- Taste-fit note: Indigo Quartermaster documents no bespoke "dialog"
-- anatomy -- per standard-showcase.md ("reuse the closest existing window
-- variant at a smaller size -- that IS the expected answer"), this reuses
-- Window's popup variant (flat surface panel, 8px corners, no stroke/shadow,
-- 48px integrated header band, bare white X flush right) at a small size,
-- with the dim wash for the backdrop treatment and the green button-primary
-- footer convention from the Window anatomy prose ("the footer convention is
-- either a green button-primary bottom-right (forms/popups)...").
-- Title casing: DESIGN.md's window titles are documented sentence-case
-- ("Title sits left in the band, white Bold, sentence case") -- CONFIRM's
-- all-caps spelling here is the standard-showcase's fixed content
-- requirement, kept verbatim rather than re-cased, and noted as the one
-- place this story's literal text overrides the taste's own casing rule.

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
			Confirm = e(Window, {
				variant = "popup",
				title = "CONFIRM",
				size = UDim2.fromOffset(420, 220),
				showDim = true,
				dismissible = true, -- dim-tap dismiss, plus the bare X close glyph
			}, {
				Body = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 50),
					Text = "Buy Crown for 2,500?",
					FontFace = Theme.typography.body.font,
					TextSize = Theme.typography.body.textSize,
					TextColor3 = Theme.colors.onSurface,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
				}),
				ConfirmButton = e(ButtonPrimary, {
					text = "Confirm",
					variant = "primary",
					size = UDim2.fromOffset(160, 44),
					position = UDim2.new(1, 0, 1, 0),
					anchorPoint = Vector2.new(1, 1),
				}),
			}),
		})
	end,
}
