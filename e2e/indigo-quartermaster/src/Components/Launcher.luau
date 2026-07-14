-- launcher/side-button: a DERIVED component (generation-procedure.md
-- "derived tokens" rule) -- Indigo Quartermaster's own Screen Patterns never
-- describe a top-level HUD icon toolbar (its documented HUD is In-match:
-- timer/kills/roster pills + hotbar + interaction-prompt; its Shop/Items/
-- Settings surfaces live inside the Event-hub WINDOW, reached via tabs, not
-- HUD-docked buttons). The standard-showcase HUD story still needs
-- SHOP/ITEMS/SETTINGS launchers for comparability, so this fills the gap
-- with the taste's OWN grammar rather than inventing new taste:
--   - flat rectangle fill (`button-primary` anatomy: rounded.sm, no stroke,
--     no shadow) at `{colors.surface-dark}` -- the same dark chrome step
--     `currency-bar` already uses for HUD-docked pills, so the launcher
--     reads as "HUD chrome", not a lobby button.
--   - press feedback = darken one value step (Motion prose), NO squash --
--     this taste never squashes.
--   - icon: real sourced asset (Theme.assets), ImageColor3-tinted white.
--   - caption below in {typography.caption}, white, sentence/caps per call site.
--   - badge-slot: the taste's own badge-slot anatomy (tiny square, white
--     caption digit), pinned to the top-right corner -- the
--     standard-showcase's "attach the badge to a launcher anyway, note the
--     transplant" allowance, since this taste's badge-slot is documented for
--     hotbar keybind tags, not HUD launchers. Fill uses {colors.header} (one
--     step LIGHTER than the launcher's own surface-dark background) rather
--     than the badge-slot token's literal surface-dark: on the hotbar, that
--     token reads against a translucent 0.35-transparency slot, but this
--     launcher's fill is opaque surface-dark, so the literal token color
--     would be invisible against its own background. "Go one step lighter"
--     (Colors rule of thumb #1) is this taste's own rule for exactly this
--     situation -- a documented, noted deviation, not a silent one.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local SIZE = 72 -- comfortably above the 44px tap-target minimum

local LIFT_IN = TweenInfo.new(
	Theme.motion.durations.instant,
	Theme.motion.easings.settle.style,
	Theme.motion.easings.settle.direction
)
local LIFT_OUT = TweenInfo.new(
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

local function Launcher(props)
	local fillRef = React.useRef(nil)

	local function lift(color, info)
		local rbx = fillRef.current
		if rbx then
			TweenService:Create(rbx, info, { BackgroundColor3 = color }):Play()
		end
	end

	return e("TextButton", {
		ref = fillRef,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.colors.surfaceDark,
		Size = props.size or UDim2.fromOffset(SIZE, SIZE),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			lift(Theme.derived.surfaceDarkPressed, LIFT_IN)
		end,
		[React.Event.MouseButton1Up] = function()
			lift(Theme.colors.surfaceDark, LIFT_OUT)
		end,
		[React.Event.MouseLeave] = function()
			lift(Theme.colors.surfaceDark, LIFT_OUT)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
		Icon = e("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.icon or "",
			ImageColor3 = Theme.colors.onSurface,
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(0.5, 0, 0, Theme.spacing.sm),
			AnchorPoint = Vector2.new(0.5, 0),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = (props.zIndex or 1) + 1,
		}),
		Caption = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -Theme.spacing.xs * 2, 0, 18),
			Position = UDim2.new(0.5, 0, 1, -Theme.spacing.xs),
			AnchorPoint = Vector2.new(0.5, 1),
			Text = string.upper(props.text or "SHOP"),
			FontFace = Theme.typography.caption.font,
			TextSize = Theme.typography.caption.textSize,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = (props.zIndex or 1) + 1,
		}),
		-- badge-slot, transplanted from its documented hotbar-keybind host
		-- (noted above): tiny square, white caption digit, pinned to the
		-- launcher's top-right corner. Fill is {colors.header} (one step
		-- lighter than this launcher's own surface-dark), not the token's
		-- literal surface-dark -- see the module comment for why.
		Badge = if props.badge and props.badge > 0
			then e("Frame", {
				BackgroundColor3 = Theme.colors.header,
				Size = UDim2.fromOffset(22, 22),
				Position = UDim2.new(1, 4, 0, -4),
				AnchorPoint = Vector2.new(1, 0),
				ZIndex = (props.zIndex or 1) + 2,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.none }),
				Count = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = badgeText(props.badge),
					FontFace = Theme.typography.caption.font,
					TextSize = Theme.typography.caption.textSize,
					TextColor3 = Theme.colors.onSurface,
					ZIndex = (props.zIndex or 1) + 3,
				}),
			})
			else nil,
	})
end

return Launcher
