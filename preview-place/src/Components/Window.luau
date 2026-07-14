-- window / window-header / dim-overlay from DESIGN.roblox.md.
-- Header band sits proud of the window top edge (~40% overlap), close button
-- overlaps the top-right corner. Drop shadow is a plain offset frame (no assets).
-- Entrance (DESIGN.md Motion): scale 0.8 -> 1.0 with pop (Back Out) at
-- durations.normal; never fade-only. Shadow and panel scale together via the
-- PanelGroup wrapper.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local CloseButton = require(script.Parent.CloseButton)

local e = React.createElement

local ENTRANCE = TweenInfo.new(
	Theme.motion.durations.normal,
	Theme.motion.easings.pop.style,
	Theme.motion.easings.pop.direction
)

local function Window(props)
	local scaleRef = React.useRef(nil)

	React.useEffect(function()
		local uiScale = scaleRef.current
		if uiScale then
			uiScale.Scale = 0.8
			TweenService:Create(uiScale, ENTRANCE, { Scale = 1 }):Play()
		end
	end, {})

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}, {
		Dim = e("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.dim,
			BackgroundTransparency = Theme.dimTransparency,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			[React.Event.Activated] = function()
				if props.onClose then
					props.onClose()
				end
			end,
		}),
		PanelGroup = e("Frame", {
			BackgroundTransparency = 1,
			Size = props.size or UDim2.fromScale(0.85, 0.85),
			Position = UDim2.fromScale(0.5, 0.52),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 11,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			-- Responsive window pattern (layout-rules.md): Scale-first sizing
			-- with a MaxSize clamp at the taste's intended desktop dimensions,
			-- so the panel can never exceed the viewport at phone landscape
			-- (667x375) while staying the original fixed-offset size at
			-- desktop widths >= the max.
			MaxSize = e("UISizeConstraint", { MaxSize = props.maxSize or Vector2.new(700, 520) }),
			-- Shadow must render BEFORE Panel (lower sibling ZIndex): under
			-- ZIndexBehavior.Sibling a child always draws above its parent, so
			-- a shadow child of Panel would tint the whole panel (bug caught
			-- by the blind calibration).
			Shadow = e("Frame", {
				BackgroundColor3 = Color3.fromHex("#000000"),
				BackgroundTransparency = 0.75,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.new(0.5, 0, 0.5, 8),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 1,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
			}),
			Panel = e("Frame", {
				BackgroundColor3 = Theme.colors.surface,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outlineHeavy.thickness,
					Color = Theme.strokes.outlineHeavy.color,
					ApplyStrokeMode = Theme.strokes.outlineHeavy.mode,
				}),
				Header = e("Frame", {
					BackgroundColor3 = Theme.colors.secondary,
					Size = UDim2.new(0.5, 0, 0, 56),
					Position = UDim2.new(0.5, 0, 0, -22),
					AnchorPoint = Vector2.new(0.5, 0),
					ZIndex = 4,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.outline.thickness,
						Color = Theme.strokes.outline.color,
						ApplyStrokeMode = Theme.strokes.outline.mode,
					}),
					Title = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Text = string.upper(props.title or "WINDOW"),
						FontFace = Theme.typography.heading.font,
						TextScaled = true,
						TextColor3 = Theme.colors.white,
						ZIndex = 5,
					}, {
						Stroke = e("UIStroke", {
							Thickness = Theme.strokes.textOutline.thickness,
							Color = Theme.strokes.textOutline.color,
							ApplyStrokeMode = Theme.strokes.textOutline.mode,
						}),
						MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
						Padding = e("UIPadding", {
							PaddingLeft = UDim.new(0, Theme.spacing.lg),
							PaddingRight = UDim.new(0, Theme.spacing.lg),
							PaddingTop = UDim.new(0, Theme.spacing.sm),
							PaddingBottom = UDim.new(0, Theme.spacing.sm),
						}),
					}),
				}),
				Close = e(CloseButton, {
					position = UDim2.new(1, 6, 0, -6),
					anchorPoint = Vector2.new(0.5, 0.5),
					zIndex = 5,
					onActivated = props.onClose,
				}),
				Content = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, -44),
					Position = UDim2.new(0, 0, 0, 44),
					ZIndex = 3,
				}, {
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.xl),
						PaddingRight = UDim.new(0, Theme.spacing.xl),
						PaddingTop = UDim.new(0, Theme.spacing.md),
						PaddingBottom = UDim.new(0, Theme.spacing.xl),
					}),
					Children = e(React.Fragment, nil, props.children),
				}),
			}),
		}),
	})
end

return Window
