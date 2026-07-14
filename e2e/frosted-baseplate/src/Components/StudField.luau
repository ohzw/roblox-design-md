-- Shared stud-emboss texture (Elevation & Depth: "the stud pattern on slabs
-- and rings is the primary depth texture... subtle, ~10% contrast"). No image
-- assets are embedded (rights policy): the tile pattern is built procedurally
-- from a UIGridLayout of small round Frames, lighter than the fill they sit
-- on by Theme.derived.studContrast and kept subtle via studTransparency.
-- Purely decorative: BackgroundTransparency = 1 on the root, ClipsDescendants
-- so studs never bleed past rounded corners.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

-- Generous fixed count keeps the grid tiling regardless of parent size;
-- UIGridLayout simply lays out however many cells fit (repeating content
-- rule: layout delegation, never hand-computed positions).
local STUD_COUNT = 400

local function StudField(props)
	local baseColor = props.color or Theme.colors.surface
	local studColor = baseColor:Lerp(Color3.new(1, 1, 1), Theme.derived.studContrast)

	local studs = {}
	for i = 1, STUD_COUNT do
		studs["Stud" .. i] = e("Frame", {
			BackgroundColor3 = studColor,
			BackgroundTransparency = Theme.derived.studTransparency,
			Size = UDim2.fromOffset(Theme.derived.studSize, Theme.derived.studSize),
			LayoutOrder = i,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
		})
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ClipsDescendants = true,
		ZIndex = props.zIndex,
	}, {
		Grid = e("UIGridLayout", {
			CellSize = UDim2.fromOffset(Theme.derived.studSize, Theme.derived.studSize),
			CellPadding = UDim2.fromOffset(
				Theme.derived.studSpacing - Theme.derived.studSize,
				Theme.derived.studSpacing - Theme.derived.studSize
			),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirectionMaxCells = 0,
		}),
		Studs = e(React.Fragment, nil, studs),
	})
end

return StudField
