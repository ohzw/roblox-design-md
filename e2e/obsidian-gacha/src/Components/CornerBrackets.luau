-- CornerBrackets — the taste's signature elevation motif (Elevation & Depth):
-- thin light L-shaped brackets at the four corners of every panel and well,
-- instead of a full perimeter stroke. Read as 4 corners x 2 arms = 8 thin
-- frames. On selected / high-rarity elements the caller passes a brighter
-- color (full-bright recolor).
--
-- Props: color (Color3), thickness (px), arm (px arm length), inset (px from
-- the corner), transparency (0..1), zIndex. Purely decorative — no input.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

-- corner spec: anchor + sign so one builder serves all four corners.
local CORNERS = {
	TL = { anchor = Vector2.new(0, 0), ax = 0, ay = 0, sx = 1, sy = 1 },
	TR = { anchor = Vector2.new(1, 0), ax = 1, ay = 0, sx = -1, sy = 1 },
	BL = { anchor = Vector2.new(0, 1), ax = 0, ay = 1, sx = 1, sy = -1 },
	BR = { anchor = Vector2.new(1, 1), ax = 1, ay = 1, sx = -1, sy = -1 },
}

local function CornerBrackets(props)
	local color = props.color or Theme.colors.outline
	local thick = props.thickness or Theme.strokes.bracket.thickness
	local arm = props.arm or 24
	local inset = props.inset or 6
	local zIndex = props.zIndex or 6
	local transparency = props.transparency or 0

	local children = {}
	for name, c in CORNERS do
		-- horizontal arm: full arm long, `thick` tall, pinned to the corner.
		children[name .. "H"] = e("Frame", {
			BackgroundColor3 = color,
			BackgroundTransparency = transparency,
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(arm, thick),
			Position = UDim2.new(c.ax, c.sx * inset, c.ay, c.sy * inset),
			AnchorPoint = c.anchor,
			ZIndex = zIndex,
		})
		-- vertical arm: `thick` wide, full arm tall, same corner.
		children[name .. "V"] = e("Frame", {
			BackgroundColor3 = color,
			BackgroundTransparency = transparency,
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(thick, arm),
			Position = UDim2.new(c.ax, c.sx * inset, c.ay, c.sy * inset),
			AnchorPoint = c.anchor,
			ZIndex = zIndex,
		})
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = zIndex,
	}, children)
end

return CornerBrackets
