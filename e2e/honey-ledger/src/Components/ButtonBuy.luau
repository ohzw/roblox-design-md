-- button-buy from DESIGN.roblox.md (Honey Ledger): red price tag docked to
-- a card's top-right corner, full-bleed to the edge, white stroked amount.
-- "Price lives in the tag, never inside a green button" (Components prose)
-- -- this is the taste's buy-control voice for shop rows/cards; button-
-- primary stays reserved for the separate craft/confirm CTA frame. No
-- press/disabled state was observed; a fill darken on press matches the
-- rest of the taste's flat press convention.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local PRESS_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local PRESS_OUT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ButtonBuy(props)
	local fillRef = React.useRef(nil)

	local function tweenTo(color, info)
		local fill = fillRef.current
		if fill then
			TweenService:Create(fill, info, { BackgroundColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.derived.closeBeveledFill, -- component token: button-buy.backgroundColor "#F05850"
		Size = props.size or UDim2.fromOffset(84, 40),
		Position = props.position or UDim2.new(1, 0, 0, 0),
		AnchorPoint = props.anchorPoint or Vector2.new(1, 0),
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			tweenTo(Theme.derived.buttonBuyPressed, PRESS_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			tweenTo(Theme.derived.closeBeveledFill, PRESS_OUT)
		end,
		[React.Event.MouseLeave] = function()
			tweenTo(Theme.derived.closeBeveledFill, PRESS_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		-- rounded.none: sharp corners, full-bleed to the card edge.
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = tostring(props.price or 0),
			FontFace = Theme.typography.label.font,
			TextScaled = true,
			TextColor3 = Theme.colors.white,
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.xs),
				PaddingRight = UDim.new(0, Theme.spacing.xs),
			}),
		}),
	})
end

return ButtonBuy
