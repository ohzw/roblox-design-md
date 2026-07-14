-- progress-bar from DESIGN.roblox.md (Indigo Quartermaster): square-ended
-- strip, {colors.progress-track} track, {colors.accent-soft} fill, 8px tall,
-- pinned under rows. rounded.none (square-ended is load-bearing -- this is
-- NOT a pill). Value changes interpolate linearly (motion.easings.settle);
-- timers/instant snaps never tween here.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local SETTLE = TweenInfo.new(
	Theme.motion.durations.slow,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)

local function ProgressBar(props)
	local fillRef = React.useRef(nil)
	local progress = math.clamp(props.progress or 0, 0, 1)

	-- Frozen-initial-render pattern (motion-implementation.md): render the
	-- fill's Size once from the first value, drive every subsequent change
	-- through TweenService so React never snaps it.
	React.useEffect(function()
		local fill = fillRef.current
		if fill then
			TweenService:Create(fill, SETTLE, { Size = UDim2.fromScale(progress, 1) }):Play()
		end
	end, { progress })

	return e("Frame", {
		BackgroundColor3 = Theme.colors.progressTrack,
		Size = props.size or UDim2.new(1, 0, 0, 8),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.none }),
		Fill = e("Frame", {
			ref = fillRef,
			BackgroundColor3 = Theme.colors.accentSoft,
			Size = UDim2.fromScale(progress, 1),
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.none }),
		}),
	})
end

return ProgressBar
