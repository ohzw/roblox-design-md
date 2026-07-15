-- banner-offer from DESIGN.roblox.md: "a shop card with a per-offer horizontal
-- gradient hue (cyan 2X Gems, purple INF Storage, gold VIP), holding an icon,
-- a display title, a body subtitle, and one or two buy price pills." The loud
-- colored element of the shop — no corner brackets here (that motif is for the
-- dark wells/cards); the gradient hue carries it.
--
-- Props: title, subtitle, icon, hue (Color3 for the gradient), price
-- (Robux pill text), gems (optional gem pill text), onBuy.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ActionButton = require(script.Parent.ActionButton)

local e = React.createElement

local function BannerOffer(props)
	local hue = props.hue or Theme.gradients.banner.from

	return e("Frame", {
		-- white base: the per-offer hue lives in the UIGradient below, which
		-- multiplies with BackgroundColor3 (see Theme.white).
		BackgroundColor3 = Theme.white,
		Size = props.size or UDim2.new(1, 0, 0, 96),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Gradient = e("UIGradient", {
			Color = ColorSequence.new(hue, Theme.gradients.banner.to),
			Rotation = 0,
		}),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.panel.thickness,
			Color = Theme.strokes.panel.color,
			ApplyStrokeMode = Theme.strokes.panel.mode,
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
			PaddingTop = UDim.new(0, Theme.spacing.sm),
			PaddingBottom = UDim.new(0, Theme.spacing.sm),
		}),
		Icon = if props.icon
			then e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.icon,
				ImageColor3 = Theme.colors.onSurface,
				Size = UDim2.fromOffset(64, 64),
				Position = UDim2.new(0, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				ZIndex = (props.zIndex or 1) + 1,
			})
			else nil,
		Text = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -240, 1, 0),
			Position = UDim2.fromOffset(80, 0),
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, Theme.spacing.xs),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Title = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, 0, 0, 0),
				Text = props.title or "Offer",
				FontFace = Theme.typography.display.font,
				TextColor3 = Theme.colors.onSurface,
				TextSize = Theme.typography.display.textSize - 8,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 1,
			}),
			Subtitle = if props.subtitle
				then e("TextLabel", {
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.new(1, 0, 0, 0),
					Text = props.subtitle,
					FontFace = Theme.typography.body.font,
					TextColor3 = Theme.colors.onSurfaceDim,
					TextSize = Theme.typography.body.textSize,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 2,
				})
				else nil,
		}),
		Pills = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(150, 44),
			Position = UDim2.new(1, 0, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, Theme.spacing.sm),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Buy = e(ActionButton, {
				variant = "buy",
				price = props.price or "499",
				icon = Theme.assets.iconRobux,
				size = UDim2.fromOffset(110, 44),
				layoutOrder = 1,
				onActivated = props.onBuy,
			}),
		}),
	})
end

return BannerOffer
