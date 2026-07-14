-- side-button from DESIGN.roblox.md: HUD launcher tiles in a 2-column grid
-- (Store, Trade, Index...): dark translucent squared tile with icon, caption
-- below, "NEW!" corner flash in gold when relevant (Components prose).
-- backgroundColor #1A1A1A80 -> 0.50 transparency (Theme.transparencies.sideButtonFill).
--
-- Motion (press feedback): squash 0.94 + a brightness lift alongside (this
-- taste's flat-fill components have no bevel; Components prose says derive
-- pressed/disabled since none were observed -- squash still carries the
-- primary read, brightness lift keeps a still-frame press cue like the
-- GradientButton's Fill lift).
--
-- Icon slot: `props.image` (a Theme.assets.* rbxassetid, tinted via
-- ImageColor3 per asset-sourcing.md's tinting rule) takes precedence over
-- `props.icon` (a glyph placeholder string) when both are given -- mirrors
-- frosted-baseplate/src/Components/SideButton.luau's pattern -- real assets
-- replace glyphs without dropping the glyph fallback path other callers
-- still use.

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
		BackgroundColor3 = Theme.inks.sideButtonFill,
		BackgroundTransparency = Theme.transparencies.sideButtonFill,
		Size = props.size or UDim2.fromOffset(140, 140 / Theme.metrics.sideButtonAspect),
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
		Content = e("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 3,
		}, {
			Layout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, Theme.spacing.xs),
			}),
			Icon = if props.image then e("ImageLabel", {
				BackgroundTransparency = 1,
				Image = props.image,
				ImageColor3 = Theme.colors.onSurface,
				Size = UDim2.fromOffset(40, 40),
				LayoutOrder = 1,
			}) else e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(40, 40),
				Text = props.icon or "\u{25A0}",
				FontFace = Theme.typography.heading.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				LayoutOrder = 1,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
			}),
			Caption = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -Theme.spacing.xs * 2, 0, 24),
				Text = props.text or "Menu",
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				LayoutOrder = 2,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
			}),
		}),
		-- "NEW!" corner flash in gold (Components prose), opt-in via prop.
		NewFlash = props.isNew and e("TextLabel", {
			BackgroundColor3 = Theme.colors.currencySoft,
			Size = UDim2.fromOffset(48, 24),
			Position = UDim2.new(1, -4, 0, -8),
			AnchorPoint = Vector2.new(1, 0),
			Text = "NEW!",
			FontFace = Theme.typography.caption.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			Rotation = -8,
			ZIndex = 5,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			TextStroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
		}) or nil,
		-- Notification badge (standard-showcase.md HUD story: "a notification
		-- badge showing 3 on one of them"). Small squared badge-slot anatomy
		-- pinned to the tile's top-right corner, distinct from the NEW flash.
		Badge = props.badge and e("Frame", {
			BackgroundColor3 = Theme.inks.badgeSlotFill,
			BackgroundTransparency = Theme.transparencies.badgeSlotFill,
			Size = UDim2.fromOffset(32, 32),
			Position = UDim2.new(1, 6, 0, -6),
			AnchorPoint = Vector2.new(1, 0),
			ZIndex = 6,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			Text = e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Text = tostring(props.badge),
				FontFace = Theme.typography.caption.font,
				TextScaled = true,
				TextColor3 = Theme.colors.onSurface,
				ZIndex = 7,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.caption.textSize }),
			}),
		}) or nil,
	})
end

return SideButton
