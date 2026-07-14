-- button-buy / button-buy-hard from DESIGN.roblox.md (Frosted Baseplate):
-- paired price pills on offer/product rows -- ice-cyan for earned currency,
-- lime for premium. Icon left, amount right, full-rounded (Components
-- prose). "They appear side by side; never show one without a clear icon" --
-- this component renders ONE pill; callers place the soft/hard pair as
-- siblings (see ItemRow). No stroke token on either button-buy variant.
--
-- Do's and Don'ts: never repurpose currency-soft/currency-hard for anything
-- that isn't money -- this component is the ONLY consumer of those two
-- colors as a fill.
--
-- Press feedback: flat-fill, squash + brightness lift (taste-family default,
-- same pattern as Button/SideButton/CloseCross).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local SQUASH_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local SQUASH_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local VARIANTS = {
	soft = { fill = Theme.colors.currencySoft, pressed = Theme.derived.currencySoftPressed },
	hard = { fill = Theme.colors.currencyHard, pressed = Theme.derived.currencyHardPressed },
}

local ICON_SIZE = 26

local function BuyPill(props)
	local scaleRef = React.useRef(nil)
	local fillRef = React.useRef(nil)

	local variant = VARIANTS[props.variant or "soft"]
	local fill = variant.fill
	local pressedFill = variant.pressed

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local function lift(color, info)
		local rbx = fillRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	-- Tap-target vs token conflict (generation-procedure.md): no explicit
	-- height token for button-buy; default 40px matches toggle-pill's own
	-- full-rounded pill height, kept inside a 44px+ invisible touch root.
	local touchHeight = math.max(44, props.pillHeight or 40)

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1, -- invisible 44px+ touch root
		Size = props.size or UDim2.fromOffset(96, touchHeight),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			squash(0.93, SQUASH_IN)
			lift(pressedFill, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
			lift(fill, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
			lift(fill, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Pill = e("Frame", {
			ref = fillRef,
			BackgroundColor3 = fill,
			Size = UDim2.new(1, 0, 0, props.pillHeight or 40),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 2,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			-- Icon: no distinct image-icon token exists for button-buy beyond
			-- "icon left" (Components prose); CurrencyBar's own currency icon is
			-- ALSO a procedural diamond silhouette (never an image asset), so this
			-- reuses the same ice-cube motif rather than inventing a new asset
			-- slot for a shape the DESIGN.md never describes beyond "icon."
			Icon = e("Frame", {
				BackgroundColor3 = Theme.colors.onSurface,
				Size = UDim2.fromOffset(ICON_SIZE * 0.62, ICON_SIZE * 0.62),
				Position = UDim2.new(0, Theme.spacing.sm + ICON_SIZE * 0.19, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Rotation = 45,
				ZIndex = 3,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			}),
			Amount = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -(ICON_SIZE + Theme.spacing.md * 2), 1, 0),
				Position = UDim2.new(0, ICON_SIZE + Theme.spacing.md, 0, 0),
				Text = tostring(props.amount or 0),
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
				Padding = e("UIPadding", {
					PaddingRight = UDim.new(0, Theme.spacing.sm),
				}),
			}),
		}),
	})
end

return BuyPill
