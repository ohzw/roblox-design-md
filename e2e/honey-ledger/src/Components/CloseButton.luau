-- button-close / button-close-beveled from DESIGN.roblox.md (Honey Ledger).
-- Two anatomies, one component with a variant prop (precedence rule:
-- component-level tokens branch the anatomy rather than duplicating modules):
--   "flat"    (blue/info windows) -- danger-red square docked flush to the
--             band's LEFT end, sharp corners, no inset. Shares the band's
--             full height.
--   "beveled" (honey windows, the ONE bevel in the whole system) -- rounded
--             red block floating inside the band's RIGHT end, darker-red X
--             glyph, 10px bottom bevel. Held state collapses the bevel
--             (Motion: "may collapse its bevel while held") instead of a
--             fill-darken tween.
-- Both use the system voice (typography.utility / SourceSansPro Bold) for
-- the X glyph, per Agent Prompt Guide.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement
local BEVEL = 10 -- components.button-close-beveled shadow: bevel(10px #771C16)

local function CloseButton(props)
	local pressed, setPressed = React.useState(false)
	local variant = props.variant or "flat" -- "flat" | "beveled"

	local size = props.size
		or (if variant == "beveled" then UDim2.fromOffset(64, 64) else UDim2.fromOffset(56, 56))

	local events = {
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
	}

	if variant == "beveled" then
		local rootProps = {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = Theme.derived.closeBeveledBevel,
			Size = size,
			Position = props.position,
			AnchorPoint = props.anchorPoint,
			LayoutOrder = props.layoutOrder,
			ZIndex = props.zIndex or 4,
		}
		for k, v in events do
			rootProps[k] = v
		end

		return e("TextButton", rootProps, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
			Face = e("Frame", {
				BackgroundColor3 = if pressed then Theme.derived.closeBeveledPressed else Theme.derived.closeBeveledFill,
				Size = if pressed then UDim2.new(1, 0, 1, 0) else UDim2.new(1, 0, 1, -BEVEL),
				ZIndex = (props.zIndex or 4) + 1,
			}, {
				Corner = e("UICorner", { CornerRadius = Theme.rounded.md }),
				Label = e("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Text = "X",
					FontFace = Theme.typography.utility.font,
					TextScaled = true,
					TextColor3 = Theme.derived.closeBeveledText,
					ZIndex = (props.zIndex or 4) + 2,
				}, {
					MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.utility.textSize }),
					Padding = e("UIPadding", {
						PaddingLeft = UDim.new(0, Theme.spacing.md),
						PaddingRight = UDim.new(0, Theme.spacing.md),
						PaddingTop = UDim.new(0, Theme.spacing.sm),
						PaddingBottom = UDim.new(0, Theme.spacing.sm),
					}),
				}),
			}),
		})
	end

	-- flat variant: danger-red square, no rounding, no bevel; docked flush
	-- to the band (the parent Window positions it at the band's left edge).
	local rootProps = {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = if pressed then Theme.derived.dangerPressed else Theme.colors.danger,
		Size = size,
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 4,
	}
	for k, v in events do
		rootProps[k] = v
	end

	return e("TextButton", rootProps, {
		Label = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "X",
			FontFace = Theme.typography.utility.font,
			TextScaled = true,
			TextColor3 = Theme.colors.white,
			ZIndex = (props.zIndex or 4) + 1,
		}, {
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.utility.textSize }),
			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, Theme.spacing.md),
				PaddingRight = UDim.new(0, Theme.spacing.md),
				PaddingTop = UDim.new(0, Theme.spacing.sm),
				PaddingBottom = UDim.new(0, Theme.spacing.sm),
			}),
		}),
	})
end

return CloseButton
