-- Gloss -- the specular glass sheen (DESIGN.md Elevation Emission #2). A
-- top-anchored white UIGradient overlay: Transparency ~0.82 at the top edge ->
-- 1.0 by the vertical middle, so the upper half catches a soft highlight and
-- the lower half stays matte. Turns a flat gradient pill/banner into lit glass.
-- Place as a child on top of the element's fill (matches the element's corner).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function Gloss(props)
	return e("Frame", {
		BackgroundColor3 = Theme.colors.onSurface, -- cool near-white, never pure #FFF
		BackgroundTransparency = 0.82,
		Size = UDim2.fromScale(1, 1),
		ZIndex = props.zIndex or 2,
	}, {
		Corner = if props.rounded then e("UICorner", { CornerRadius = props.rounded }) else nil,
		Sheen = e("UIGradient", {
			-- opaque(ish) at top -> fully transparent by mid-height
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.5, 1),
				NumberSequenceKeypoint.new(1, 1),
			}),
			Rotation = 90,
		}),
	})
end

return Gloss
