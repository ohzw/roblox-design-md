-- button-close from DESIGN.roblox.md (Indigo Quartermaster): a bare white X
-- glyph, no fill, no circle, no stroke -- flush right inside the header band,
-- vertically centered, never overlapping a corner. The visible glyph is
-- small (24px per the token); an invisible 44px+ frame supplies the touch
-- target (Tap-target vs token conflict, generation-procedure.md #2).
-- Press feedback: darken the glyph one value step (no squash anywhere in
-- this taste).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local TOUCH = 44
local GLYPH = 24

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

local function CloseButton(props)
	local glyphRef = React.useRef(nil)

	local function lift(color, info)
		local glyph = glyphRef.current
		if glyph then
			TweenService:Create(glyph, info, { TextColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1, -- bare glyph: no fill, no circle
		Size = props.size or UDim2.fromOffset(TOUCH, TOUCH),
		Position = props.position,
		AnchorPoint = props.anchorPoint or Vector2.new(1, 0.5),
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			lift(Theme.derived.onSurfacePressed, LIFT_IN) -- one value step darker than white
		end,
		[React.Event.MouseButton1Up] = function()
			lift(Theme.colors.onSurface, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(Theme.colors.onSurface, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Glyph = e("TextLabel", {
			ref = glyphRef,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(GLYPH, GLYPH),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "\u{00D7}", -- bare X (U+00D7 renders reliably; U+2715 tofu'd in testing per verification.md)
			FontFace = Theme.typography.label.font,
			TextSize = GLYPH,
			TextColor3 = Theme.colors.onSurface, -- never stroked -- this taste's loudest signature
			ZIndex = props.zIndex,
		}),
	})
end

return CloseButton
