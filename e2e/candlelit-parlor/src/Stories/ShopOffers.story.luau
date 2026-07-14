-- Taste-specific 4th story (standard-showcase.md: "Tastes may ADD a fourth
-- story showcasing something unique ... clearly named after it"). Retained
-- from the pre-standard-showcase build (formerly ParlorShop.story) because
-- it exercises two things the standard Shop.story genuinely cannot: (1) the
-- **banner-offer** component (gradient display headline + caption + flush
-- price pill in an accent-tinted well) — the standard set has no slot for
-- it; and (2) the **dual gold/rose accent system** ("Gold never touches a
-- life/revive context and rose never touches a commerce/boost context" —
-- Colors prose) — the standard six-item catalog is entirely soft-currency
-- commerce, so it never exercises the rose/life-revive half of this taste's
-- signature two-accent rule. Screen Patterns ("Shop window"): serif title +
-- bare X header, then per section: eyebrow label with a serif hint ->
-- full-width banner-offer strip -> price pills. Gold accents the commerce
-- section, rose accents the revives section; the systems never blend.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)
local ParlorWindow = require(script.Parent.Parent.Components.ParlorWindow)
local BuyPill = require(script.Parent.Parent.Components.BuyPill)

local e = React.createElement

-- Section header row: eyebrow caps (cream for commerce, rose for life
-- items) with a serif hint sentence beside it (Screen Patterns prose).
local function SectionHeader(props)
	local eyebrowText = props.text
	if Theme.typography.eyebrow.uppercase then
		eyebrowText = string.upper(eyebrowText)
	end
	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 32),
		LayoutOrder = props.layoutOrder,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.md),
		}),
		Eyebrow = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = eyebrowText,
			FontFace = Theme.typography.eyebrow.font,
			TextSize = Theme.typography.eyebrow.textSize,
			TextColor3 = props.accentColor,
			LayoutOrder = 1,
		}),
		Hint = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = props.hint, -- serif flavor voice, sentence case
			FontFace = Theme.typography.body.font,
			TextSize = Theme.typography.body.textSize,
			TextColor3 = Theme.colors.onSurface,
			LayoutOrder = 2,
		}),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = {
		Title = "Shop",
		Headline = "5x Boost",
		BannerPrice = 99,
		ShowDim = true,
	},
	story = function(props)
		local headline = props.controls.Headline
		if Theme.typography.display.uppercase then
			headline = string.upper(headline)
		end
		local caption = "For this run only"
		if Theme.typography.caption.uppercase then
			caption = string.upper(caption)
		end

		return e("Frame", {
			BackgroundColor3 = Theme.derived.worldBackdrop,
			Size = UDim2.fromScale(1, 1),
		}, {
			Window = e(ParlorWindow, {
				title = props.controls.Title,
				size = UDim2.fromOffset(640, 480), -- editorial density: sized to its strips
				showDim = props.controls.ShowDim,
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.md),
				}),
				KnobsHeader = e(SectionHeader, {
					text = "Knobs",
					hint = "Fittings for the parlor's locked doors.",
					accentColor = Theme.colors.primary, -- commerce sections: cream caps
					layoutOrder = 1,
				}),
				-- banner-offer: accent-tinted well, gradient display headline +
				-- caption stacked, price pill flush right. Strokeless.
				Banner = e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceGold,
					Size = UDim2.new(1, 0, 0, 104),
					LayoutOrder = 2,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.md),
						PaddingRight = UDim.new(0, Theme.spacing.md),
						PaddingTop = UDim.new(0, Theme.spacing.md),
						PaddingBottom = UDim.new(0, Theme.spacing.md),
					}),
					TextStack = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -150, 1, 0),
					}, {
						Layout = e("UIListLayout", {
							FillDirection = Enum.FillDirection.Vertical,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, Theme.spacing.xs),
						}),
						Headline = e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 44),
							Text = headline,
							FontFace = Theme.typography.display.font,
							TextScaled = true, -- display scales within its container
							TextColor3 = Theme.inks.onSecondary, -- gradient recolors this white base
							TextXAlignment = Enum.TextXAlignment.Left,
							LayoutOrder = 1,
						}, {
							MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.display.textSize }),
							-- cream-to-gold gradient: the commerce-banner display treatment
							Gradient = e("UIGradient", {
								Color = ColorSequence.new(Theme.gradients.commerce[1], Theme.gradients.commerce[2]),
								Rotation = 90,
							}),
							-- hairline dark rim keeps gradient digits legible
							Rim = e("UIStroke", {
								Thickness = Theme.strokes.textRim.thickness,
								Color = Theme.strokes.textRim.color,
								Transparency = Theme.strokes.textRim.transparency,
								ApplyStrokeMode = Theme.strokes.textRim.mode,
							}),
						}),
						Caption = e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 20),
							Text = caption,
							FontFace = Theme.typography.caption.font,
							TextSize = Theme.typography.caption.textSize, -- caption uses fixed textSize
							TextColor3 = Theme.colors.primary,
							TextXAlignment = Enum.TextXAlignment.Left,
							LayoutOrder = 2,
						}),
					}),
					Price = e(BuyPill, {
						amount = props.controls.BannerPrice,
						variant = "gold", -- gold stays strictly in commerce context
						position = UDim2.fromScale(1, 0.5),
						anchorPoint = Vector2.new(1, 0.5),
					}),
				}),
				RevivesHeader = e(SectionHeader, {
					text = "Revives",
					hint = "A second chance, dearly bought.",
					accentColor = Theme.colors.accentRose, -- life sections: rose caps
					layoutOrder = 3,
				}),
				RevivePills = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 44),
					LayoutOrder = 4,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, Theme.spacing.md),
					}),
					One = e(BuyPill, { amount = 39, variant = "rose", layoutOrder = 1 }),
					Bundle = e(BuyPill, { amount = 99, variant = "rose", layoutOrder = 2 }),
				}),
			}),
		})
	end,
}
