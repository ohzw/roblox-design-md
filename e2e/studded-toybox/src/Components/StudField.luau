-- Shared stud-emboss overlay (Elevation & Depth prose #2 + Agent Prompt
-- Guide): "every opaque fill carries the repeating rounded-square stud
-- pattern... implement as a tiled ImageLabel over the fill at high
-- transparency." This is the ONE place the sourced texture asset
-- (Theme.assets.studTexture) is consumed -- every component that needs an
-- emboss composes this instead of repeating the ImageLabel setup.
--
-- Do's and Don'ts: "Never leave a fill flat and untextured; it reads as
-- unfinished here" -- so every opaque fill component in this taste renders
-- one of these as its top-most-but-one layer (content sits above it).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function StudField(props)
	return e("ImageLabel", {
		Image = Theme.assets.studTexture,
		ImageColor3 = props.tint or Color3.new(1, 1, 1),
		ImageTransparency = props.transparency or Theme.derived.studTransparency,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(Theme.derived.studCellSize, Theme.derived.studCellSize),
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = props.zIndex or 1,
	})
end

return StudField
