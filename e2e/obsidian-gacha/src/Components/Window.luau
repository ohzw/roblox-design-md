-- window / window-header / dim-overlay from DESIGN.roblox.md.
-- Anatomy (Screen Patterns): a centered near-black `surface` panel over the
-- dimmed + BLURRED world; header integrated top-left (a semantic-colored icon +
-- white title, NO overlapping band); an optional pill search field; a bare
-- white X close top-right; white corner brackets on the panel; a footer slot.
-- Motion (DESIGN.md): the panel FADES fast with no scale-down (CanvasGroup
-- GroupTransparency 1->0), while an animated depth-of-field blur eases onto the
-- world over ~slow — the signature transition. `variant = "dialog"` shrinks the
-- max size for the small confirm popup (a smaller window variant, not a new
-- anatomy — standard-showcase.md).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local CloseButton = require(script.Parent.CloseButton)
local CornerBrackets = require(script.Parent.CornerBrackets)

local e = React.createElement

local HEADER_H = 48
local BLUR = TweenInfo.new(Theme.motion.durations.slow, Theme.motion.easings.blur.style, Theme.motion.easings.blur.direction)

local function Window(props)
	React.useEffect(function()
		-- Signature: an animated depth-of-field blur on the WORLD (Lighting;
		-- blurs the 3D render, never the ScreenGui UI). Cleaned up on unmount.
		-- NOTE: the DESIGN.md's "panel fades in" is intentionally dropped here.
		-- A CanvasGroup is the only way to fade chrome + children as one, but it
		-- RASTERIZES the subtree and visibly dims/softens it (verified in-engine:
		-- correct token colors rendered muddy). The backdrop blur is the taste's
		-- real signature transition; render fidelity of the settled panel wins
		-- over a fast fade that isn't even visible in a still. (motion-implementation.md
		-- sanctions the plain-Frame fallback over trading anatomy for one tween.)
		local blur = Instance.new("BlurEffect")
		blur.Size = 0
		blur.Parent = Lighting
		TweenService:Create(blur, BLUR, { Size = 18 }):Play()
		return function()
			blur:Destroy()
		end
	end, {})

	local isDialog = props.variant == "dialog"
	local maxSize = props.maxSize or (if isDialog then Vector2.new(460, 300) else Vector2.new(1000, 620))
	local panelScale = props.size or (if isDialog then UDim2.fromScale(0.5, 0.42) else UDim2.fromScale(0.82, 0.78))

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
		Panel = e("Frame", {
			-- white base: the panel's dark top-to-bottom gradient (Theme.gradients.window)
			-- multiplies with this, so it must be white to render true (Theme.white).
			BackgroundColor3 = Theme.white,
			BackgroundTransparency = Theme.panelTransparency,
			Size = panelScale,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 11,
		}, {
			MaxSize = e("UISizeConstraint", { MaxSize = maxSize }),
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Gradient = e("UIGradient", {
				Color = ColorSequence.new(Theme.gradients.window.top, Theme.gradients.window.bottom),
				Rotation = 90,
			}),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.panel.thickness,
				Color = Theme.strokes.panel.color,
				ApplyStrokeMode = Theme.strokes.panel.mode,
			}),
			Brackets = e(CornerBrackets, { color = Theme.colors.outline, arm = 26, inset = 8, thickness = 3, zIndex = 5 }),
			-- Integrated header, top-left: icon + title. No band.
			HeaderIcon = if props.icon
				then e("ImageLabel", {
					BackgroundTransparency = 1,
					Image = props.icon,
					ImageColor3 = props.iconColor or Theme.colors.primary,
					Size = UDim2.fromOffset(30, 30),
					Position = UDim2.fromOffset(Theme.spacing.lg, Theme.spacing.md + 2),
					ZIndex = 6,
				})
				else nil,
			Title = e("TextLabel", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.XY,
				Size = UDim2.fromScale(0, 0),
				Position = UDim2.fromOffset(if props.icon then Theme.spacing.lg + 40 else Theme.spacing.lg, Theme.spacing.md),
				Text = props.title or "Window",
				FontFace = Theme.typography.heading.font,
				TextColor3 = Theme.colors.onSurface,
				TextSize = Theme.typography.heading.textSize,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 6,
			}),
			Search = if props.search
				then e("Frame", {
					BackgroundColor3 = Theme.colors.surfaceDeep,
					Size = UDim2.fromOffset(240, 34),
					Position = UDim2.new(1, -64, 0, Theme.spacing.md),
					AnchorPoint = Vector2.new(1, 0),
					ZIndex = 6,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.panel.thickness,
						Color = Theme.strokes.panel.color,
						ApplyStrokeMode = Theme.strokes.panel.mode,
					}),
					Placeholder = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Text = "  Search",
						FontFace = Theme.typography.body.font,
						TextColor3 = Theme.colors.onSurfaceDim,
						TextSize = Theme.typography.body.textSize,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 6,
					}, {
						Padding = e("UIPadding", { PaddingLeft = UDim.new(0, Theme.spacing.md) }),
					}),
				})
				else nil,
			Close = e(CloseButton, {
				position = UDim2.new(1, -Theme.spacing.sm, 0, Theme.spacing.sm),
				anchorPoint = Vector2.new(1, 0),
				zIndex = 6,
				onActivated = props.onClose,
			}),
			Content = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, -HEADER_H),
				Position = UDim2.fromOffset(0, HEADER_H),
				ZIndex = 5,
			}, {
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.lg),
					PaddingRight = UDim.new(0, Theme.spacing.lg),
					PaddingTop = UDim.new(0, Theme.spacing.sm),
					PaddingBottom = UDim.new(0, Theme.spacing.lg),
				}),
				Children = e(React.Fragment, nil, props.children),
			}),
		}),
	})
end

return Window
