-- toggle-pill / toggle-pill-off from DESIGN.roblox.md (Frosted Baseplate):
-- settings rows end in a full-rounded state pill -- mint green ON / red OFF
-- with the state word AS its label (Title Case: "On" / "Off"). The pill
-- swaps color and text together; there is NO knob (unlike a bevel-taste
-- toggle with a sliding circle -- this taste's toggle IS the pill).
-- Press feedback (Motion prose, inferred -- no pressed frame captured):
-- squash to ~0.93 at durations.instant, restore with settle.
-- Value change (state flip): color crossfades via settle easing rather than
-- an instant snap, matching "value changes ... tween" from the Motion prose.
-- Tap-target vs token conflict (generation-procedure.md): the token height is
-- 40px, below the 44px rubric floor. The visible pill stays 40px tall inside
-- an invisible 44px+ TextButton touch root -- taste and usability both win.

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
local FLIP = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function pillColor(value)
	return if value then Theme.inks.toggleOn else Theme.inks.toggleOff
end

local function TogglePill(props)
	local scaleRef = React.useRef(nil)
	local pillRef = React.useRef(nil)
	-- Frozen first-render value: BackgroundColor3 below always renders from
	-- this, so a prop change never yanks the color out from under the tween
	-- (frozen-value pattern, motion-implementation.md).
	local initialValue = React.useRef(props.value)
	local isFirstEffect = React.useRef(true)

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	React.useEffect(function()
		if isFirstEffect.current then
			isFirstEffect.current = false
			return
		end
		local pill = pillRef.current
		if pill then
			TweenService:Create(pill, FLIP, { BackgroundColor3 = pillColor(props.value) }):Play()
		end
	end, { props.value })

	local labelText = if props.value then "On" else "Off" -- Title Case per Typography prose
	local touchHeight = math.max(44, Theme.metrics.togglePillHeight)

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1, -- invisible 44px+ touch root
		Size = props.size or UDim2.fromOffset(100, touchHeight),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			squash(0.93, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onToggle then
				props.onToggle(not props.value)
			end
		end,
	}, {
		Pill = e("Frame", {
			ref = pillRef,
			BackgroundColor3 = pillColor(initialValue.current),
			Size = UDim2.new(1, 0, 0, Theme.metrics.togglePillHeight),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 2,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
			-- No stroke: Do's and Don'ts reserves outline strokes for arcade
			-- pills and the close cross; toggle-pill's own token carries no
			-- `stroke` key.
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = labelText,
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

return TogglePill
