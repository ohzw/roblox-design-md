-- side-button from DESIGN.roblox.md (Frosted Baseplate): ~100px rounded
-- squares in a 2x2 launcher grid, each with its own saturated fill (observed:
-- purple, red, green, orange -- one hue per destination), a chunky icon, and
-- a white outlined caption inside the bottom edge. NO stroke -- the
-- saturated fill carries it (Components prose). rounded.md, aspectRatio 1.
-- Press feedback: squash + brightness lift (taste-family default, no bevel
-- token defined for this component).
--
-- Icon slot: `props.image` (a Theme.assets.* rbxassetid, tinted white via
-- ImageColor3 per asset-sourcing.md's tinting rule) takes precedence over
-- `props.icon` (a glyph placeholder string) when both are given -- real
-- assets replace glyphs per asset-sourcing.md without dropping the glyph
-- fallback path other callers still use.

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

local function SideButton(props)
	local scaleRef = React.useRef(nil)
	local fillRef = React.useRef(nil)

	local fill = props.color or Theme.colors.secondary
	local pressedFill = fill:Lerp(Color3.new(1, 1, 1), 0.12)

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

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = fill,
		Size = props.size or UDim2.fromOffset(Theme.metrics.sideButtonSize, Theme.metrics.sideButtonSize),
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
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
		Aspect = e("UIAspectRatioConstraint", { AspectRatio = Theme.metrics.sideButtonAspect }),
		Icon = if props.image then e("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.image,
			ImageColor3 = Theme.colors.onSurface,
			Size = UDim2.fromScale(0.56, 0.56),
			Position = UDim2.new(0.5, 0, 0.31, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 2,
		}) else e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0.62),
			Position = UDim2.new(0, 0, 0, Theme.spacing.xs),
			Text = props.icon or "\u{25C6}",
			FontFace = Theme.typography.label.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
		Caption = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 22),
			Position = UDim2.new(0, 0, 1, -22 - Theme.spacing.xs),
			Text = props.text or "",
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize, -- caption uses fixed textSize (Typography prose)
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
		}),
		Badge = props.badge and e("Frame", {
			BackgroundColor3 = Theme.inks.badgeSlot,
			Size = UDim2.fromOffset(22, 22),
			Position = UDim2.fromScale(1, 0),
			AnchorPoint = Vector2.new(0.8, 0.2),
			ZIndex = 3,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = props.badge,
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 4,
			}),
		}) or nil,
	})
end

return SideButton
