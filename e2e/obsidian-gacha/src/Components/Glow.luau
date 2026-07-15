-- Glow -- the emission halo (DESIGN.md Elevation Emission #1). A soft radial
-- glow TEXTURE (Theme.assets.glowRadial), ImageColor3-tinted to the element's
-- color, sized `spread` beyond the lit element, at Transparency ~ 1 - intensity.
-- NOT a stack of UIStroke rings (those render as hard concentric borders, not
-- light -- see asset-sourcing.md). Place it as a sibling at a LOWER ZIndex than
-- the element it lights (so it blooms behind, not over). Its parent must not
-- ClipsDescendants, so the halo can bleed past the element's bounds.
--
-- Sizing: pass the lit element's `size`/`position`/`anchorPoint`; the halo
-- expands `spread` px in every direction around it. Or pass a `glow` token
-- table ({color, spread, intensity}) plus an optional `colorOverride` to recolor
-- per element/rarity.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function Glow(props)
	local token = props.token or Theme.glow.accent
	local color = props.colorOverride or token.color
	local spread = props.spread or token.spread
	local intensity = props.intensity or token.intensity

	-- base size of the lit element (offset px); default fills its parent.
	local base = props.elementSize or UDim2.fromScale(1, 1)
	local size = UDim2.new(
		base.X.Scale, base.X.Offset + spread * 2,
		base.Y.Scale, base.Y.Offset + spread * 2
	)

	return e("ImageLabel", {
		BackgroundTransparency = 1,
		Image = Theme.assets.glowRadial,
		ImageColor3 = color,
		ImageTransparency = 1 - intensity,
		Size = size,
		Position = props.position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
		ZIndex = props.zIndex or 0,
	})
end

return Glow
