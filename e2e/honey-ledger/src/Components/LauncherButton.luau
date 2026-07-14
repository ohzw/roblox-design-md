-- Icon toolbar entry from DESIGN.roblox.md (Honey Ledger) Screen Patterns:
-- "white glyph icon toolbar (egg, quests, mask, badges, settings, premium)
-- top-left as a horizontal row." This taste defines no dedicated
-- button-icon-toolbar token (button-icon is the bottom-center HOTBAR circle,
-- a different anatomy) -- per generation-procedure.md's derived-token rule,
-- this is a documented gap filled with the taste's own grammar: a bare white
-- glyph (real image asset, ImageColor3-tinted white per asset-sourcing.md's
-- tinting rule) over NO background chrome (this taste has no floating icon
-- chip outside the hotbar), with a small caption below in the system voice,
-- and an optional badge-slot count tag overlapping the icon's top-right
-- corner. No stroke/shadow anywhere, matching "no container chrome" (Do's).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function badgeText(count)
	if count > 99 then
		return "99+"
	end
	return tostring(count)
end

local function LauncherButton(props)
	local pressed, setPressed = React.useState(false)
	local iconTint = if pressed then Theme.colors.currencySoft else Theme.colors.white

	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(64, 64),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex,
		[React.Event.MouseButton1Down] = function()
			setPressed(true)
		end,
		[React.Event.MouseButton1Up] = function()
			setPressed(false)
		end,
		[React.Event.MouseLeave] = function()
			setPressed(false)
		end,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Icon = e("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.icon or "",
			ImageColor3 = iconTint,
			Size = UDim2.new(1, -Theme.spacing.md, 0, 34),
			Position = UDim2.new(0.5, 0, 0, 0),
			AnchorPoint = Vector2.new(0.5, 0),
			ZIndex = (props.zIndex or 1) + 1,
		}),
		Caption = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 18),
			Position = UDim2.new(0.5, 0, 1, 0),
			AnchorPoint = Vector2.new(0.5, 1),
			Text = props.text or "Shop",
			FontFace = Theme.typography.utility.font,
			TextScaled = true,
			TextColor3 = Theme.colors.white,
			ZIndex = (props.zIndex or 1) + 1,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = 16 }),
		}),
		-- badge-slot: stroked white "xN" count tag overlapping the icon's
		-- corner, no background fill.
		Badge = if props.badge and props.badge > 0
			then e("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(28, 20),
				Position = UDim2.new(1, 2, 0, -4),
				AnchorPoint = Vector2.new(1, 0),
				Text = badgeText(props.badge),
				FontFace = Theme.typography.caption.font,
				TextColor3 = Theme.colors.danger,
				TextScaled = true,
				ZIndex = (props.zIndex or 1) + 2,
			}, {
				Stroke = e("UIStroke", {
					Thickness = Theme.strokes.textOutline.thickness,
					Color = Theme.strokes.textOutline.color,
					ApplyStrokeMode = Theme.strokes.textOutline.mode,
				}),
				MaxSize = e("UITextSizeConstraint", { MaxTextSize = 16 }),
			})
			else nil,
	})
end

return LauncherButton
