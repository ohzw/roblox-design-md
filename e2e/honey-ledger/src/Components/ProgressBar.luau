-- progress-bar from DESIGN.roblox.md (Honey Ledger): same charcoal track as
-- currency-bar with a success-green fill growing from the left and a
-- "current/max" white numeral overlay. The quest-task row variant recolors
-- track -> trackIncomplete salmon, fill -> success (see Screen Patterns:
-- "Quest window" -- NOT implemented here since quest rows are out of the
-- standard-showcase set; this component covers the HUD resource-progress
-- reading only). Value changes tween width with `settle`, never snap.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local HEIGHT = 34

local FILL_TWEEN = TweenInfo.new(
	Theme.motion.durations.slow,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ProgressBar(props)
	local fillRef = React.useRef(nil)
	local current = props.current or 0
	local max = math.max(props.max or 1, 1)
	local ratio = math.clamp(current / max, 0, 1)

	-- Frozen-initial-render pattern (motion-implementation.md): render the
	-- Size ONCE from the first ratio, drive subsequent changes through a
	-- tween so React never snaps it back.
	local initialRatio = React.useRef(ratio)

	React.useEffect(function()
		local fill = fillRef.current
		if fill then
			TweenService:Create(fill, FILL_TWEEN, { Size = UDim2.fromScale(ratio, 1) }):Play()
		end
	end, { ratio })

	return e("Frame", {
		BackgroundColor3 = Theme.colors.surfaceDark,
		BackgroundTransparency = Theme.surfaceDarkTransparency,
		Size = props.size or UDim2.fromOffset(190, HEIGHT),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		ClipsDescendants = true,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Fill = e("Frame", {
			ref = fillRef,
			BackgroundColor3 = Theme.colors.success,
			Size = UDim2.fromScale(initialRatio.current, 1),
			ZIndex = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		}),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = string.format("%d/%d", current, max),
			FontFace = Theme.typography.utility.font,
			TextScaled = true,
			TextColor3 = Theme.colors.white,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.utility.textSize }),
		}),
	})
end

return ProgressBar
