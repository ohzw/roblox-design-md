-- Foundation tokens at a glance: color swatches, type scale, corner radii, strokes.
-- This is the "preview story screen" for the Foundation layer of DESIGN.roblox.md.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local COLOR_LIST = {
	{ name = "primary", color = Theme.colors.primary },
	{ name = "secondary", color = Theme.colors.secondary },
	{ name = "danger", color = Theme.colors.danger },
	{ name = "surface", color = Theme.colors.surface },
	{ name = "surface-deep", color = Theme.colors.surfaceDeep },
	{ name = "on-surface", color = Theme.colors.onSurface },
	{ name = "currency-soft", color = Theme.colors.currencySoft },
	{ name = "currency-hard", color = Theme.colors.currencyHard },
	{ name = "accent-rare", color = Theme.colors.accentRare },
	{ name = "outline", color = Theme.colors.outline },
	{ name = "dim", color = Theme.colors.dim },
}

local TYPE_LIST = { "display", "heading", "body", "label", "caption" }

local ROUNDED_LIST = {
	{ name = "sm", radius = Theme.rounded.sm },
	{ name = "md", radius = Theme.rounded.md },
	{ name = "lg", radius = Theme.rounded.lg },
	{ name = "full", radius = Theme.rounded.full },
}

local function sectionLabel(text, order)
	return e("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 28),
		Text = string.upper(text),
		FontFace = Theme.typography.heading.font,
		TextSize = 22,
		TextColor3 = Theme.colors.white,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = order,
	}, {
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.textOutline.thickness,
			Color = Theme.strokes.textOutline.color,
			ApplyStrokeMode = Theme.strokes.textOutline.mode,
		}),
	})
end

local function TokensStory()
	local colorSwatches = {}
	colorSwatches.Layout = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, Theme.spacing.md),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	for i, entry in ipairs(COLOR_LIST) do
		colorSwatches[entry.name] = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(96, 100),
			LayoutOrder = i,
		}, {
			Swatch = e("Frame", {
				BackgroundColor3 = entry.color,
				Size = UDim2.fromOffset(96, 66),
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outline.thickness,
					Color = Theme.strokes.outline.color,
					ApplyStrokeMode = Theme.strokes.outline.mode,
				}),
			}),
			Name = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 28),
				Position = UDim2.new(0, 0, 1, -28),
				Text = entry.name,
				FontFace = Theme.typography.caption.font,
				TextSize = 12,
				TextColor3 = Theme.colors.white,
				TextWrapped = true,
			}),
		})
	end

	local typeLines = {}
	typeLines.Layout = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, Theme.spacing.xs),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	for i, name in ipairs(TYPE_LIST) do
		local tier = Theme.typography[name]
		local sample = name .. " — Hatch 3 Eggs 123"
		if tier.uppercase then
			sample = string.upper(sample)
		end
		typeLines[name] = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, tier.textSize + 8),
			Text = sample,
			FontFace = tier.font,
			TextSize = tier.textSize,
			TextColor3 = Theme.colors.white,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = i,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		})
	end

	local roundedBoxes = {}
	roundedBoxes.Layout = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, Theme.spacing.md),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	for i, entry in ipairs(ROUNDED_LIST) do
		roundedBoxes[entry.name] = e("Frame", {
			BackgroundColor3 = Theme.colors.surface,
			Size = UDim2.fromOffset(90, 66),
			LayoutOrder = i,
		}, {
			Corner = e("UICorner", { CornerRadius = entry.radius }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			Name = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = entry.name,
				FontFace = Theme.typography.caption.font,
				TextSize = Theme.typography.caption.textSize,
				TextColor3 = Theme.colors.onSurface,
			}),
		})
	end

	return e("Frame", {
		-- Sky-blue world backdrop so outline/stroke tokens read in context
		BackgroundColor3 = Color3.fromHex("#87CEEB"),
		Size = UDim2.fromScale(1, 1),
	}, {
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.xl),
			PaddingRight = UDim.new(0, Theme.spacing.xl),
			PaddingTop = UDim.new(0, Theme.spacing.xl),
			PaddingBottom = UDim.new(0, Theme.spacing.xl),
		}),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, Theme.spacing.lg),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		ColorsLabel = sectionLabel("Colors", 1),
		Colors = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 100),
			LayoutOrder = 2,
		}, colorSwatches),
		TypeLabel = sectionLabel("Typography", 3),
		Type = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 160),
			LayoutOrder = 4,
		}, typeLines),
		RoundedLabel = sectionLabel("Shapes", 5),
		Rounded = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 70),
			LayoutOrder = 6,
		}, roundedBoxes),
	})
end

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return e(TokensStory)
	end,
}
