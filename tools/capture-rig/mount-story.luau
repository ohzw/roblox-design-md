-- Story mount harness for the MCP visual-QA loop.
-- Usage: replace STORY_NAME, then run via the Roblox_Studio MCP `execute_luau`
-- tool with datamodel_type = "Client" while the preview place is in Play mode,
-- then call `screen_capture`.
--
-- Loop: start_stop_play(true) -> execute_luau(this, Client) -> screen_capture
--       -> compare against DESIGN.roblox.md -> repeat per story.

local STORY_NAME = "HUD.story" -- e.g. "Tokens.story", "Buttons.story", "Window.story"

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local storyModule = ReplicatedStorage.CartoonChunky.Stories:FindFirstChild(STORY_NAME)
if not storyModule then
	return "story not found: " .. STORY_NAME
end
local story = require(storyModule)

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("StoryPreview")
if old then
	old:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StoryPreview"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
-- Instance.new ScreenGui defaults to ZIndexBehavior.Global, which hides
-- default-ZIndex descendants under explicitly-ZIndexed overlays (SPEC.md 5.2).
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local root = ReactRoblox.createRoot(screenGui)
root:render(React.createElement(story.story, { controls = story.controls }))
return "mounted " .. STORY_NAME
