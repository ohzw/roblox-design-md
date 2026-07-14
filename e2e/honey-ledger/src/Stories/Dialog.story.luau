-- Standard showcase: Dialog.story (standard-showcase.md).
-- Matches shot-6 (crop 882x388: "confirmation dialog -- bright blue frame,
-- darker inner text well, green Yes / red No"): the `window-info` family,
-- accentSelect bright-blue outer frame, a surfaceInfoDeep inner text well
-- for the body line, green button-primary Yes / red No pair -- "this taste
-- happily shows both at once and lets color do the reading" (Colors prose).
-- No dim backdrop was observed behind ANY window (declared gap) -- the
-- dialog sits raw over the world backdrop, per Elevation & Depth: "windows
-- sit directly over the world; separation comes from fill saturation."
-- Dismiss affordance: the info family's flat close square, docked LEFT
-- inside the header band (this taste's dismiss grammar, not a dim-tap).

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
				variant = "info",
				title = "Confirm",
				size = UDim2.fromOffset(420, 260),
				position = UDim2.fromScale(0.5, 0.5),
				anchorPoint = Vector2.new(0.5, 0.5),
				-- Bright accentSelect frame overrides the default navy `frame`
				-- stroke: this is the dialog-specific "outer frame" reading
				-- from Colors prose ("accentSelect ... dialog outer frame").
				frameColor = Theme.colors.accentSelect,
			}, {
				TextWell = e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceInfoDeep,
					Size = UDim2.new(1, 0, 0, 96),
					LayoutOrder = 1,
				}, {
					Body = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -Theme.spacing.md * 2, 1, -Theme.spacing.md * 2),
						Position = UDim2.fromOffset(Theme.spacing.md, Theme.spacing.md),
						Text = props.controls.Body,
						FontFace = Theme.typography.utility.font,
						TextSize = Theme.typography.utility.textSize,
						TextColor3 = Theme.colors.white,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						ZIndex = 2,
					}, {
						Stroke = e("UIStroke", {
							Thickness = Theme.strokes.textOutline.thickness,
							Color = Theme.strokes.textOutline.color,
							ApplyStrokeMode = Theme.strokes.textOutline.mode,
						}),
					}),
				}),
				Actions = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 44),
					LayoutOrder = 2,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, Theme.spacing.md),
					}),
					-- Yes/No pair: both visible at once, state read by which
					-- side is saturated (Do's and Don'ts) -- here both are
					-- always "on" since neither is a persisted toggle.
					No = e("TextButton", {
						Text = "",
						AutoButtonColor = false,
						BackgroundColor3 = Theme.colors.danger,
						Size = UDim2.fromOffset(150, 44),
						LayoutOrder = 1,
					}, {
						Label = e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							Text = "No",
							FontFace = Theme.typography.label.font,
							TextScaled = true,
							TextColor3 = Theme.colors.white,
							ZIndex = 2,
						}, {
							Stroke = e("UIStroke", {
								Thickness = Theme.strokes.textOutline.thickness,
								Color = Theme.strokes.textOutline.color,
								ApplyStrokeMode = Theme.strokes.textOutline.mode,
							}),
							MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
						}),
					}),
					Yes = e(ButtonPrimary, {
						text = "Yes",
						size = UDim2.fromOffset(150, 44),
						layoutOrder = 2,
					}),
				}),
			}),
		})
	end,
}
