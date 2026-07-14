-- currency-bar from DESIGN.roblox.md: "deliberately containerless" -- currency
-- icon plus white outlined amount sit DIRECTLY on the world, with a small
-- squared '+' buy tile beside each. The ink text outline does all the
-- lifting (Components prose). transparency: 1 token -> no background fill at
-- all, unlike every other component in this taste.
--
-- Value changes (Motion section): "the HUD shows abbreviated earning
-- counters... count-up tweens for any earned number" -- implemented via
-- useBinding + a short RunService connection stepping toward the target
-- (motion-implementation.md's count-up pattern), settle easing, durations.slow.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

local function abbreviate(n)
	if n >= 1_000_000 then
		return string.format("%.2fM", n / 1_000_000)
	elseif n >= 1_000 then
		return string.format("%.1fK", n / 1_000)
	end
	return tostring(math.floor(n))
end

local function CurrencyBar(props)
	local displayed, setDisplayed = React.useState(props.amount or 0)
	local target = props.amount or 0
	local prevTarget = React.useRef(target)

	React.useEffect(function()
		if prevTarget.current == target then
			return
		end
		local startValue = prevTarget.current
		prevTarget.current = target
		local duration = Theme.motion.durations.slow
		local startTime = os.clock()
		local conn
		conn = RunService.RenderStepped:Connect(function()
			local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
			-- Quad-Out settle: 1 - (1-alpha)^2
			local eased = 1 - (1 - alpha) ^ 2
			setDisplayed(startValue + (target - startValue) * eased)
			if alpha >= 1 then
				conn:Disconnect()
			end
		end)
		return function()
			conn:Disconnect()
		end
	end, { target })

	local iconColor = if props.kind == "hard" then Theme.colors.currencyHard else Theme.colors.currencySoft

	return e("Frame", {
		BackgroundTransparency = Theme.transparencies.currencyBar, -- currency-bar token: transparency 1 (containerless)
		Size = props.size or UDim2.fromOffset(220, Theme.metrics.currencyBarHeight),
		Position = props.position,
		AnchorPoint = props.anchorPoint,
		LayoutOrder = props.layoutOrder,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, Theme.spacing.sm),
		}),
		Icon = e("Frame", {
			BackgroundColor3 = iconColor,
			Size = UDim2.fromOffset(Theme.metrics.currencyBarHeight, Theme.metrics.currencyBarHeight),
			LayoutOrder = 1,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
		}),
		Amount = e("TextLabel", {
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			Text = abbreviate(displayed),
			FontFace = Theme.typography.body.font,
			TextSize = Theme.typography.body.textSize,
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
		Plus = e("TextButton", {
			AutoButtonColor = false,
			BackgroundColor3 = Theme.colors.primary,
			Size = UDim2.fromOffset(Theme.metrics.currencyBarHeight * 0.8, Theme.metrics.currencyBarHeight * 0.8),
			Text = "+",
			FontFace = Theme.typography.label.font,
			TextScaled = true,
			TextColor3 = Theme.colors.onSurface,
			LayoutOrder = 3,
			[React.Event.Activated] = function()
				if props.onBuy then
					props.onBuy()
				end
			end,
		}, {
			Corner = e("UICorner", { CornerRadius = Theme.rounded.sm }),
			Stroke = e("UIStroke", {
				Thickness = Theme.strokes.outline.thickness,
				Color = Theme.strokes.outline.color,
				ApplyStrokeMode = Theme.strokes.outline.mode,
			}),
			TextStroke = e("UIStroke", {
				Thickness = Theme.strokes.textOutline.thickness,
				Color = Theme.strokes.textOutline.color,
				ApplyStrokeMode = Theme.strokes.textOutline.mode,
			}),
			MaxSize = e("UITextSizeConstraint", { MaxTextSize = Theme.typography.label.textSize }),
		}),
	})
end

return CurrencyBar
