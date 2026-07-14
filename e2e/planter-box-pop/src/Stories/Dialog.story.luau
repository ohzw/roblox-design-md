-- Standard showcase: Dialog.story (standard-showcase.md).
-- "Tastes rarely define a bespoke 'dialog' anatomy: reuse the closest
-- existing window variant at a smaller size." This taste's `window`
-- component IS that reuse: same stud-quilted body, 14px corners, integrated
-- green header band -- just a smaller popup size (Components prose for
-- window-header already anticipates a non-title use: "a countdown may
-- replace the title", i.e. the header band's title slot is generic).
-- Dismiss affordance: the header's own red button-close square (Do's and
-- Don'ts: "Put the close button INSIDE the header band, square and red,
-- rightmost") -- this taste's documented dismiss grammar, not a dim-tap (no
-- dim token exists at all: Colors prose declares it a gap).
-- Confirm CTA: button-primary gold plate (RESTOCK/Claim's anatomy), reused
-- here for the CONFIRM action per Components prose ("One per header/footer
-- region" -- here the footer region of this small popup).
-- No backdrop dim is rendered (declared gap, Colors section) -- the dialog
-- sits directly over the world backdrop like every other window in this
-- taste (Elevation prose: "windows sit flat over the world with no detached
-- darkness").

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
	controls = {
		Body = "Buy Crown for 2,500?",
	},
	story = function(props)
		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Dialog = e(Window, {
				title = "CONFIRM",
				actionText = nil,
				hideAction = true, -- header cluster keeps only the close square (no RESTOCK plate on a confirm popup)
				size = UDim2.fromOffset(420, 260),
				position = UDim2.fromScale(0.5, 0.5),
				anchorPoint = Vector2.new(0.5, 0.5),
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.lg),
				}),
				Body = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 48),
					Text = props.controls.Body,
					FontFace = Theme.typography.body.font,
					TextScaled = true,
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
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.body.textSize }),
				}),
				Confirm = e(ButtonPrimary, {
					text = "CONFIRM",
					size = UDim2.fromOffset(220, 56),
					layoutOrder = 2,
				}),
			}),
		})
	end,
}
