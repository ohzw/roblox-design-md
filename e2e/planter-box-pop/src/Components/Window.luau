-- window / window-header from DESIGN.roblox.md: the planter box. Brown
-- stud-quilted body, 14px corners, 2px ink rim, NO shadow (Elevation prose:
-- "windows sit flat over the world with no detached darkness"). The header
-- is an INTEGRATED full-width band at the window TOP -- never a floating
-- tab, never overlapping the top edge (Do's and Don'ts) -- stud-embossed
-- green, title left in {typography.heading}, utility cluster (gold action
-- plate then red close square) flush-right INSIDE the band.
-- Stud emboss (Elevation #1, the signature cue): both header and body tile
-- the canonical stud texture asset (Theme.assets.studTexture), tinted per
-- surface via ImageColor3. Inset rows (RowCard) deliberately omit this so
-- they read as recessed dirt (Elevation prose).
-- Entrance/exit (Motion): scale 0.8 -> 1.0 Back-Out at durations.normal on
-- enter; scale -> 0.9 + fade at durations.fast (Quad-In) on exit, faster than
-- entrance per the DESIGN.md's explicit asymmetry rule.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local ButtonPrimary = require(script.Parent.ButtonPrimary)
local ButtonClose = require(script.Parent.ButtonClose)

local e = React.createElement

local HEADER_HEIGHT = 64 -- components.window-header.height

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

-- Stud emboss: tiled real texture asset (asset-sourcing.md canonical
-- studTexture), tinted to `studColor` via ImageColor3 so the same asset
-- serves every surface hue. Replaces the earlier procedural Frame grid,
-- which was a placeholder standing in for the image motif the DESIGN.md
-- calls for.
local function StudField(props)
	return e("ImageLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = Theme.assets.studTexture,
		ImageColor3 = props.studColor,
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(40, 40),
		ZIndex = props.zIndex or 1,
	})
end

local function Window(props)
	local scaleRef = React.useRef(nil)
	local groupRef = React.useRef(nil)
	local closingRef = React.useRef(false)

	React.useEffect(function()
		local uiScale = scaleRef.current
		local group = groupRef.current
		if uiScale then
			uiScale.Scale = 0.8
			TweenService:Create(uiScale, ENTRANCE, { Scale = 1 }):Play()
		end
		if group then
			group.GroupTransparency = 1
			TweenService:Create(group, ENTRANCE, { GroupTransparency = 0 }):Play()
		end
	end, {})

	local function requestClose()
		if closingRef.current then
			return
		end
		closingRef.current = true
		local uiScale = scaleRef.current
		local group = groupRef.current
		if uiScale then
			TweenService:Create(uiScale, EXIT, { Scale = 0.9 }):Play()
		end
		if group then
			local tween = TweenService:Create(group, EXIT, { GroupTransparency = 1 })
			tween.Completed:Once(function()
				if props.onClose then
					props.onClose()
				end
			end)
			tween:Play()
		elseif props.onClose then
			props.onClose()
		end
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}, {
		Panel = e("CanvasGroup", {
			ref = groupRef,
			BackgroundColor3 = Theme.colors.surface,
			Size = props.size or UDim2.fromScale(0.5, 0.62),
			Position = props.position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5),
			ZIndex = props.zIndex or 11,
		}, {
			Scale = e("UIScale", { ref = scaleRef }),
			-- Responsive window pattern (layout-rules.md): MaxSize clamps the
			-- panel at the taste's intended desktop dimensions so it can never
			-- exceed the viewport at phone landscape (667x375) -- verified
			-- failure mode: the Shop window's fixed 560x560 offset pushed the
			-- integrated header band off the top of the screen at that size.
			MaxSize = e("UISizeConstraint", { MaxSize = props.maxSize or Vector2.new(560, 560) }),
			Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			-- Body stud emboss, behind everything else as a low-ZIndex sibling
			-- of Header/Content (never a child of something it must sit behind).
			BodyStuds = e(StudField, {
				studColor = Theme.colors.onSurface,
				count = 96,
				zIndex = 1,
			}),
			-- Header band: INTEGRATED, full-width, flush with the window top.
			-- Never floats above the top edge (Do's and Don'ts).
			Header = e("Frame", {
				BackgroundColor3 = Theme.colors.secondary,
				Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
				ZIndex = 4,
			}, {
				-- Corners rounded only at the top (mask the bottom two so the
				-- band reads flush with the body it sits on).
				Corner = e("UICorner", { CornerRadius = Theme.rounded.lg }),
				Mask = e("Frame", {
					BackgroundColor3 = Theme.colors.secondary,
					Size = UDim2.new(1, 0, 0, Theme.rounded.lg.Offset),
					Position = UDim2.new(0, 0, 1, 0),
					AnchorPoint = Vector2.new(0, 1),
					ZIndex = 4,
				}),
				HeaderStuds = e(StudField, {
					studColor = Theme.colors.secondary,
					count = 24,
					zIndex = 5,
				}),
				Title = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.5, 0, 1, 0),
					Text = props.title or "Seed Shop",
					FontFace = Theme.typography.heading.font,
					TextScaled = true,
					TextColor3 = Theme.colors.onSurface,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, {
					Stroke = e("UIStroke", {
						Thickness = Theme.strokes.textOutline.thickness,
						Color = Theme.strokes.textOutline.color,
						ApplyStrokeMode = Theme.strokes.textOutline.mode,
					}),
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.heading.textSize }),
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.lg),
					}),
				}),
				-- Utility cluster: gold action plate then red close square,
				-- flush-right INSIDE the band (never outside/overlapping it).
				Cluster = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0.5, -Theme.spacing.lg, 1, 0),
					Position = UDim2.new(1, -Theme.spacing.lg, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5),
					ZIndex = 6,
				}, {
					Layout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						Padding = UDim.new(0, Theme.spacing.sm),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Action = if props.actionText ~= nil or not props.hideAction
						then e(ButtonPrimary, {
							text = props.actionText or "RESTOCK",
							variant = props.actionVariant,
							size = UDim2.fromOffset(150, 56), -- Layout prose: action plates ~56px at reference
							layoutOrder = 1,
							onActivated = props.onAction,
						})
						else nil,
					Close = e(ButtonClose, {
						size = UDim2.fromOffset(56, 56), -- Layout prose: close button ~56px at reference
						layoutOrder = 2,
						onActivated = requestClose,
					}),
				}),
			}),
			Content = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, -(HEADER_HEIGHT + Theme.spacing.xl)),
				Position = UDim2.new(0, 0, 0, HEADER_HEIGHT + Theme.spacing.md),
				ZIndex = 3,
			}, {
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.xl),
					PaddingRight = UDim.new(0, Theme.spacing.xl),
					PaddingBottom = UDim.new(0, Theme.spacing.xl),
				}),
				Children = e(React.Fragment, nil, props.children),
			}),
		}),
	})
end

return Window
