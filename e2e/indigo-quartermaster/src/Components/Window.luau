-- window / window-header / dim-overlay from DESIGN.roblox.md (Indigo
-- Quartermaster). Anatomy (drawable from prose, "Window anatomy" section):
--
--   A popup window is a flat {colors.surface} rectangle, 8px corners, NO
--   stroke, NO shadow -- it separates from the world only by the dim wash
--   and its own lightness. The header is an INTEGRATED band, full window
--   width, 48px tall, one value step lighter ({colors.header}), square where
--   it meets the body; the window's top radius clips its outer corners.
--   Title sits left in the band, white Bold, sentence case; the close X is a
--   bare white glyph flush right INSIDE the band -- never a filled circle,
--   never overlapping a corner. Full-screen hubs stretch the band to ~130px
--   to stack title + muted subtitle left, run the tab strip inline beside
--   them, and dock the dark currency pill left of the X. Body content is
--   wells and rows on the surface; the footer convention is either a green
--   button-primary bottom-right (forms/popups) or a full-width verdict band
--   flush with the bottom edge (purchase cards). Layer stack: dim -> panel
--   -> band/content, all on one visual plane (no shadow, no bevel).
--
-- Depth in this taste is a LIGHTNESS LADDER of one hue, never a shadow or
-- stroke -- the header is realized as an inner Frame at Theme.colors.header,
-- clipped square against the panel's own corner radius (ClipsDescendants +
-- a corner-radius-matched inner frame, so the header's OWN top corners still
-- read as rounded via the panel's UICorner, while its bottom edge is square
-- against the body, per "square where it meets the body").
--
-- Motion (taste-family preset, low confidence -- no video input): entrance
-- = fade + 12-16px slide in (pop, durations.normal), no scale-overshoot (this
-- taste reads bounce as lag); exit = fade + slight slide out, faster
-- (exit, durations.fast). Implemented via CanvasGroup fade (motion-
-- implementation.md "Fade entrances") since this taste bans scale pops.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)
local CloseButton = require(script.Parent.CloseButton)
local Tab = require(script.Parent.Tab)
local CurrencyBar = require(script.Parent.CurrencyBar)

local e = React.createElement

local POPUP_HEADER = 48
local HUB_HEADER = 130
local SLIDE = 14 -- px, within the DESIGN.md's 12-16px entrance-slide range

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
	local panelRef = React.useRef(nil)
	local dimRef = React.useRef(nil)
	local closingRef = React.useRef(false)

	local variant = props.variant or "popup" -- "popup" | "hub"
	local isHub = variant == "hub"
	local headerHeight = if isHub then HUB_HEADER else POPUP_HEADER
	local showDim = props.showDim ~= false
	local finalPosition = props.position or UDim2.fromScale(0.5, 0.5)
	local finalAnchor = props.anchorPoint or Vector2.new(0.5, 0.5)

	-- Entrance: fade + small downward-settling slide (frozen-initial-render
	-- pattern -- render once from the pre-entrance values, drive the rest via
	-- TweenService so React never fights the tween, per motion-
	-- implementation.md).
	React.useEffect(function()
		local panel = panelRef.current
		if panel then
			panel.Position = finalPosition - UDim2.fromOffset(0, SLIDE)
			panel.GroupTransparency = 1
			TweenService:Create(panel, ENTRANCE, {
				Position = finalPosition,
				GroupTransparency = 0,
			}):Play()
		end
	end, {})

	local function requestClose()
		if closingRef.current then
			return
		end
		closingRef.current = true
		local panel = panelRef.current
		if not panel then
			if props.onClose then
				props.onClose()
			end
			return
		end
		local tween = TweenService:Create(panel, EXIT, {
			Position = finalPosition - UDim2.fromOffset(0, SLIDE * 0.5),
			GroupTransparency = 1,
		})
		local dim = dimRef.current
		if dim then
			TweenService:Create(dim, EXIT, { BackgroundTransparency = 1 }):Play()
		end
		tween.Completed:Once(function()
			closingRef.current = false
			if props.onClose then
				props.onClose()
			end
		end)
		tween:Play()
	end

	return e("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = props.zIndex,
	}, {
		-- Layer stack: dim wash -> flat panel (no shadow) -> band/content,
		-- all on one visual plane.
		Dim = showDim and e("TextButton", {
			ref = dimRef,
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.dim,
			BackgroundTransparency = Theme.dimTransparency,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 10,
			[React.Event.Activated] = function()
				if props.dismissible ~= false then
					requestClose()
				end
			end,
		}) or nil,
		Panel = e("CanvasGroup", {
			ref = panelRef,
			GroupTransparency = 1, -- entrance effect fades this to 0
			BackgroundColor3 = Theme.colors.surface,
			Size = props.size or (if isHub then UDim2.fromScale(1, 1) else UDim2.fromScale(0.42, 0.55)),
			Position = finalPosition,
			AnchorPoint = finalAnchor,
			ZIndex = 11,
		}, {
			-- 8px corners; NO stroke, NO shadow anywhere on the panel.
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			-- Header band: integrated, full window width, one step lighter,
			-- square where it meets the body. ClipsDescendants keeps the
			-- band's own square bottom-inner corner from poking past the
			-- panel's rounded outer corner.
			Header = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, headerHeight),
				ClipsDescendants = true,
				ZIndex = 2,
			}, {
				Band = e("Frame", {
					BackgroundColor3 = Theme.colors.header,
					Size = UDim2.new(1, 0, 1, Theme.rounded.md.Offset), -- extend past the clip so only the TOP stays rounded
					ZIndex = 2,
				}, {
					-- The band's rounding matches the panel's outer corner at
					-- the top; the extra height + parent clip squares the
					-- bottom edge against the body per the anatomy.
					Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
					Title = e("TextLabel", {
						BackgroundTransparency = 1,
						Size = if isHub
							then UDim2.new(0.45, -Theme.spacing.xl, 0, 0)
							else UDim2.new(1, -(44 + Theme.spacing.lg + Theme.spacing.xl), 1, 0),
						AutomaticSize = if isHub then Enum.AutomaticSize.Y else Enum.AutomaticSize.None,
						Position = UDim2.new(0, Theme.spacing.xl, 0, 0),
						Text = props.title or "Window",
						FontFace = Theme.typography.heading.font,
						TextSize = Theme.typography.heading.textSize,
						TextColor3 = Theme.colors.onSurface,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = if isHub then Enum.TextYAlignment.Top else Enum.TextYAlignment.Center,
						ZIndex = 3,
					}, {
						Padding = if isHub
							then e("UIPadding", { PaddingTop = UDim.new(0, Theme.spacing.lg) })
							else nil,
					}),
					Subtitle = if isHub and props.subtitle
						then e("TextLabel", {
							BackgroundTransparency = 1,
							Size = UDim2.new(0.45, -Theme.spacing.xl, 0, 24),
							Position = UDim2.new(0, Theme.spacing.xl, 0, Theme.spacing.lg + 30),
							Text = props.subtitle,
							FontFace = Theme.typography.body.font,
							TextSize = Theme.typography.body.textSize,
							TextColor3 = Theme.colors.onSurfaceMuted,
							TextXAlignment = Enum.TextXAlignment.Left,
							ZIndex = 3,
						})
						else nil,
					-- Inline tab strip beside the title (hub only).
					Tabs = if isHub and props.tabs
						then e("Frame", {
							BackgroundTransparency = 1,
							Size = UDim2.new(0.55, -180, 1, 0),
							Position = UDim2.fromScale(0.45, 0),
							ZIndex = 3,
						}, (function()
							local children = {}
							children.Layout = e("UIListLayout", {
								FillDirection = Enum.FillDirection.Horizontal,
								VerticalAlignment = Enum.VerticalAlignment.Center,
								SortOrder = Enum.SortOrder.LayoutOrder,
								Padding = UDim.new(0, Theme.spacing.sm),
							})
							for i, tab in ipairs(props.tabs) do
								children["Tab_" .. tab.key] = e(Tab, {
									text = tab.label,
									selected = props.activeTab == tab.key,
									layoutOrder = i,
									zIndex = 3,
									onActivated = function()
										if props.onTabChange then
											props.onTabChange(tab.key)
										end
									end,
								})
							end
							return children
						end)())
						else nil,
					-- Dark currency pill, docked left of the close glyph (hub only).
					Currency = if isHub and props.currencyAmount ~= nil
						then e(CurrencyBar, {
							amount = props.currencyAmount,
							size = UDim2.fromOffset(110, 40),
							position = UDim2.new(1, -(44 + Theme.spacing.md), 0.5, 0),
							anchorPoint = Vector2.new(1, 0.5),
							zIndex = 3,
						})
						else nil,
					Close = e(CloseButton, {
						position = UDim2.new(1, -Theme.spacing.md, 0.5, 0),
						anchorPoint = Vector2.new(1, 0.5),
						zIndex = 4,
						onActivated = function()
							requestClose()
						end,
					}),
				}),
			}),
			Content = e("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, -headerHeight),
				Position = UDim2.new(0, 0, 0, headerHeight),
				ZIndex = 1,
			}, {
				Padding = e("UIPadding", {
					PaddingLeft = UDim.new(0, Theme.spacing.xl),
					PaddingRight = UDim.new(0, Theme.spacing.xl),
					PaddingTop = UDim.new(0, Theme.spacing.lg),
					PaddingBottom = UDim.new(0, Theme.spacing.xl),
				}),
				Children = e(React.Fragment, nil, props.children),
			}),
		}),
	})
end

return Window
