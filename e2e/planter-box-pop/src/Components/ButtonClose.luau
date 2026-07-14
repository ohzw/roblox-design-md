-- button-close from DESIGN.roblox.md: red ROUNDED SQUARE (aspect 1, never a
-- circle) with a white outlined X, last item in the header cluster, inside
-- the corner (never overlapping it). Anatomy: root (bevel fill) > Face (fill,
-- sits `bevel.height`px short of the bottom) > Label. Pressing stretches Face
-- to full height: the plate visually depresses (Elevation prose: press
-- feedback collapses the bevel; inferred, never observed, mandatory anyway).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local BEVEL = Theme.bevels.close

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

local function ButtonClose(props)
	local pressed, setPressed = React.useState(false)
	local scaleRef = React.useRef(nil)

	local function squash(target, info)
		local uiScale = scaleRef.current
		if uiScale then
			TweenService:Create(uiScale, info, { Scale = target }):Play()
		end
	end

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = BEVEL.color,
		Size = props.size or UDim2.fromOffset(56, 56), -- Layout prose: close button ~56px at reference
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 1,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
			squash(Theme.derived.pressSquash, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			setPressed(false)
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Ratio = e("UIAspectRatioConstraint", { AspectRatio = 1 }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Face = e("Frame", {
			BackgroundColor3 = Theme.colors.danger,
			Size = if pressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL.height),
			ZIndex = 2,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Label = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				-- U+2715 tofu'd in this taste's font (verified via Studio capture,
				-- matching verification.md's known gotcha); U+00D7 renders fine.
				Text = "\u{00D7}",
				FontFace = Theme.typography.label.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 3,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.sm),
					PaddingRight = UDim.new(0, Theme.spacing.sm),
					PaddingTop = UDim.new(0, Theme.spacing.sm),
					PaddingBottom = UDim.new(0, Theme.spacing.sm),
				}),
			}),
		}),
	})
end

return ButtonClose
