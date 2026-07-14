-- window / window-header from DESIGN.roblox.md: the core grammar. An
-- integrated edge-to-edge gradient header band (~84px, brightest at top,
-- stud emboss, icon far-left, left-aligned title, close slab flush at the
-- header's right end) over one large self-dimming `{colors.surface-deep}`
-- well (~70% opaque near-black) holding all content, with a huge, very
-- transparent watermark title echo behind the content (Elevation #4). A 4px
-- border wraps the whole window; corners resolve at rounded.md, flat -- no
-- bevel, no drop shadow anywhere (Elevation prose: "there are no drop
-- shadows and no bevels anywhere").
--
-- Layer stack (Components prose): world -> self-dimming well (this IS the
-- dim layer -- no separate dim overlay exists in this taste) -> chrome ->
-- content. `showDim` here toggles a dim-tap-to-close backdrop BEHIND the
-- window frame for story/dialog contexts; it is intentionally a thin dark
-- veil distinct from the window's own surface-deep well.
--
-- Motion (Motion section): entrance scale 0.85 -> 1.0 Back-Out at
-- durations.normal ("an overshoot-happy, juicy register -- inferred, not
-- observed"). Exit: scale to 0.9 + fade, Quad-In at durations.fast, faster
-- than the entrance. UIScale sits on a PanelGroup wrapper containing the
-- whole window (header + well) so everything scales together -- there is no
-- separate shadow to co-scale in this taste (no drop shadows per Elevation).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local StudField = require(script.Parent.StudField)
local CloseButton = require(script.Parent.CloseButton)

local e = React.createElement

local ENTRANCE = TweenInfo.new(
	Theme.motion.durations.normal,
	Theme.motion.easings.pop.style,
	Theme.motion.easings.pop.direction
)
local EXIT = TweenInfo.new(
	Theme.motion.durations.fast,
	Theme.motion.easings.exit.style,
	Theme.motion.easings.exit.direction
)

local function Window(props)
	local scaleRef = React.useRef(nil)
	local wellRef = React.useRef(nil)
	local headerRef = React.useRef(nil)
	local closingRef = React.useRef(false)

	React.useEffect(function()
		local uiScale = scaleRef.current
		if uiScale then
			uiScale.Scale = 0.85
			TweenService:Create(uiScale, ENTRANCE, { Scale = 1 }):Play()
		end
	end, {})

	local function requestClose()
		if closingRef.current or not props.onClose then
			return
		end
		closingRef.current = true
		local uiScale = scaleRef.current
		if not uiScale then
			props.onClose()
			return
		end
		local scaleTween = TweenService:Create(uiScale, EXIT, { Scale = 0.9 })
		local well = wellRef.current
		if well then
			TweenService:Create(well, EXIT, { BackgroundTransparency = 1 }):Play()
		end
		local header = headerRef.current
		if header then
			TweenService:Create(header, EXIT, { BackgroundTransparency = 1 }):Play()
		end
		scaleTween.Completed:Once(function()
			props.onClose()
		end)
		scaleTween:Play()
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = props.zIndex,
	}, {
		-- Optional dim-tap backdrop (dialogs over the HUD/world). This is NOT
		-- the window's own well -- see header note: this taste's window has no
		-- separate dim token, but a modal dialog still needs a tap-to-dismiss
		-- veil behind it in a story/HUD context.
		Dim = props.showDim and e("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 0.45,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			[React.Event.Activated] = requestClose,
		}) or nil,
		PanelGroup = e("Frame", {
			BackgroundTransparency = 1,
			Size = props.size or UDim2.fromScale(0.85, 0.75),
			Position = props.position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
			ZIndex = 11,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			-- Responsive window pattern (layout-rules.md): MaxSize clamps the
			-- panel at the taste's intended desktop dimensions so it can never
			-- exceed the viewport at phone landscape (667x375).
			MaxSize = if props.maxSize then e("UISizeConstraint", { MaxSize = props.maxSize }) else nil,
			Frame = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ClipsDescendants = true,
				ZIndex = 1,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.outlineHeavy.thickness,
					Color = Theme.strokes.outlineHeavy.color,
					ApplyStrokeMode = Theme.strokes.outlineHeavy.mode,
				}),
				-- Header band: integrated, edge-to-edge, ~84px, themed vertical
				-- gradient (brightest at top). Its own UICorner + the panel's
				-- ClipsDescendants keep the top corners rounded while the band's
				-- bottom edge stays a flush square seam against the well below
				-- (layout-rules.md #4.5 partial-corner-rounding pattern (b)).
				Header = e("Frame", {
					ref = headerRef,
					BackgroundColor3 = Theme.gradients.windowHeader[1],
					Size = UDim2.new(1, 0, 0, Theme.metrics.windowHeaderHeight),
					ZIndex = 2,
				}, {
					Gradient = e("UIGradient", {
						Color = ColorSequence.new(Theme.gradients.windowHeader[1], Theme.gradients.windowHeader[2]),
						Rotation = 90,
					}),
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.outline.thickness,
						Color = Theme.strokes.outline.color,
						ApplyStrokeMode = Theme.strokes.outline.mode,
					}),
					Emboss = e(StudField, { zIndex = 3 }),
					Content = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 4,
					}, {
						Padding = e("UIPadding", {
							PaddingLeft = UDim.new(0, Theme.spacing.lg),
							PaddingRight = UDim.new(0, Theme.spacing.lg),
						}),
						Layout = e("UIListLayout", {
							FillDirection = Enum.FillDirection.Horizontal,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, Theme.spacing.sm),
						}),
						Icon = props.icon and e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.fromOffset(40, 40),
							Text = props.icon,
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
						}) or nil,
						Title = e("TextLabel", {
							BackgroundTransparency = 1,
							AutomaticSize = Enum.AutomaticSize.X,
							Size = UDim2.new(0, 0, 1, 0),
							Text = props.title or "Window", -- Title Case, never ALL CAPS (Typography prose)
							FontFace = Theme.typography.heading.font,
							TextSize = Theme.typography.heading.textSize,
							TextColor3 = Theme.colors.onSurface,
							TextXAlignment = Enum.TextXAlignment.Left,
							LayoutOrder = 2,
						}, {
							Stroke = e("UIStroke", {
								Thickness = Theme.strokes.textOutline.thickness,
								Color = Theme.strokes.textOutline.color,
								ApplyStrokeMode = Theme.strokes.textOutline.mode,
							}),
						}),
						CounterChip = props.counterText and e("Frame", {
							BackgroundColor3 = Theme.colors.onSurface,
							Size = UDim2.fromOffset(96, 40),
							LayoutOrder = 3,
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
								Text = props.counterText,
								FontFace = Theme.typography.body.font,
								TextScaled = true,
								TextColor3 = Theme.colors.outline,
								ZIndex = 2,
							}, {
								MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.body.textSize }),
								Padding = e("UIPadding", {
									PaddingLeft = UDim.new(0, Theme.spacing.sm),
									PaddingRight = UDim.new(0, Theme.spacing.sm),
								}),
							}),
						}) or nil,
					}),
					Close = e(CloseButton, {
						anchorPoint = Vector2.new(1, 0),
						position = UDim2.new(1, 0, 0, 0),
						size = UDim2.fromOffset(Theme.metrics.windowHeaderHeight * Theme.metrics.buttonCloseAspect, Theme.metrics.windowHeaderHeight),
						zIndex = 5,
						onActivated = requestClose,
					}),
				}),
				-- Body well: one large self-dimming `{colors.surface-deep}` fill
				-- (~70% opaque near-black). No separate dim layer -- the well
				-- itself is the depth cue (Elevation prose #3).
				Well = e("Frame", {
					ref = wellRef,
					BackgroundColor3 = Theme.colors.surfaceDeep,
					BackgroundTransparency = Theme.surfaceDeepTransparency,
					Size = UDim2.new(1, 0, 1, -Theme.metrics.windowHeaderHeight),
					Position = UDim2.fromOffset(0, Theme.metrics.windowHeaderHeight),
					ZIndex = 2,
				}, {
					-- Watermark echo: the window title repeats as a huge, very
					-- transparent ghost headline behind the content rows
					-- (Elevation #4, a signature depth cue of this taste).
					Watermark = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1.4, 1),
						Position = UDim2.fromScale(-0.2, 0),
						Text = string.upper(props.title or "WINDOW"),
						FontFace = Theme.typography.display.font,
						TextScaled = true,
						TextColor3 = Theme.colors.onSurface,
						TextTransparency = Theme.derived.watermarkTransparency,
						TextWrapped = false,
						ZIndex = 3,
					}),
					Content = e("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 4,
					}, {
						Padding = e("UIPadding", {
							PaddingLeft = UDim.new(0, Theme.spacing.xl),
							PaddingRight = UDim.new(0, Theme.spacing.xl),
							PaddingTop = UDim.new(0, Theme.spacing.lg),
							PaddingBottom = UDim.new(0, Theme.spacing.lg),
						}),
						Children = e(React.Fragment, nil, props.children),
					}),
				}),
			}),
		}),
	})
end

return Window
