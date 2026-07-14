-- item-row (this e2e slice's shop grammar) from DESIGN.roblox.md (Candlelit
-- Parlor): a full-width strip — item render left, serif title + eyebrow tier
-- caption stacked, a BuyPill flush right. One column of full-width strips
-- per the Layout section ("one column of full-width strips inside windows").
--
-- ARBITRATED 2026-07-13 (Studio verification pass, resolving a conflict the
-- implementer flagged): the row's surface now uses the DESIGN.md's OWN
-- `card-grid` token — a tier-tinted vertical gradient fill, slightly
-- translucent, 8px corners, and explicitly **NO stroke** ("cards are the
-- only major element without an edge, which makes them read as artwork").
-- The prior revision gave each row a thin cream border reusing the window/
-- hotbar-slot stroke grammar instead (a plausible reading of "glass rows
-- with thin cream strokes" from the originating task prompt), but an
-- in-engine capture of the Shop story showed the bordered rows reading as
-- boxed list cells, directly contradicting the DESIGN.md's own emphatic,
-- load-bearing claim about cards being strokeless. That claim is stated as
-- a defining taste fact (not an incidental detail), so on reverification the
-- stroke lost: this component now renders card-grid's gradient anatomy
-- while keeping the ROW/STRIP shape (full-width, not a square card) since
-- "one column of full-width strips" is genuinely native to this taste's
-- Layout section and the six-item standard set reads correctly as rows.
--
-- Rarity ladder mapping (standard-showcase.md): this taste defines no
-- rarity/tier ladder at all (no accent-common/rare/legendary tokens exist in
-- the front matter — commerce vs. life is the only two-way split it draws).
-- Tier captions are therefore rendered in plain cream ink (no per-tier
-- recolor) EXCEPT Crown, which gets this taste's own top/exclusive
-- treatment: the display gradient (cream-to-gold, the commerce-banner
-- treatment) on its title plus a brighter, non-dimmed stroke — the nearest
-- taste-native "emphasized" device available (Do's and Don'ts: "keep gold
-- strictly for commerce" — Crown IS a commerce item, so the gold gradient
-- stays in-bounds). Fails soft: an unknown/missing tier string never
-- indexes a table, so there is no nil-crash surface here by construction.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local BuyPill = require(script.Parent.BuyPill)

local e = React.createElement

local ROW_HEIGHT = 84 -- clears the 44px tap-target rubric comfortably; fits the well + two text lines
local WELL_SIZE = 60

local LIFT_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local LIFT_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ItemRow(props)
	local fillRef = React.useRef(nil)
	local emphasized = props.emphasized or false
	local gradientPair = if emphasized then Theme.itemRow.gradientEmphasized else Theme.itemRow.gradient

	-- Press feedback: a brightness lift on the fill (Motion prose: "a
	-- brightness or stroke lift, not a squash"), matching every other
	-- interactive element in this taste now that the row is strokeless.
	local function liftFill(transparency, info)
		local fill = fillRef.current
		if fill then
			TweenService:Create(fill, info, { BackgroundTransparency = transparency }):Play()
		end
	end

	local tierText = props.tier
	if tierText and Theme.typography.eyebrow.uppercase then
		tierText = string.upper(tierText)
	end

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.new(1, 1, 1), -- UIGradient supplies the visible color; base must be white
		BackgroundTransparency = Theme.itemRow.transparency, -- card-grid token: slightly translucent
		Size = props.size or UDim2.new(1, 0, 0, ROW_HEIGHT),
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 1,
		[React.Event.MouseButton1Down] = function()
			liftFill(math.max(Theme.itemRow.transparency - 0.08, 0), LIFT_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			liftFill(Theme.itemRow.transparency, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			liftFill(Theme.itemRow.transparency, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		-- card-grid anatomy (Components prose): tier-tinted vertical gradient
		-- fill, NO stroke — "cards are the only major element without an
		-- edge, which makes them read as artwork." Crown gets the brighter
		-- gold variant as its top/exclusive treatment.
		Gradient = e("UIGradient", {
			Color = ColorSequence.new(gradientPair[1], gradientPair[2]),
			Rotation = 90,
		}),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Theme.spacing.md),
			PaddingRight = UDim.new(0, Theme.spacing.md),
			PaddingTop = UDim.new(0, Theme.spacing.sm),
			PaddingBottom = UDim.new(0, Theme.spacing.sm),
		}),
		-- Item render well: square, left-anchored, vertically centered.
		Well = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(WELL_SIZE, WELL_SIZE),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			ZIndex = 2,
		}, {
			Render = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					-- Only the tintable (transparent-monochrome) icons take the
					-- one-ink cream recolor (asset-sourcing.md tinting rule);
					-- full-color baked assets (Acorn/Lantern/Crown) render at
					-- their native color, noted per-asset in Theme.luau.
					ImageColor3 = if props.tintable then Theme.colors.primary else Theme.derived.imageTintNone,
					ScaleType = Enum.ScaleType.Fit,
					Size = UDim2.fromScale(0.82, 0.82),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					ZIndex = 3,
				})
				else nil,
		}),
		-- Text stack: serif title + eyebrow tier caption, right of the well.
		Info = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -(WELL_SIZE + Theme.spacing.md * 2 + 140), 1, 0),
			Position = UDim2.fromOffset(WELL_SIZE + Theme.spacing.md, 0),
			ZIndex = 2,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.xs),
			}),
			Title = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 26),
				Text = props.title or "Item", -- serif parlor voice, mixed case
				FontFace = Theme.typography.heading.font,
				TextScaled = true,
				TextColor3 = Theme.colors.primary,
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = 1,
				ZIndex = 3,
			}, (function()
				local children = {
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = 24 }),
				}
				if emphasized then
					-- Crown's emphasis device: the commerce cream-to-gold display
					-- gradient (Typography prose) + hairline text-rim, this
					-- taste's top/exclusive treatment, applied to the title.
					children.Gradient = e("UIGradient", {
						Color = ColorSequence.new(Theme.gradients.commerce[1], Theme.gradients.commerce[2]),
						Rotation = 90,
					})
					children.Rim = e("UIStroke", {
						Thickness = Theme.strokes.textRim.thickness,
						Color = Theme.strokes.textRim.color,
						Transparency = Theme.strokes.textRim.transparency,
						ApplyStrokeMode = Theme.strokes.textRim.mode,
					})
				end
				return children
			end)()),
			Tier = if tierText
				then e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 18),
					Text = tierText,
					FontFace = Theme.typography.eyebrow.font,
					TextSize = 14,
					TextColor3 = Theme.colors.onSurfaceDim,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 2,
					ZIndex = 3,
				})
				else nil,
		}),
		-- Buy control: this taste's in-row price pill, flush right.
		Buy = e(BuyPill, {
			amount = props.price,
			variant = props.buyVariant or "gold",
			position = UDim2.fromScale(1, 0.5),
			anchorPoint = Vector2.new(1, 0.5),
			zIndex = 3,
			onActivated = props.onBuy,
		}),
	})
end

return ItemRow
