# react-lua rules (React 17 in Luau)

Verified against jsdotlua/react-lua 17.2.1 and Roblox/react-luau 17.3.x —
identical API surface. Wally packages: `jsdotlua/react` + `jsdotlua/react-roblox`
(note: `roblox/react@17.3.9` is broken on the public Wally index as of
2026-07 — missing transitive deps; prefer jsdotlua until fixed).

## Canonical anchors (copy these shapes exactly)

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local e = React.createElement
```

**Elements & children** — host components are string class names; children
tables use string keys (the key becomes the React key AND the Instance.Name):

```lua
e("Frame", { Size = UDim2.fromScale(1, 1) }, {
	Title = e("TextLabel", { Text = "Hello" }),
	Body = e("Frame", {}),
})
```

**Mounting** — roots take FULL ownership of their container; never pass
PlayerGui itself:

```lua
local screenGui = Instance.new("ScreenGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  -- ALWAYS explicit (default is Global!)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local root = ReactRoblox.createRoot(screenGui)
root:render(e(App))
-- root:unmount() to tear down
```

**Events & property-change** — bracketed keys, handler's first arg is the
Instance:

```lua
[React.Event.Activated] = function(rbx) ... end,
[React.Event.MouseButton1Down] = function(rbx, x, y) ... end,
[React.Change.AbsoluteSize] = function(rbx) ... end,
```

**Hooks** — Luau multiple returns, deps are plain tables:

```lua
local count, setCount = React.useState(0)
React.useEffect(function()
	local conn = signal:Connect(handler)
	return function() conn:Disconnect() end
end, {})
local memo = React.useMemo(function() return f(a) end, { a })
local ref = React.useRef(nil)   -- access via ref.current
```

**Bindings** — update Instance properties WITHOUT re-render; the idiomatic
tool for high-frequency values. Never call `:getValue()` during render:

```lua
local pos, setPos = React.useBinding(UDim2.fromScale(0, 0))
e("Frame", { Position = pos })  -- pass the binding itself
-- or derived: Position = pos:map(function(v) return v + offset end)
```

**Portals** — `ReactRoblox.createPortal(children, hostInstance)`.

**Fragments** — `e(React.Fragment, nil, childrenTable)`.

**Class components** (avoid for new code; function components + hooks are
the default): `React.Component:extend("Name")`, `self:setState({...})` in
`init`, React-style lifecycle names, `React.None` to clear state fields.

## Hard bans (generation must never emit these)

| Banned | Why / instead |
|---|---|
| JSX (`<Frame>...`) | Does not exist in Luau |
| `Roact.mount/update/unmount` | `createRoot` + `root:render/unmount` |
| `[Roact.Ref]` | plain `ref = someRef` prop |
| `[Roact.Children]` | `props.children` |
| `Roact.Portal` | `ReactRoblox.createPortal` |
| `roact-hooked` API | hooks are built in |
| `React.Suspense` / `React.lazy` / error boundaries | unusable in 17.x Luau |
| `onClick`/`onActivated` camelCase props | `[React.Event.Activated]` |
| `Enum.Font.Gotham*`, `Enum.Font.Arial*` | removed from engine; use `Font.fromName("Montserrat")` etc. |
| `TextLabel.Font` assignments | use `FontFace` + `Font.fromName/fromEnum` |
| ternary `a ? b : c` | Luau if-expression: `if cond then a else b` |
| JS destructuring `local {a, b} = ...` | multiple returns: `local a, b = ...` |

## Frequent Luau slips to self-check

- Missing commas between sibling entries in children tables (the #1 syntax
  error in generated code — re-read every children table).
- `{}` deps table means "run once"; omitting deps means "every render".
- Setting a state field to `nil` in class setState silently no-ops — use
  `React.None` (function components: restructure state instead).
- `require` paths: Wally linkers live at `ReplicatedStorage.Packages.React` /
  `.ReactRoblox`; sibling modules via `script.Parent...`.
