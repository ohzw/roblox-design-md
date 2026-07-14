-- button-primary from DESIGN.roblox.md: the gold plate (RESTOCK, Claim).
-- White outlined uppercase label, white rim, darker-gold bevel. One per
-- header/footer region. Anatomy: root (bevel fill, white rim) > Face (fill,
-- sits `bevel.height`px short of the bottom) > Label. A blue variant appeared
-- once for an event restock (Components prose: "treat hue as swappable,
-- plate anatomy as fixed") -- exposed here as `variant = "primary" | "event"`.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local BEVEL = Theme.bevels.primary

-- Derived (no front-matter token for the once-observed event-restock hue;
-- Components prose explicitly calls hue swappable). Blue chosen to match the
-- shot-limited-shop RESTOCK variant description; bevel darkened at the same
-- ratio as the gold bevel.
local VARIANTS = {
	primary = { fill = Theme.colors.primary, bevel = BEVEL.color },
	event = { fill = Theme.colors.accentRare, bevel = Theme.derived.eventButtonBevel },
}

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

local function ButtonPrimary(props)
	local pressed, setPressed = React.useState(false)
	local scaleRef = React.useRef(nil)

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local variant = VARIANTS[props.variant or "primary"]
	local fill = variant.fill
	local bevel = variant.bevel
	local disabled = props.disabled

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = bevel,
		Size = props.size or UDim2.fromOffset(160, 56),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 1,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
			if not disabled then
				squash(Theme.derived.pressSquash, SQUASH_IN)
			end
		end,
		[React.Event.MouseButton1Up] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if not disabled and props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outlineWhite.thickness,
			Color = Theme.strokes.outlineWhite.color,
			ApplyStrokeMode = Theme.strokes.outlineWhite.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = fill,
			Size = if pressed and not disabled then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL.height),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				-- Typography prose: action text is ALL CAPS (uppercase = true on the label tier)
				Text = string.upper(props.text or "RESTOCK"),
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.md),
					PaddingRight = UDim.new(0, Theme.spacing.md),
					PaddingTop = UDim.new(0, Theme.spacing.xs),
					PaddingBottom = UDim.new(0, Theme.spacing.xs),
				}),
			}),
		}),
	})
end

return ButtonPrimary
