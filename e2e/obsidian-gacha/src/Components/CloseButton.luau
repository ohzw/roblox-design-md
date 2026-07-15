-- button-close from DESIGN.roblox.md: "a bare white X glyph anchored top-right,
-- no fill and no stroke. It floats on the panel, not in a button." Uses U+00D7
-- (multiplication sign) which renders in FredokaOne (verification.md: U+2715
-- tofus, U+00D7 renders). The invisible TextButton root keeps a >=44px touch
-- target around the glyph (layout-rules.md tap-target rule).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function CloseButton(props)
	return e("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(44, 44),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
		ZIndex = props.zIndex or 6,
		[React.Event.Activated] = function()
			if props.onActivated then
				props.onActivated()
			end
		end,
	}, {
		Glyph = e("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Text = "\u{00D7}",
			FontFace = Theme.typography.heading.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			ZIndex = props.zIndex or 6,
		}, {
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = 30 }),
		}),
	})
end

return CloseButton
