-- button-close from DESIGN.roblox.md (Frosted Baseplate): the pink-red cross
-- IS the button — no circle behind it, no container. Oversized (~70px),
-- always top-right, always overlapping the panel corner it floats over.
-- Rendered as two crossed bars (a true four-armed cross silhouette, not a
-- glyph — Roblox fonts do not ship a clean thick cross character) with a
-- near-black stroke on each bar. Press feedback: squash + brightness lift
-- (Motion prose: pressed frame not captured, inferred from taste family).

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

local function Bar(props)
	return e("Frame", {
		ref = props.barRef,
		BackgroundColor3 = Theme.colors.danger,
		Size = props.size,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Rotation = props.rotation,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
	})
end

local function CloseCross(props)
	local barARef = React.useRef(nil)
	local barBRef = React.useRef(nil)
	local scaleRef = React.useRef(nil)

	local size = props.size or Theme.metrics.closeCrossSize
	local armLength = size
	local armThickness = size * 0.32

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	local function lift(color, info)
		for _, ref in { barARef, barBRef } do
			local rbx = ref.current
			if rbx then
				TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
			end
		end
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1, -- the cross silhouette IS the button; no container
		Size = UDim2.fromOffset(size, size),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			squash(0.93, SQUASH_IN)
			lift(Theme.derived.dangerPressed, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
			lift(Theme.colors.danger, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
			lift(Theme.colors.danger, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		BarVertical = e(Bar, {
			barRef = barARef,
			size = UDim2.fromOffset(armThickness, armLength),
			rotation = 45,
			zIndex = 2,
		}),
		BarHorizontal = e(Bar, {
			barRef = barBRef,
			size = UDim2.fromOffset(armThickness, armLength),
			rotation = -45,
			zIndex = 3,
		}),
	})
end

return CloseCross
