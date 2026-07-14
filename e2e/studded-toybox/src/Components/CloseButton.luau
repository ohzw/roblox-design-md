-- button-close from DESIGN.roblox.md: red squared slab, full header height,
-- flush with the window's top-right corner (Components prose: "it does not
-- overlap outside the frame"). White outlined X glyph at heading size. Red
-- means close, nowhere else (Do's and Don'ts).
--
-- Motion (Motion section, press feedback): squash to 0.94 while held, restore
-- with settle -- "There is no bevel to collapse, so the squash carries all
-- the feedback."

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local StudField = require(script.Parent.StudField)

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

local function CloseButton(props)
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
		BackgroundColor3 = Theme.colors.danger,
		Size = props.size or UDim2.fromOffset(Theme.metrics.windowHeaderHeight * Theme.metrics.buttonCloseAspect, Theme.metrics.windowHeaderHeight),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			squash(0.94, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = props.onActivated,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.outline.thickness,
			Color = Theme.strokes.outline.color,
			ApplyStrokeMode = Theme.strokes.outline.mode,
		}),
		Emboss = e(StudField, { zIndex = 2 }),
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "\u{00D7}", -- multiplication sign: renders cleanly in FredokaOne (verification.md glyph list)
			FontFace = Theme.typography.heading.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 3,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.sm),
				PaddingRight = UDim.new(0, Theme.spacing.sm),
				PaddingTop = UDim.new(0, Theme.spacing.sm),
				PaddingBottom = UDim.new(0, Theme.spacing.sm),
			}),
		}),
	})
end

return CloseButton
