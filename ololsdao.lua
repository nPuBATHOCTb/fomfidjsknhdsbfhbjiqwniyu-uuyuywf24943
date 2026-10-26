if getgenv().NEVERCRACK_LOADER_LOADED then return end
getgenv().NEVERCRACK_LOADER_LOADED = true

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local PARENT = (gethui and gethui()) or game:GetService("CoreGui")
local http_request = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)

local SECRET_KEY = "usfhyis-deiwfj0-efjuw82-ffsdfus"

local Theme = {
    Background = Color3.fromRGB(8, 8, 8),
    Panel = Color3.fromRGB(12, 12, 12),
    Element = Color3.fromRGB(16, 16, 16),
    Text = Color3.fromRGB(210, 210, 210),
    DimText = Color3.fromRGB(110, 110, 115),
    Accent = Color3.fromRGB(255, 255, 255),
    Red = Color3.fromRGB(255, 60, 60),
    Green = Color3.fromRGB(60, 255, 120),
    Shadow = Color3.fromRGB(0, 0, 0)
}

local function new(class, props)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    return obj
end
local function tween(obj, time, props)
    local t = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local SHADOW_TEX = "rbxassetid://1316045217"

local gui = new("ScreenGui", { Name = "NeverCrackLoader", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = PARENT })

local mainWrapper = new("Frame", {
    Parent = gui, Size = UDim2.fromOffset(400 + 60, 250 + 60),
    Position = UDim2.new(0.5, -230, 0.5, -155),
    BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 10,
})
local bodyShadow = new("ImageLabel", {
    Parent = mainWrapper, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
    Image = SHADOW_TEX, ImageColor3 = Theme.Shadow, ImageTransparency = 0.35,
    ScaleType = Enum.ScaleType.Stretch, ZIndex = 9,
})

local root = new("Frame", {
    Parent = mainWrapper, Size = UDim2.fromOffset(400, 250),
    Position = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Theme.Background, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 10,
})
new("UICorner", { CornerRadius = UDim.new(0, 6), Parent = root })
new("UIStroke", { Color = Color3.fromRGB(45, 45, 45), Thickness = 1, Parent = root })

local header = new("Frame", { Parent = root, Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = Color3.fromRGB(10, 10, 10), BorderSizePixel = 0, ZIndex = 11 })
new("UICorner", { CornerRadius = UDim.new(0, 6), Parent = header })
new("TextLabel", { Parent = header, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(16, 0), BackgroundTransparency = 1, Text = "nevercrack | auth", Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Theme.Accent, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12 })
local closeBtn = new("TextButton", { Parent = header, Size = UDim2.fromOffset(40, 40), Position = UDim2.new(1, -40, 0, 0), BackgroundTransparency = 1, Text = "✕", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Theme.DimText, AutoButtonColor = false, ZIndex = 12 })
new("Frame", { Parent = root, Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromOffset(0, 40), BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderSizePixel = 0, ZIndex = 12 })

local dragging, dragStart, startPos
header.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = mainWrapper.Position end end)
UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart mainWrapper.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() getgenv().NEVERCRACK_LOADER_LOADED = false end)

local content = new("Frame", { Parent = root, Size = UDim2.new(1, -32, 1, -60), Position = UDim2.fromOffset(16, 56), BackgroundTransparency = 1, ZIndex = 11 })

local statusLbl = new("TextLabel", { Parent = content, Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, Text = "Enter your key to load nevercrack", TextColor3 = Theme.DimText, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 15 })

local keyInput = new("TextBox", { Parent = content, Size = UDim2.new(1, 0, 0, 36), Position = UDim2.fromOffset(0, 30), BackgroundColor3 = Theme.Element, BorderSizePixel = 0, Text = "", PlaceholderText = "usfhyis-deiwfj0-efjuw82-ffsdfus", TextColor3 = Theme.Accent, Font = Enum.Font.Code, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Center, ClearTextOnFocus = false, ZIndex = 15 })
new("UICorner", { CornerRadius = UDim.new(0, 4), Parent = keyInput })
new("UIStroke", { Color = Color3.fromRGB(35, 35, 35), Thickness = 1, Parent = keyInput })

local checkBtn = new("TextButton", { Parent = content, Size = UDim2.new(1, 0, 0, 36), Position = UDim2.fromOffset(0, 76), BackgroundColor3 = Theme.Element, BorderSizePixel = 0, Text = "CHECK KEY", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Accent, AutoButtonColor = false, ZIndex = 15 })
new("UICorner", { CornerRadius = UDim.new(0, 4), Parent = checkBtn })
new("UIStroke", { Color = Color3.fromRGB(35, 35, 35), Thickness = 1, Parent = checkBtn })
checkBtn.MouseEnter:Connect(function() tween(checkBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(30, 30, 30) }) end)
checkBtn.MouseLeave:Connect(function() tween(checkBtn, 0.15, { BackgroundColor3 = Theme.Element }) end)

local statusBottom = new("TextLabel", { Parent = content, Size = UDim2.new(1, 0, 0, 20), Position = UDim2.fromOffset(0, 120), BackgroundTransparency = 1, Text = "", TextColor3 = Theme.DimText, Font = Enum.Font.Gotham, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 15 })

local function loadNeverCrack()
    statusLbl.Text = "Key valid! Loading nevercrack..."
    statusLbl.TextColor3 = Theme.Green
    task.wait(0.5)
    gui:Destroy()
    getgenv().NEVERCRACK_LOADER_LOADED = false
    local url = "https://raw.githubusercontent.com/nPuBATHOCTb/gf-klmoikgafsdgkmljsdfjgafsdjufgujsdukj34fr76g-6473fsdfa/refs/heads/main/hgfbdsf.lua"
    local success, response = pcall(function()
        return http_request({ Url = url, Method = "GET" })
    end)
    if success and response and response.Body then
        local func, err = loadstring(response.Body)
        if func then
            pcall(func)
            print("[nevercrack] Loaded successfully.")
        else
            warn("[nevercrack] Lua error: " .. tostring(err))
        end
    else
        warn("[nevercrack] Failed to download script. Check your internet or URL.")
    end
end

checkBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if key == "" then
        statusLbl.Text = "Please enter a key."
        statusLbl.TextColor3 = Theme.Red
        return
    end
    statusLbl.Text = "Checking key..."
    statusLbl.TextColor3 = Theme.DimText
    task.spawn(function()
        task.wait(0.5)
        if key == SECRET_KEY then
            loadNeverCrack()
        else
            statusLbl.Text = "Invalid key. Try again."
            statusLbl.TextColor3 = Theme.Red
            statusBottom.Text = "Access denied."
        end
    end)
end)

print("[nevercrack loader] Ready. Enter key to load.")
