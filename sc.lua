-- ============================================================
-- FISHING ADMIN PANEL v1.0 — Style: YUJI v4.3
-- Tab: Main | Players | Teleport
-- Shortcut: F=Fly | J=Infinite Jump | L=Anti Lag | K=Anti AFK
-- ============================================================

local Players       = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService  = game:GetService("TweenService")
local CoreGui       = game:GetService("CoreGui")
local UIS           = game:GetService("UserInputService")
local RunService    = game:GetService("RunService")
local Lighting      = game:GetService("Lighting")
local RS            = game:GetService("ReplicatedStorage")

local lp            = Players.LocalPlayer
local playerGui     = lp:WaitForChild("PlayerGui")

print("[START] Fishing Panel v1.0 Loading...")

-- ============================================================
-- COLORS
-- ============================================================
local C = {
    bg        = Color3.fromRGB(10,  14,  22),
    sidebar   = Color3.fromRGB(7,   11,  18),
    panel     = Color3.fromRGB(13,  18,  28),
    accent    = Color3.fromRGB(0,  180, 255),
    accentDim = Color3.fromRGB(0,   80, 130),
    text      = Color3.fromRGB(210, 230, 245),
    textDim   = Color3.fromRGB(100, 130, 160),
    rowAlt    = Color3.fromRGB(16,  22,  36),
    btnBlue   = Color3.fromRGB(0,  120, 220),
    btnRed    = Color3.fromRGB(180,  50,  50),
    divider   = Color3.fromRGB(25,  40,  65),
    topbar    = Color3.fromRGB(8,   13,  22),
    inputBg   = Color3.fromRGB(20,  28,  45),
    togOff    = Color3.fromRGB(40,  50,  70),
    togOn     = Color3.fromRGB(0,  180, 255),
}

-- ============================================================
-- CLEANUP OLD GUI
-- ============================================================
pcall(function()
    if CoreGui:FindFirstChild("FISH_PANEL") then CoreGui:FindFirstChild("FISH_PANEL"):Destroy() end
end)
if playerGui:FindFirstChild("FISH_PANEL") then playerGui:FindFirstChild("FISH_PANEL"):Destroy() end

-- ============================================================
-- ROOT SCREENGUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name            = "FISH_PANEL"
screenGui.ResetOnSpawn    = false
screenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset  = false

local ok = pcall(function() screenGui.Parent = CoreGui end)
if not ok then screenGui.Parent = playerGui end

-- ============================================================
-- MINIMIZED ICON BUTTON
-- ============================================================
local iconBtn = Instance.new("TextButton", screenGui)
iconBtn.Size              = UDim2.new(0, 34, 0, 34)
iconBtn.Position          = UDim2.new(0, 18, 0.5, -17)
iconBtn.BackgroundColor3  = C.sidebar
iconBtn.BorderSizePixel   = 0
iconBtn.Text              = "🎣"
iconBtn.TextColor3        = C.accent
iconBtn.TextSize          = 16
iconBtn.Font              = Enum.Font.GothamBold
iconBtn.Visible           = false
iconBtn.ZIndex            = 50
Instance.new("UICorner",  iconBtn).CornerRadius = UDim.new(0, 8)
local _ics = Instance.new("UIStroke", iconBtn)
_ics.Color     = C.accent
_ics.Thickness = 1.5

-- ============================================================
-- MAIN FRAME
-- ============================================================
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size             = UDim2.new(0, 440, 0, 325)
mainFrame.Position         = UDim2.new(0.5, -220, 0.5, -162)
mainFrame.BackgroundColor3 = C.bg
mainFrame.BorderSizePixel  = 0
mainFrame.ZIndex           = 10
Instance.new("UICorner",  mainFrame).CornerRadius = UDim.new(0, 10)
local _mfs = Instance.new("UIStroke", mainFrame)
_mfs.Color     = Color3.fromRGB(0, 80, 130)
_mfs.Thickness = 1

-- ============================================================
-- TOPBAR
-- ============================================================
local topBar = Instance.new("Frame", mainFrame)
topBar.Size             = UDim2.new(1, 0, 0, 32)
topBar.BackgroundColor3 = C.topbar
topBar.BorderSizePixel  = 0
topBar.ZIndex           = 11
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)
-- square bottom corners
local tbFix = Instance.new("Frame", topBar)
tbFix.Size             = UDim2.new(1, 0, 0.5, 0)
tbFix.Position         = UDim2.new(0, 0, 0.5, 0)
tbFix.BackgroundColor3 = C.topbar
tbFix.BorderSizePixel  = 0
tbFix.ZIndex           = 11

local topLogo = Instance.new("TextLabel", topBar)
topLogo.Size              = UDim2.new(0, 160, 1, 0)
topLogo.Position          = UDim2.new(0, 10, 0, 0)
topLogo.BackgroundTransparency = 1
topLogo.Text              = "🎣 FISHING PANEL"
topLogo.TextColor3        = C.accent
topLogo.TextSize          = 13
topLogo.Font              = Enum.Font.GothamBold
topLogo.TextXAlignment    = Enum.TextXAlignment.Left
topLogo.ZIndex            = 12

local minimizeBtn = Instance.new("TextButton", topBar)
minimizeBtn.Size             = UDim2.new(0, 26, 0, 20)
minimizeBtn.Position         = UDim2.new(1, -34, 0.5, -10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 70)
minimizeBtn.Text             = "—"
minimizeBtn.TextColor3       = C.text
minimizeBtn.TextSize         = 11
minimizeBtn.Font             = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel  = 0
minimizeBtn.ZIndex           = 12
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 4)

-- ============================================================
-- SIDEBAR
-- ============================================================
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size             = UDim2.new(0, 110, 1, -32)
sideBar.Position         = UDim2.new(0, 0, 0, 32)
sideBar.BackgroundColor3 = C.sidebar
sideBar.BorderSizePixel  = 0
sideBar.ZIndex           = 11
Instance.new("UICorner", sideBar).CornerRadius = UDim.new(0, 10)
local sbFix = Instance.new("Frame", sideBar)
sbFix.Size             = UDim2.new(0.5, 0, 1, 0)
sbFix.Position         = UDim2.new(0.5, 0, 0, 0)
sbFix.BackgroundColor3 = C.sidebar
sbFix.BorderSizePixel  = 0
sbFix.ZIndex           = 11

local sideTabList = Instance.new("Frame", sideBar)
sideTabList.Size               = UDim2.new(1, 0, 1, -8)
sideTabList.Position           = UDim2.new(0, 0, 0, 8)
sideTabList.BackgroundTransparency = 1
sideTabList.ZIndex             = 12
local _stl = Instance.new("UIListLayout", sideTabList)
_stl.SortOrder = Enum.SortOrder.LayoutOrder
_stl.Padding   = UDim.new(0, 1)

-- ============================================================
-- CONTENT AREA
-- ============================================================
local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size             = UDim2.new(1, -110, 1, -32)
contentArea.Position         = UDim2.new(0, 110, 0, 32)
contentArea.BackgroundColor3 = C.panel
contentArea.BorderSizePixel  = 0
contentArea.ZIndex           = 11
Instance.new("UICorner", contentArea).CornerRadius = UDim.new(0, 10)
local caFix = Instance.new("Frame", contentArea)
caFix.Size             = UDim2.new(0.5, 0, 1, 0)
caFix.BackgroundColor3 = C.panel
caFix.BorderSizePixel  = 0
caFix.ZIndex           = 11

local contentHeader = Instance.new("TextLabel", contentArea)
contentHeader.Size                 = UDim2.new(1, -20, 0, 28)
contentHeader.Position             = UDim2.new(0, 18, 0, 5)
contentHeader.BackgroundTransparency = 1
contentHeader.Text                 = "Main"
contentHeader.TextColor3           = C.text
contentHeader.TextSize             = 15
contentHeader.Font                 = Enum.Font.GothamBold
contentHeader.TextXAlignment       = Enum.TextXAlignment.Left
contentHeader.ZIndex               = 12

local _acBar = Instance.new("Frame", contentArea)
_acBar.Size             = UDim2.new(0, 3, 0, 18)
_acBar.Position         = UDim2.new(0, 12, 0, 10)
_acBar.BackgroundColor3 = C.accent
_acBar.BorderSizePixel  = 0
_acBar.ZIndex           = 12

local _hdiv = Instance.new("Frame", contentArea)
_hdiv.Size             = UDim2.new(1, -20, 0, 1)
_hdiv.Position         = UDim2.new(0, 10, 0, 36)
_hdiv.BackgroundColor3 = C.divider
_hdiv.BorderSizePixel  = 0
_hdiv.ZIndex           = 12

local scrollFrame = Instance.new("ScrollingFrame", contentArea)
scrollFrame.Size                  = UDim2.new(1, -10, 1, -46)
scrollFrame.Position              = UDim2.new(0, 5, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollingDirection    = Enum.ScrollingDirection.Y
scrollFrame.AutomaticCanvasSize   = Enum.AutomaticSize.Y
scrollFrame.ScrollBarThickness    = 3
scrollFrame.ScrollBarImageColor3  = C.accent
scrollFrame.BorderSizePixel       = 0
scrollFrame.ZIndex                = 12
local scrollLayout = Instance.new("UIListLayout", scrollFrame)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Padding   = UDim.new(0, 2)

-- ============================================================
-- STATE VARIABLES
-- ============================================================
local isFlying        = false
local flySpeed        = 200
local bodyVel, bodyGyr
local isSpeedHack     = false
local currentSpeed    = 22
local isInfJump       = false
local infJumpConn     = nil
local isAntiLag       = false
local origLight       = {}
local disabledFX      = {}
local isAntiAfk       = false
local isNoclip        = false
local noclipConn      = nil
local isMoonwalk      = false
local moonwalkConn    = nil
local isUnlimZoom     = false
local origMaxZoom     = nil
local isWalkWater     = false
local walkWaterConn   = nil
local isFullBright    = false
local origFBLight     = {}
local fullBrightConn  = nil
local antiLagConn     = nil
local antiLagDescConn = nil
local speedConn       = nil
local autoTpActive    = false
local autoTpTarget    = nil
local autoTpConn      = nil
local isFishing       = false
local fishingStatusLbl = nil
local flyInput = {fwd=false,bwd=false,lft=false,rgt=false,up=false,dn=false}

-- V2 fishing state
local isFishingV2       = false
local fishingV2StatusLbl = nil
local fishingV2DelayBox  = nil
local selectedRodV2 = "Basic Rod"
local rodEquippedV2 = false

-- Shop state (timer based) for V2 sell
local shopIntervalInput = nil
local autoSellEnabled = false
local autoSellTask = nil

-- V1 Sell state (timer based)
local autoSellV1Enabled = false
local autoSellV1Task = nil
local sellV1IntervalInput = nil

-- Stable Result state (for V1)
local isStableResult = false

-- ============================================================
-- REMOTE HELPERS (V1 with fallback)
-- ============================================================
local NET_PKG = "sleitnick_net@0.2.0"
local function getNet()
    local p = RS:FindFirstChild("Packages")
    if not p then return nil end
    local i = p:FindFirstChild("_Index")
    if not i then return nil end
    local s = i:FindFirstChild(NET_PKG)
    if not s then return nil end
    return s:FindFirstChild("net")
end

-- Daftar hash primary dan backup untuk setiap fungsi
local REMOTES_V1 = {
    equip = {
        "RE/ee1a2f723f77f79090555792270035e124e2fed06eda14dd6c776d50b56b2a2e",
        "RE/2d2ee8c07e8cb0de5e0f389b7ec01eaef2a14a4b3c986058a12eb5cbeda22018",
    },
    unequip = {
        "RE/f11d0342427acb60630fd00823154a30e7377a41312e904ee61ceea6105cc73c",
        "RE/8c821f4bdddfe769bfd54c454bf82f3eb17bc687fb72dc947f5ba5789aa00204",
    },
    awal = {
        "RF/516c6685a2ca2ea3e971aefb73c4e16732c029787cb73f85ca3df7f85454816d",
        "RF/921b8a3be3795259e2e316231d598cd6b5769083ff6da6901607e80e4c7459ac",
    },
    lempar = {
        "RF/3a74da5c8bd2a27a5c0c59888e9eb64129a1443973985a4678a15655faed52c5",
        "RF/2038f12e7196b94caf85a0bc23951f4e32507dcc7c4793d9a5c3efac0712bc40",
    },
    tarik = {
        "RE/80587b6ed1b6438cdf9e2c53028a8a7f2a4ffdea744713f76fd0ba874a1ed518",
        "RE/03b7da2c5515a24a9e953cc17fc34c1c8332a755cd29bd6269373dfab72e7fcd",
    },
    stable = {
        "RF/a8d45075fa321893238d721572aa77a2d430a76c1e27bd797b2a3694c50a8e31",
    },
    sell = {
        "RF/76fca35ac85a6b780b47990d140c463d8b3fc543d536db5013add1a9c0a98acc",
    },
    boat_spawn = {
        "RF/72f10be9c44ed407cccf31a7d563ea5c3e28df55881ff562be932d2f320fdff1",
    },
    boat_remove = {
        "RF/74df4fe6c63d180467b777a54ad6a52b6ad2f023b4ca063054f6772f826764ba",
    },
}

local function getRemote(name)
    local n = getNet()
    if not n then return nil end
    local hashList = REMOTES_V1[name]
    if not hashList then return nil end
    for _, hash in ipairs(hashList) do
        local r = n:FindFirstChild(hash)
        if r then return r end
    end
    return nil
end

local function equipRod()
    local r = getRemote("equip")
    if not r then return false end
    pcall(function() r:FireServer(1) end)
    return true
end

local function unequipRod()
    local r = getRemote("unequip")
    if not r then return end
    pcall(function() r:FireServer() end)
end

local function doAwal()
    local r = getRemote("awal")
    if not r then return false end
    pcall(function() r:InvokeServer() end)
    return true
end

local function doLempar()
    local r = getRemote("lempar")
    if not r then return false end
    pcall(function() r:InvokeServer(-1.233184814453125, 0.4441734929180473, tick()) end)
    return true
end

local function doTarik()
    local r = getRemote("tarik")
    if not r then return false end
    pcall(function() r:FireServer() end)
    return true
end

local function setStableResult(state)
    local r = getRemote("stable")
    if not r then return false end
    pcall(function() r:InvokeServer(state) end)
    return true
end

local function sellAllV1()
    local r = getRemote("sell")
    if not r then return false end
    pcall(function() r:InvokeServer() end)
    return true
end

local function spawnBoat()
    local r = getRemote("boat_spawn")
    if not r then return false end
    pcall(function() r:InvokeServer(14) end)
    return true
end

local function removeBoat()
    local r = getRemote("boat_remove")
    if not r then return false end
    pcall(function() r:InvokeServer() end)
    return true
end

-- ============================================================
-- REMOTE HELPERS V2 (New Fishing System) - path-nya fixed
-- ============================================================
local FishingSystem = RS:FindFirstChild("FishingSystem")
if not FishingSystem then
    warn("FishingSystem not found - V2 fishing may not work")
end

local function equipRodV2(rodName)
    rodName = rodName or selectedRodV2 or "Basic Rod"
    if not FishingSystem then return false end
    local invEvents = FishingSystem:FindFirstChild("InventoryEvents")
    if not invEvents then return false end
    local equip = invEvents:FindFirstChild("Inventory_EquipRod")
    if not equip then return false end
    pcall(function() equip:FireServer(rodName) end)
    return true
end

local function unequipRodV2()
    if not FishingSystem then return end
    local invEvents = FishingSystem:FindFirstChild("InventoryEvents")
    if not invEvents then return end
    local unequip = invEvents:FindFirstChild("Inventory_UnequipAll")
    if not unequip then return end
    pcall(function() unequip:FireServer() end)
end

local function doCastV2()
    if not FishingSystem then return false end
    local cast = FishingSystem:FindFirstChild("CastReplication")
    if not cast then return false end
    local c = lp.Character
    if not c then return false end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local pos = hrp.Position
    local dir = hrp.CFrame.LookVector * 5 + Vector3.new(0, 0.5, 0)
    local angle = 87 + math.random(-5, 5)
    pcall(function() cast:FireServer(pos, dir, selectedRodV2, angle) end)
    return true
end

local function doReelV2()
    if not FishingSystem then return false end
    local reel = FishingSystem:FindFirstChild("FishCaught")
    if not reel then return false end
    local c = lp.Character
    if not c then return false end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local pos = hrp.Position + Vector3.new(0, 1, 0)
    pcall(function() reel:FireServer(pos) end)
    return true
end

-- ============================================================
-- ROD SHOP FUNCTIONS
-- ============================================================
local function purchaseRod(rodName)
    if not FishingSystem then return false end
    local shopEvents = FishingSystem:FindFirstChild("RodShopEvents")
    if not shopEvents then return false end
    local purchase = shopEvents:FindFirstChild("RequestPurchase")
    if not purchase then return false end
    pcall(function() purchase:FireServer(rodName) end)
    return true
end

-- ============================================================
-- SELL FUNCTIONS (V2)
-- ============================================================
local function sellAllFishV2()
    if not FishingSystem then
        notify("⚠ FishingSystem not found, cannot sell", 4)
        return false
    end

    local invEvents = FishingSystem:FindFirstChild("InventoryEvents")
    if invEvents then
        local sellAll = invEvents:FindFirstChild("Inventory_SellAll")
        if sellAll then
            local success, err = pcall(function()
                sellAll:InvokeServer()
            end)
            if success then
                notify("✅ Menjual semua ikan (V2)!", 3)
                return true
            else
                warn("Inventory_SellAll failed: " .. tostring(err))
            end
        end
    end

    local sellRemote = FishingSystem:FindFirstChild("SellFish")
    if sellRemote then
        local fishData = {}
        if invEvents then
            local getData = invEvents:FindFirstChild("Inventory_GetData")
            if getData then
                local success, result = pcall(function()
                    return getData:InvokeServer()
                end)
                if success and type(result) == "table" then
                    for k, v in pairs(result) do
                        if type(v) == "table" and (v.fishId or v.rarity or v.weight) then
                            table.insert(fishData, {
                                fishId = tostring(v.fishId or ""),
                                rarity = tostring(v.rarity or ""),
                                weight = tonumber(v.weight) or 0
                            })
                        end
                    end
                end
            end
        end
        if #fishData == 0 then
            notify("Tidak ada ikan untuk dijual (V2)", 3)
            return false
        end
        local success, err = pcall(function()
            sellRemote:FireServer("SellAllBatch", fishData)
        end)
        if success then
            notify("✅ Menjual " .. #fishData .. " ikan (V2 fallback)", 3)
            return true
        else
            warn("SellFish fallback failed: " .. tostring(err))
        end
    end

    notify("⚠ Gagal menjual ikan (V2)", 4)
    return false
end

-- ============================================================
-- NOTIFICATION
-- ============================================================
local function notify(msg, dur)
    dur = dur or 3
    local f = Instance.new("Frame", screenGui)
    f.Size             = UDim2.new(0, 275, 0, 44)
    f.Position         = UDim2.new(0.5, -137, 0, -60)
    f.BackgroundColor3 = Color3.fromRGB(10, 16, 28)
    f.ZIndex           = 100
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 7)
    local _ns = Instance.new("UIStroke", f); _ns.Color = C.accent; _ns.Thickness = 1
    local _nb = Instance.new("Frame", f)
    _nb.Size = UDim2.new(0, 3, 0.65, 0); _nb.Position = UDim2.new(0,0,0.175,0)
    _nb.BackgroundColor3 = C.accent; _nb.BorderSizePixel = 0; _nb.ZIndex = 101
    local nl = Instance.new("TextLabel", f)
    nl.Size = UDim2.new(1,-18,1,0); nl.Position = UDim2.new(0,14,0,0)
    nl.BackgroundTransparency = 1; nl.Text = msg; nl.TextColor3 = C.text
    nl.TextWrapped = true; nl.TextSize = 11; nl.Font = Enum.Font.Gotham; nl.ZIndex = 101
    TweenService:Create(f, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5,-137,0,14)}):Play()
    task.delay(dur, function()
        if not f or not f.Parent then return end
        TweenService:Create(f, TweenInfo.new(0.22), {Position = UDim2.new(0.5,-137,0,-65)}):Play()
        task.delay(0.26, function() if f and f.Parent then f:Destroy() end end)
    end)
end

-- ============================================================
-- UI HELPERS
-- ============================================================
local tabSetters = {}

local function makeSideTab(label, icon, order)
    local btn = Instance.new("TextButton", sideTabList)
    btn.Size = UDim2.new(1,0,0,34); btn.BackgroundTransparency = 1
    btn.Text = ""; btn.BorderSizePixel = 0; btn.LayoutOrder = order; btn.ZIndex = 13

    local bar = Instance.new("Frame", btn)
    bar.Size = UDim2.new(0,3,0.6,0); bar.Position = UDim2.new(0,0,0.2,0)
    bar.BackgroundColor3 = C.accent; bar.BorderSizePixel = 0; bar.Visible = false; bar.ZIndex = 14

    local ic = Instance.new("TextLabel", btn)
    ic.Size = UDim2.new(0,22,1,0); ic.Position = UDim2.new(0,8,0,0)
    ic.BackgroundTransparency = 1; ic.Text = icon; ic.TextColor3 = C.textDim
    ic.TextSize = 14; ic.Font = Enum.Font.GothamBold; ic.ZIndex = 14

    local tx = Instance.new("TextLabel", btn)
    tx.Size = UDim2.new(1,-32,1,0); tx.Position = UDim2.new(0,32,0,0)
    tx.BackgroundTransparency = 1; tx.Text = label; tx.TextColor3 = C.textDim
    tx.TextSize = 10; tx.Font = Enum.Font.Gotham; tx.TextXAlignment = Enum.TextXAlignment.Left; tx.ZIndex = 14

    local function setActive(v)
        if v then
            btn.BackgroundTransparency = 0; btn.BackgroundColor3 = Color3.fromRGB(15,25,45)
            bar.Visible = true; ic.TextColor3 = C.accent; tx.TextColor3 = C.text; tx.Font = Enum.Font.GothamBold
        else
            btn.BackgroundTransparency = 1; bar.Visible = false
            ic.TextColor3 = C.textDim; tx.TextColor3 = C.textDim; tx.Font = Enum.Font.Gotham
        end
    end
    return btn, setActive
end

-- Toggle row helper
local function makeToggle(parent, label, order, onCb)
    local row = Instance.new("Frame", parent)
    row.Name = label; row.Size = UDim2.new(1,0,0,36)
    row.BackgroundTransparency = 1; row.BorderSizePixel = 0
    row.LayoutOrder = order; row.ZIndex = 15

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-56,1,0); lbl.BackgroundTransparency = 1
    lbl.Text = label; lbl.TextColor3 = C.text; lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 16

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(0,44,0,24); track.Position = UDim2.new(1,-50,0.5,-12)
    track.BackgroundColor3 = C.togOff; track.BorderSizePixel = 0; track.ZIndex = 16
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame", track)
    knob.Size = UDim2.new(0,18,0,18); knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(180,200,220); knob.BorderSizePixel = 0; knob.ZIndex = 17
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local isOn = false
    local clk = Instance.new("TextButton", track)
    clk.Size = UDim2.new(1,0,1,0); clk.BackgroundTransparency = 1; clk.Text = ""; clk.ZIndex = 18

    local function setState(v, silent)
        isOn = v
        if isOn then
            TweenService:Create(track,TweenInfo.new(0.15),{BackgroundColor3=C.togOn}):Play()
            TweenService:Create(knob,TweenInfo.new(0.15),{Position=UDim2.new(0,23,0.5,-9)}):Play()
        else
            TweenService:Create(track,TweenInfo.new(0.15),{BackgroundColor3=C.togOff}):Play()
            TweenService:Create(knob,TweenInfo.new(0.15),{Position=UDim2.new(0,3,0.5,-9)}):Play()
        end
        if not silent and onCb then onCb(isOn) end
    end
    clk.MouseButton1Click:Connect(function() setState(not isOn) end)
    return row, setState, function() return isOn end
end

-- Expandable section (awalnya collapsed = true)
local function makeSection(parent, title, order, build)
    local wrap = Instance.new("Frame", parent)
    wrap.Name = title; wrap.BackgroundColor3 = C.rowAlt; wrap.BorderSizePixel = 0
    wrap.LayoutOrder = order; wrap.ZIndex = 13; wrap.AutomaticSize = Enum.AutomaticSize.Y
    wrap.Size = UDim2.new(1,0,0,0)
    Instance.new("UICorner", wrap).CornerRadius = UDim.new(0,6)

    local inner = Instance.new("Frame", wrap)
    inner.Size = UDim2.new(1,0,0,0); inner.BackgroundTransparency = 1
    inner.AutomaticSize = Enum.AutomaticSize.Y; inner.ZIndex = 13
    local il = Instance.new("UIListLayout", inner); il.SortOrder = Enum.SortOrder.LayoutOrder

    local hdr = Instance.new("Frame", inner)
    hdr.Name = "H"; hdr.Size = UDim2.new(1,0,0,38); hdr.BackgroundTransparency = 1
    hdr.LayoutOrder = 0; hdr.ZIndex = 14

    local tl = Instance.new("TextLabel", hdr)
    tl.Size = UDim2.new(1,-44,1,0); tl.Position = UDim2.new(0,12,0,0)
    tl.BackgroundTransparency = 1; tl.Text = title; tl.TextColor3 = C.text
    tl.TextSize = 12; tl.Font = Enum.Font.GothamBold
    tl.TextXAlignment = Enum.TextXAlignment.Left; tl.ZIndex = 15

    local arrow = Instance.new("TextLabel", hdr)
    arrow.Size = UDim2.new(0,20,1,0); arrow.Position = UDim2.new(1,-28,0,0)
    arrow.BackgroundTransparency = 1; arrow.Text = "▶"; arrow.TextColor3 = C.accent
    arrow.TextSize = 10; arrow.Font = Enum.Font.GothamBold; arrow.ZIndex = 15

    local div = Instance.new("Frame", hdr)
    div.Size = UDim2.new(1,-16,0,1); div.Position = UDim2.new(0,8,1,-1)
    div.BackgroundColor3 = C.divider; div.BorderSizePixel = 0; div.ZIndex = 14

    local cc = Instance.new("Frame", inner)
    cc.Size = UDim2.new(1,0,0,0); cc.BackgroundTransparency = 1
    cc.AutomaticSize = Enum.AutomaticSize.Y; cc.LayoutOrder = 1; cc.ZIndex = 14
    cc.Visible = false  -- default collapsed
    local ccl = Instance.new("UIListLayout", cc); ccl.SortOrder = Enum.SortOrder.LayoutOrder
    local ccp = Instance.new("UIPadding", cc)
    ccp.PaddingLeft = UDim.new(0,12); ccp.PaddingRight = UDim.new(0,12)
    ccp.PaddingTop = UDim.new(0,4); ccp.PaddingBottom = UDim.new(0,10)

    build(cc)

    local collapsed = true
    local function setCol(v)
        collapsed = v
        cc.Visible = not collapsed
        div.Visible = not collapsed
        arrow.Text = collapsed and "▶" or "▼"
    end

    local hBtn = Instance.new("TextButton", hdr)
    hBtn.Size = UDim2.new(1,0,1,0); hBtn.BackgroundTransparency = 1; hBtn.Text = ""; hBtn.ZIndex = 16
    hBtn.MouseButton1Click:Connect(function() setCol(not collapsed) end)
    setCol(true)  -- awalnya tertutup
    return wrap
end

-- Action row (button)
local function makeAction(parent, label, color, cb, order)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,34); row.BackgroundColor3 = color or C.rowAlt
    row.BorderSizePixel = 0; row.LayoutOrder = order or 0; row.ZIndex = 13
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,6)
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1,-12,1,0); lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = C.text
    lbl.TextSize = 11; lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 14
    local btn = Instance.new("TextButton", row)
    btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 15
    btn.MouseButton1Click:Connect(function() if cb then cb() end end)
end

-- Speed input
local function makeSpeedInput(parent, order)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1,0,0,36); row.BackgroundTransparency = 1
    row.BorderSizePixel = 0; row.LayoutOrder = order; row.ZIndex = 15
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(0.52,0,1,0); lbl.BackgroundTransparency = 1
    lbl.Text = "Speed Value"; lbl.TextColor3 = C.text; lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 16
    local inp = Instance.new("TextBox", row)
    inp.Size = UDim2.new(0.44,0,0.72,0); inp.Position = UDim2.new(0.56,0,0.14,0)
    inp.BackgroundColor3 = C.inputBg; inp.BorderSizePixel = 0; inp.Text = "22"
    inp.TextColor3 = C.accent; inp.TextSize = 12; inp.Font = Enum.Font.GothamBold
    inp.ClearTextOnFocus = false; inp.TextXAlignment = Enum.TextXAlignment.Center; inp.ZIndex = 16
    Instance.new("UICorner", inp).CornerRadius = UDim.new(0,5)
    local _s = Instance.new("UIStroke", inp); _s.Color = Color3.fromRGB(0,80,130); _s.Thickness = 1
    return inp
end

-- ============================================================
-- MODAL DROPDOWN
-- ============================================================
local function createDropdownButton(parent, labelText, options, defaultOption, onSelect, layoutOrder)
    local wrapper = Instance.new("Frame", parent)
    wrapper.Size = UDim2.new(1, 0, 0, 36)
    wrapper.BackgroundTransparency = 1
    wrapper.LayoutOrder = layoutOrder or 1
    wrapper.ZIndex = 15

    local lbl = Instance.new("TextLabel", wrapper)
    lbl.Size = UDim2.new(0.52, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = C.text
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 16

    local dropdownBtn = Instance.new("TextButton", wrapper)
    dropdownBtn.Size = UDim2.new(0.44, 0, 0.72, 0)
    dropdownBtn.Position = UDim2.new(0.54, 0, 0.14, 0)
    dropdownBtn.BackgroundColor3 = C.inputBg
    dropdownBtn.BorderSizePixel = 0
    dropdownBtn.Text = defaultOption .. " ↕"
    dropdownBtn.TextColor3 = C.accent
    dropdownBtn.TextSize = 10
    dropdownBtn.Font = Enum.Font.GothamBold
    dropdownBtn.ZIndex = 17
    Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0, 5)

    local currentSelected = defaultOption
    local isOpen = false
    local dropFrame = nil
    local inputConnection = nil

    local function setSelected(selected)
        currentSelected = selected
        dropdownBtn.Text = selected .. " ▼"
        if onSelect then onSelect(selected) end
    end

    dropdownBtn.MouseButton1Click:Connect(function()
        if isOpen then
            if dropFrame then dropFrame:Destroy(); dropFrame = nil end
            if inputConnection then inputConnection:Disconnect(); inputConnection = nil end
            isOpen = false
            return
        end

        dropFrame = Instance.new("Frame", screenGui)
        dropFrame.Size = UDim2.new(0, 160, 0, math.min(180, #options * 30 + 4))
        dropFrame.BackgroundColor3 = C.inputBg
        dropFrame.BorderSizePixel = 0
        dropFrame.ZIndex = 1000
        Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 5)

        local btnPos = dropdownBtn.AbsolutePosition
        local btnSize = dropdownBtn.AbsoluteSize
        local screenSize = workspace.CurrentCamera.ViewportSize
        local dropX = btnPos.X + btnSize.X + 2
        if dropX + dropFrame.AbsoluteSize.X > screenSize.X then
            dropX = btnPos.X - dropFrame.AbsoluteSize.X - 2
        end
        local dropY = btnPos.Y
        if dropY + dropFrame.AbsoluteSize.Y > screenSize.Y then
            dropY = screenSize.Y - dropFrame.AbsoluteSize.Y
        end
        dropFrame.Position = UDim2.new(0, dropX, 0, dropY)

        local scroll = Instance.new("ScrollingFrame", dropFrame)
        scroll.Size = UDim2.new(1, 0, 1, 0)
        scroll.BackgroundTransparency = 1
        scroll.ScrollingDirection = Enum.ScrollingDirection.Y
        scroll.CanvasSize = UDim2.new(0, 0, 0, #options * 30)
        scroll.ScrollBarThickness = 3
        scroll.ScrollBarImageColor3 = C.accent

        local layout = Instance.new("UIListLayout", scroll)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 1)

        for _, opt in ipairs(options) do
            local btn = Instance.new("TextButton", scroll)
            btn.Size = UDim2.new(1, 0, 0, 28)
            btn.BackgroundColor3 = C.inputBg
            btn.BorderSizePixel = 0
            btn.Text = ""
            btn.ZIndex = 1001

            local textLbl = Instance.new("TextLabel", btn)
            textLbl.Size = UDim2.new(1, 0, 1, 0)
            textLbl.BackgroundTransparency = 1
            textLbl.Text = opt
            textLbl.TextColor3 = (opt == currentSelected) and C.accent or C.textDim
            textLbl.TextSize = 10
            textLbl.Font = Enum.Font.GothamBold
            textLbl.ZIndex = 1002

            btn.MouseButton1Click:Connect(function()
                setSelected(opt)
                if dropFrame then dropFrame:Destroy(); dropFrame = nil end
                if inputConnection then inputConnection:Disconnect(); inputConnection = nil end
                isOpen = false
            end)
        end

        isOpen = true

        local function onInputBegan(input)
            if not isOpen then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                task.wait(0.1)
                local mousePos = UIS:GetMouseLocation()
                local btnAbs = dropdownBtn.AbsolutePosition
                local btnSz = dropdownBtn.AbsoluteSize
                local frameAbs = dropFrame and dropFrame.AbsolutePosition
                local frameSz = dropFrame and dropFrame.AbsoluteSize

                local inBtn = (mousePos.X >= btnAbs.X and mousePos.X <= btnAbs.X + btnSz.X and
                               mousePos.Y >= btnAbs.Y and mousePos.Y <= btnAbs.Y + btnSz.Y)
                local inFrame = frameAbs and (mousePos.X >= frameAbs.X and mousePos.X <= frameAbs.X + frameSz.X and
                                              mousePos.Y >= frameAbs.Y and mousePos.Y <= frameAbs.Y + frameSz.Y)

                if not inBtn and not inFrame then
                    if dropFrame then dropFrame:Destroy(); dropFrame = nil end
                    isOpen = false
                    if inputConnection then inputConnection:Disconnect(); inputConnection = nil end
                end
            end
        end

        inputConnection = UIS.InputBegan:Connect(onInputBegan)
    end)

    return wrapper, dropdownBtn, setSelected
end

-- ============================================================
-- ADMIN / GAMEPLAY FUNCTIONS
-- ============================================================

-- Speed engine
local function stopSpeedEngine()
    if speedConn then speedConn:Disconnect(); speedConn = nil end
    local c = lp.Character
    if c then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp then local bv = hrp:FindFirstChild("FP_BV"); if bv then bv:Destroy() end end
        local h = c:FindFirstChildOfClass("Humanoid"); if h then h.WalkSpeed = 16 end
    end
end

local function hybridSpeed(val)
    stopSpeedEngine()
    local c = lp.Character
    if c then local h = c:FindFirstChildOfClass("Humanoid"); if h then h.WalkSpeed = math.min(val*0.5,28) end end
    local boost = val * 0.012
    speedConn = RunService.Heartbeat:Connect(function(dt)
        local ch = lp.Character; if not ch then return end
        local hrp = ch:FindFirstChild("HumanoidRootPart")
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        if hum.MoveDirection.Magnitude > 0.01 then
            hrp.CFrame = hrp.CFrame + hum.MoveDirection * (boost * dt * 60)
        end
    end)
end

local function toggleNoclip()
    isNoclip = not isNoclip
    if isNoclip then
        noclipConn = RunService.Heartbeat:Connect(function()
            local c = lp.Character; if not c then return end
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
            end
        end)
        notify("Noclip ON")
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        local c = lp.Character
        if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = true end end end
        notify("Noclip OFF")
    end
end

local function toggleMoonwalk()
    isMoonwalk = not isMoonwalk
    if isMoonwalk then
        moonwalkConn = RunService.Heartbeat:Connect(function()
            local c = lp.Character; if not c then return end
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(hrp.Position, hrp.Position - workspace.CurrentCamera.CFrame.LookVector) end
        end)
        notify("Moonwalk ON")
    else
        if moonwalkConn then moonwalkConn:Disconnect(); moonwalkConn = nil end
        notify("Moonwalk OFF")
    end
end

local function toggleUnlimZoom()
    isUnlimZoom = not isUnlimZoom
    if isUnlimZoom then origMaxZoom = lp.CameraMaxZoomDistance; lp.CameraMaxZoomDistance = 999999; notify("Unlimited Zoom ON")
    else lp.CameraMaxZoomDistance = origMaxZoom or 400; notify("Unlimited Zoom OFF") end
end

local function toggleWalkWater()
    isWalkWater = not isWalkWater
    if isWalkWater then
        walkWaterConn = RunService.Heartbeat:Connect(function()
            local c = lp.Character; if not c then return end
            local hrp = c:FindFirstChild("HumanoidRootPart")
            local h = c:FindFirstChildOfClass("Humanoid")
            if not hrp or not h or h.Health <= 0 then return end
            local rp = RaycastParams.new()
            rp.FilterType = Enum.RaycastFilterType.Blacklist
            rp.FilterDescendantsInstances = {c}
            local rr = workspace:Raycast(hrp.Position, Vector3.new(0,-10,0), rp)
            if rr and rr.Instance.Material == Enum.Material.Water then
                if hrp.Position.Y <= rr.Position.Y + 2 then
                    hrp.CFrame = CFrame.new(hrp.Position.X, rr.Position.Y+1, hrp.Position.Z)
                    hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                    h.PlatformStand = true
                end
            else h.PlatformStand = false end
        end)
        notify("Walk on Water ON")
    else
        if walkWaterConn then walkWaterConn:Disconnect(); walkWaterConn = nil end
        local c = lp.Character
        if c then local h = c:FindFirstChildOfClass("Humanoid"); if h then h.PlatformStand = false end end
        notify("Walk on Water OFF")
    end
end

local function toggleFullBright()
    isFullBright = not isFullBright
    if isFullBright then
        origFBLight = {Ambient=Lighting.Ambient,Brightness=Lighting.Brightness,
            GlobalShadows=Lighting.GlobalShadows,FogEnd=Lighting.FogEnd,
            FogStart=Lighting.FogStart,ClockTime=Lighting.ClockTime}
        fullBrightConn = RunService.Heartbeat:Connect(function()
            if not isFullBright then return end
            pcall(function()
                Lighting.Ambient = Color3.new(1,1,1); Lighting.Brightness = 2
                Lighting.GlobalShadows = false; Lighting.FogEnd = 100000
                Lighting.FogStart = 0; Lighting.ClockTime = 12
            end)
        end)
        notify("Full Bright ON")
    else
        if fullBrightConn then fullBrightConn:Disconnect(); fullBrightConn = nil end
        for k,v in pairs(origFBLight) do pcall(function() Lighting[k] = v end) end
        notify("Full Bright OFF")
    end
end

local function toggleAntiLag()
    isAntiLag = not isAntiLag
    if isAntiLag then
        origLight = {GlobalShadows=Lighting.GlobalShadows,ShadowSoftness=Lighting.ShadowSoftness,
            Ambient=Lighting.Ambient,Brightness=Lighting.Brightness}
        antiLagConn = RunService.Heartbeat:Connect(function()
            if not isAntiLag then return end
            pcall(function()
                Lighting.GlobalShadows = false; Lighting.ShadowSoftness = 0
                Lighting.Ambient = Color3.new(1,1,1); Lighting.Brightness = 1.5
            end)
            pcall(function() UserSettings():GetService("UserGameSettings").QualityLevel = 1 end)
        end)
        antiLagDescConn = workspace.DescendantAdded:Connect(function(obj)
            if not isAntiLag then return end
            if (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
                or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles")) and obj.Enabled then
                obj.Enabled = false; table.insert(disabledFX, obj)
            end
        end)
        for _, c in ipairs(workspace:GetDescendants()) do
            if (c:IsA("ParticleEmitter") or c:IsA("Trail") or c:IsA("Beam")
                or c:IsA("Smoke") or c:IsA("Fire") or c:IsA("Sparkles")) and c.Enabled then
                c.Enabled = false; table.insert(disabledFX, c)
            end
        end
        notify("Anti Lag ON  [L]")
    else
        if antiLagConn then antiLagConn:Disconnect(); antiLagConn = nil end
        if antiLagDescConn then antiLagDescConn:Disconnect(); antiLagDescConn = nil end
        for k,v in pairs(origLight) do pcall(function() Lighting[k] = v end) end
        for _, e in ipairs(disabledFX) do pcall(function() if e and e.Parent then e.Enabled = true end end) end
        disabledFX = {}
        notify("Anti Lag OFF")
    end
end

local function toggleAntiAfk()
    isAntiAfk = not isAntiAfk
    if isAntiAfk then
        task.spawn(function()
            while isAntiAfk do
                task.wait(30)
                if not isAntiAfk then break end
                local c = lp.Character; if not c then continue end
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local cf = hrp.CFrame
                    hrp.CFrame = cf + cf.LookVector
                    task.wait(0.1)
                    pcall(function() hrp.CFrame = cf end)
                end
            end
        end)
        notify("Anti AFK ON  [K]")
    else notify("Anti AFK OFF") end
end

local function toggleFly()
    local c = lp.Character or lp.CharacterAdded:Wait()
    local hum = c:FindFirstChildOfClass("Humanoid")
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    isFlying = not isFlying
    if isFlying then
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum.PlatformStand = true
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.Velocity = Vector3.zero; bodyVel.MaxForce = Vector3.new(4e4,4e4,4e4)
        bodyVel.P = 1250; bodyVel.Parent = hrp
        bodyGyr = Instance.new("BodyGyro")
        bodyGyr.MaxTorque = Vector3.new(4e4,4e4,4e4); bodyGyr.P = 1250
        bodyGyr.D = 250; bodyGyr.CFrame = hrp.CFrame; bodyGyr.Parent = hrp
        notify("Fly ON  [F to toggle]")
    else
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        hum.PlatformStand = false
        if bodyVel then bodyVel:Destroy(); bodyVel = nil end
        if bodyGyr then bodyGyr:Destroy(); bodyGyr = nil end
        for k in pairs(flyInput) do flyInput[k] = false end
        notify("Fly OFF")
    end
end

local function toggleInfJump()
    isInfJump = not isInfJump
    if isInfJump then
        if not infJumpConn then
            infJumpConn = UIS.JumpRequest:Connect(function()
                if not isInfJump then return end
                local c = lp.Character; if not c then return end
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        end
        notify("Infinite Jump ON  [J]")
    else
        if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
        notify("Infinite Jump OFF")
    end
end

-- Fly heartbeat
RunService.Heartbeat:Connect(function()
    if not isFlying or not bodyVel or not bodyGyr then return end
    local c = lp.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    bodyGyr.CFrame = workspace.CurrentCamera.CFrame
    local cam = workspace.CurrentCamera.CFrame
    local dir = Vector3.zero
    local spd = flySpeed
    if UIS:IsKeyDown(Enum.KeyCode.W) or flyInput.fwd then dir = dir + cam.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) or flyInput.bwd then dir = dir - cam.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) or flyInput.rgt then dir = dir + cam.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) or flyInput.lft then dir = dir - cam.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) or flyInput.up then dir = dir + Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or flyInput.dn then dir = dir - Vector3.new(0,1,0) end
    bodyVel.Velocity = dir * spd
end)

-- ============================================================
-- FISHING V1 FUNCTIONS
-- ============================================================
local function setFishStatus(txt, col)
    if fishingStatusLbl then
        fishingStatusLbl.Text = txt
        fishingStatusLbl.TextColor3 = col or C.accent
    end
end

local fishingDelayBox = nil

local function startFishing()
    if isFishing then return end
    local ok = equipRod()
    if not ok then
        notify("⚠ Remote equip tidak ditemukan! Cek path net package", 4)
        isFishing = false; return
    end
    isFishing = true
    task.wait(1)
    notify("🎣 Instant Fishing V1 dimulai!")
    task.spawn(function()
        local cycle = 0
        while isFishing do
            cycle = cycle + 1
            setFishStatus("⚙ Cycle #"..cycle.." – Awal...", Color3.fromRGB(180,180,255))
            pcall(doAwal)
            setFishStatus("🕐 Menunggu 0.1 detik...", C.accent)
            task.wait(0.1)
            if not isFishing then break end

            setFishStatus("🎯 Melempar umpan...", Color3.fromRGB(255,210,50))
            pcall(doLempar)

            local delay = 3
            if fishingDelayBox then
                local val = tonumber(fishingDelayBox.Text)
                if val and val > 0 then delay = val end
            end
            setFishStatus("🕐 Menunggu "..delay.." detik...", Color3.fromRGB(255,210,50))
            task.wait(delay)
            if not isFishing then break end

            setFishStatus("⬆ Menarik pancingan!", Color3.fromRGB(0,220,80))
            pcall(doTarik)
            task.wait(0.4)
        end
        setFishStatus("⛔ Fishing berhenti", Color3.fromRGB(200,80,80))
    end)
end

local function stopFishing()
    isFishing = false
    pcall(unequipRod)
    notify("🎣 Instant Fishing V1 dihentikan")
    setFishStatus("⛔ Tidak aktif", Color3.fromRGB(200,80,80))
end

-- ============================================================
-- FISHING V2 FUNCTIONS
-- ============================================================
local function setFishV2Status(txt, col)
    if fishingV2StatusLbl then
        fishingV2StatusLbl.Text = txt
        fishingV2StatusLbl.TextColor3 = col or C.accent
    end
end

local function startFishingV2()
    if isFishingV2 then return end
    if not FishingSystem then
        notify("⚠ FishingSystem tidak ditemukan! V2 tidak bisa digunakan", 4)
        return
    end
    if not rodEquippedV2 then
        local ok = equipRodV2(selectedRodV2)
        if ok then
            rodEquippedV2 = true
            notify("Rod equipped: " .. selectedRodV2, 2)
        else
            notify("⚠ Gagal equip rod V2: " .. tostring(selectedRodV2), 4)
            return
        end
    end
    isFishingV2 = true
    notify("🎣 Instant Fishing V2 dimulai dengan rod: " .. selectedRodV2)
    task.spawn(function()
        local cycle = 0
        while isFishingV2 do
            cycle = cycle + 1
            setFishV2Status("⚙ Cycle #"..cycle.." – Casting...", Color3.fromRGB(180,180,255))
            pcall(doCastV2)

            local delay = 2
            if fishingV2DelayBox then
                local val = tonumber(fishingV2DelayBox.Text)
                if val and val > 0 then delay = val end
            end
            setFishV2Status("🕐 Menunggu "..delay.." detik...", Color3.fromRGB(255,210,50))
            task.wait(delay)
            if not isFishingV2 then break end

            setFishV2Status("⬆ Menarik pancingan!", Color3.fromRGB(0,220,80))
            pcall(doReelV2)
            task.wait(0.5)
        end
        setFishV2Status("⛔ Fishing V2 berhenti", Color3.fromRGB(200,80,80))
    end)
end

local function stopFishingV2()
    isFishingV2 = false
    if rodEquippedV2 then
        pcall(unequipRodV2)
        rodEquippedV2 = false
    end
    notify("🎣 Instant Fishing V2 dihentikan")
    setFishV2Status("⛔ Tidak aktif", Color3.fromRGB(200,80,80))
end

-- Teleport helpers
local function stopAutoTp()
    if autoTpConn then autoTpConn:Disconnect(); autoTpConn = nil end
    autoTpActive = false; autoTpTarget = nil
    notify("Auto Teleport dihentikan")
end

local function startAutoTp(target)
    if autoTpActive then stopAutoTp() end
    if not target or not target.Parent then notify("Player tidak ada!"); return end
    autoTpTarget = target; autoTpActive = true
    notify("Auto TP → "..target.Name)
    autoTpConn = RunService.RenderStepped:Connect(function()
        if not autoTpActive or not autoTpTarget or not autoTpTarget.Parent then stopAutoTp(); return end
        local tc = autoTpTarget.Character
        if lp.Character and tc then
            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
            local thrp = tc:FindFirstChild("HumanoidRootPart")
            if hrp and thrp then hrp.CFrame = thrp.CFrame end
        end
    end)
end

local function teleportToPlayer(target)
    if lp.Character and target.Character then
        local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
        local thrp = target.Character:FindFirstChild("HumanoidRootPart")
        if hrp and thrp then hrp.CFrame = thrp.CFrame * CFrame.new(0,0,-3); notify("TP → "..target.Name)
        else notify("HumanoidRootPart tidak ditemukan!") end
    end
end

-- ============================================================
-- FLY D-PAD & SPEED SLIDER UI
-- ============================================================
local BW,BH,GAP = 38,38,4

local dpadF = Instance.new("Frame", screenGui)
dpadF.Size = UDim2.new(0, BW*3+GAP*2, 0, BH*2+GAP)
dpadF.Position = UDim2.new(0, 10, 1, -(BH*2+GAP+75))
dpadF.BackgroundTransparency = 1; dpadF.Visible = false; dpadF.ZIndex = 60

local udF = Instance.new("Frame", screenGui)
udF.Size = UDim2.new(0, BW, 0, BH*2+GAP)
udF.Position = UDim2.new(1, -(BW+10), 1, -(BH*2+GAP+75))
udF.BackgroundTransparency = 1; udF.Visible = false; udF.ZIndex = 60

local function mkFBtn(par, lbl, x, y, w, h, dn, up)
    local b = Instance.new("TextButton", par)
    b.Size = UDim2.new(0,w,0,h); b.Position = UDim2.new(0,x,0,y)
    b.BackgroundColor3 = Color3.fromRGB(10,20,40); b.BackgroundTransparency = 0.3
    b.Text = lbl; b.TextColor3 = Color3.fromRGB(200,230,255)
    b.TextSize = 16; b.Font = Enum.Font.GothamBold; b.BorderSizePixel = 0; b.ZIndex = 61
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
    local bs = Instance.new("UIStroke",b); bs.Color = C.accent; bs.Thickness = 1.5
    b.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            b.BackgroundColor3=C.accent; b.BackgroundTransparency=0.15; dn()
        end
    end)
    b.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            b.BackgroundColor3=Color3.fromRGB(10,20,40); b.BackgroundTransparency=0.3; up()
        end
    end)
end
mkFBtn(dpadF,"↑",BW+GAP,0,BW,BH,function() flyInput.fwd=true end,function() flyInput.fwd=false end)
mkFBtn(dpadF,"←",0,BH+GAP,BW,BH,function() flyInput.lft=true end,function() flyInput.lft=false end)
mkFBtn(dpadF,"↓",BW+GAP,BH+GAP,BW,BH,function() flyInput.bwd=true end,function() flyInput.bwd=false end)
mkFBtn(dpadF,"→",(BW+GAP)*2,BH+GAP,BW,BH,function() flyInput.rgt=true end,function() flyInput.rgt=false end)
mkFBtn(udF,"↑",0,0,BW,BH,function() flyInput.up=true end,function() flyInput.up=false end)
mkFBtn(udF,"↓",0,BH+GAP,BW,BH,function() flyInput.dn=true end,function() flyInput.dn=false end)

-- Speed Slider Panel
local slPanel = Instance.new("Frame", screenGui)
slPanel.Size = UDim2.new(0, BW*3+GAP*2, 0, 50)
slPanel.Position = UDim2.new(0, 10, 1, -(BH*2+GAP+135))
slPanel.BackgroundColor3 = Color3.fromRGB(10,20,40); slPanel.BackgroundTransparency = 0.3
slPanel.BorderSizePixel = 0; slPanel.Visible = false; slPanel.ZIndex = 60
Instance.new("UICorner", slPanel).CornerRadius = UDim.new(0,8)
local _slS = Instance.new("UIStroke", slPanel); _slS.Color = C.accent; _slS.Thickness = 1.5

local slTitle = Instance.new("TextLabel", slPanel)
slTitle.Size = UDim2.new(0.6,0,0,18); slTitle.Position = UDim2.new(0,8,0,4)
slTitle.BackgroundTransparency = 1; slTitle.Text = "FLY SPEED"
slTitle.TextColor3 = C.accent; slTitle.TextSize = 9; slTitle.Font = Enum.Font.GothamBold
slTitle.TextXAlignment = Enum.TextXAlignment.Left; slTitle.ZIndex = 61

local slVal = Instance.new("TextLabel", slPanel)
slVal.Size = UDim2.new(0.4,-8,0,18); slVal.Position = UDim2.new(0.6,0,0,4)
slVal.BackgroundTransparency = 1; slVal.Text = tostring(flySpeed)
slVal.TextColor3 = C.text; slVal.TextSize = 9; slVal.Font = Enum.Font.GothamBold
slVal.TextXAlignment = Enum.TextXAlignment.Right; slVal.ZIndex = 61

local slTrack = Instance.new("Frame", slPanel)
slTrack.Size = UDim2.new(1,-16,0,4); slTrack.Position = UDim2.new(0,8,0,30)
slTrack.BackgroundColor3 = Color3.fromRGB(30,45,70); slTrack.BorderSizePixel = 0; slTrack.ZIndex = 61
Instance.new("UICorner", slTrack).CornerRadius = UDim.new(1,0)

local slFill = Instance.new("Frame", slTrack)
slFill.Size = UDim2.new(flySpeed/500,0,1,0); slFill.BackgroundColor3 = C.accent
slFill.BorderSizePixel = 0; slFill.ZIndex = 62
Instance.new("UICorner", slFill).CornerRadius = UDim.new(1,0)

local slKnob = Instance.new("Frame", slTrack)
slKnob.Size = UDim2.new(0,14,0,14); slKnob.AnchorPoint = Vector2.new(0.5,0.5)
slKnob.Position = UDim2.new(flySpeed/500,0,0.5,0); slKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
slKnob.BorderSizePixel = 0; slKnob.ZIndex = 63
Instance.new("UICorner", slKnob).CornerRadius = UDim.new(1,0)
local _skS = Instance.new("UIStroke", slKnob); _skS.Color = C.accent; _skS.Thickness = 2

local slDrag = Instance.new("TextButton", slPanel)
slDrag.Size = UDim2.new(1,-16,0,24); slDrag.Position = UDim2.new(0,8,0,22)
slDrag.BackgroundTransparency = 1; slDrag.Text = ""; slDrag.ZIndex = 64

local isDragSl = false
local function updateSl(val)
    val = math.clamp(val,1,500); flySpeed = val
    local r = (val-1)/499
    slFill.Size = UDim2.new(r,0,1,0); slKnob.Position = UDim2.new(r,0,0.5,0)
    slVal.Text = tostring(val)
end
local function slFromX(x)
    local ax = slTrack.AbsolutePosition.X; local aw = slTrack.AbsoluteSize.X
    if aw <= 0 then return flySpeed end
    return math.floor(1 + math.clamp((x-ax)/aw,0,1)*499)
end
slDrag.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        isDragSl=true; updateSl(slFromX(i.Position.X)) end end)
slDrag.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        isDragSl=false end end)
UIS.InputChanged:Connect(function(i)
    if isDragSl and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        updateSl(slFromX(i.Position.X)) end end)

local function setFlyUI(v)
    dpadF.Visible = v; udF.Visible = v; slPanel.Visible = v
end

-- ============================================================
-- PAGES
-- ============================================================
local function makePage(name)
    local pg = Instance.new("Frame", scrollFrame)
    pg.Size = UDim2.new(1,0,0,0); pg.AutomaticSize = Enum.AutomaticSize.Y
    pg.BackgroundTransparency = 1; pg.Visible = false; pg.ZIndex = 12; pg.Name = name
    local l = Instance.new("UIListLayout", pg); l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0,3)
    return pg
end

local mainPage    = makePage("Main")
local playersPage = makePage("Players")
local teleportPage = makePage("Teleport")

-- ============================================================
-- BUILD MAIN PAGE
-- ============================================================

-- Player Utility section
makeSection(mainPage, "Player Utility", 1, function(cc)
    local spdInp = makeSpeedInput(cc, 1)

    makeToggle(cc, "Enable Run Speed", 2, function(on)
        if on then
            local v = tonumber(spdInp.Text) or 22; currentSpeed = v; isSpeedHack = true
            hybridSpeed(v)
            lp.CharacterAdded:Connect(function(nc)
                if not isSpeedHack then return end
                nc:WaitForChild("HumanoidRootPart", 5); task.wait(0.5)
                hybridSpeed(currentSpeed)
            end)
        else isSpeedHack = false; stopSpeedEngine(); notify("Speed OFF") end
    end)

    makeToggle(cc, "No Clip",         3, function(on) if on~=isNoclip     then toggleNoclip()   end end)
    makeToggle(cc, "Moonwalk",        4, function(on) if on~=isMoonwalk   then toggleMoonwalk() end end)
    makeToggle(cc, "Unlimited Zoom",  5, function(on) if on~=isUnlimZoom  then toggleUnlimZoom() end end)
    makeToggle(cc, "Walk on Water",   6, function(on) if on~=isWalkWater  then toggleWalkWater() end end)
    makeToggle(cc, "Full Bright",     7, function(on) if on~=isFullBright then toggleFullBright() end end)

    makeAction(cc, "📍 Cek Posisi Saat Ini", C.rowAlt, function()
        local c = lp.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local p = c.HumanoidRootPart.Position
            notify(string.format("X:%.1f  Y:%.1f  Z:%.1f", p.X, p.Y, p.Z), 5)
        end
    end, 8)
end)

-- Instant Fishing V1 section
makeSection(mainPage, "🎣 Instant Fishing V1", 2, function(cc)
    local info = Instance.new("TextLabel", cc)
    info.Size = UDim2.new(1,0,0,36); info.BackgroundTransparency = 1
    info.Text = "Equip Rod → Awal [0.1s] → Lempar Umpan → [delay] → Tarik → Loop otomatis"
    info.TextColor3 = C.textDim; info.TextSize = 9; info.Font = Enum.Font.Gotham
    info.TextWrapped = true; info.TextXAlignment = Enum.TextXAlignment.Left
    info.LayoutOrder = 1; info.ZIndex = 16

    local statusF = Instance.new("Frame", cc)
    statusF.Size = UDim2.new(1,0,0,28); statusF.BackgroundColor3 = Color3.fromRGB(8,14,24)
    statusF.BorderSizePixel = 0; statusF.LayoutOrder = 2; statusF.ZIndex = 15
    Instance.new("UICorner", statusF).CornerRadius = UDim.new(0,5)
    local _sfs = Instance.new("UIStroke", statusF); _sfs.Color = C.divider; _sfs.Thickness = 1

    fishingStatusLbl = Instance.new("TextLabel", statusF)
    fishingStatusLbl.Size = UDim2.new(1,-12,1,0); fishingStatusLbl.Position = UDim2.new(0,10,0,0)
    fishingStatusLbl.BackgroundTransparency = 1; fishingStatusLbl.Text = "⛔ Tidak aktif"
    fishingStatusLbl.TextColor3 = Color3.fromRGB(200,80,80); fishingStatusLbl.TextSize = 10
    fishingStatusLbl.Font = Enum.Font.GothamBold; fishingStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
    fishingStatusLbl.ZIndex = 16

    makeToggle(cc, "Enable Instant Fishing V1", 3, function(on)
        if on then startFishing() else stopFishing() end
    end)

    -- Stable Result toggle
    makeToggle(cc, "Stable Result", 4, function(on)
        isStableResult = on
        local ok = setStableResult(on)
        if ok then
            notify("Stable Result " .. (on and "ON" or "OFF"))
        else
            notify("⚠ Gagal mengubah Stable Result")
        end
    end)

    local delayRow = Instance.new("Frame", cc)
    delayRow.Size = UDim2.new(1,0,0,36); delayRow.BackgroundTransparency = 1
    delayRow.LayoutOrder = 5; delayRow.ZIndex = 15
    local dlbl = Instance.new("TextLabel", delayRow)
    dlbl.Size = UDim2.new(0.55,0,1,0); dlbl.BackgroundTransparency = 1
    dlbl.Text = "Delay Tarik (detik)"
    dlbl.TextColor3 = C.text; dlbl.TextSize = 11; dlbl.Font = Enum.Font.GothamBold
    dlbl.TextXAlignment = Enum.TextXAlignment.Left; dlbl.ZIndex = 16
    fishingDelayBox = Instance.new("TextBox", delayRow)
    fishingDelayBox.Size = UDim2.new(0.25,0,0.7,0); fishingDelayBox.Position = UDim2.new(0.7,0,0.15,0)
    fishingDelayBox.BackgroundColor3 = C.inputBg; fishingDelayBox.BorderSizePixel = 0
    fishingDelayBox.Text = "3"; fishingDelayBox.TextColor3 = C.accent
    fishingDelayBox.TextSize = 12; fishingDelayBox.Font = Enum.Font.GothamBold
    fishingDelayBox.ClearTextOnFocus = false; fishingDelayBox.TextXAlignment = Enum.TextXAlignment.Center
    fishingDelayBox.ZIndex = 16
    Instance.new("UICorner", fishingDelayBox).CornerRadius = UDim.new(0,5)
    local _ds = Instance.new("UIStroke", fishingDelayBox); _ds.Color = Color3.fromRGB(0,80,130); _ds.Thickness = 1

    local dv = Instance.new("TextLabel", cc)
    dv.Size = UDim2.new(1,0,0,22); dv.BackgroundTransparency = 1
    dv.Text = "— Manual Controls —"; dv.TextColor3 = C.textDim; dv.TextSize = 9
    dv.Font = Enum.Font.Gotham; dv.LayoutOrder = 6; dv.ZIndex = 16

    local rodEquipped = false
    makeToggle(cc, "Equip Rod (V1)", 7, function(on)
        if on then
            if equipRod() then rodEquipped = true; notify("Rod equipped!") else notify("Gagal equip rod") end
        else
            unequipRod(); rodEquipped = false; notify("Rod unequipped")
        end
    end)

    local hRow = Instance.new("Frame", cc)
    hRow.Size = UDim2.new(1,0,0,34); hRow.BackgroundTransparency = 1
    hRow.LayoutOrder = 8; hRow.ZIndex = 14
    local hLayout = Instance.new("UIListLayout", hRow)
    hLayout.FillDirection = Enum.FillDirection.Horizontal
    hLayout.Padding = UDim.new(0,6)
    hLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function makeSmallBtn(parent, text, color, cb)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0.28,0,1,0)
        btn.BackgroundColor3 = color or C.btnBlue
        btn.Text = text
        btn.TextColor3 = C.text
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.ZIndex = 15
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
        btn.MouseButton1Click:Connect(cb)
        return btn
    end

    makeSmallBtn(hRow, "▶ Awal", Color3.fromRGB(0,70,130), function() doAwal(); notify("Awal fired!") end)
    makeSmallBtn(hRow, "🎯 Lempar", Color3.fromRGB(0,90,50), function() doLempar(); notify("Lempar umpan!") end)
    makeSmallBtn(hRow, "⬆ Tarik", Color3.fromRGB(0,110,40), function() doTarik(); notify("Tarik!") end)

    -- Boat spawn/remove buttons
    local boatRow = Instance.new("Frame", cc)
    boatRow.Size = UDim2.new(1,0,0,34); boatRow.BackgroundTransparency = 1
    boatRow.LayoutOrder = 9; boatRow.ZIndex = 14
    local boatLayout = Instance.new("UIListLayout", boatRow)
    boatLayout.FillDirection = Enum.FillDirection.Horizontal
    boatLayout.Padding = UDim.new(0,6)
    boatLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local spawnBtn = Instance.new("TextButton", boatRow)
    spawnBtn.Size = UDim2.new(0.4,0,1,0)
    spawnBtn.BackgroundColor3 = Color3.fromRGB(0,120,200)
    spawnBtn.Text = "Spawn Boat"
    spawnBtn.TextColor3 = C.text
    spawnBtn.TextSize = 10
    spawnBtn.Font = Enum.Font.GothamBold
    spawnBtn.BorderSizePixel = 0
    spawnBtn.ZIndex = 15
    Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0,5)
    spawnBtn.MouseButton1Click:Connect(function()
        if spawnBoat() then
            notify("Boat spawned!")
        else
            notify("Failed to spawn boat")
        end
    end)

    local removeBtn = Instance.new("TextButton", boatRow)
    removeBtn.Size = UDim2.new(0.4,0,1,0)
    removeBtn.BackgroundColor3 = Color3.fromRGB(180,50,50)
    removeBtn.Text = "Remove Boat"
    removeBtn.TextColor3 = C.text
    removeBtn.TextSize = 10
    removeBtn.Font = Enum.Font.GothamBold
    removeBtn.BorderSizePixel = 0
    removeBtn.ZIndex = 15
    Instance.new("UICorner", removeBtn).CornerRadius = UDim.new(0,5)
    removeBtn.MouseButton1Click:Connect(function()
        if removeBoat() then
            notify("Boat removed!")
        else
            notify("Failed to remove boat")
        end
    end)
end)

-- Instant Fishing V2 section
makeSection(mainPage, "🎣 Instant Fishing V2", 3, function(cc)
    local info = Instance.new("TextLabel", cc)
    info.Size = UDim2.new(1,0,0,36); info.BackgroundTransparency = 1
    info.Text = "Pilih Rod, Equip/Unequip, lalu enable fishing"
    info.TextColor3 = C.textDim; info.TextSize = 9; info.Font = Enum.Font.Gotham
    info.TextWrapped = true; info.TextXAlignment = Enum.TextXAlignment.Left
    info.LayoutOrder = 1; info.ZIndex = 16

    local statusF = Instance.new("Frame", cc)
    statusF.Size = UDim2.new(1,0,0,28); statusF.BackgroundColor3 = Color3.fromRGB(8,14,24)
    statusF.BorderSizePixel = 0; statusF.LayoutOrder = 2; statusF.ZIndex = 15
    Instance.new("UICorner", statusF).CornerRadius = UDim.new(0,5)
    local _sfs = Instance.new("UIStroke", statusF); _sfs.Color = C.divider; _sfs.Thickness = 1

    fishingV2StatusLbl = Instance.new("TextLabel", statusF)
    fishingV2StatusLbl.Size = UDim2.new(1,-12,1,0); fishingV2StatusLbl.Position = UDim2.new(0,10,0,0)
    fishingV2StatusLbl.BackgroundTransparency = 1; fishingV2StatusLbl.Text = "⛔ Tidak aktif"
    fishingV2StatusLbl.TextColor3 = Color3.fromRGB(200,80,80); fishingV2StatusLbl.TextSize = 10
    fishingV2StatusLbl.Font = Enum.Font.GothamBold; fishingV2StatusLbl.TextXAlignment = Enum.TextXAlignment.Left
    fishingV2StatusLbl.ZIndex = 16

    -- Rod dropdown (modal)
    local rodNames = {
        "Basic Rod", "Gold Rod", "Cople x1x1x", "GhostRod", "Fluorescent Rod",
        "Polarized", "Lightning", "Magic Rod", "Mistic Rod", "Sunflower Rod",
        "King Rod", "Megalofriend", "Manifest", "Earthly", "Aqua Prism",
        "Copblue x1x1x", "Umbrella", "x1x1x Hammer", "Purple Saber", "Binary Edge",
        "Corruption Edge", "Katana", "ZombieRod", "Crystalized", "LightingPunk Rod",
        "Frozen Rod", "Forsaken", "Pirate Octopus", "Fiery", "Loving"
    }
    local defaultRod = selectedRodV2
    local dropWrapper, dropBtn, dropSetSelected = createDropdownButton(cc, "Select Rod", rodNames, defaultRod, function(selected)
        selectedRodV2 = selected
    end, 3)

    -- Equip/Unequip toggle
    local equipToggleSetter
    equipToggleSetter = makeToggle(cc, "Equip Rod", 4, function(on)
        if on then
            local ok = equipRodV2(selectedRodV2)
            if ok then
                rodEquippedV2 = true
                notify("Equipped rod: " .. selectedRodV2, 3)
            else
                notify("Gagal equip rod: " .. selectedRodV2, 3)
                rodEquippedV2 = false
                equipToggleSetter(false, true)
            end
        else
            pcall(unequipRodV2)
            rodEquippedV2 = false
            notify("Rod unequipped", 3)
        end
    end)

    -- Delay input
    local delayRow = Instance.new("Frame", cc)
    delayRow.Size = UDim2.new(1,0,0,36); delayRow.BackgroundTransparency = 1
    delayRow.LayoutOrder = 5; delayRow.ZIndex = 15
    local dlbl = Instance.new("TextLabel", delayRow)
    dlbl.Size = UDim2.new(0.55,0,1,0); dlbl.BackgroundTransparency = 1
    dlbl.Text = "Delay Cast (detik)"
    dlbl.TextColor3 = C.text; dlbl.TextSize = 11; dlbl.Font = Enum.Font.GothamBold
    dlbl.TextXAlignment = Enum.TextXAlignment.Left; dlbl.ZIndex = 16
    fishingV2DelayBox = Instance.new("TextBox", delayRow)
    fishingV2DelayBox.Size = UDim2.new(0.25,0,0.7,0); fishingV2DelayBox.Position = UDim2.new(0.7,0,0.15,0)
    fishingV2DelayBox.BackgroundColor3 = C.inputBg; fishingV2DelayBox.BorderSizePixel = 0
    fishingV2DelayBox.Text = "2"; fishingV2DelayBox.TextColor3 = C.accent
    fishingV2DelayBox.TextSize = 12; fishingV2DelayBox.Font = Enum.Font.GothamBold
    fishingV2DelayBox.ClearTextOnFocus = false; fishingV2DelayBox.TextXAlignment = Enum.TextXAlignment.Center
    fishingV2DelayBox.ZIndex = 16
    Instance.new("UICorner", fishingV2DelayBox).CornerRadius = UDim.new(0,5)
    local _ds = Instance.new("UIStroke", fishingV2DelayBox); _ds.Color = Color3.fromRGB(0,80,130); _ds.Thickness = 1

    -- Instant Fishing toggle
    makeToggle(cc, "Enable Instant Fishing V2", 6, function(on)
        if on then
            startFishingV2()
        else
            stopFishingV2()
        end
    end)

    -- Manual controls
    local dv = Instance.new("TextLabel", cc)
    dv.Size = UDim2.new(1,0,0,22); dv.BackgroundTransparency = 1
    dv.Text = "— Manual Controls —"; dv.TextColor3 = C.textDim; dv.TextSize = 9
    dv.Font = Enum.Font.Gotham; dv.LayoutOrder = 7; dv.ZIndex = 16

    local hRow = Instance.new("Frame", cc)
    hRow.Size = UDim2.new(1,0,0,34); hRow.BackgroundTransparency = 1
    hRow.LayoutOrder = 8; hRow.ZIndex = 14
    local hLayout = Instance.new("UIListLayout", hRow)
    hLayout.FillDirection = Enum.FillDirection.Horizontal
    hLayout.Padding = UDim.new(0,6)
    hLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function makeSmallBtn2(parent, text, color, cb)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0.28,0,1,0)
        btn.BackgroundColor3 = color or C.btnBlue
        btn.Text = text
        btn.TextColor3 = C.text
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.ZIndex = 15
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
        btn.MouseButton1Click:Connect(cb)
        return btn
    end

    makeSmallBtn2(hRow, "🎣 Cast", Color3.fromRGB(0,70,130), function() doCastV2(); notify("Cast!") end)
    makeSmallBtn2(hRow, "⬆ Reel", Color3.fromRGB(0,110,40), function() doReelV2(); notify("Reel!") end)
end)

-- ============================================================
-- SELL ALL V1 SECTION (with fixed auto-loop)
-- ============================================================
makeSection(mainPage, "🛒 Sell All V1", 4, function(cc)
    local info = Instance.new("TextLabel", cc)
    info.Size = UDim2.new(1,0,0,36); info.BackgroundTransparency = 1
    info.Text = "Jual semua ikan dari sistem V1 menggunakan remote vendor"
    info.TextColor3 = C.textDim; info.TextSize = 9; info.Font = Enum.Font.Gotham
    info.TextWrapped = true; info.TextXAlignment = Enum.TextXAlignment.Left
    info.LayoutOrder = 1; info.ZIndex = 16

    local intervalRow = Instance.new("Frame", cc)
    intervalRow.Size = UDim2.new(1,0,0,36); intervalRow.BackgroundTransparency = 1
    intervalRow.LayoutOrder = 2; intervalRow.ZIndex = 15
    local intLbl = Instance.new("TextLabel", intervalRow)
    intLbl.Size = UDim2.new(0.55,0,1,0); intLbl.BackgroundTransparency = 1
    intLbl.Text = "Interval Sell V1 (detik)"
    intLbl.TextColor3 = C.text; intLbl.TextSize = 11; intLbl.Font = Enum.Font.GothamBold
    intLbl.TextXAlignment = Enum.TextXAlignment.Left; intLbl.ZIndex = 16
    sellV1IntervalInput = Instance.new("TextBox", intervalRow)
    sellV1IntervalInput.Size = UDim2.new(0.25,0,0.7,0); sellV1IntervalInput.Position = UDim2.new(0.7,0,0.15,0)
    sellV1IntervalInput.BackgroundColor3 = C.inputBg; sellV1IntervalInput.BorderSizePixel = 0
    sellV1IntervalInput.Text = "30"; sellV1IntervalInput.TextColor3 = C.accent
    sellV1IntervalInput.TextSize = 12; sellV1IntervalInput.Font = Enum.Font.GothamBold
    sellV1IntervalInput.ClearTextOnFocus = false; sellV1IntervalInput.TextXAlignment = Enum.TextXAlignment.Center
    sellV1IntervalInput.ZIndex = 16
    Instance.new("UICorner", sellV1IntervalInput).CornerRadius = UDim.new(0,5)
    local _si = Instance.new("UIStroke", sellV1IntervalInput); _si.Color = Color3.fromRGB(0,80,130); _si.Thickness = 1

    local function startAutoSellV1Timer()
        if autoSellV1Task then
            autoSellV1Enabled = false
            task.wait(0.2)
            if autoSellV1Task then
                task.cancel(autoSellV1Task)
                autoSellV1Task = nil
            end
        end
        autoSellV1Enabled = true
        autoSellV1Task = task.spawn(function()
            while autoSellV1Enabled do
                local interval = tonumber(sellV1IntervalInput.Text) or 30
                if interval < 1 then interval = 1 end
                task.wait(interval)
                if autoSellV1Enabled then
                    local success, err = pcall(sellAllV1)
                    if not success then
                        warn("Auto sell V1 error: " .. tostring(err))
                    end
                end
            end
            autoSellV1Task = nil
        end)
        notify("🔁 Auto Sell V1 ON (interval: " .. (tonumber(sellV1IntervalInput.Text) or 30) .. " detik)", 3)
    end

    local function stopAutoSellV1Timer()
        autoSellV1Enabled = false
        if autoSellV1Task then
            task.cancel(autoSellV1Task)
            autoSellV1Task = nil
        end
        notify("🔁 Auto Sell V1 OFF", 3)
    end

    local _, autoSellV1Setter = makeToggle(cc, "Auto Sell V1 Timer", 3, function(on)
        if on then
            startAutoSellV1Timer()
        else
            stopAutoSellV1Timer()
        end
    end)

    makeAction(cc, "💰 Sell All Now (V1)", Color3.fromRGB(0, 150, 80), function()
        sellAllV1()
    end, 4)
end)

-- ============================================================
-- ROD SHOP SECTION
-- ============================================================
makeSection(mainPage, "🛍️ Rod Shop", 5, function(cc)
    local info = Instance.new("TextLabel", cc)
    info.Size = UDim2.new(1,0,0,36); info.BackgroundTransparency = 1
    info.Text = "Pilih rod dari dropdown dan klik Buy untuk membeli"
    info.TextColor3 = C.textDim; info.TextSize = 9; info.Font = Enum.Font.Gotham
    info.TextWrapped = true; info.TextXAlignment = Enum.TextXAlignment.Left
    info.LayoutOrder = 1; info.ZIndex = 16

    local shopRods = {
        {name="GhostRod", price="100,000"},
        {name="Fluorescent Rod", price="50,000"},
        {name="Polarized", price="50,000"},
        {name="Lightning", price="30,000"},
        {name="ZombieRod", price="200 Robux"},
        {name="Crystalized", price="200 Robux"},
        {name="LightingPunk Rod", price="150,000"},
        {name="Frozen Rod", price="120,000"},
        {name="Forsaken", price="200 Robux"},
        {name="Pirate Octopus", price="200,000"},
        {name="Fiery", price="200 Robux"},
        {name="Loving", price="200 Robux"},
        {name="Megalofriend", price="7,500,000"},
        {name="Manifest", price="5,000,000"},
        {name="Earthly", price="3,000,000"},
        {name="Aqua Prism", price="20,000"},
        {name="Copblue x1x1x", price="7,600,000"},
        {name="Umbrella", price="350 Robux"},
        {name="x1x1x Hammer", price="7,900,000"},
        {name="Purple Saber", price="10,000,000"},
        {name="Binary Edge", price="8,100,000"},
        {name="Corruption Edge", price="7,600,000"},
        {name="Cople x1x1x", price="OWNED"},
        {name="Magic Rod", price="1000 Robux"},
        {name="Mistic Rod", price="1000 Robux"},
        {name="Sunflower Rod", price="1,000,000,000"},
        {name="King Rod", price="1,000,000,000"},
    }

    local shopOptions = {}
    local shopRodMap = {}
    for _, rod in ipairs(shopRods) do
        local display = rod.name .. " [" .. rod.price .. "]"
        table.insert(shopOptions, display)
        shopRodMap[display] = rod.name
    end

    local selectedShopRod = nil
    local defaultShopOption = shopOptions[1]
    selectedShopRod = shopRodMap[defaultShopOption]

    local dropWrapper, dropBtn, dropSetSelected = createDropdownButton(cc, "Select Rod", shopOptions, defaultShopOption, function(selected)
        selectedShopRod = shopRodMap[selected]
    end, 2)

    local buyRow = Instance.new("Frame", cc)
    buyRow.Size = UDim2.new(1,0,0,34); buyRow.BackgroundTransparency = 1
    buyRow.LayoutOrder = 3; buyRow.ZIndex = 15
    local buyBtn = Instance.new("TextButton", buyRow)
    buyBtn.Size = UDim2.new(0.4,0,1,0); buyBtn.Position = UDim2.new(0.3,0,0,0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0,150,80)
    buyBtn.Text = "BUY ROD"
    buyBtn.TextColor3 = C.text
    buyBtn.TextSize = 11; buyBtn.Font = Enum.Font.GothamBold
    buyBtn.BorderSizePixel = 0; buyBtn.ZIndex = 16
    Instance.new("UICorner", buyBtn).CornerRadius = UDim.new(0,5)
    buyBtn.MouseButton1Click:Connect(function()
        if selectedShopRod then
            if purchaseRod(selectedShopRod) then
                notify("✅ Membeli rod: " .. selectedShopRod, 3)
            else
                notify("❌ Gagal membeli rod: " .. selectedShopRod, 3)
            end
        else
            notify("⚠ Pilih rod terlebih dahulu", 3)
        end
    end)
end)

-- ============================================================
-- SELL FISH V2 SECTION (with fixed auto-loop)
-- ============================================================
makeSection(mainPage, "🛒 Sell Fish V2", 6, function(cc)
    local info = Instance.new("TextLabel", cc)
    info.Size = UDim2.new(1,0,0,36); info.BackgroundTransparency = 1
    info.Text = "Jual ikan dari sistem V2 secara otomatis atau manual"
    info.TextColor3 = C.textDim; info.TextSize = 9; info.Font = Enum.Font.Gotham
    info.TextWrapped = true; info.TextXAlignment = Enum.TextXAlignment.Left
    info.LayoutOrder = 1; info.ZIndex = 16

    local intervalRow = Instance.new("Frame", cc)
    intervalRow.Size = UDim2.new(1,0,0,36); intervalRow.BackgroundTransparency = 1
    intervalRow.LayoutOrder = 2; intervalRow.ZIndex = 15
    local intLbl = Instance.new("TextLabel", intervalRow)
    intLbl.Size = UDim2.new(0.55,0,1,0); intLbl.BackgroundTransparency = 1
    intLbl.Text = "Interval Sell V2 (detik)"
    intLbl.TextColor3 = C.text; intLbl.TextSize = 11; intLbl.Font = Enum.Font.GothamBold
    intLbl.TextXAlignment = Enum.TextXAlignment.Left; intLbl.ZIndex = 16
    shopIntervalInput = Instance.new("TextBox", intervalRow)
    shopIntervalInput.Size = UDim2.new(0.25,0,0.7,0); shopIntervalInput.Position = UDim2.new(0.7,0,0.15,0)
    shopIntervalInput.BackgroundColor3 = C.inputBg; shopIntervalInput.BorderSizePixel = 0
    shopIntervalInput.Text = "30"; shopIntervalInput.TextColor3 = C.accent
    shopIntervalInput.TextSize = 12; shopIntervalInput.Font = Enum.Font.GothamBold
    shopIntervalInput.ClearTextOnFocus = false; shopIntervalInput.TextXAlignment = Enum.TextXAlignment.Center
    shopIntervalInput.ZIndex = 16
    Instance.new("UICorner", shopIntervalInput).CornerRadius = UDim.new(0,5)
    local _si = Instance.new("UIStroke", shopIntervalInput); _si.Color = Color3.fromRGB(0,80,130); _si.Thickness = 1

    local function startAutoSellV2Timer()
        if autoSellTask then
            autoSellEnabled = false
            task.wait(0.2)
            if autoSellTask then
                task.cancel(autoSellTask)
                autoSellTask = nil
            end
        end
        autoSellEnabled = true
        autoSellTask = task.spawn(function()
            while autoSellEnabled do
                local interval = tonumber(shopIntervalInput.Text) or 30
                if interval < 1 then interval = 1 end
                task.wait(interval)
                if autoSellEnabled then
                    local success, err = pcall(sellAllFishV2)
                    if not success then
                        warn("Auto sell V2 error: " .. tostring(err))
                    end
                end
            end
            autoSellTask = nil
        end)
        notify("🔁 Auto Sell V2 ON (interval: " .. (tonumber(shopIntervalInput.Text) or 30) .. " detik)", 3)
    end

    local function stopAutoSellV2Timer()
        autoSellEnabled = false
        if autoSellTask then
            task.cancel(autoSellTask)
            autoSellTask = nil
        end
        notify("🔁 Auto Sell V2 OFF", 3)
    end

    local _, autoSellV2Setter = makeToggle(cc, "Auto Sell V2 Timer", 3, function(on)
        if on then
            startAutoSellV2Timer()
        else
            stopAutoSellV2Timer()
        end
    end)

    makeAction(cc, "💰 Sell All Now (V2)", Color3.fromRGB(0, 150, 80), function()
        sellAllFishV2()
    end, 4)
end)

-- Single-row toggles
local _, flyRowSet = makeToggle(mainPage, "Fly  [F]",          7, function(on)
    if on ~= isFlying then toggleFly(); setFlyUI(isFlying) end
end)

local _, antiLagSet = makeToggle(mainPage, "Anti Lag  [L]",   8, function(on)
    if on ~= isAntiLag then toggleAntiLag() end
end)

local _, antiAfkSet = makeToggle(mainPage, "Anti AFK  [K]",   9, function(on)
    if on ~= isAntiAfk then toggleAntiAfk() end
end)

local _, infJumpSet = makeToggle(mainPage, "Infinite Jump  [J]", 10, function(on)
    if on ~= isInfJump then toggleInfJump() end
end)

makeAction(mainPage, "🔄 Rejoin Server", Color3.fromRGB(100,30,30), function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end, 11)

-- ============================================================
-- BUILD TELEPORT PAGE
-- ============================================================
makeAction(teleportPage, "🏠 Teleport ke Spawn (0, 5, 0)", C.btnBlue, function()
    local c = lp.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0); notify("Teleported ke Spawn")
    end
end, 1)

local coordWrap = Instance.new("Frame", teleportPage)
coordWrap.Size = UDim2.new(1,0,0,108); coordWrap.BackgroundColor3 = C.rowAlt
coordWrap.BorderSizePixel = 0; coordWrap.LayoutOrder = 2; coordWrap.ZIndex = 13
Instance.new("UICorner", coordWrap).CornerRadius = UDim.new(0,6)

local cTitle = Instance.new("TextLabel", coordWrap)
cTitle.Size = UDim2.new(1,-12,0,26); cTitle.Position = UDim2.new(0,12,0,4)
cTitle.BackgroundTransparency = 1; cTitle.Text = "📌 Teleport ke Koordinat Custom"
cTitle.TextColor3 = C.text; cTitle.TextSize = 11; cTitle.Font = Enum.Font.GothamBold
cTitle.TextXAlignment = Enum.TextXAlignment.Left; cTitle.ZIndex = 14

local cRow = Instance.new("Frame", coordWrap)
cRow.Size = UDim2.new(1,-12,0,28); cRow.Position = UDim2.new(0,6,0,34)
cRow.BackgroundTransparency = 1; cRow.ZIndex = 14

local function mkCI(par, ph, xS)
    local b = Instance.new("TextBox", par)
    b.Size = UDim2.new(0.3,-4,1,0); b.Position = UDim2.new(xS,2,0,0)
    b.BackgroundColor3 = C.inputBg; b.BorderSizePixel = 0
    b.PlaceholderText = ph; b.PlaceholderColor3 = C.textDim; b.Text = "0"
    b.TextColor3 = C.accent; b.TextSize = 11; b.Font = Enum.Font.GothamBold
    b.ClearTextOnFocus = false; b.TextXAlignment = Enum.TextXAlignment.Center; b.ZIndex = 15
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
    local _s = Instance.new("UIStroke", b); _s.Color = Color3.fromRGB(0,80,130); _s.Thickness = 1
    return b
end
local xInp = mkCI(cRow,"X",0); local yInp = mkCI(cRow,"Y",0.333); local zInp = mkCI(cRow,"Z",0.666)
yInp.Text = "5"

local cBtn = Instance.new("TextButton", coordWrap)
cBtn.Size = UDim2.new(1,-12,0,28); cBtn.Position = UDim2.new(0,6,0,68)
cBtn.BackgroundColor3 = C.btnBlue; cBtn.Text = "Teleport ke Koordinat"
cBtn.TextColor3 = C.text; cBtn.TextSize = 11; cBtn.Font = Enum.Font.GothamBold
cBtn.BorderSizePixel = 0; cBtn.ZIndex = 14
Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0,5)
cBtn.MouseButton1Click:Connect(function()
    local x,y,z = tonumber(xInp.Text) or 0, tonumber(yInp.Text) or 5, tonumber(zInp.Text) or 0
    local c = lp.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
        notify(string.format("TP → X:%.0f Y:%.0f Z:%.0f",x,y,z))
    end
end)

-- ============================================================
-- BUILD PLAYERS PAGE
-- ============================================================
playersPage.AutomaticSize = Enum.AutomaticSize.None
playersPage.Size = UDim2.new(1,0,0,220)

local plScroll = Instance.new("ScrollingFrame", playersPage)
plScroll.Size = UDim2.new(1,0,1,0); plScroll.BackgroundTransparency = 1
plScroll.ScrollingDirection = Enum.ScrollingDirection.Y
plScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
plScroll.ScrollBarThickness = 3; plScroll.ScrollBarImageColor3 = C.accent
plScroll.BorderSizePixel = 0; plScroll.ZIndex = 12
local plLay = Instance.new("UIListLayout", plScroll)
plLay.SortOrder = Enum.SortOrder.LayoutOrder; plLay.Padding = UDim.new(0,4)
local plPad = Instance.new("UIPadding", plScroll)
plPad.PaddingTop = UDim.new(0,4); plPad.PaddingBottom = UDim.new(0,6)
plPad.PaddingLeft = UDim.new(0,4); plPad.PaddingRight = UDim.new(0,6)

local function refreshPlayers()
    for _, ch in ipairs(plScroll:GetChildren()) do
        if ch:IsA("Frame") then ch:Destroy() end
    end
    local others, order = {}, 1
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp then table.insert(others, p) end
    end
    if #others == 0 then
        local ef = Instance.new("Frame", plScroll)
        ef.Size = UDim2.new(1,0,0,60); ef.BackgroundColor3 = C.rowAlt
        ef.BorderSizePixel = 0; ef.LayoutOrder = 1; ef.ZIndex = 13
        Instance.new("UICorner", ef).CornerRadius = UDim.new(0,6)
        local el = Instance.new("TextLabel", ef)
        el.Size = UDim2.new(1,0,1,0); el.BackgroundTransparency = 1
        el.Text = "Tidak ada player lain di server"; el.TextColor3 = C.textDim
        el.TextSize = 11; el.Font = Enum.Font.Gotham; el.ZIndex = 14
        return
    end
    for _, tp in ipairs(others) do
        local row = Instance.new("Frame", plScroll)
        row.Size = UDim2.new(1,0,0,70); row.BackgroundColor3 = C.rowAlt
        row.BorderSizePixel = 0; row.LayoutOrder = order; row.ZIndex = 13
        Instance.new("UICorner", row).CornerRadius = UDim.new(0,6)
        local rs = Instance.new("UIStroke", row); rs.Color = C.divider; rs.Thickness = 1

        local av = Instance.new("Frame", row)
        av.Size = UDim2.new(0,30,0,30); av.Position = UDim2.new(0,8,0,6)
        av.BackgroundColor3 = Color3.fromRGB(0,60,100); av.BorderSizePixel = 0; av.ZIndex = 14
        Instance.new("UICorner", av).CornerRadius = UDim.new(1,0)
        local avL = Instance.new("TextLabel", av)
        avL.Size = UDim2.new(1,0,1,0); avL.BackgroundTransparency = 1
        avL.Text = string.upper(string.sub(tp.Name,1,1))
        avL.TextColor3 = C.accent; avL.TextSize = 13; avL.Font = Enum.Font.GothamBold; avL.ZIndex = 15

        local nl = Instance.new("TextLabel", row)
        nl.Size = UDim2.new(1,-50,0,18); nl.Position = UDim2.new(0,46,0,6)
        nl.BackgroundTransparency = 1; nl.Text = tp.Name; nl.TextColor3 = C.text
        nl.TextSize = 11; nl.Font = Enum.Font.GothamBold; nl.TextXAlignment = Enum.TextXAlignment.Left; nl.ZIndex = 14

        local dl = Instance.new("TextLabel", row)
        dl.Size = UDim2.new(1,-50,0,14); dl.Position = UDim2.new(0,46,0,24)
        dl.BackgroundTransparency = 1; dl.Text = "@"..tp.DisplayName; dl.TextColor3 = C.textDim
        dl.TextSize = 9; dl.Font = Enum.Font.Gotham; dl.TextXAlignment = Enum.TextXAlignment.Left; dl.ZIndex = 14

        local bf = Instance.new("Frame", row)
        bf.Size = UDim2.new(1,-12,0,24); bf.Position = UDim2.new(0,6,0,42)
        bf.BackgroundTransparency = 1; bf.ZIndex = 14
        local bfl = Instance.new("UIListLayout", bf)
        bfl.FillDirection = Enum.FillDirection.Horizontal; bfl.Padding = UDim.new(0,4)

        local tpBtn = Instance.new("TextButton", bf)
        tpBtn.Size = UDim2.new(0.5,-4,1,0); tpBtn.BackgroundColor3 = Color3.fromRGB(0,100,180)
        tpBtn.Text = "TELEPORT"; tpBtn.TextColor3 = Color3.fromRGB(230,240,255)
        tpBtn.TextSize = 9; tpBtn.Font = Enum.Font.GothamBold
        tpBtn.BorderSizePixel = 0; tpBtn.ZIndex = 15
        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,4)
        tpBtn.MouseButton1Click:Connect(function() teleportToPlayer(tp) end)

        local atpF = Instance.new("Frame", bf)
        atpF.Size = UDim2.new(0.5,-4,1,0); atpF.BackgroundTransparency = 1; atpF.ZIndex = 14

        local atpL = Instance.new("TextLabel", atpF)
        atpL.Size = UDim2.new(0.55,0,1,0); atpL.BackgroundTransparency = 1; atpL.Text = "AUTO TP"
        atpL.TextColor3 = C.text; atpL.TextSize = 9; atpL.Font = Enum.Font.GothamBold
        atpL.TextXAlignment = Enum.TextXAlignment.Left; atpL.ZIndex = 15

        local atpTrack = Instance.new("Frame", atpF)
        atpTrack.Size = UDim2.new(0,40,0,22); atpTrack.Position = UDim2.new(1,-40,0.5,-11)
        atpTrack.BackgroundColor3 = (autoTpActive and autoTpTarget==tp) and C.togOn or C.togOff
        atpTrack.BorderSizePixel = 0; atpTrack.ZIndex = 15
        Instance.new("UICorner", atpTrack).CornerRadius = UDim.new(1,0)

        local atpKnob = Instance.new("Frame", atpTrack)
        atpKnob.Size = UDim2.new(0,16,0,16)
        atpKnob.Position = (autoTpActive and autoTpTarget==tp) and UDim2.new(0,21,0.5,-8) or UDim2.new(0,3,0.5,-8)
        atpKnob.BackgroundColor3 = Color3.fromRGB(180,200,220)
        atpKnob.BorderSizePixel = 0; atpKnob.ZIndex = 16
        Instance.new("UICorner", atpKnob).CornerRadius = UDim.new(1,0)

        local atpClk = Instance.new("TextButton", atpTrack)
        atpClk.Size = UDim2.new(1,0,1,0); atpClk.BackgroundTransparency = 1
        atpClk.Text = ""; atpClk.ZIndex = 17
        atpClk.MouseButton1Click:Connect(function()
            if autoTpActive and autoTpTarget == tp then
                stopAutoTp()
                TweenService:Create(atpTrack,TweenInfo.new(0.15),{BackgroundColor3=C.togOff}):Play()
                TweenService:Create(atpKnob,TweenInfo.new(0.15),{Position=UDim2.new(0,3,0.5,-8)}):Play()
            else
                startAutoTp(tp)
                TweenService:Create(atpTrack,TweenInfo.new(0.15),{BackgroundColor3=C.togOn}):Play()
                TweenService:Create(atpKnob,TweenInfo.new(0.15),{Position=UDim2.new(0,21,0.5,-8)}):Play()
            end
        end)
        order = order + 1
    end
end

-- ============================================================
-- TAB SYSTEM
-- ============================================================
local tabs = {
    {name="Main",     icon="⚡", page=mainPage,     order=1},
    {name="Players",  icon="👥", page=playersPage,  order=2},
    {name="Teleport", icon="📍", page=teleportPage, order=3},
}

local function switchTab(idx)
    for i, td in ipairs(tabs) do
        td.page.Visible = (i == idx)
        if tabSetters[i] then tabSetters[i](i == idx) end
    end
    contentHeader.Text = tabs[idx].name
    if idx == 2 then refreshPlayers() end
    scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
end

for i, td in ipairs(tabs) do
    local btn, setter = makeSideTab(td.name, td.icon, td.order)
    tabSetters[i] = setter
    local ci = i
    btn.MouseButton1Click:Connect(function() switchTab(ci) end)
end
switchTab(1)

-- ============================================================
-- MINIMIZE / RESTORE
-- ============================================================
local isMinimized = false
local function toggleMin()
    isMinimized = not isMinimized
    mainFrame.Visible = not isMinimized
    iconBtn.Visible   = isMinimized
end
minimizeBtn.MouseButton1Click:Connect(toggleMin)
iconBtn.MouseButton1Click:Connect(function()
    if not iconBtn:GetAttribute("wasDragged") then toggleMin() end
    iconBtn:SetAttribute("wasDragged", false)
end)

-- ============================================================
-- DRAG SYSTEM
-- ============================================================
do
    local drag, dragStart, frameStart
    topBar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            local rx = i.Position.X - topBar.AbsolutePosition.X
            if rx > topBar.AbsoluteSize.X - 50 then return end
            drag = true; dragStart = UIS:GetMouseLocation()
            frameStart = Vector2.new(mainFrame.Position.X.Offset, mainFrame.Position.Y.Offset)
        end
    end)
    topBar.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local mp = UIS:GetMouseLocation(); local d = mp - dragStart
            local vs = workspace.CurrentCamera.ViewportSize
            mainFrame.Position = UDim2.new(0,
                math.clamp(frameStart.X+d.X, 0, vs.X-mainFrame.AbsoluteSize.X), 0,
                math.clamp(frameStart.Y+d.Y, 0, vs.Y-mainFrame.AbsoluteSize.Y))
        end
    end)
end

do
    local drag, ds, is, moved = false, nil, nil, 0
    iconBtn.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag=true; moved=0; ds=UIS:GetMouseLocation()
            is=Vector2.new(iconBtn.Position.X.Offset, iconBtn.Position.Y.Offset)
        end
    end)
    iconBtn.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag=false; iconBtn:SetAttribute("wasDragged", moved > 5) end end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local mp = UIS:GetMouseLocation(); local d = mp - ds; moved = moved + d.Magnitude
            local vs = workspace.CurrentCamera.ViewportSize
            iconBtn.Position = UDim2.new(0,
                math.clamp(is.X+d.X, 0, vs.X-iconBtn.AbsoluteSize.X), 0,
                math.clamp(is.Y+d.Y, 0, vs.Y-iconBtn.AbsoluteSize.Y))
        end
    end)
end

-- ============================================================
-- KEYBOARD SHORTCUTS
-- ============================================================
UIS.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.F then
        toggleFly(); setFlyUI(isFlying)
    elseif i.KeyCode == Enum.KeyCode.J then
        toggleInfJump()
    elseif i.KeyCode == Enum.KeyCode.L then
        toggleAntiLag()
    elseif i.KeyCode == Enum.KeyCode.K then
        toggleAntiAfk()
    end
end)

-- ============================================================
-- PLAYER EVENTS
-- ============================================================
Players.PlayerAdded:Connect(function()
    if playersPage.Visible then task.wait(0.5); refreshPlayers() end
end)
Players.PlayerRemoving:Connect(function(p)
    if playersPage.Visible then refreshPlayers() end
    if autoTpActive and autoTpTarget == p then stopAutoTp() end
end)

-- ============================================================
-- DONE
-- ============================================================
print("[FINISH] Fishing Panel v1.0 Siap!")
notify("🎣 Fishing Panel v1.0  [F=Fly | J=Jump | L=AntiLag | K=AntiAFK]", 5)
