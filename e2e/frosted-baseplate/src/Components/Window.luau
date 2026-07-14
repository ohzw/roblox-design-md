-- window / window-header / dim-overlay from DESIGN.roblox.md (Frosted
-- Baseplate): a charcoal stud-embossed slab (rounded.lg, soft drop shadow,
-- NO outer stroke) floating over the blurred world. There is NO header band:
-- the title is a floating sticker tab -- a small circular icon badge plus
-- typography.heading white outlined text -- hovering over the slab's
-- top-left edge, half outside the panel. The close control is CloseCross,
-- an oversized cross overlapping the top-right corner, floating free of the
-- edge (never a child of the panel's clipped content). Content is a single
-- padded column of inset rows or a grid; there is NO footer -- CTAs live
-- inline in rows (this component only lays out the padded content area;
-- rows/CTAs are the caller's job per the "components before screens" rule).
-- Layer stack (Elevation prose): blurred world -> dim tint -> slab (shadow)
-- -> inset rows -> floating tab and cross.
--
-- Celebration re-skin (ice frame) is NOT implemented here: Do's and Don'ts /
-- Components prose says celebration windows "keep this exact grammar but
-- swap the slab for a surface-ice frame" -- that is a separate component
-- (out of scope for this core slice; flagged, not silently dropped).
--
-- Motion (Motion section): entrance scale 0.8 -> 1.0 with pop (Back-Out) at
-- durations.normal, world blur ramps in over the same duration (BlurEffect
-- driven by the caller/story, since Window does not own the camera). Exit:
-- scale to 0.9 + fade, durations.fast, exit easing -- faster than entrance.
-- Shadow, panel, tab, and cross all scale together via the PanelGroup
-- wrapper (never a child of Panel -- ZIndexBehavior.Sibling renders children
-- ABOVE their parent, so a shadow child would tint the whole slab; see
-- layout-rules.md #4). PanelGroup is a plain Frame, NOT a CanvasGroup: the
-- sticker tab and cross must float half outside the panel's own bounds, and
-- CanvasGroup rasterizes + clips its entire subtree to its own bounds (see
-- motion-implementation.md's CanvasGroup caveat) -- that would silently clip
-- the floating chrome this taste's whole anatomy depends on. Exit fade is
-- therefore per-piece Transparency tweens, not a single GroupTransparency.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local StudField = require(script.Parent.StudField)
local CloseCross = require(script.Parent.CloseCross)

local e = React.createElement

local TAB_HEIGHT = 56
local TAB_BADGE = 44 -- circular icon badge inside the sticker tab

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
	local panelRef = React.useRef(nil)
	local shadowRef = React.useRef(nil)
	local closingRef = React.useRef(false)

	-- Entrance: scale 0.8 -> 1.0, Back-Out, never fade-only (Motion prose).
	React.useEffect(function()
		local uiScale = scaleRef.current
		if uiScale then
			uiScale.Scale = 0.8
			TweenService:Create(uiScale, ENTRANCE, { Scale = 1 }):Play()
		end
	end, {})

	local function requestClose()
		-- No handler -> no close affordance; do NOT latch closingRef here or
		-- the window becomes permanently unresponsive once a handler appears
		-- (bug caught by the Studio verification pass).
		if closingRef.current or not props.onClose then
			return
		end
		closingRef.current = true
		local uiScale = scaleRef.current
		if not uiScale then
			props.onClose()
			return
		end
		-- Exit: scale to 0.9 + fade, faster than the entrance (Motion prose).
		-- PanelGroup is a plain Frame (see header note: a CanvasGroup here
		-- would clip the floating tab/cross), so the fade is the slab's own
		-- BackgroundTransparency + its shadow, in parallel with the shared
		-- scale-down -- the floating chrome shrinks away with the panel it
		-- overlaps rather than fading on a separate channel.
		local scaleTween = TweenService:Create(uiScale, EXIT, { Scale = 0.9 })
		local panel = panelRef.current
		if panel then
			TweenService:Create(panel, EXIT, { BackgroundTransparency = 1 }):Play()
		end
		local shadow = shadowRef.current
		if shadow then
			TweenService:Create(shadow, EXIT, { BackgroundTransparency = 1 }):Play()
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
		-- Layering (Elevation prose): dim tint sits under the slab; a strong
		-- camera BlurEffect is a scene-level concern owned by the caller/story,
		-- not this component (Window has no access to workspace.CurrentCamera
		-- concerns beyond its own ScreenGui tree).
		Dim = props.showDim ~= false and e("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.dim,
			BackgroundTransparency = Theme.dimTransparency,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			[React.Event.Activated] = requestClose,
		}) or nil,
		PanelGroup = e("Frame", {
			BackgroundTransparency = 1,
			Size = props.size or UDim2.fromScale(0.42, 0.5),
			Position = props.position or UDim2.fromScale(0.5, 0.52),
			AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
			ZIndex = 11,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			-- Responsive window pattern (layout-rules.md): MaxSize clamps the
			-- panel at the taste's intended desktop dimensions so it can never
			-- exceed the viewport at phone landscape (667x375). Applies to the
			-- whole PanelGroup (slab + floating tab/cross together), since this
			-- taste's floating chrome must shrink in lockstep with the slab it
			-- overlaps, never independently.
			MaxSize = e("UISizeConstraint", { MaxSize = props.maxSize or Vector2.new(600, 600) }),
			-- Shadow drawn as a lower-ZIndex SIBLING inside the group, never a
			-- child of Panel (layout-rules.md #4: a shadow child renders ABOVE
			-- its parent under Sibling behavior).
			Shadow = e("Frame", {
				ref = shadowRef,
				BackgroundColor3 = Theme.windowShadow.color,
				BackgroundTransparency = Theme.windowShadow.transparency,
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.new(0.5, 0, 0.5, Theme.windowShadow.offset),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 1,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
			}),
			-- Slab: studded charcoal fill, soft shadow already drawn behind it,
			-- NO outer UIStroke (Do's and Don'ts: slabs carry no outer stroke;
			-- their edge is the drop shadow alone).
			Panel = e("Frame", {
				ref = panelRef,
				BackgroundColor3 = Theme.colors.surface,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
				ClipsDescendants = true,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
				Emboss = e(StudField, { color = Theme.colors.surface, zIndex = 1 }),
				Content = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 2,
				}, {
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.xl),
						PaddingRight = UDim.new(0, Theme.spacing.xl),
						PaddingTop = UDim.new(0, Theme.spacing.xl),
						PaddingBottom = UDim.new(0, Theme.spacing.xl),
					}),
					Children = e(React.Fragment, nil, props.children),
				}),
			}),
			-- Floating sticker-tab title: NOT a header band. Half outside the
			-- panel over the top-left edge (Components prose). Transparent
			-- background (window-header token: transparency 1); icon badge
			-- left, title text right; never stretch into a bar.
			TitleTab = e("Frame", {
				BackgroundTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.new(0, 0, 0, TAB_HEIGHT),
				Position = UDim2.new(0, Theme.spacing.lg, 0, -TAB_HEIGHT * 0.45),
				ZIndex = 20,
			}, {
				Layout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Theme.spacing.sm),
				}),
				Badge = e("Frame", {
					BackgroundColor3 = Theme.colors.secondary,
					Size = UDim2.fromOffset(TAB_BADGE, TAB_BADGE),
					LayoutOrder = 1,
					ZIndex = 21,
				}, {
					Corner = e("UICorner", { CornerRadius = Theme.rounded.full }),
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.outline.thickness,
						Color = Theme.strokes.outline.color,
						ApplyStrokeMode = Theme.strokes.outline.mode,
					}),
					Icon = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(0.6, 0.6),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Text = props.icon or "\u{2699}", -- gear default; callers pass a taste-appropriate glyph
						FontFace = Theme.typography.label.font,
						TextScaled = true,
						TextColor3 = Theme.colors.onSurface,
						ZIndex = 22,
					}),
				}),
				Title = e("TextLabel", {
					BackgroundTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.new(0, 0, 1, 0),
					Text = props.title or "Window", -- Title Case per Typography prose, never ALL CAPS
					FontFace = Theme.typography.heading.font,
					TextSize = Theme.typography.heading.textSize, -- fixed: the tab is fixed chrome, not a scaled container
					TextColor3 = Theme.colors.onSurface,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 2,
					ZIndex = 21,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
				}),
			}),
			-- Free-floating cross, always top-right, overlapping the corner.
			Close = e(CloseCross, {
				position = UDim2.new(1, Theme.spacing.md, 0, -Theme.metrics.closeCrossSize * 0.35),
				anchorPoint = Vector2.new(0.5, 0.5),
				zIndex = 20,
				onActivated = requestClose,
			}),
		}),
	})
end

return Window
