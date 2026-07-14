-- side-button from DESIGN.roblox.md (Loud Slab): "HUD rail slab: icon fills
-- it, caption sits inside the bottom edge; stacked vertically on the
-- screen's left edge." "~90px square at reference." surface-deep fill,
-- transparency 0.25, no rounding, caption in BuilderSans caption tier +
-- text-outline. Optional red notification badge (Do's-and-Don'ts: no bevel
-- shading anywhere in this taste, badge is a flat square).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

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

local function badgeText(count)
	if count > 99 then
		return "99+"
	end
	return tostring(count)
end

local function SideButton(props)
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
		BackgroundColor3 = Theme.colors.surfaceDeep,
		BackgroundTransparency = 0.25,
		Size = props.size or UDim2.fromOffset(90, 90), -- token: "~90px square at reference"
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			squash(0.92, SQUASH_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.MouseLeave] = function()
			squash(1, SQUASH_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Scale = e("UIScale", { ref = scaleRef }),
		Stroke = e("UIStroke", {
			Thickness = Theme.strokes.slotOutline.thickness,
			Color = Theme.strokes.slotOutline.color,
			ApplyStrokeMode = Theme.strokes.slotOutline.mode,
		}),
		Icon = e("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.icon or "",
			ImageColor3 = Theme.colors.onSurface, -- monochrome asset tinted via the palette (asset-sourcing.md)
			Size = UDim2.new(1, -Theme.spacing.md * 2, 1, -(Theme.spacing.md * 2 + 20)),
			Position = UDim2.new(0.5, 0, 0, Theme.spacing.sm),
			AnchorPoint = Vector2.new(0.5, 0),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2,
		}),
		Caption = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -Theme.spacing.xs * 2, 0, 20),
			Position = UDim2.new(0.5, 0, 1, -Theme.spacing.xs),
			AnchorPoint = Vector2.new(0.5, 1),
			Text = props.text and (props.text:sub(1, 1):upper() .. props.text:sub(2):lower()) or "Shop", -- Title Case row label
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = 2,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
		}),
		Badge = (props.badge and props.badge > 0) and e("Frame", {
			BackgroundColor3 = Theme.colors.danger,
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, 0, 0, 0),
			AnchorPoint = Vector2.new(1, 0),
			ZIndex = 3,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.slotOutline.thickness,
				Color = Theme.strokes.slotOutline.color,
				ApplyStrokeMode = Theme.strokes.slotOutline.mode,
			}),
			Count = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = badgeText(props.badge),
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 4,
			}, {
				Stroke = e("UIStroke", {
					Thickness = 2,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = 14 }),
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, 3),
					PaddingRight = UDim.new(0, 3),
					PaddingTop = UDim.new(0, 3),
					PaddingBottom = UDim.new(0, 3),
				}),
			}),
		}) or nil,
	})
end

return SideButton
