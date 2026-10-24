return(function(RgYjH, ...)
local Vjvwji = {"We1rxSQR";"slrSU7TVHFKco9";"FB5S33";"40s";"eSh";"KdXPRDJom";"J32GH1me4P2duV5"}
local 4SLp3Z1K = function(...)
--!nonstrict

if not game:IsLoaded() then game.Loaded:Wait() end
setfenv(1, setmetatable({}, { __index = getfenv(1) }))
do
    local P = game:GetService(loadstring(base64decode("UGxheWVycw=="))())
    while not P.LocalPlayer do task.wait() end
end

if _G.AutoParrySystem and _G.AutoParrySystem.Unload then
    pcall(_G.AutoParrySystem.Unload)
end
_G.AutoParrySystem = {}

-- SERVICES
local Players          = game:GetService(loadstring(base64decode("UGxheWVycw=="))())
local RunService       = game:GetService(loadstring(base64decode("UnVuU2VydmljZQ=="))())
local UserInputService = game:GetService(loadstring(base64decode("VXNlcklucHV0U2VydmljZQ=="))())
local TweenService     = game:GetService(loadstring(base64decode("VHdlZW5TZXJ2aWNl"))())
local HttpService      = game:GetService(loadstring(base64decode("SHR0cFNlcnZpY2U="))())
local Stats            = game:GetService(loadstring(base64decode("U3RhdHM="))())
local ReplicatedStorage = game:GetService(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2U="))())

local okVIM, VirtualInputManager = pcall(function() return game:GetService(loadstring(base64decode("VmlydHVhbElucHV0TWFuYWdlcg=="))()) end)
if not okVIM then VirtualInputManager = nil end

local LocalPlayer = Players.LocalPlayer

local CanSaveFiles = (type(writefile) == loadstring(base64decode("ZnVuY3Rpb24="))() and type(readfile) == loadstring(base64decode("ZnVuY3Rpb24="))() and type(isfile) == loadstring(base64decode("ZnVuY3Rpb24="))())
local SaveFileName = loadstring(base64decode("QXV0b1BhcnJ5X1NraWxscy5qc29u"))()

-- THEME (kar teması)
local Theme = {
    Background = Color3.fromRGB(17, 24, 36),
    Sidebar    = Color3.fromRGB(12, 18, 29),
    Panel      = Color3.fromRGB(23, 33, 48),
    Card       = Color3.fromRGB(31, 43, 61),
    Raised     = Color3.fromRGB(46, 62, 84),
    Stroke     = Color3.fromRGB(62, 82, 108),
    Accent     = Color3.fromRGB(84, 178, 245),   -- buz mavisi
    Good       = Color3.fromRGB(110, 224, 180),
    Bad        = Color3.fromRGB(244, 113, 113),
    Warn       = Color3.fromRGB(250, 214, 90),
    Purple     = Color3.fromRGB(190, 170, 250),
    Muted      = Color3.fromRGB(105, 122, 145),
    Text       = Color3.fromRGB(242, 248, 255),
    SubText    = Color3.fromRGB(150, 172, 198),
}

local KindColor = { Anim = Theme.Accent, Skill = Theme.Warn, Object = Theme.Purple }

type SkillType = loadstring(base64decode("U2tpbGw="))() | loadstring(base64decode("QW5pbQ=="))() | loadstring(base64decode("T2JqZWN0"))()

type Skill = {
    Id: string, Name: string, Type: SkillType,
    AnimId: string, Key: string, ObjName: string, ObjParent: string,
    Enabled: boolean, Dist: number, Delay: number, Hold: boolean, Dur: number,
}

type Source = {
    Key: any, Name: string, Id: string, IsPlayer: boolean, Friend: boolean,
    GetChar: () -> Model?, Snap: Model?,
    SkillSerial: number?, LastSkillKey: string?, LastSkillT: number?, MonSkill: string?,
}

type RadarOpts = {
    Name: string, Life: number,
    Part: () -> BasePart?, Dist: (Vector3) -> number?, Alive: () -> boolean,
    Rate: (() -> number)?, Active: (() -> boolean)?,
}
-- LOCALIZATION: anahtar = İngilizce metin. Create() her metni otomatik çevirir.

local L = {
    Lang = loadstring(base64decode("RW5nbGlzaA=="))(),
    Langs = { loadstring(base64decode("RW5nbGlzaA=="))(), loadstring(base64decode("VMO8cmvDp2U="))(), loadstring(base64decode("RGV1dHNjaA=="))(), loadstring(base64decode("RnJhbsOnYWlz"))() },
    Dict = {},
    Reg = setmetatable({}, { __mode = loadstring(base64decode("aw=="))() }),
}

function L.T(s)
    if L.Lang == loadstring(base64decode("RW5nbGlzaA=="))() or type(s) ~= loadstring(base64decode("c3RyaW5n"))() or s == loadstring(base64decode(""))() then return s end
    local d = L.Dict[L.Lang]
    if not d then return s end
    local hit = d[s]
    if hit then return hit end
    -- loadstring(base64decode("w5ZuZWs6IGRlxJ9lcg=="))() biçimi
    local pre, rest = s:match(loadstring(base64decode("XiguLTogKSguKikk"))())
    if pre and d[pre] then return d[pre] .. rest end
    -- sayı içeren metinler: sayılar %d ile değiştirilip şablon aranır
    local nums = {}
    local norm = s:gsub(loadstring(base64decode("JS0/JWQrJS4/JWQq"))(), function(n) nums[#nums + 1] = n return loadstring(base64decode("JWQ="))() end)
    if #nums > 0 and d[norm] then
        local ok, out = pcall(string.format, d[norm], table.unpack(nums))
        if ok then return out end
    end
    return s
end

function L.Track(inst)
    if inst:IsA(loadstring(base64decode("VGV4dExhYmVs"))()) or inst:IsA(loadstring(base64decode("VGV4dEJ1dHRvbg=="))()) then
        local t = inst.Text
        if t ~= loadstring(base64decode(""))() then
            local tr = L.T(t)
            L.Reg[inst] = { Text = t, Applied = tr }
            if tr ~= t then inst.Text = tr end
        end
    elseif inst:IsA(loadstring(base64decode("VGV4dEJveA=="))()) then
        local p = inst.PlaceholderText
        if p ~= loadstring(base64decode(""))() then
            L.Reg[inst] = { Ph = p }
            local tr = L.T(p)
            if tr ~= p then inst.PlaceholderText = tr end
        end
    end
end

-- Kod tarafından değiştirilen metinler için (Pause/Resume vb.)
function L.Set(inst, text)
    local tr = L.T(text)
    L.Reg[inst] = { Text = text, Applied = tr }
    inst.Text = tr
end

function L.Apply()
    for inst, r in pairs(L.Reg) do
        if inst.Parent then
            if r.Text and inst.Text == r.Applied then
                local tr = L.T(r.Text)
                r.Applied = tr
                inst.Text = tr
            elseif r.Ph then
                inst.PlaceholderText = L.T(r.Ph)
            end
        end
    end
end


-- UTILITIES

local function Create(className: string, props: { [string]: any }): any
    local inst: any = Instance.new(className)
    for GgfRx2bY, v in props do
        if GgfRx2bY ~= loadstring(base64decode("UGFyZW50"))() then inst[GgfRx2bY] = v end
    end
    L.Track(inst)
    inst.Parent = props.Parent -- en son: tek seferde replikasyon/layout
    return inst
end

local function Corner(inst, r)
    return Create(loadstring(base64decode("VUlDb3JuZXI="))(), { CornerRadius = UDim.new(0, r or 6), Parent = inst })
end

local function Stroke(inst, color, thickness)
    return Create(loadstring(base64decode("VUlTdHJva2U="))(), {
        Color = color or Theme.Stroke, Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = inst,
    })
end

local function Tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Aynı parent içindeki helper'larla oluşturulan elemanlara otomatik LayoutOrder verir
local function Order(inst, parent)
    local n = (parent:GetAttribute(loadstring(base64decode("X24="))()) or 0) + 1
    parent:SetAttribute(loadstring(base64decode("X24="))(), n)
    inst.LayoutOrder = n
end

local function Trim(s)
    return ((s or loadstring(base64decode(""))()):match(loadstring(base64decode("XiVzKiguLSklcyok"))()))
end

local function GetGuiParent()
    local ok, hui = pcall(function() return gethui() end)
    if ok and hui then return hui end
    return LocalPlayer:WaitForChild(loadstring(base64decode("UGxheWVyR3Vp"))())
end

local function NormalizeAnimId(id)
    if typeof(id) ~= loadstring(base64decode("c3RyaW5n"))() then id = tostring(id) end
    local digits = id:match(loadstring(base64decode("JWQr"))())
    if digits then return loadstring(base64decode("cmJ4YXNzZXRpZDovLw=="))() .. digits end
    return id
end

local function GetAnimator(character)
    if not character then return nil end
    local controller = character:WaitForChild(loadstring(base64decode("SHVtYW5vaWQ="))(), 5) or character:FindFirstChildOfClass(loadstring(base64decode("QW5pbWF0aW9uQ29udHJvbGxlcg=="))())
    if not controller then return nil end
    return controller:FindFirstChildOfClass(loadstring(base64decode("QW5pbWF0b3I="))()) or controller:WaitForChild(loadstring(base64decode("QW5pbWF0b3I="))(), 3)
end

local function GenerateId()
    local ok, guid = pcall(function() return HttpService:GenerateGUID(false) end)
    if ok then return guid end
    return tostring(os.clock()) .. loadstring(base64decode("Xw=="))() .. tostring(math.random(1, 999999))
end

local function ClearChildren(container)
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA(loadstring(base64decode("R3VpT2JqZWN0"))()) then child:Destroy() end
    end
end

local function DisconnectAll(list)
    if not list then return end
    for _, c in ipairs(list) do pcall(function() c:Disconnect() end) end
end

local function TrackAnimId(track)
    local ok, raw = pcall(function() return track.Animation.AnimationId end)
    if not ok or not raw or raw == loadstring(base64decode(""))() then return nil end
    return NormalizeAnimId(raw)
end

local function TrackAnimName(track)
    local ok, name = pcall(function()
        local n = track.Animation.Name
        if n and n ~= loadstring(base64decode(""))() and n ~= loadstring(base64decode("QW5pbWF0aW9u"))() then return n end
        return track.Name
    end)
    if ok and name and name ~= loadstring(base64decode(""))() then return name end
    return loadstring(base64decode("VW5rbm93bg=="))()
end

local function IsAlive(char)
    local hum = char and char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    return hum ~= nil and hum.Health > 0
end

local function ModelPos(inst)
    if not inst then return nil end
    if inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then return inst.Position end
    if inst:IsA(loadstring(base64decode("TW9kZWw="))()) then
        local ok, cf = pcall(function() return inst:GetPivot() end)
        if ok then return cf.Position end
    end
    return nil
end

local function ValueToKey(v)
    if v == nil then return loadstring(base64decode(""))() end
    if type(v) == loadstring(base64decode("c3RyaW5n"))() then return v end
    if typeof(v) == loadstring(base64decode("SW5zdGFuY2U="))() then return v.Name end
    return tostring(v)
end

-- Sadece sürükleme sırasında bağlantı açar (sıhDmnWKlxıntı yok)
local function TrackDrag(onMove, onEnd)
    local moveConn, endConn
    moveConn = UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
            onMove(i)
        end
    end)
    endConn = UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            moveConn:Disconnect()
            endConn:Disconnect()
            if onEnd then onEnd() end
        end
    end)
end

-- Yarım ping (saniye): sunucu gidiş süresi tahmini
local function GetPing()
    local ok, ms = pcall(function() return Stats.Network.ServerStatsItem[loadstring(base64decode("RGF0YSBQaW5n"))()]:GetValue() end)
    if ok and type(ms) == loadstring(base64decode("bnVtYmVy"))() then return math.clamp(ms / 2000, 0, 0.3) end
    local ok2, s = pcall(function() return LocalPlayer:GetNetworkPing() end)
    if ok2 and type(s) == loadstring(base64decode("bnVtYmVy"))() then return math.clamp(s / 2, 0, 0.3) end
    return 0
end


-- CONFIG + SAVED DATA

local Config = {
    AutoExecute      = true,
    AutoParryEnabled = false,
    PingComp         = false,
    IgnoreFriends    = false,
    IncludeNpcs      = false,
    Ignored          = loadstring(base64decode(""))(),
    SkillValueName   = loadstring(base64decode("Q3VycmVudFNraWxs"))(),
    UIKeybind        = Enum.KeyCode.RightControl,
    ParryKey         = Enum.KeyCode.F,
    ToggleKey        = Enum.KeyCode.Home,
    Outfit           = loadstring(base64decode(""))(),
    OutfitBroken     = false,
    OutfitReapply    = true,
    OutfitActive     = false,
    HideArmor        = true,    -- üstteki mevcut armoru/GgfRx2bYıyafeti gizle (client-side)
    DebugVis         = false,   -- hitbox / parry sebebi görselleştirme
    ClothingUI       = false,   -- Misc > Clothing paneli açıGgfRx2bY mı
    OutfitX          = 0,
    OutfitY          = 0,
    OutfitZ          = 0,
    OutfitOffsets    = {},   -- [GgfRx2bYıyafet adı] = {UTZeUWBZ, 7GzvlMab, hDmnWKlx, limbX, limbY, limbZ}
    LimbX            = 0,
    LimbY            = 0,
    LimbZ            = 0,
    Language         = loadstring(base64decode("RW5nbGlzaA=="))(),
    UIScale          = 1,
    Snow             = true,
    DeclinedDefault  = loadstring(base64decode(""))(),
}

-- Tune: parry kararı ayarları
-- Varsayılan skill listesi aşağıda DEFAULT_JSON içinde (Initialization bölümü)
local Defaults = {
    Dist = 15, Delay = 0.05, Dur = 1,
    Tune = { TAP_HOLD = 0.3 },
}
local LEARN_LEAD = 0.12   -- loadstring(base64decode("VXNlIGxlYXJuZWQgdGltaW5n"))(): vuruştan bu kadar önce bas
local MAX_OBJECT_ENTRIES = 300
Defaults.Tune.TAP_HOLD   = 0.3
local PARRY_POLL_RANGE = 250   -- NPC animasyon taraması için azami mesafe (stud)

local function ReadSaveFile()
    if not CanSaveFiles then return nil end
    local ok, exists = pcall(function() return isfile(SaveFileName) end)
    if not ok or not exists then return nil end
    local ok2, content = pcall(function() return readfile(SaveFileName) end)
    if not ok2 then return nil end
    local ok3, decoded = pcall(function() return HttpService:JSONDecode(content) end)
    if ok3 and type(decoded) == loadstring(base64decode("dGFibGU="))() then return decoded end
    return nil
end

local Saved = ReadSaveFile()
if Saved and type(Saved.Settings) == loadstring(base64decode("dGFibGU="))() then
    local s = Saved.Settings
    -- v6 öncesi kayıtlarda ping comp / ignore friends / RightAlt varsayılan olarak açıktı
    -- ve zamanlamayı bozuyordu: bu üç ayar eski kayıttan 7GzvlMabüklenmez.
    local fresh = (tonumber(Saved.Version) or 0) >= 6
    for _, GgfRx2bY in ipairs({ loadstring(base64decode("UGluZ0NvbXA="))(), loadstring(base64decode("SWdub3JlRnJpZW5kcw=="))(), loadstring(base64decode("SW5jbHVkZU5wY3M="))() }) do
        if type(s[GgfRx2bY]) == loadstring(base64decode("Ym9vbGVhbg=="))() and (fresh or GgfRx2bY == loadstring(base64decode("SW5jbHVkZU5wY3M="))()) then Config[GgfRx2bY] = s[GgfRx2bY] end
    end
    if type(s.Ignored) == loadstring(base64decode("c3RyaW5n"))() then Config.Ignored = s.Ignored end
    if type(s.Language) == loadstring(base64decode("c3RyaW5n"))() then
        for _, nm in ipairs(L.Langs) do if nm == s.Language then Config.Language = nm end end
    end
    if type(s.UIScale) == loadstring(base64decode("bnVtYmVy"))() then Config.UIScale = math.clamp(s.UIScale, 0.6, 1.3) end
    if type(s.Snow) == loadstring(base64decode("Ym9vbGVhbg=="))() then Config.Snow = s.Snow end
    if type(s.AutoExecute) == loadstring(base64decode("Ym9vbGVhbg=="))() then Config.AutoExecute = s.AutoExecute end
    if type(s.DeclinedDefault) == loadstring(base64decode("c3RyaW5n"))() then Config.DeclinedDefault = s.DeclinedDefault end
    if type(s.Outfit) == loadstring(base64decode("c3RyaW5n"))() then Config.Outfit = s.Outfit end
    for _, GgfRx2bY in ipairs({ loadstring(base64decode("T3V0Zml0QnJva2Vu"))(), loadstring(base64decode("T3V0Zml0UmVhcHBseQ=="))(), loadstring(base64decode("T3V0Zml0QWN0aXZl"))(), loadstring(base64decode("SGlkZUFybW9y"))(), loadstring(base64decode("RGVidWdWaXM="))() }) do
        if type(s[GgfRx2bY]) == loadstring(base64decode("Ym9vbGVhbg=="))() then Config[GgfRx2bY] = s[GgfRx2bY] end
    end
    for _, GgfRx2bY in ipairs({ loadstring(base64decode("T3V0Zml0WA=="))(), loadstring(base64decode("T3V0Zml0WQ=="))(), loadstring(base64decode("T3V0Zml0Wg=="))() }) do
        if type(s[GgfRx2bY]) == loadstring(base64decode("bnVtYmVy"))() then Config[GgfRx2bY] = math.clamp(s[GgfRx2bY], -5, 5) end
    end
    if type(s.OutfitOffsets) == loadstring(base64decode("dGFibGU="))() then
        for nm, v in pairs(s.OutfitOffsets) do
            if type(nm) == loadstring(base64decode("c3RyaW5n"))() and type(v) == loadstring(base64decode("dGFibGU="))() then
                Config.OutfitOffsets[nm] = {
                    math.clamp(tonumber(v[1]) or 0, -5, 5),
                    math.clamp(tonumber(v[2]) or 0, -5, 5),
                    math.clamp(tonumber(v[3]) or 0, -5, 5),
                    math.clamp(tonumber(v[4]) or tonumber(v[1]) or 0, -5, 5),
                    math.clamp(tonumber(v[5]) or tonumber(v[2]) or 0, -5, 5),
                    math.clamp(tonumber(v[6]) or tonumber(v[3]) or 0, -5, 5),
                }
            end
        end
    end
    if type(s.ClothingUI) == loadstring(base64decode("Ym9vbGVhbg=="))() then Config.ClothingUI = s.ClothingUI
    else Config.ClothingUI = Config.OutfitActive end
    if type(s.SkillValueName) == loadstring(base64decode("c3RyaW5n"))() and Trim(s.SkillValueName) ~= loadstring(base64decode(""))() then
        Config.SkillValueName = Trim(s.SkillValueName)
    end
    for _, GgfRx2bY in ipairs({ loadstring(base64decode("VUlLZXliaW5k"))(), loadstring(base64decode("UGFycnlLZXk="))(), loadstring(base64decode("VG9nZ2xlS2V5"))() }) do
        pcall(function()
            local kc = (fresh or GgfRx2bY ~= loadstring(base64decode("VG9nZ2xlS2V5"))()) and s[GgfRx2bY] and Enum.KeyCode[s[GgfRx2bY]]
            if kc then Config[GgfRx2bY] = kc end
        end)
    end
end

local IgnoredSet = {}
local function RebuildIgnored()
    IgnoredSet = {}
    for name in string.gmatch(Config.Ignored, loadstring(base64decode("W14sJXNdKw=="))()) do IgnoredSet[name:lower()] = true end
end
RebuildIgnored()


-- ÇEVİRİLER  { İngilizce, Türkçe, Deutsch, Français }
-- Yeni dil eklemek için L.Langs'a ekle ve aşağıdaki satırlara bir sütun daha yaz.

L.Lang = Config.Language
do
    local rows = {
        -- pencere / sekmeler / durum
        { loadstring(base64decode("QXV0by1QYXJyeQ=="))(), loadstring(base64decode("T3RvLVBhcnJ5"))(), loadstring(base64decode("QXV0by1QYXJyeQ=="))(), loadstring(base64decode("QXV0by1QYXJyeQ=="))() },
        { loadstring(base64decode("QW5pbWF0aW9uIE1vbml0b3I="))(), loadstring(base64decode("QW5pbWFzeW9uIMSwemxleWljaQ=="))(), loadstring(base64decode("QW5pbWF0aW9ucy1Nb25pdG9y"))(), loadstring(base64decode("TW9uaXRldXIgZCdhbmltYXRpb25z"))() },
        { loadstring(base64decode("U2tpbGxz"))(), loadstring(base64decode("WWV0ZW5la2xlcg=="))(), loadstring(base64decode("RsOkaGlna2VpdGVu"))(), loadstring(base64decode("Q29tcMOpdGVuY2Vz"))() },
        { loadstring(base64decode("TWlzYw=="))(), loadstring(base64decode("w4dlxZ9pdGxp"))(), loadstring(base64decode("U29uc3RpZ2Vz"))(), loadstring(base64decode("RGl2ZXJz"))() },
        { loadstring(base64decode("U2V0dGluZ3M="))(), loadstring(base64decode("QXlhcmxhcg=="))(), loadstring(base64decode("RWluc3RlbGx1bmdlbg=="))(), loadstring(base64decode("UGFyYW3DqHRyZXM="))() },
        { loadstring(base64decode("UmVhZHk="))(), loadstring(base64decode("SGF6xLFy"))(), loadstring(base64decode("QmVyZWl0"))(), loadstring(base64decode("UHLDqnQ="))() },
        { loadstring(base64decode("QXV0by1QYXJyeSBPTg=="))(), loadstring(base64decode("T3RvLVBhcnJ5IEHDh0lL"))(), loadstring(base64decode("QXV0by1QYXJyeSBBTg=="))(), loadstring(base64decode("QXV0by1QYXJyeSBBQ1RJRg=="))() },
        { loadstring(base64decode("QXV0by1QYXJyeSBPRkY="))(), loadstring(base64decode("T3RvLVBhcnJ5IEtBUEFMSQ=="))(), loadstring(base64decode("QXV0by1QYXJyeSBBVVM="))(), loadstring(base64decode("QXV0by1QYXJyeSBJTkFDVElG"))() },
        -- bölüm başlıkları
        { loadstring(base64decode("Q09OVFJPTA=="))(), loadstring(base64decode("S09OVFJPTA=="))(), loadstring(base64decode("U1RFVUVSVU5H"))(), loadstring(base64decode("Q09OVFLDlExF"))() },
        { loadstring(base64decode("T1BUSU9OUw=="))(), loadstring(base64decode("U0XDh0VORUtMRVI="))(), loadstring(base64decode("T1BUSU9ORU4="))(), loadstring(base64decode("T1BUSU9OUw=="))() },
        { loadstring(base64decode("QXV0byBleGVjdXRl"))(), loadstring(base64decode("T3RvbWF0aWsgw6dhbMSxxZ90xLFy"))(), loadstring(base64decode("QXV0by1BdXNmw7xocnVuZw=="))(), loadstring(base64decode("RXjDqWN1dGlvbiBhdXRv"))() },
        { loadstring(base64decode("UmUtcnVucyB0aGUgc2NyaXB0IGF1dG9tYXRpY2FsbHkgd2hlbiB5b3Ugam9pbiBhbm90aGVyIHNlcnZlciBvciB0ZWxlcG9ydC4="))(), loadstring(base64decode("QmHFn2thIHN1bnVjdXlhIGdlw6dpbmNlIHZleWEgxLHFn8SxbmxhbsSxbmNhIHNjcmlwdGkgb3RvbWF0aWsgdGVrcmFyIMOnYWzEscWfdMSxcsSxci4="))(), loadstring(base64decode("RsO8aHJ0IGRhcyBTY3JpcHQgYmVpbSBTZXJ2ZXJ3ZWNoc2VsIG9kZXIgVGVsZXBvcnQgYXV0b21hdGlzY2ggZXJuZXV0IGF1cy4="))(), loadstring(base64decode("UmVsYW5jZSBsZSBzY3JpcHQgYXV0b21hdGlxdWVtZW50IGxvcnMgZCd1biBjaGFuZ2VtZW50IGRlIHNlcnZldXIgb3UgZCd1bmUgdMOpbMOpcG9ydGF0aW9uLg=="))() },
        { loadstring(base64decode("Q0xPVEhJTkc="))(), loadstring(base64decode("S0lZQUZFVA=="))(), loadstring(base64decode("S0xFSURVTkc="))(), loadstring(base64decode("VsOKVEVNRU5UUw=="))() },
        { loadstring(base64decode("UE9TSVRJT04gQURKVVNU"))(), loadstring(base64decode("S09OVU0gQVlBUkk="))(), loadstring(base64decode("UE9TSVRJT04gQU5QQVNTRU4="))(), loadstring(base64decode("QUpVU1RFUiBMQSBQT1NJVElPTg=="))() },
        { loadstring(base64decode("UFJPRklMRQ=="))(), loadstring(base64decode("UFJPRsSwTA=="))(), loadstring(base64decode("UFJPRklM"))(), loadstring(base64decode("UFJPRklM"))() },
        { loadstring(base64decode("REVURUNUSU9O"))(), loadstring(base64decode("QUxHSUxBTUE="))(), loadstring(base64decode("RVJLRU5OVU5H"))(), loadstring(base64decode("RMOJVEVDVElPTg=="))() },
        { loadstring(base64decode("S0VZQklORFM="))(), loadstring(base64decode("VFXFniBBVEFNQUxBUkk="))(), loadstring(base64decode("VEFTVEVOQkVMRUdVTkc="))(), loadstring(base64decode("UkFDQ09VUkNJUw=="))() },
        { loadstring(base64decode("SU1QT1JUIC8gRVhQT1JU"))(), loadstring(base64decode("xLDDh0UgLyBEScWeQSBBS1RBUg=="))(), loadstring(base64decode("SU1QT1JUIC8gRVhQT1JU"))(), loadstring(base64decode("SU1QT1JUIC8gRVhQT1JU"))() },
        { loadstring(base64decode("SU5URVJGQUNF"))(), loadstring(base64decode("QVJBWcOcWg=="))(), loadstring(base64decode("T0JFUkZMw4RDSEU="))(), loadstring(base64decode("SU5URVJGQUNF"))() },
        { loadstring(base64decode("TElDRU5TRQ=="))(), loadstring(base64decode("TMSwU0FOUw=="))(), loadstring(base64decode("TElaRU5a"))(), loadstring(base64decode("TElDRU5DRQ=="))() },
        -- Auto-Parry sekmesi
        { loadstring(base64decode("RW5hYmxlIEF1dG8tUGFycnk="))(), loadstring(base64decode("T3RvLVBhcnJ5J3lpIEV0a2lubGXFn3Rpcg=="))(), loadstring(base64decode("QXV0by1QYXJyeSBha3RpdmllcmVu"))(), loadstring(base64decode("QWN0aXZlciBsJ0F1dG8tUGFycnk="))() },
        { loadstring(base64decode("UHJlc3NlcyB0aGUgcGFycnkga2V5IHdoZW4gYSBza2lsbCwgYW5pbWF0aW9uIG9yIG9iamVjdCBpcyBkZXRlY3RlZCBpbiByYW5nZS4="))(), loadstring(base64decode("TWVuemlsZGUgYmlyIHlldGVuZWssIGFuaW1hc3lvbiB2ZXlhIG5lc25lIGFsZ8SxbGFuZMSxxJ/EsW5kYSBwYXJyeSB0dcWfdW5hIGJhc2FyLg=="))(), loadstring(base64decode("RHLDvGNrdCBkaWUgUGFycnktVGFzdGUsIHdlbm4gZWluZSBGw6RoaWdrZWl0LCBBbmltYXRpb24gb2RlciBlaW4gT2JqZWt0IGluIFJlaWNod2VpdGUgZXJrYW5udCB3aXJkLg=="))(), loadstring(base64decode("QXBwdWllIHN1ciBsYSB0b3VjaGUgZGUgcGFyYWRlIHF1YW5kIHVuZSBjb21ww6l0ZW5jZSwgYW5pbWF0aW9uIG91IHVuIG9iamV0IGVzdCBkw6l0ZWN0w6kgw6AgcG9ydMOpZS4="))() },
        { loadstring(base64decode("U291cmNlcyBob29rZWQ="))(), loadstring(base64decode("QmHEn2zEsSBrYXluYWs="))(), loadstring(base64decode("VmVyYnVuZGVuZSBRdWVsbGVu"))(), loadstring(base64decode("U291cmNlcyBsacOpZXM="))() },
        { loadstring(base64decode("QWN0aXZlIHNraWxscw=="))(), loadstring(base64decode("QWt0aWYgeWV0ZW5law=="))(), loadstring(base64decode("QWt0aXZlIFNraWxscw=="))(), loadstring(base64decode("Q29tcMOpdGVuY2VzIGFjdGl2ZXM="))() },
        { loadstring(base64decode("TGFzdCBwYXJyeQ=="))(), loadstring(base64decode("U29uIHBhcnJ5"))(), loadstring(base64decode("TGV0enRlciBQYXJyeQ=="))(), loadstring(base64decode("RGVybmnDqHJlIHBhcmFkZQ=="))() },
        { loadstring(base64decode("Tm9uZQ=="))(), loadstring(base64decode("WW9r"))(), loadstring(base64decode("S2VpbmU="))(), loadstring(base64decode("QXVjdW5l"))() },
        { loadstring(base64decode("U2hvdyBoaXRib3hlcyAvIHBhcnJ5IHJlYXNvbg=="))(), loadstring(base64decode("SGl0Ym94J2xhcsSxIC8gcGFycnkgbmVkZW5pbmkgZ8O2c3Rlcg=="))(), loadstring(base64decode("SGl0Ym94ZW4gLyBQYXJyeS1HcnVuZCBhbnplaWdlbg=="))(), loadstring(base64decode("QWZmaWNoZXIgaGl0Ym94IC8gcmFpc29uIGRlIHBhcmFkZQ=="))() },
        { loadstring(base64decode("RHJhd3MgZGV0ZWN0aW9uIHJhbmdlcyBpbiB0aGUgd29ybGQgYW5kIHNob3dzIHdoeSB0aGUgcGFycnkga2V5IHdhcyBwcmVzc2VkLg=="))(), loadstring(base64decode("QWxnxLFsYW1hIG1lbnppbGxlcmluaSBkw7xueWFkYSDDp2l6ZXIgdmUgcGFycnkgdHXFn3VuYSBuZWRlbiBiYXPEsWxkxLHEn8SxbsSxIGfDtnN0ZXJpci4="))(), loadstring(base64decode("WmVpY2huZXQgRXJrZW5udW5nc3JlaWNod2VpdGVuIGluIGRlciBXZWx0IHVuZCB6ZWlndCwgd2FydW0gZGllIFBhcnJ5LVRhc3RlIGdlZHLDvGNrdCB3dXJkZS4="))(), loadstring(base64decode("RGVzc2luZSBsZXMgcG9ydMOpZXMgZGUgZMOpdGVjdGlvbiBkYW5zIGxlIG1vbmRlIGV0IGluZGlxdWUgcG91cnF1b2kgbGEgdG91Y2hlIGEgw6l0w6kgcHJlc3PDqWUu"))() },
        { loadstring(base64decode("UGluZyBjb21wZW5zYXRpb24="))(), loadstring(base64decode("UGluZyB0ZWxhZmlzaQ=="))(), loadstring(base64decode("UGluZy1BdXNnbGVpY2g="))(), loadstring(base64decode("Q29tcGVuc2F0aW9uIGR1IHBpbmc="))() },
        { loadstring(base64decode("SWdub3JlIGZyaWVuZHM="))(), loadstring(base64decode("QXJrYWRhxZ9sYXLEsSB5b2tzYXk="))(), loadstring(base64decode("RnJldW5kZSBpZ25vcmllcmVu"))(), loadstring(base64decode("SWdub3JlciBsZXMgYW1pcw=="))() },
        { loadstring(base64decode("SW5jbHVkZSBOUENz"))(), loadstring(base64decode("TlBDJ2xlcmkgZGFoaWwgZXQ="))(), loadstring(base64decode("TlBDcyBlaW5iZXppZWhlbg=="))(), loadstring(base64decode("SW5jbHVyZSBsZXMgUE5K"))() },
        { loadstring(base64decode("QWxzbyBwYXJyaWVzIGFuaW1hdGlvbnMsIHNraWxscyBhbmQgb2JqZWN0cyBjb21pbmcgZnJvbSBOUENzLg=="))(), loadstring(base64decode("TlBDJ2xlcmRlbiBnZWxlbiBhbmltYXN5b24sIHlldGVuZWsgdmUgbmVzbmVsZXJpIGRlIHBhcnJ5J2xlci4="))(), loadstring(base64decode("UGFyaWVydCBhdWNoIEFuaW1hdGlvbmVuLCBGw6RoaWdrZWl0ZW4gdW5kIE9iamVrdGUgdm9uIE5QQ3Mu"))(), loadstring(base64decode("UGFyZSBhdXNzaSBsZXMgYW5pbWF0aW9ucywgY29tcMOpdGVuY2VzIGV0IG9iamV0cyB2ZW5hbnQgZGVzIFBOSi4="))() },
        { loadstring(base64decode("SUdOT1JFRCBQTEFZRVJTIChjb21tYSBzZXBhcmF0ZWQp"))(), loadstring(base64decode("WU9LIFNBWUlMQU4gT1lVTkNVTEFSICh2aXJnw7xsbGUgYXnEsXIp"))(), loadstring(base64decode("SUdOT1JJRVJURSBTUElFTEVSIChkdXJjaCBLb21tYSBnZXRyZW5udCk="))(), loadstring(base64decode("Sk9VRVVSUyBJR05PUsOJUyAoc8OpcGFyw6lzIHBhciBkZXMgdmlyZ3VsZXMp"))() },
        -- Animation Monitor
        { loadstring(base64decode("Tm90IHdhdGNoaW5n"))(), loadstring(base64decode("xLB6bGVubWl5b3I="))(), loadstring(base64decode("S2VpbmUgw5xiZXJ3YWNodW5n"))(), loadstring(base64decode("UGFzIGRlIHN1aXZp"))() },
        { loadstring(base64decode("V0FUQ0g="))(), loadstring(base64decode("xLBaTEU="))(), loadstring(base64decode("WklFTA=="))(), loadstring(base64decode("U1VJVkk="))() },
        { loadstring(base64decode("U09SVA=="))(), loadstring(base64decode("U0lSQUxB"))(), loadstring(base64decode("T1JETkVO"))(), loadstring(base64decode("VFJJ"))() },
        { loadstring(base64decode("VFlQRQ=="))(), loadstring(base64decode("VMOcUg=="))(), loadstring(base64decode("VFlQ"))(), loadstring(base64decode("VFlQRQ=="))() },
        { loadstring(base64decode("U2VhcmNoIGJ5IG5hbWUgb3IgSUQuLi4="))(), loadstring(base64decode("xLBzaW0gdmV5YSBJRCBpbGUgYXJhLi4u"))(), loadstring(base64decode("TmFjaCBOYW1lIG9kZXIgSUQgc3VjaGVuLi4u"))(), loadstring(base64decode("UmVjaGVyY2hlciBwYXIgbm9tIG91IElELi4u"))() },
        { loadstring(base64decode("UGF1c2U="))(), loadstring(base64decode("RHVyYWtsYXQ="))(), loadstring(base64decode("UGF1c2U="))(), loadstring(base64decode("UGF1c2U="))() },
        { loadstring(base64decode("UmVzdW1l"))(), loadstring(base64decode("RGV2YW0="))(), loadstring(base64decode("Rm9ydHNldHplbg=="))(), loadstring(base64decode("UmVwcmVuZHJl"))() },
        { loadstring(base64decode("Q2xlYXI="))(), loadstring(base64decode("VGVtaXpsZQ=="))(), loadstring(base64decode("TGVlcmVu"))(), loadstring(base64decode("RWZmYWNlcg=="))() },
        { loadstring(base64decode("UGF1c2VkIC0g"))(), loadstring(base64decode("RHVyYWtsYXTEsWxkxLEgLSA="))(), loadstring(base64decode("UGF1c2llcnQgLSA="))(), loadstring(base64decode("RW4gcGF1c2UgLSA="))() },
        { loadstring(base64decode("V2F0Y2hpbmcg"))(), loadstring(base64decode("xLB6bGVuaXlvcjog"))(), loadstring(base64decode("w5xiZXJ3YWNoZSA="))(), loadstring(base64decode("U3VpdmkgZGUg"))() },
        { loadstring(base64decode("ZXZlcnlvbmU="))(), loadstring(base64decode("aGVya2Vz"))(), loadstring(base64decode("YWxsZQ=="))(), loadstring(base64decode("dG91dCBsZSBtb25kZQ=="))() },
        { loadstring(base64decode("ZW50cnk="))(), loadstring(base64decode("a2F5xLF0"))(), loadstring(base64decode("RWludHJhZw=="))(), loadstring(base64decode("ZW50csOpZQ=="))() },
        { loadstring(base64decode("ZW50cmllcw=="))(), loadstring(base64decode("a2F5xLF0"))(), loadstring(base64decode("RWludHLDpGdl"))(), loadstring(base64decode("ZW50csOpZXM="))() },
        { loadstring(base64decode("U2V0IFdBVENIIHRvIGEgcGxheWVyLCBOUENzIG9yIEV2ZXJ5b25lIChhbmltYXRpb25zICsgc2tpbGxzKS5cbk9iamVjdHMgc3Bhd25pbmcgaW4gdGhlIHdvcmtzcGFjZSBhcmUgcmVjb3JkZWQgd2hpbGUgV0FUQ0ggaXMgb24u"))(), loadstring(base64decode("xLBaTEUneWkgYmlyIG95dW5jdXlhLCBOUEMnbGVyZSB2ZXlhIEhlcmtlcydlIGF5YXJsYSAoYW5pbWFzeW9uICsgeWV0ZW5laykuXG7EsHpsZW1lIGHDp8Sxa2tlbiB3b3Jrc3BhY2UndGUgYmVsaXJlbiBuZXNuZWxlciBkZSBrYXlkZWRpbGlyLg=="))(), loadstring(base64decode("U3RlbGxlIFpJRUwgYXVmIGVpbmVuIFNwaWVsZXIsIE5QQ3Mgb2RlciBBbGxlIChBbmltYXRpb25lbiArIFNraWxscykuXG5PYmpla3RlIGltIFdvcmtzcGFjZSB3ZXJkZW4gYXVmZ2V6ZWljaG5ldCwgc29sYW5nZSBkaWUgw5xiZXJ3YWNodW5nIGFuIGlzdC4="))(), loadstring(base64decode("UsOpZ2xleiBTVUlWSSBzdXIgdW4gam91ZXVyLCBsZXMgUE5KIG91IFRvdXMgKGFuaW1hdGlvbnMgKyBjb21ww6l0ZW5jZXMpLlxuTGVzIG9iamV0cyBhcHBhcmFpc3NhbnQgZGFucyBsZSB3b3Jrc3BhY2Ugc29udCBlbnJlZ2lzdHLDqXMgcGVuZGFudCBsZSBzdWl2aS4="))() },
        { loadstring(base64decode("V2FpdGluZyBmb3IgYWN0aXZpdHkuLi5cbk1ha2UgdGhlIHBsYXllciAvIE5QQyB1c2UgYSBza2lsbC4="))(), loadstring(base64decode("QWt0aXZpdGUgYmVrbGVuaXlvci4uLlxuT3l1bmN1IC8gTlBDJ3llIGJpciB5ZXRlbmVrIGt1bGxhbmTEsXIu"))(), loadstring(base64decode("V2FydGUgYXVmIEFrdGl2aXTDpHQuLi5cbkxhc3MgZGVuIFNwaWVsZXIgLyBOUEMgZWluZSBGw6RoaWdrZWl0IGVpbnNldHplbi4="))(), loadstring(base64decode("RW4gYXR0ZW50ZSBkJ2FjdGl2aXTDqS4uLlxuRmFpdGVzIHV0aWxpc2VyIHVuZSBjb21ww6l0ZW5jZSBhdSBqb3VldXIgLyBQTkou"))() },
        { loadstring(base64decode("Tm8gZW50cmllcyBtYXRjaCB0aGUgY3VycmVudCBmaWx0ZXIu"))(), loadstring(base64decode("RmlsdHJleWUgdXlhbiBrYXnEsXQgeW9rLg=="))(), loadstring(base64decode("S2VpbmUgRWludHLDpGdlIGVudHNwcmVjaGVuIGRlbSBGaWx0ZXIu"))(), loadstring(base64decode("QXVjdW5lIGVudHLDqWUgbmUgY29ycmVzcG9uZCBhdSBmaWx0cmUu"))() },
        { loadstring(base64decode("Tm8gYW5pbWF0aW9uIHNlbGVjdGVk"))(), loadstring(base64decode("QW5pbWFzeW9uIHNlw6dpbG1lZGk="))(), loadstring(base64decode("S2VpbmUgQW5pbWF0aW9uIGF1c2dld8OkaGx0"))(), loadstring(base64decode("QXVjdW5lIGFuaW1hdGlvbiBzw6lsZWN0aW9ubsOpZQ=="))() },
        { loadstring(base64decode("UHJlc3MgUHJldmlldyBvbiBhbiBhbmltYXRpb24="))(), loadstring(base64decode("QmlyIGFuaW1hc3lvbmRhIMOWbml6bGUneWUgYmFz"))(), loadstring(base64decode("RHLDvGNrZSBiZWkgZWluZXIgQW5pbWF0aW9uIGF1ZiBWb3JzY2hhdQ=="))(), loadstring(base64decode("QXBwdXlleiBzdXIgQXBlcsOndSBzdXIgdW5lIGFuaW1hdGlvbg=="))() },
        { loadstring(base64decode("UGxheQ=="))(), loadstring(base64decode("T3luYXQ="))(), loadstring(base64decode("QWJzcGllbGVu"))(), loadstring(base64decode("TGlyZQ=="))() },
        { loadstring(base64decode("UmVwbGF5"))(), loadstring(base64decode("VGVrcmFy"))(), loadstring(base64decode("V2llZGVyaG9sZW4="))(), loadstring(base64decode("UmVqb3Vlcg=="))() },
        { loadstring(base64decode("UHJldmlldw=="))(), loadstring(base64decode("w5ZuaXpsZQ=="))(), loadstring(base64decode("Vm9yc2NoYXU="))(), loadstring(base64decode("QXBlcsOndQ=="))() },
        { loadstring(base64decode("QWRkIFNraWxs"))(), loadstring(base64decode("WWV0ZW5layBFa2xl"))(), loadstring(base64decode("U2tpbGwgaGluenVmw7xnZW4="))(), loadstring(base64decode("QWpvdXRlcg=="))() },
        { loadstring(base64decode("RWRpdCBTa2lsbA=="))(), loadstring(base64decode("RMO8emVubGU="))(), loadstring(base64decode("QmVhcmJlaXRlbg=="))(), loadstring(base64decode("TW9kaWZpZXI="))() },
        { loadstring(base64decode("U291cmNl"))(), loadstring(base64decode("S2F5bmFr"))(), loadstring(base64decode("UXVlbGxl"))(), loadstring(base64decode("U291cmNl"))() },
        { loadstring(base64decode("cGxheWVk"))(), loadstring(base64decode("b3luYW5kxLE="))(), loadstring(base64decode("Z2VzcGllbHQ="))(), loadstring(base64decode("am91w6k="))() },
        { loadstring(base64decode("dXNlZA=="))(), loadstring(base64decode("a3VsbGFuxLFsZMSx"))(), loadstring(base64decode("YmVudXR6dA=="))(), loadstring(base64decode("dXRpbGlzw6k="))() },
        { loadstring(base64decode("c3Bhd25lZA=="))(), loadstring(base64decode("ZG/En2R1"))(), loadstring(base64decode("ZXJzY2hpZW5lbg=="))(), loadstring(base64decode("YXBwYXJ1"))() },
        { loadstring(base64decode("aGl0"))(), loadstring(base64decode("dnVydcWf"))(), loadstring(base64decode("VHJlZmZlcg=="))(), loadstring(base64decode("dG91Y2hl"))() },
        { loadstring(base64decode("c3R1ZHM="))(), loadstring(base64decode("c3R1ZA=="))(), loadstring(base64decode("U3R1ZHM="))(), loadstring(base64decode("c3R1ZHM="))() },
        { loadstring(base64decode("ZGVsYXk="))(), loadstring(base64decode("Z2VjaWttZQ=="))(), loadstring(base64decode("VmVyesO2Z2VydW5n"))(), loadstring(base64decode("ZMOpbGFp"))() },
        { loadstring(base64decode("aG9sZA=="))(), loadstring(base64decode("YmFzxLFsxLE="))(), loadstring(base64decode("SGFsdGVu"))(), loadstring(base64decode("bWFpbnRpZW4="))() },
        -- Skills sekmesi
        { loadstring(base64decode("U2VhcmNoIHNraWxscy4uLg=="))(), loadstring(base64decode("WWV0ZW5layBhcmEuLi4="))(), loadstring(base64decode("U2tpbGxzIHN1Y2hlbi4uLg=="))(), loadstring(base64decode("UmVjaGVyY2hlci4uLg=="))() },
        { loadstring(base64decode("KyBOZXcgU2tpbGw="))(), loadstring(base64decode("KyBZZW5pIFlldGVuZWs="))(), loadstring(base64decode("KyBOZXVlciBTa2lsbA=="))(), loadstring(base64decode("KyBOb3V2ZWxsZQ=="))() },
        { loadstring(base64decode("QWxsIE9u"))(), loadstring(base64decode("SGVwc2kgQcOnxLFr"))(), loadstring(base64decode("QWxsZSBhbg=="))(), loadstring(base64decode("VG91dCBhY3RpdmVy"))() },
        { loadstring(base64decode("QWxsIE9mZg=="))(), loadstring(base64decode("SGVwc2kgS2FwYWzEsQ=="))(), loadstring(base64decode("QWxsZSBhdXM="))(), loadstring(base64decode("VG91dCBkw6lzYWN0aXZlcg=="))() },
        { loadstring(base64decode("Tm8gc2tpbGxzIHlldC5cbkFkZCBvbmUgZnJvbSB0aGUgQW5pbWF0aW9uIE1vbml0b3Iu"))(), loadstring(base64decode("SGVuw7x6IHlldGVuZWsgeW9rLlxuQW5pbWFzeW9uIMSwemxleWljaSdkZW4gZWtsZS4="))(), loadstring(base64decode("Tm9jaCBrZWluZSBTa2lsbHMuXG5Gw7xnZSBlaW5lbiBpbSBBbmltYXRpb25zLU1vbml0b3IgaGluenUu"))(), loadstring(base64decode("QXVjdW5lIGNvbXDDqXRlbmNlLlxuQWpvdXRlei1lbiBkZXB1aXMgbGUgbW9uaXRldXIgZCdhbmltYXRpb25zLg=="))() },
        { loadstring(base64decode("U2VsZWN0IGEgc2tpbGwgZnJvbSB0aGUgbGlzdCB0byBlZGl0IGl0Lg=="))(), loadstring(base64decode("RMO8emVubGVtZWsgacOnaW4gbGlzdGVkZW4gYmlyIHlldGVuZWsgc2XDpy4="))(), loadstring(base64decode("V8OkaGxlIGVpbmVuIFNraWxsIHp1bSBCZWFyYmVpdGVuIGF1cy4="))(), loadstring(base64decode("U8OpbGVjdGlvbm5leiB1bmUgY29tcMOpdGVuY2Ugw6AgbW9kaWZpZXIu"))() },
        { loadstring(base64decode("TkFNRQ=="))(), loadstring(base64decode("xLBTxLBN"))(), loadstring(base64decode("TkFNRQ=="))(), loadstring(base64decode("Tk9N"))() },
        { loadstring(base64decode("REVURUNUSU9OIFRZUEU="))(), loadstring(base64decode("QUxHSUxBTUEgVMOcUsOc"))(), loadstring(base64decode("RVJLRU5OVU5HU1RZUA=="))(), loadstring(base64decode("VFlQRSBERSBEw4lURUNUSU9O"))() },
        { loadstring(base64decode("QU5JTUFUSU9OIElE"))(), loadstring(base64decode("QU7EsE1BU1lPTiBJRA=="))(), loadstring(base64decode("QU5JTUFUSU9OUy1JRA=="))(), loadstring(base64decode("SUQgRCdBTklNQVRJT04="))() },
        { loadstring(base64decode("T0JKRUNUIE5BTUUgKGV4YWN0LCBhcyBzaG93biBpbiBFeHBsb3Jlcik="))(), loadstring(base64decode("TkVTTkUgQURJICh0YW0sIEV4cGxvcmVyJ2Rha2kgZ2liaSk="))(), loadstring(base64decode("T0JKRUtUTkFNRSAoZXhha3QsIHdpZSBpbSBFeHBsb3Jlcik="))(), loadstring(base64decode("Tk9NIERFIEwnT0JKRVQgKGV4YWN0LCBjb21tZSBkYW5zIGwnRXhwbG9yZXIp"))() },
        { loadstring(base64decode("UEFSRU5UIE5BTUUgKGJsYW5rID0gYW55IHBhcmVudCk="))(), loadstring(base64decode("w5xTVCBORVNORSBBREkgKGJvxZ8gPSBoZXJoYW5naSk="))(), loadstring(base64decode("RUxURVJOTkFNRSAobGVlciA9IGJlbGllYmlnKQ=="))(), loadstring(base64decode("Tk9NIERVIFBBUkVOVCAodmlkZSA9IHRvdXQp"))() },
        { loadstring(base64decode("U0tJTEwgS0VZIChleGFjdCBDdXJyZW50U2tpbGwgdmFsdWUgLSBibGFuayA9IHNhbWUgYXMgbmFtZSk="))(), loadstring(base64decode("WUVURU5FSyBBTkFIVEFSSSAodGFtIEN1cnJlbnRTa2lsbCBkZcSfZXJpIC0gYm/FnyA9IGlzaW1sZSBheW7EsSk="))(), loadstring(base64decode("U0tJTEwtU0NITMOcU1NFTCAoZXhha3RlciBDdXJyZW50U2tpbGwtV2VydCAtIGxlZXIgPSB3aWUgTmFtZSk="))(), loadstring(base64decode("Q0zDiSBERSBDT01Qw4lURU5DRSAodmFsZXVyIEN1cnJlbnRTa2lsbCBleGFjdGUgLSB2aWRlID0gbm9tKQ=="))() },
        { loadstring(base64decode("ZS5nLiAxMjM0NTY3ODkw"))(), loadstring(base64decode("w7Zybi4gMTIzNDU2Nzg5MA=="))(), loadstring(base64decode("ei4gQi4gMTIzNDU2Nzg5MA=="))(), loadstring(base64decode("ZXguIDEyMzQ1Njc4OTA="))() },
        { loadstring(base64decode("ZS5nLiBXYXRlckRyYWdvbkhlYWQ="))(), loadstring(base64decode("w7Zybi4gV2F0ZXJEcmFnb25IZWFk"))(), loadstring(base64decode("ei4gQi4gV2F0ZXJEcmFnb25IZWFk"))(), loadstring(base64decode("ZXguIFdhdGVyRHJhZ29uSGVhZA=="))() },
        { loadstring(base64decode("ZS5nLiBEZWJyaXM="))(), loadstring(base64decode("w7Zybi4gRGVicmlz"))(), loadstring(base64decode("ei4gQi4gRGVicmlz"))(), loadstring(base64decode("ZXguIERlYnJpcw=="))() },
        { loadstring(base64decode("ZS5nLiBTbW9sZGVyaW5nIEVhcnRoICAgKGJsYW5rID0gc2FtZSBhcyBuYW1lKQ=="))(), loadstring(base64decode("w7Zybi4gU21vbGRlcmluZyBFYXJ0aCAgIChib8WfID0gaXNpbWxlIGF5bsSxKQ=="))(), loadstring(base64decode("ei4gQi4gU21vbGRlcmluZyBFYXJ0aCAgIChsZWVyID0gd2llIE5hbWUp"))(), loadstring(base64decode("ZXguIFNtb2xkZXJpbmcgRWFydGggICAodmlkZSA9IG5vbSk="))() },
        { loadstring(base64decode("RW5hYmxlZA=="))(), loadstring(base64decode("RXRraW4="))(), loadstring(base64decode("QWt0aXY="))(), loadstring(base64decode("QWN0aXbDqQ=="))() },
        { loadstring(base64decode("RGlzdGFuY2U="))(), loadstring(base64decode("TWVzYWZl"))(), loadstring(base64decode("RGlzdGFueg=="))(), loadstring(base64decode("RGlzdGFuY2U="))() },
        { loadstring(base64decode("RGVsYXk="))(), loadstring(base64decode("R2VjaWttZQ=="))(), loadstring(base64decode("VmVyesO2Z2VydW5n"))(), loadstring(base64decode("RMOpbGFp"))() },
        { loadstring(base64decode("SG9sZA=="))(), loadstring(base64decode("QmFzxLFsxLEgVHV0"))(), loadstring(base64decode("SGFsdGVu"))(), loadstring(base64decode("TWFpbnRlbmly"))() },
        { loadstring(base64decode("SG9sZHMgdGhlIHBhcnJ5IGtleSBpbnN0ZWFkIG9mIHRhcHBpbmcgaXQu"))(), loadstring(base64decode("UGFycnkgdHXFn3VuYSBkb2t1bm1hayB5ZXJpbmUgYmFzxLFsxLEgdHV0YXIu"))(), loadstring(base64decode("SMOkbHQgZGllIFBhcnJ5LVRhc3RlLCBzdGF0dCBzaWUgbnVyIGFuenV0aXBwZW4u"))(), loadstring(base64decode("TWFpbnRpZW50IGxhIHRvdWNoZSBhdSBsaWV1IGQndW4gc2ltcGxlIGFwcHVpLg=="))() },
        { loadstring(base64decode("RHVyYXRpb24="))(), loadstring(base64decode("U8O8cmU="))(), loadstring(base64decode("RGF1ZXI="))(), loadstring(base64decode("RHVyw6ll"))() },
        { loadstring(base64decode("RHVwbGljYXRl"))(), loadstring(base64decode("S29weWFsYQ=="))(), loadstring(base64decode("RHVwbGl6aWVyZW4="))(), loadstring(base64decode("RHVwbGlxdWVy"))() },
        { loadstring(base64decode("RGVsZXRlIFNraWxs"))(), loadstring(base64decode("WWV0ZW5lxJ9pIFNpbA=="))(), loadstring(base64decode("U2tpbGwgbMO2c2NoZW4="))(), loadstring(base64decode("U3VwcHJpbWVy"))() },
        { loadstring(base64decode("VXNlIGxlYXJuZWQgdGltaW5nICAoaGl0IGF0ICVkIHMp"))(), loadstring(base64decode("w5bEn3JlbmlsZW4gemFtYW5sYW1hecSxIGt1bGxhbiAgKHZ1cnXFnzogJXMgc24p"))(), loadstring(base64decode("R2VsZXJudGUgWmVpdCB2ZXJ3ZW5kZW4gIChUcmVmZmVyIGJlaSAlcyBzKQ=="))(), loadstring(base64decode("VXRpbGlzZXIgbGUgdGltaW5nIGFwcHJpcyAgKHRvdWNoZSDDoCAlcyBzKQ=="))() },
        -- Misc sekmesi
        { loadstring(base64decode("Q2xvdGhpbmcgc3lzdGVt"))(), loadstring(base64decode("S8SxeWFmZXQgc2lzdGVtaQ=="))(), loadstring(base64decode("S2xlaWR1bmdzc3lzdGVt"))(), loadstring(base64decode("U3lzdMOobWUgZGUgdGVudWVz"))() },
        { loadstring(base64decode("Q2xpZW50LXNpZGUgb3V0Zml0cy4gVHVybiBvbiB0byBzaG93IHRoZSBjb250cm9scy4="))(), loadstring(base64decode("U2FkZWNlIHNlbmRlIGfDtnLDvG5lbiBrxLF5YWZldGxlci4gS29udHJvbGxlcmkgZ8O2c3Rlcm1layBpw6dpbiBhw6cu"))(), loadstring(base64decode("Q2xpZW50c2VpdGlnZSBPdXRmaXRzLiBFaW5zY2hhbHRlbiwgdW0gZGllIFN0ZXVlcnVuZyBhbnp1emVpZ2VuLg=="))(), loadstring(base64decode("VGVudWVzIGPDtHTDqSBjbGllbnQuIEFjdGl2ZXogcG91ciBhZmZpY2hlciBsZXMgY29udHLDtGxlcy4="))() },
        { loadstring(base64decode("T1VURklU"))(), loadstring(base64decode("S0lZQUZFVA=="))(), loadstring(base64decode("T1VURklU"))(), loadstring(base64decode("VEVOVUU="))() },
        { loadstring(base64decode("U2VsZWN0IG91dGZpdA=="))(), loadstring(base64decode("S8SxeWFmZXQgc2XDpw=="))(), loadstring(base64decode("T3V0Zml0IHfDpGhsZW4="))(), loadstring(base64decode("Q2hvaXNpciB1bmUgdGVudWU="))() },
        { loadstring(base64decode("SGlkZSBlcXVpcHBlZCBhcm1vcg=="))(), loadstring(base64decode("VGFrxLFsxLEgesSxcmjEsSBnaXpsZQ=="))(), loadstring(base64decode("QW5nZWxlZ3RlIFLDvHN0dW5nIGF1c2JsZW5kZW4="))(), loadstring(base64decode("TWFzcXVlciBsJ2FybXVyZSDDqXF1aXDDqWU="))() },
        { loadstring(base64decode("SGlkZXMgdGhlIGFybW9yIHlvdSBhbHJlYWR5IHdlYXIgKGUuZy4gQXNjZW5kZWQgU2VuanUpIHNvIHRoZSBzZWxlY3RlZCBvdXRmaXQgcmVwbGFjZXMgaXQgaW5zdGVhZCBvZiBzdGFja2luZy4="))(), loadstring(base64decode("R2l5ZGnEn2luIHrEsXJoxLEgKMO2ci4gQXNjZW5kZWQgU2VuanUpIGdpemxlcjsgc2XDp2lsZW4ga8SxeWFmZXQgw7xzdCDDvHN0ZSBiaW5tZWsgeWVyaW5lIG9udW4geWVyaW5pIGFsxLFyLg=="))(), loadstring(base64decode("QmxlbmRldCBkZWluZSBnZXRyYWdlbmUgUsO8c3R1bmcgKHouIEIuIEFzY2VuZGVkIFNlbmp1KSBhdXMsIGRhbWl0IGRhcyBnZXfDpGhsdGUgT3V0Zml0IHNpZSBlcnNldHp0LCBzdGF0dCBzaWNoIHp1IHN0YXBlbG4u"))(), loadstring(base64decode("TWFzcXVlIGwnYXJtdXJlIGTDqWrDoCBwb3J0w6llIChleC4gQXNjZW5kZWQgU2VuanUpIHBvdXIgcXVlIGxhIHRlbnVlIGNob2lzaWUgbGEgcmVtcGxhY2UgYXUgbGlldSBkZSBzZSBzdXBlcnBvc2VyLg=="))() },
        { loadstring(base64decode("QnJva2VuIHZhcmlhbnQ="))(), loadstring(base64decode("S8SxcsSxayB2ZXJzaXlvbg=="))(), loadstring(base64decode("S2FwdXR0ZSBWYXJpYW50ZQ=="))(), loadstring(base64decode("VmFyaWFudGUgYnJpc8OpZQ=="))() },
        { loadstring(base64decode("V2VhcnMgdGhlIEJyb2tlbiBzZXQgKEJyb2tlbiBmb2xkZXIsIFNoaXJ0QnJva2VuLCBQYW50c0Jyb2tlbiku"))(), loadstring(base64decode("QnJva2VuIHNldGluaSBnaXllciAoQnJva2VuIGtsYXPDtnLDvCwgU2hpcnRCcm9rZW4sIFBhbnRzQnJva2VuKS4="))(), loadstring(base64decode("VHLDpGd0IGRhcyBCcm9rZW4tU2V0IChCcm9rZW4tT3JkbmVyLCBTaGlydEJyb2tlbiwgUGFudHNCcm9rZW4pLg=="))(), loadstring(base64decode("UG9ydGUgbCdlbnNlbWJsZSBCcm9rZW4gKGRvc3NpZXIgQnJva2VuLCBTaGlydEJyb2tlbiwgUGFudHNCcm9rZW4pLg=="))() },
        { loadstring(base64decode("UmUtYXBwbHkgb24gcmVzcGF3bg=="))(), loadstring(base64decode("WWVuaWRlbiBkb8SfdW5jYSB0ZWtyYXIgZ2l5"))(), loadstring(base64decode("TmFjaCBSZXNwYXduIGVybmV1dCBhbmxlZ2Vu"))(), loadstring(base64decode("UmVtZXR0cmUgYXByw6hzIHLDqWFwcGFyaXRpb24="))() },
        { loadstring(base64decode("UHV0cyB0aGUgc2VsZWN0ZWQgb3V0Zml0IGJhY2sgb24gYWZ0ZXIgeW91IHJlc3Bhd24u"))(), loadstring(base64decode("WWVuaWRlbiBkb8SfZHVrdGFuIHNvbnJhIHNlw6dpbGkga8SxeWFmZXRpIHRla3JhciBnaXlkaXJpci4="))(), loadstring(base64decode("WmllaHQgZGFzIGdld8OkaGx0ZSBPdXRmaXQgbmFjaCBkZW0gUmVzcGF3biB3aWVkZXIgYW4u"))(), loadstring(base64decode("UmVtZXQgbGEgdGVudWUgY2hvaXNpZSBhcHLDqHMgdm90cmUgcsOpYXBwYXJpdGlvbi4="))() },
        { loadstring(base64decode("T2Zmc2V0IFggKGxlZnQgLyByaWdodCk="))(), loadstring(base64decode("S2F5ZMSxcm1hIFggKHNvbCAvIHNhxJ8p"))(), loadstring(base64decode("VmVyc2F0eiBYIChsaW5rcyAvIHJlY2h0cyk="))(), loadstring(base64decode("RMOpY2FsYWdlIFggKGdhdWNoZSAvIGRyb2l0ZSk="))() },
        { loadstring(base64decode("T2Zmc2V0IFkgKHVwIC8gZG93bik="))(), loadstring(base64decode("S2F5ZMSxcm1hIFkgKHl1a2FyxLEgLyBhxZ9hxJ/EsSk="))(), loadstring(base64decode("VmVyc2F0eiBZIChvYmVuIC8gdW50ZW4p"))(), loadstring(base64decode("RMOpY2FsYWdlIFkgKGhhdXQgLyBiYXMp"))() },
        { loadstring(base64decode("T2Zmc2V0IFogKGZvcndhcmQgLyBiYWNrKQ=="))(), loadstring(base64decode("S2F5ZMSxcm1hIFogKGlsZXJpIC8gZ2VyaSk="))(), loadstring(base64decode("VmVyc2F0eiBaICh2b3IgLyB6dXLDvGNrKQ=="))(), loadstring(base64decode("RMOpY2FsYWdlIFogKGF2YW50IC8gYXJyacOocmUp"))() },
        { loadstring(base64decode("V2VhciBhZ2Fpbg=="))(), loadstring(base64decode("VGVrcmFyIGdpeQ=="))(), loadstring(base64decode("RXJuZXV0IGFubGVnZW4="))(), loadstring(base64decode("UmVtZXR0cmU="))() },
        { loadstring(base64decode("UmVtb3Zl"))(), loadstring(base64decode("S2FsZMSxcg=="))(), loadstring(base64decode("RW50ZmVybmVu"))(), loadstring(base64decode("UmV0aXJlcg=="))() },
        { loadstring(base64decode("T25seSB5b3UgY2FuIHNlZSB0aGlzLiBMaXN0cyBldmVyeSBvdXRmaXQgaW4gUmVwbGljYXRlZFN0b3JhZ2UgPiBDbG90aGluZyB0aGF0IGhhcyBhIE5vcm1hbCAvIEJyb2tlbiBmb2xkZXIuIEFybXMsIGxlZ3MgYW5kIHRvcnNvIGFyZSBkZXRlY3RlZCBmcm9tIHBhcnQgYW5kIG1vZGVsIG5hbWVzIChMQSwgUkEsIExMLCBSTCwgVCwgTGVmdCBBcm0sIC4uLiku"))(), loadstring(base64decode("QnVudSBzYWRlY2Ugc2VuIGfDtnLDvHJzw7xuLiBSZXBsaWNhdGVkU3RvcmFnZSA+IENsb3RoaW5nIGnDp2luZGUgTm9ybWFsIC8gQnJva2VuIGtsYXPDtnLDvCBvbGFuIHTDvG0ga8SxeWFmZXRsZXJpIGxpc3RlbGVyLiBLb2wsIGJhY2FrIHZlIGfDtnZkZTsgcGFyw6dhIHZlIG1vZGVsIGFkbGFyxLFuZGFuIChMQSwgUkEsIExMLCBSTCwgVCwgTGVmdCBBcm0sIC4uLikgYWxnxLFsYW7EsXIu"))(), loadstring(base64decode("RGFzIHNpZWhzdCBudXIgZHUuIExpc3RldCBqZWRlcyBPdXRmaXQgaW4gUmVwbGljYXRlZFN0b3JhZ2UgPiBDbG90aGluZyBtaXQgTm9ybWFsLSAvIEJyb2tlbi1PcmRuZXIuIEFybWUsIEJlaW5lIHVuZCBUb3JzbyB3ZXJkZW4gYW5oYW5kIGRlciBUZWlsLSB1bmQgTW9kZWxsbmFtZW4gZXJrYW5udCAoTEEsIFJBLCBMTCwgUkwsIFQsIExlZnQgQXJtLCAuLi4pLg=="))(), loadstring(base64decode("VmlzaWJsZSB1bmlxdWVtZW50IHBhciB2b3VzLiBMaXN0ZSBjaGFxdWUgdGVudWUgZGUgUmVwbGljYXRlZFN0b3JhZ2UgPiBDbG90aGluZyBheWFudCB1biBkb3NzaWVyIE5vcm1hbCAvIEJyb2tlbi4gQnJhcywgamFtYmVzIGV0IHRvcnNlIHNvbnQgZMOpdGVjdMOpcyBkJ2FwcsOocyBsZXMgbm9tcyAoTEEsIFJBLCBMTCwgUkwsIFQsIExlZnQgQXJtLCAuLi4pLg=="))() },
        -- Settings sekmesi
        { loadstring(base64decode("QUNUSVZF"))(), loadstring(base64decode("QUtUxLBG"))(), loadstring(base64decode("QUtUSVY="))(), loadstring(base64decode("QUNUSUY="))() },
        { loadstring(base64decode("TkVXIFBST0ZJTEUgTkFNRQ=="))(), loadstring(base64decode("WUVOxLAgUFJPRsSwTCBBREk="))(), loadstring(base64decode("TkVVRVIgUFJPRklMTkFNRQ=="))(), loadstring(base64decode("Tk9NIERVIE5PVVZFQVUgUFJPRklM"))() },
        { loadstring(base64decode("Q3JlYXRl"))(), loadstring(base64decode("T2x1xZ90dXI="))(), loadstring(base64decode("RXJzdGVsbGVu"))(), loadstring(base64decode("Q3LDqWVy"))() },
        { loadstring(base64decode("RGVsZXRlIGN1cnJlbnQ="))(), loadstring(base64decode("TWV2Y3V0dSBzaWw="))(), loadstring(base64decode("QWt0dWVsbGVzIGzDtnNjaGVu"))(), loadstring(base64decode("U3VwcHJpbWVyIGwnYWN0dWVs"))() },
        { loadstring(base64decode("UmVzdG9yZSByZWNvbW1lbmRlZCBjb25maWc="))(), loadstring(base64decode("w5ZuZXJpbGVuIGNvbmZpZ2kgZ2VyaSB5w7xrbGU="))(), loadstring(base64decode("RW1wZm9obGVuZSBDb25maWcgd2llZGVyaGVyc3RlbGxlbg=="))(), loadstring(base64decode("UmVzdGF1cmVyIGxhIGNvbmZpZyByZWNvbW1hbmTDqWU="))() },
        { loadstring(base64decode("U0tJTEwgVkFMVUUgTkFNRSAoYXR0cmlidXRlIC8gdmFsdWUgb2JqZWN0KQ=="))(), loadstring(base64decode("WUVURU5FSyBERcSeRVIgQURJIChhdHRyaWJ1dGUgLyB2YWx1ZSBuZXNuZXNpKQ=="))(), loadstring(base64decode("U0tJTEwtV0VSVE5BTUUgKEF0dHJpYnV0IC8gVmFsdWUtT2JqZWt0KQ=="))(), loadstring(base64decode("Tk9NIERFIExBIFZBTEVVUiAoYXR0cmlidXQgLyBvYmpldCBWYWx1ZSk="))() },
        { loadstring(base64decode("U2tpbGwtdHlwZSBza2lsbHMgcmVhZCB0aGlzIHZhbHVlIGZyb20gUmVwbGljYXRlZFN0b3JhZ2UgPiBTZXR0aW5ncyA+IFtwbGF5ZXIgbmFtZV0sIGFuZCBhbHNvIGZyb20gdGhlIGNoYXJhY3RlciwgaXRzIEh1bWFub2lkIG9yIHRoZSBwbGF5ZXIgKGF0dHJpYnV0ZSBvciBWYWx1ZSBvYmplY3QpLg=="))(), loadstring(base64decode("U2tpbGwgdMO8csO8bmRla2kgeWV0ZW5la2xlciBidSBkZcSfZXJpIFJlcGxpY2F0ZWRTdG9yYWdlID4gU2V0dGluZ3MgPiBbb3l1bmN1IGFkxLFdIGnDp2luZGVuLCBheXLEsWNhIGthcmFrdGVyZGVuLCBIdW1hbm9pZCdpbmRlbiB2ZXlhIG95dW5jdWRhbiAoYXR0cmlidXRlIHlhIGRhIFZhbHVlIG5lc25lc2kpIG9rdXIu"))(), loadstring(base64decode("U2tpbGwtVHlwLUbDpGhpZ2tlaXRlbiBsZXNlbiBkaWVzZW4gV2VydCBhdXMgUmVwbGljYXRlZFN0b3JhZ2UgPiBTZXR0aW5ncyA+IFtTcGllbGVybmFtZV0gc293aWUgYXVzIGRlbSBDaGFyYWt0ZXIsIGRlc3NlbiBIdW1hbm9pZCBvZGVyIGRlbSBTcGllbGVyIChBdHRyaWJ1dCBvZGVyIFZhbHVlLU9iamVrdCku"))(), loadstring(base64decode("TGVzIGNvbXDDqXRlbmNlcyBkZSB0eXBlIFNraWxsIGxpc2VudCBjZXR0ZSB2YWxldXIgZGFucyBSZXBsaWNhdGVkU3RvcmFnZSA+IFNldHRpbmdzID4gW25vbSBkdSBqb3VldXJdLCBhaW5zaSBxdWUgZGFucyBsZSBwZXJzb25uYWdlLCBzb24gSHVtYW5vaWQgb3UgbGUgam91ZXVyIChhdHRyaWJ1dCBvdSBvYmpldCBWYWx1ZSku"))() },
        { loadstring(base64decode("VG9nZ2xlIFVJ"))(), loadstring(base64decode("QXJhecO8esO8IGHDpy9rYXBhdA=="))(), loadstring(base64decode("VUkgdW1zY2hhbHRlbg=="))(), loadstring(base64decode("QWZmaWNoZXIvbWFzcXVlciBsJ1VJ"))() },
        { loadstring(base64decode("VG9nZ2xlIEF1dG8tUGFycnk="))(), loadstring(base64decode("T3RvLVBhcnJ5J3lpIGHDpy9rYXBhdA=="))(), loadstring(base64decode("QXV0by1QYXJyeSB1bXNjaGFsdGVu"))(), loadstring(base64decode("QWN0aXZlci9kw6lzYWN0aXZlciBsJ0F1dG8tUGFycnk="))() },
        { loadstring(base64decode("UGFycnkga2V5IChpbi1nYW1lKQ=="))(), loadstring(base64decode("UGFycnkgdHXFn3UgKG95dW4gacOnaSk="))(), loadstring(base64decode("UGFycnktVGFzdGUgKGltIFNwaWVsKQ=="))(), loadstring(base64decode("VG91Y2hlIGRlIHBhcmFkZSAoZW4gamV1KQ=="))() },
        { loadstring(base64decode("UHJlc3MgYSBrZXkuLi4="))(), loadstring(base64decode("QmlyIHR1xZ9hIGJhcy4uLg=="))(), loadstring(base64decode("VGFzdGUgZHLDvGNrZW4uLi4="))(), loadstring(base64decode("QXBwdXlleiBzdXIgdW5lIHRvdWNoZS4uLg=="))() },
        { loadstring(base64decode("U0tJTExTIE9GIENVUlJFTlQgUFJPRklMRSAoSlNPTik="))(), loadstring(base64decode("TUVWQ1VUIFBST0bEsEzEsE4gWUVURU5FS0xFUsSwIChKU09OKQ=="))(), loadstring(base64decode("U0tJTExTIERFUyBBS1RVRUxMRU4gUFJPRklMUyAoSlNPTik="))(), loadstring(base64decode("Q09NUMOJVEVOQ0VTIERVIFBST0ZJTCBBQ1RVRUwgKEpTT04p"))() },
        { loadstring(base64decode("RXhwb3J0"))(), loadstring(base64decode("RMSxxZ9hIGFrdGFy"))(), loadstring(base64decode("RXhwb3J0aWVyZW4="))(), loadstring(base64decode("RXhwb3J0ZXI="))() },
        { loadstring(base64decode("SW1wb3J0"))(), loadstring(base64decode("xLDDp2UgYWt0YXI="))(), loadstring(base64decode("SW1wb3J0aWVyZW4="))(), loadstring(base64decode("SW1wb3J0ZXI="))() },
        { loadstring(base64decode("RmlsZSBhY2Nlc3MgaXMgbm90IGF2YWlsYWJsZSBpbiB0aGlzIGV4ZWN1dG9yLiBDaGFuZ2VzIGFyZSBsb3N0IG9uIHJlc3RhcnQgLSB1c2UgRXhwb3J0IHRvIGtlZXAgeW91ciBza2lsbHMu"))(), loadstring(base64decode("QnUgZXhlY3V0b3InZGEgZG9zeWEgZXJpxZ9pbWkgeW9rLiBEZcSfacWfaWtsaWtsZXIgeWVuaWRlbiBiYcWfbGF0xLFuY2Ega2F5Ym9sdXIgLSB5ZXRlbmVrbGVyaW5pIHNha2xhbWFrIGnDp2luIETEscWfYSBha3RhcifEsSBrdWxsYW4u"))(), loadstring(base64decode("SW4gZGllc2VtIEV4ZWN1dG9yIGlzdCBrZWluIERhdGVpenVncmlmZiB2ZXJmw7xnYmFyLiDDhG5kZXJ1bmdlbiBnZWhlbiBiZWltIE5ldXN0YXJ0IHZlcmxvcmVuIC0gbnV0emUgRXhwb3J0LCB1bSBkZWluZSBTa2lsbHMgenUgc2ljaGVybi4="))(), loadstring(base64decode("TCdhY2PDqHMgYXV4IGZpY2hpZXJzIG4nZXN0IHBhcyBkaXNwb25pYmxlIGRhbnMgY2V0IGV4w6ljdXRldXIuIExlcyBjaGFuZ2VtZW50cyBzb250IHBlcmR1cyBhdSByZWTDqW1hcnJhZ2UgLSB1dGlsaXNleiBFeHBvcnRlciBwb3VyIGNvbnNlcnZlciB2b3MgY29tcMOpdGVuY2VzLg=="))() },
        { loadstring(base64decode("VW5sb2FkIFNjcmlwdA=="))(), loadstring(base64decode("U2NyaXB0aSBrYWxkxLFy"))(), loadstring(base64decode("U2NyaXB0IGVudGxhZGVu"))(), loadstring(base64decode("RMOpY2hhcmdlciBsZSBzY3JpcHQ="))() },
        { loadstring(base64decode("TEFOR1VBR0U="))(), loadstring(base64decode("RMSwTA=="))(), loadstring(base64decode("U1BSQUNIRQ=="))(), loadstring(base64decode("TEFOR1VF"))() },
        { loadstring(base64decode("VUkgc2NhbGU="))(), loadstring(base64decode("QXJhecO8eiBib3l1dHU="))(), loadstring(base64decode("VUktR3LDtsOfZQ=="))(), loadstring(base64decode("VGFpbGxlIGRlIGwnVUk="))() },
        { loadstring(base64decode("U25vdyBlZmZlY3Q="))(), loadstring(base64decode("S2FyIGVmZWt0aQ=="))(), loadstring(base64decode("U2NobmVlZWZmZWt0"))(), loadstring(base64decode("RWZmZXQgZGUgbmVpZ2U="))() },
        { loadstring(base64decode("QW5pbWF0ZWQgc25vd2ZhbGwgaW4gdGhlIHdpbmRvdyBiYWNrZ3JvdW5kIChkaXNhYmxlIGZvciBtYXggRlBTKS4="))(), loadstring(base64decode("UGVuY2VyZSBhcmthIHBsYW7EsW5kYSBhbmltYXN5b25sdSBrYXIgeWHEn8SxxZ/EsSAobWFrc2ltdW0gRlBTIGnDp2luIGthcGF0KS4="))(), loadstring(base64decode("QW5pbWllcnRlciBTY2huZWVmYWxsIGltIEZlbnN0ZXJoaW50ZXJncnVuZCAoZsO8ciBtYXhpbWFsZSBGUFMgYXVzc2NoYWx0ZW4pLg=="))(), loadstring(base64decode("Q2h1dGUgZGUgbmVpZ2UgYW5pbcOpZSBlbiBhcnJpw6hyZS1wbGFuIChkw6lzYWN0aXZleiBwb3VyIHVuIG1heGltdW0gZGUgRlBTKS4="))() },
        { loadstring(base64decode("TG9nIG91dCAvIGNoYW5nZSBrZXk="))(), loadstring(base64decode("w4fEsWvEscWfIHlhcCAvIGFuYWh0YXLEsSBkZcSfacWfdGly"))(), loadstring(base64decode("QWJtZWxkZW4gLyBLZXkgw6RuZGVybg=="))(), loadstring(base64decode("U2UgZMOpY29ubmVjdGVyIC8gY2hhbmdlciBkZSBjbMOp"))() },
        { loadstring(base64decode("TGljZW5zZQ=="))(), loadstring(base64decode("TGlzYW5z"))(), loadstring(base64decode("TGl6ZW56"))(), loadstring(base64decode("TGljZW5jZQ=="))() },
        { loadstring(base64decode("bGlmZXRpbWU="))(), loadstring(base64decode("w7Ztw7xyIGJveXU="))(), loadstring(base64decode("bGViZW5zbGFuZw=="))(), loadstring(base64decode("w6Agdmll"))() },
        { loadstring(base64decode("ZGFpbHk="))(), loadstring(base64decode("Z8O8bmzDvGs="))(), loadstring(base64decode("dMOkZ2xpY2g="))(), loadstring(base64decode("am91cm5hbGnDqHJl"))() },
        { loadstring(base64decode("d2Vla2x5"))(), loadstring(base64decode("aGFmdGFsxLFr"))(), loadstring(base64decode("d8O2Y2hlbnRsaWNo"))(), loadstring(base64decode("aGViZG9tYWRhaXJl"))() },
        { loadstring(base64decode("bW9udGhseQ=="))(), loadstring(base64decode("YXlsxLFr"))(), loadstring(base64decode("bW9uYXRsaWNo"))(), loadstring(base64decode("bWVuc3VlbGxl"))() },
        { loadstring(base64decode("Y3VzdG9t"))(), loadstring(base64decode("w7Z6ZWw="))(), loadstring(base64decode("YmVudXR6ZXJkZWZpbmllcnQ="))(), loadstring(base64decode("cGVyc29ubmFsaXPDqWU="))() },
        { loadstring(base64decode("ZXhwaXJlcyBpbg=="))(), loadstring(base64decode("Yml0acWfOg=="))(), loadstring(base64decode("bMOkdWZ0IGFiIGlu"))(), loadstring(base64decode("ZXhwaXJlIGRhbnM="))() },
        { loadstring(base64decode("bmV2ZXIgZXhwaXJlcw=="))(), loadstring(base64decode("c8O8cmVzaXo="))(), loadstring(base64decode("bMOkdWZ0IG5pZSBhYg=="))(), loadstring(base64decode("bidleHBpcmUgamFtYWlz"))() },
        -- durum mesajları
        { loadstring(base64decode("QXV0by1QYXJyeSBlbmFibGVkLg=="))(), loadstring(base64decode("T3RvLVBhcnJ5IGV0a2lubGXFn3RpcmlsZGku"))(), loadstring(base64decode("QXV0by1QYXJyeSBha3RpdmllcnQu"))(), loadstring(base64decode("QXV0by1QYXJyeSBhY3RpdsOpLg=="))() },
        { loadstring(base64decode("QXV0by1QYXJyeSBkaXNhYmxlZC4="))(), loadstring(base64decode("T3RvLVBhcnJ5IGRldnJlIGTEscWfxLEu"))(), loadstring(base64decode("QXV0by1QYXJyeSBkZWFrdGl2aWVydC4="))(), loadstring(base64decode("QXV0by1QYXJyeSBkw6lzYWN0aXbDqS4="))() },
        { loadstring(base64decode("TGlzdCBjbGVhcmVkLg=="))(), loadstring(base64decode("TGlzdGUgdGVtaXpsZW5kaS4="))(), loadstring(base64decode("TGlzdGUgZ2VsZWVydC4="))(), loadstring(base64decode("TGlzdGUgZWZmYWPDqWUu"))() },
        { loadstring(base64decode("U2VsZWN0IGFuIG91dGZpdCBmaXJzdC4="))(), loadstring(base64decode("w5ZuY2UgYmlyIGvEsXlhZmV0IHNlw6cu"))(), loadstring(base64decode("V8OkaGxlIHp1ZXJzdCBlaW4gT3V0Zml0Lg=="))(), loadstring(base64decode("Q2hvaXNpc3NleiBkJ2Fib3JkIHVuZSB0ZW51ZS4="))() },
        { loadstring(base64decode("T3V0Zml0IHJlbW92ZWQgKHlvdXIgb3JpZ2luYWwgYXJtb3IgaXMgYmFjayku"))(), loadstring(base64decode("S8SxeWFmZXQga2FsZMSxcsSxbGTEsSAob3JpamluYWwgesSxcmjEsW4gZ2VyaSBnZWxkaSku"))(), loadstring(base64decode("T3V0Zml0IGVudGZlcm50IChkZWluZSB1cnNwcsO8bmdsaWNoZSBSw7xzdHVuZyBpc3QgenVyw7xjayku"))(), loadstring(base64decode("VGVudWUgcmV0aXLDqWUgKHZvdHJlIGFybXVyZSBkJ29yaWdpbmUgZXN0IGRlIHJldG91ciku"))() },
        { loadstring(base64decode("UmVjb21tZW5kZWQgY29uZmlnIHJlc3RvcmVkIHRvIHRoZSBEZWZhdWx0IHByb2ZpbGUu"))(), loadstring(base64decode("w5ZuZXJpbGVuIGNvbmZpZyBEZWZhdWx0IHByb2ZpbGluZSBnZXJpIHnDvGtsZW5kaS4="))(), loadstring(base64decode("RW1wZm9obGVuZSBDb25maWcgaW0gRGVmYXVsdC1Qcm9maWwgd2llZGVyaGVyZ2VzdGVsbHQu"))(), loadstring(base64decode("Q29uZmlnIHJlY29tbWFuZMOpZSByZXN0YXVyw6llIGRhbnMgbGUgcHJvZmlsIERlZmF1bHQu"))() },
        { loadstring(base64decode("UHJvZmlsZTog"))(), loadstring(base64decode("UHJvZmlsOiA="))(), loadstring(base64decode("UHJvZmlsOiA="))(), loadstring(base64decode("UHJvZmlsIDog"))() },
        { loadstring(base64decode("RW50ZXIgYSBwcm9maWxlIG5hbWUu"))(), loadstring(base64decode("QmlyIHByb2ZpbCBhZMSxIGdpci4="))(), loadstring(base64decode("R2liIGVpbmVuIFByb2ZpbG5hbWVuIGVpbi4="))(), loadstring(base64decode("RW50cmV6IHVuIG5vbSBkZSBwcm9maWwu"))() },
        { loadstring(base64decode("UHJvZmlsZSBhbHJlYWR5IGV4aXN0cy4="))(), loadstring(base64decode("UHJvZmlsIHphdGVuIHZhci4="))(), loadstring(base64decode("UHJvZmlsIGV4aXN0aWVydCBiZXJlaXRzLg=="))(), loadstring(base64decode("TGUgcHJvZmlsIGV4aXN0ZSBkw6lqw6Au"))() },
        { loadstring(base64decode("VGhlIERlZmF1bHQgcHJvZmlsZSBjYW4ndCBiZSBkZWxldGVkLg=="))(), loadstring(base64decode("RGVmYXVsdCBwcm9maWxpIHNpbGluZW1lei4="))(), loadstring(base64decode("RGFzIERlZmF1bHQtUHJvZmlsIGthbm4gbmljaHQgZ2Vsw7ZzY2h0IHdlcmRlbi4="))(), loadstring(base64decode("TGUgcHJvZmlsIERlZmF1bHQgbmUgcGV1dCBwYXMgw6p0cmUgc3VwcHJpbcOpLg=="))() },
        { loadstring(base64decode("RXhwb3J0ZWQgJWQgc2tpbGwocyku"))(), loadstring(base64decode("JXMgeWV0ZW5layBkxLHFn2EgYWt0YXLEsWxkxLEu"))(), loadstring(base64decode("JXMgU2tpbGwocykgZXhwb3J0aWVydC4="))(), loadstring(base64decode("JXMgY29tcMOpdGVuY2UocykgZXhwb3J0w6llKHMpLg=="))() },
        { loadstring(base64decode("SW1wb3J0ZWQgJWQgc2tpbGwocyku"))(), loadstring(base64decode("JXMgeWV0ZW5layBpw6dlIGFrdGFyxLFsZMSxLg=="))(), loadstring(base64decode("JXMgU2tpbGwocykgaW1wb3J0aWVydC4="))(), loadstring(base64decode("JXMgY29tcMOpdGVuY2UocykgaW1wb3J0w6llKHMpLg=="))() },
        { loadstring(base64decode("RXhwb3J0IGZhaWxlZC4="))(), loadstring(base64decode("RMSxxZ9hIGFrdGFybWEgYmHFn2FyxLFzxLF6Lg=="))(), loadstring(base64decode("RXhwb3J0IGZlaGxnZXNjaGxhZ2VuLg=="))(), loadstring(base64decode("w4ljaGVjIGRlIGwnZXhwb3J0Lg=="))() },
        { loadstring(base64decode("SW1wb3J0IGZhaWxlZDog"))(), loadstring(base64decode("xLDDp2UgYWt0YXJtYSBiYcWfYXLEsXPEsXo6IA=="))(), loadstring(base64decode("SW1wb3J0IGZlaGxnZXNjaGxhZ2VuOiA="))(), loadstring(base64decode("w4ljaGVjIGRlIGwnaW1wb3J0IDog"))() },
        { loadstring(base64decode("UGFycnk6IA=="))(), loadstring(base64decode("UGFycnk6IA=="))(), loadstring(base64decode("UGFycnk6IA=="))(), loadstring(base64decode("UGFyYWRlIDog"))() },
        { loadstring(base64decode("U2tpbGwgdmFsdWUgbmFtZTog"))(), loadstring(base64decode("WWV0ZW5layBkZcSfZXIgYWTEsTog"))(), loadstring(base64decode("U2tpbGwtV2VydG5hbWU6IA=="))(), loadstring(base64decode("Tm9tIGRlIGxhIHZhbGV1ciA6IA=="))() },
        { loadstring(base64decode("UGxheWVyIG5vdCBmb3VuZDog"))(), loadstring(base64decode("T3l1bmN1IGJ1bHVuYW1hZMSxOiA="))(), loadstring(base64decode("U3BpZWxlciBuaWNodCBnZWZ1bmRlbjog"))(), loadstring(base64decode("Sm91ZXVyIGludHJvdXZhYmxlIDog"))() },
        { loadstring(base64decode("Tm8gY2hhcmFjdGVyLg=="))(), loadstring(base64decode("S2FyYWt0ZXIgeW9rLg=="))(), loadstring(base64decode("S2VpbiBDaGFyYWt0ZXIu"))(), loadstring(base64decode("QXVjdW4gcGVyc29ubmFnZS4="))() },
        { loadstring(base64decode("U291cmNlIGNoYXJhY3RlciBub3QgZm91bmQgLSB1c2luZyB0aGUgZGVmYXVsdCBkdW1teS4="))(), loadstring(base64decode("S2F5bmFrIGthcmFrdGVyIGJ1bHVuYW1hZMSxIC0gdmFyc2F5xLFsYW4gbW9kZWwga3VsbGFuxLFsxLF5b3Iu"))(), loadstring(base64decode("UXVlbGxjaGFyYWt0ZXIgbmljaHQgZ2VmdW5kZW4gLSBTdGFuZGFyZG1vZGVsbCB3aXJkIHZlcndlbmRldC4="))(), loadstring(base64decode("UGVyc29ubmFnZSBzb3VyY2UgaW50cm91dmFibGUgLSBtb2TDqGxlIHBhciBkw6lmYXV0IHV0aWxpc8OpLg=="))() },
        { loadstring(base64decode("TG9hZGVkLiAlcyA9IGhpZGUvc2hvdyBVSSwgJXMgPSB0b2dnbGUgQXV0by1QYXJyeS4="))(), loadstring(base64decode("WcO8a2xlbmRpLiAlcyA9IGFyYXnDvHrDvCBnw7ZzdGVyL2dpemxlLCAlcyA9IE90by1QYXJyeSBhw6cva2FwYXQu"))(), loadstring(base64decode("R2VsYWRlbi4gJXMgPSBVSSBlaW4tL2F1c2JsZW5kZW4sICVzID0gQXV0by1QYXJyeSB1bXNjaGFsdGVuLg=="))(), loadstring(base64decode("Q2hhcmfDqS4gJXMgPSBhZmZpY2hlci9tYXNxdWVyIGwnVUksICVzID0gYWN0aXZlci9kw6lzYWN0aXZlciBsJ0F1dG8tUGFycnku"))() },
        -- lisans penceresi
        { loadstring(base64decode("TGljZW5zZSBhY3RpdmF0aW9u"))(), loadstring(base64decode("TGlzYW5zIGFrdGl2YXN5b251"))(), loadstring(base64decode("TGl6ZW56YWt0aXZpZXJ1bmc="))(), loadstring(base64decode("QWN0aXZhdGlvbiBkZSBsYSBsaWNlbmNl"))() },
        { loadstring(base64decode("QWN0aXZhdGU="))(), loadstring(base64decode("RXRraW5sZcWfdGly"))(), loadstring(base64decode("QWt0aXZpZXJlbg=="))(), loadstring(base64decode("QWN0aXZlcg=="))() },
        { loadstring(base64decode("Q2hlY2tpbmcuLi4="))(), loadstring(base64decode("S29udHJvbCBlZGlsaXlvci4uLg=="))(), loadstring(base64decode("UHLDvGZlLi4u"))(), loadstring(base64decode("VsOpcmlmaWNhdGlvbi4uLg=="))() },
        { loadstring(base64decode("TGljZW5zZSBhY3RpdmF0ZWQh"))(), loadstring(base64decode("TGlzYW5zIGV0a2lubGXFn3RpcmlsZGkh"))(), loadstring(base64decode("TGl6ZW56IGFrdGl2aWVydCE="))(), loadstring(base64decode("TGljZW5jZSBhY3RpdsOpZSAh"))() },
        { loadstring(base64decode("RW50ZXIgeW91ciBsaWNlbnNlIGtleS4="))(), loadstring(base64decode("TGlzYW5zIGFuYWh0YXLEsW7EsSBnaXIu"))(), loadstring(base64decode("R2liIGRlaW5lbiBMaXplbnpzY2hsw7xzc2VsIGVpbi4="))(), loadstring(base64decode("RW50cmV6IHZvdHJlIGNsw6kgZGUgbGljZW5jZS4="))() },
        { loadstring(base64decode("SW52YWxpZCBrZXku"))(), loadstring(base64decode("R2XDp2Vyc2l6IGFuYWh0YXIu"))(), loadstring(base64decode("VW5nw7xsdGlnZXIgU2NobMO8c3NlbC4="))(), loadstring(base64decode("Q2zDqSBpbnZhbGlkZS4="))() },
        { loadstring(base64decode("VGhpcyBrZXkgaXMgYm91bmQgdG8gYW5vdGhlciBkZXZpY2UgKEhXSUQgbWlzbWF0Y2gpLg=="))(), loadstring(base64decode("QnUgYW5haHRhciBiYcWfa2EgYmlyIGNpaGF6YSBiYcSfbMSxIChIV0lEIHV5dcWfbXV5b3IpLg=="))(), loadstring(base64decode("RGllc2VyIFNjaGzDvHNzZWwgaXN0IGFuIGVpbiBhbmRlcmVzIEdlcsOkdCBnZWJ1bmRlbiAoSFdJRCBzdGltbXQgbmljaHQgw7xiZXJlaW4pLg=="))(), loadstring(base64decode("Q2V0dGUgY2zDqSBlc3QgbGnDqWUgw6AgdW4gYXV0cmUgYXBwYXJlaWwgKEhXSUQgZGlmZsOpcmVudCku"))() },
        { loadstring(base64decode("VGhpcyBrZXkgaGFzIGV4cGlyZWQu"))(), loadstring(base64decode("QnUgYW5haHRhcsSxbiBzw7xyZXNpIGRvbG11xZ8u"))(), loadstring(base64decode("RGllc2VyIFNjaGzDvHNzZWwgaXN0IGFiZ2VsYXVmZW4u"))(), loadstring(base64decode("Q2V0dGUgY2zDqSBhIGV4cGlyw6ku"))() },
        { loadstring(base64decode("VGhpcyBrZXkgaGFzIGJlZW4gcmV2b2tlZC4="))(), loadstring(base64decode("QnUgYW5haHRhciBpcHRhbCBlZGlsZGku"))(), loadstring(base64decode("RGllc2VyIFNjaGzDvHNzZWwgd3VyZGUgd2lkZXJydWZlbi4="))(), loadstring(base64decode("Q2V0dGUgY2zDqSBhIMOpdMOpIHLDqXZvcXXDqWUu"))() },
        { loadstring(base64decode("Q291bGQgbm90IHJlYWNoIHRoZSBsaWNlbnNlIHNlcnZlci4="))(), loadstring(base64decode("TGlzYW5zIHN1bnVjdXN1bmEgdWxhxZ/EsWxhbWFkxLEu"))(), loadstring(base64decode("TGl6ZW56c2VydmVyIG5pY2h0IGVycmVpY2hiYXIu"))(), loadstring(base64decode("SW1wb3NzaWJsZSBkZSBqb2luZHJlIGxlIHNlcnZldXIgZGUgbGljZW5jZS4="))() },
        { loadstring(base64decode("SW52YWxpZCBzZXJ2ZXIgcmVzcG9uc2Uu"))(), loadstring(base64decode("R2XDp2Vyc2l6IHN1bnVjdSB5YW7EsXTEsS4="))(), loadstring(base64decode("VW5nw7xsdGlnZSBTZXJ2ZXJhbnR3b3J0Lg=="))(), loadstring(base64decode("UsOpcG9uc2UgZHUgc2VydmV1ciBpbnZhbGlkZS4="))() },
        { loadstring(base64decode("WW91ciBleGVjdXRvciBoYXMgbm8gSFRUUCByZXF1ZXN0IGZ1bmN0aW9uLg=="))(), loadstring(base64decode("RXhlY3V0b3InxLFuZGEgSFRUUCBpc3RlayBmb25rc2l5b251IHlvay4="))(), loadstring(base64decode("RGVpbiBFeGVjdXRvciBoYXQga2VpbmUgSFRUUC1SZXF1ZXN0LUZ1bmt0aW9uLg=="))(), loadstring(base64decode("Vm90cmUgZXjDqWN1dGV1ciBuJ2EgcGFzIGRlIGZvbmN0aW9uIGRlIHJlcXXDqnRlIEhUVFAu"))() },
        { loadstring(base64decode("VG9vIG1hbnkgYXR0ZW1wdHMuIFBsZWFzZSB3YWl0IGEgbW9tZW50Lg=="))(), loadstring(base64decode("w4dvayBmYXpsYSBkZW5lbWUuIEJpcmF6IGJla2xlLg=="))(), loadstring(base64decode("WnUgdmllbGUgVmVyc3VjaGUuIEJpdHRlIHdhcnRlIGt1cnou"))(), loadstring(base64decode("VHJvcCBkZSB0ZW50YXRpdmVzLiBQYXRpZW50ZXogdW4gaW5zdGFudC4="))() },
        { loadstring(base64decode("TGljZW5zZSBjaGVjayBmYWlsZWQuIFNjcmlwdCB3aWxsIHVubG9hZC4="))(), loadstring(base64decode("TGlzYW5zIGtvbnRyb2zDvCBiYcWfYXLEsXPEsXouIFNjcmlwdCBrYWxkxLFyxLFsxLF5b3Iu"))(), loadstring(base64decode("TGl6ZW56cHLDvGZ1bmcgZmVobGdlc2NobGFnZW4uIFNjcmlwdCB3aXJkIGVudGxhZGVuLg=="))(), loadstring(base64decode("w4ljaGVjIGRlIGxhIHbDqXJpZmljYXRpb24uIExlIHNjcmlwdCB2YSBzZSBkw6ljaGFyZ2VyLg=="))() },
        -- güncelleme penceresi
        { loadstring(base64decode("VXBkYXRlIGF2YWlsYWJsZQ=="))(), loadstring(base64decode("R8O8bmNlbGxlbWUgbWV2Y3V0"))(), loadstring(base64decode("VXBkYXRlIHZlcmbDvGdiYXI="))(), loadstring(base64decode("TWlzZSDDoCBqb3VyIGRpc3BvbmlibGU="))() },
        { loadstring(base64decode("UkVDT01NRU5ERUQ="))(), loadstring(base64decode("w5ZORVLEsEzEsFI="))(), loadstring(base64decode("RU1QRk9ITEVO"))(), loadstring(base64decode("UkVDT01NQU5Ew4k="))() },
        { loadstring(base64decode("WW91ciBza2lsbCBjb25maWcgZGlmZmVycyBmcm9tIHRoZSBsYXRlc3QgZGVmYXVsdCBjb25maWcu"))(), loadstring(base64decode("U2tpbGwgY29uZmlnbiBlbiBnw7xuY2VsIHZhcnNhecSxbGFuIGNvbmZpZ2RlbiBmYXJrbMSxLg=="))(), loadstring(base64decode("RGVpbmUgU2tpbGwtQ29uZmlnIHdlaWNodCB2b24gZGVyIG5ldWVzdGVuIFN0YW5kYXJkLUNvbmZpZyBhYi4="))(), loadstring(base64decode("Vm90cmUgY29uZmlnIGRpZmbDqHJlIGRlIGxhIGRlcm5pw6hyZSBjb25maWcgcGFyIGTDqWZhdXQu"))() },
        { loadstring(base64decode("VXBkYXRlIHRvIGRlZmF1bHQgY29uZmln"))(), loadstring(base64decode("VmFyc2F5xLFsYW4gY29uZmlnZSBnw7xuY2VsbGU="))(), loadstring(base64decode("QXVmIFN0YW5kYXJkLUNvbmZpZyBha3R1YWxpc2llcmVu"))(), loadstring(base64decode("TWV0dHJlIMOgIGpvdXIgdmVycyBsYSBjb25maWcgcGFyIGTDqWZhdXQ="))() },
        { loadstring(base64decode("SWYgeW91IGFjY2VwdCwgeW91ciBEZWZhdWx0IHByb2ZpbGUgd2lsbCBiZSBzd2l0Y2hlZCB0byB0aGUgcmVjb21tZW5kZWQgZGVmYXVsdCBjb25maWcuIFlvdXIgY3VycmVudCBjb25maWcgaXMgc2F2ZWQgYXMgYSBiYWNrdXAgcHJvZmlsZS4="))(), loadstring(base64decode("S2FidWwgZWRlcnNlbiBEZWZhdWx0IHByb2ZpbGluIMO2bmVyaWxlbiB2YXJzYXnEsWxhbiBjb25maWdlIGdlw6dpcmlsaXIuIE1ldmN1dCBjb25maWdpbiB5ZWRlayBwcm9maWwgb2xhcmFrIHNha2xhbsSxci4="))(), loadstring(base64decode("V2VubiBkdSB6dXN0aW1tc3QsIHdpcmQgZGVpbiBEZWZhdWx0LVByb2ZpbCBhdWYgZGllIGVtcGZvaGxlbmUgU3RhbmRhcmQtQ29uZmlnIHVtZ2VzdGVsbHQuIERlaW5lIGFrdHVlbGxlIENvbmZpZyB3aXJkIGFscyBCYWNrdXAtUHJvZmlsIGdlc3BlaWNoZXJ0Lg=="))(), loadstring(base64decode("U2kgdm91cyBhY2NlcHRleiwgdm90cmUgcHJvZmlsIERlZmF1bHQgcGFzc2VyYSDDoCBsYSBjb25maWcgcGFyIGTDqWZhdXQgcmVjb21tYW5kw6llLiBWb3RyZSBjb25maWcgYWN0dWVsbGUgZXN0IHNhdXZlZ2FyZMOpZSBkYW5zIHVuIHByb2ZpbCBkZSBzZWNvdXJzLg=="))() },
        { loadstring(base64decode("S2VlcCBteSBjb25maWc="))(), loadstring(base64decode("Q29uZmlnaW1pIGtvcnU="))(), loadstring(base64decode("TWVpbmUgQ29uZmlnIGJlaGFsdGVu"))(), loadstring(base64decode("R2FyZGVyIG1hIGNvbmZpZw=="))() },
        { loadstring(base64decode("WW91IGNhbiBzd2l0Y2ggbGF0ZXIgZnJvbSBTZXR0aW5ncyA+IFJlc3RvcmUgcmVjb21tZW5kZWQgY29uZmlnLg=="))(), loadstring(base64decode("U29ucmEgQXlhcmxhciA+IMOWbmVyaWxlbiBjb25maWdpIGdlcmkgecO8a2xlIGlsZSBnZcOnZWJpbGlyc2luLg=="))(), loadstring(base64decode("U3DDpHRlciB1bnRlciBFaW5zdGVsbHVuZ2VuID4gRW1wZm9obGVuZSBDb25maWcgd2llZGVyaGVyc3RlbGxlbiBtw7ZnbGljaC4="))(), loadstring(base64decode("Vm91cyBwb3VycmV6IGxlIGZhaXJlIHBsdXMgdGFyZCB2aWEgUGFyYW3DqHRyZXMgPiBSZXN0YXVyZXIgbGEgY29uZmlnIHJlY29tbWFuZMOpZS4="))() },
        { loadstring(base64decode("RGVmYXVsdCBjb25maWcgYXBwbGllZC4gQmFja3VwIHNhdmVkIGFzOiA="))(), loadstring(base64decode("VmFyc2F5xLFsYW4gY29uZmlnIHV5Z3VsYW5kxLEuIFllZGVrIMWfdSBhZGxhIGtheWRlZGlsZGk6IA=="))(), loadstring(base64decode("U3RhbmRhcmQtQ29uZmlnIGFuZ2V3ZW5kZXQuIEJhY2t1cCBnZXNwZWljaGVydCBhbHM6IA=="))(), loadstring(base64decode("Q29uZmlnIHBhciBkw6lmYXV0IGFwcGxpcXXDqWUuIFNhdXZlZ2FyZGUgZW5yZWdpc3Ryw6llIHNvdXMgOiA="))() },
    }
    for i = 2, 4 do L.Dict[L.Langs[i]] = {} end
    for _, r in ipairs(rows) do
        for i = 2, 4 do L.Dict[L.Langs[i]][r[1]] = r[i] end
    end
end

-- AUTO EXECUTE (sunucu değişince / teleport olunca scripti kendiliğinden tekrar çalıştırır)
local AUTO_EXEC_URL = loadstring(base64decode("aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL3ZleG9yYXNjL3Rlc3RpbmcvcmVmcy9oZWFkcy9tYWluL2Jlc3RzY3JpcHQubHVh"))()   -- KENDİ RAW LİNKİN

local AutoExec = {}

function AutoExec.Env()
    return (type(getgenv) == loadstring(base64decode("ZnVuY3Rpb24="))() and getgenv()) or _G
end

function AutoExec.Fn()
    local fn
    pcall(function()
        fn = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    end)
    return fn
end

function AutoExec.Queue()
    if not Config.AutoExecute or AUTO_EXEC_URL == loadstring(base64decode(""))() then return end
    local env = AutoExec.Env()
    if env.__VexoraQueued == game.JobId then return end      -- aynı sunucuda çift kuyruğa girmesin
    local fn = AutoExec.Fn()
    if not fn then return end
    env.__VexoraQueued = game.JobId
    pcall(fn, string.format([==[getgenv().VexoraAutoRun = true; loadstring(game:HttpGet(%q))()]==], AUTO_EXEC_URL))
end

-- Kuyruktan gelen çalıştırma: kullanıcı ayarı kapattıysa sessizce çıGgfRx2bY
do
    local env = AutoExec.Env()
    if env.VexoraAutoRun then
        env.VexoraAutoRun = nil
        if not Config.AutoExecute then
            _G.AutoParrySystem = nil
            return
        end
    end
end


-- LICENSE (HWID kilitli key sistemi - license_server.py ile çalışır)

local Lic = {
    Enabled = true,                      -- test için false yapabilirsin
    URL = loadstring(base64decode("aHR0cHM6Ly91bmRlcnN0YW5kaW5nLWFpZC1jb29raW5nLW9tYWhhLnRyeWNsb3VkZmxhcmUuY29t"))(),      -- license_server.py adresin (VPS / tünel)
    SECRET = loadstring(base64decode("OTUwYzEzOTI2MDM0NTg1ZDBmYzI0NTE5MmU2Zjg4N2E="))(),                         -- server_config.json içindeki loadstring(base64decode("c2VjcmV0"))() ile AYNI olmalı
    File = loadstring(base64decode("QXV0b1BhcnJ5X0tleS50eHQ="))(),
    Recheck = 300,                       -- saniye: oturum içi tekrar doğrulama
    Alive = false, Ok = false, Info = nil, Key = nil,
}

function Lic.SHA256(msg)
    local band, bxor, bnot, rrot, rshift = bit32.band, bit32.bxor, bit32.bnot, bit32.rrotate, bit32.rshift
    local K = {
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
    }
    local H = { 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19 }
    local M = 4294967296
    local len = #msg
    local bits = len * 8
    msg = msg .. loadstring(base64decode("XDEyOA=="))() .. string.rep(loadstring(base64decode("XDA="))(), (55 - len) % 64)
        .. string.char(0, 0, 0, 0, band(rshift(bits, 24), 255), band(rshift(bits, 16), 255), band(rshift(bits, 8), 255), band(bits, 255))
    local w = {}
    for i = 1, #msg, 64 do
        for eZOvv25u = 1, 16 do
            local a, b, c, d = string.byte(msg, i + (eZOvv25u - 1) * 4, i + (eZOvv25u - 1) * 4 + 3)
            w[eZOvv25u] = a * 16777216 + b * 65536 + c * 256 + d
        end
        for eZOvv25u = 17, 64 do
            local s0 = bxor(rrot(w[eZOvv25u - 15], 7), rrot(w[eZOvv25u - 15], 18), rshift(w[eZOvv25u - 15], 3))
            local s1 = bxor(rrot(w[eZOvv25u - 2], 17), rrot(w[eZOvv25u - 2], 19), rshift(w[eZOvv25u - 2], 10))
            w[eZOvv25u] = (w[eZOvv25u - 16] + s0 + w[eZOvv25u - 7] + s1) % M
        end
        local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
        for eZOvv25u = 1, 64 do
            local S1 = bxor(rrot(e, 6), rrot(e, 11), rrot(e, 25))
            local ch = bxor(band(e, f), band(bnot(e), g))
            local t1 = (h + S1 + ch + K[eZOvv25u] + w[eZOvv25u]) % M
            local S0 = bxor(rrot(a, 2), rrot(a, 13), rrot(a, 22))
            local maj = bxor(band(a, b), band(a, c), band(b, c))
            local t2 = (S0 + maj) % M
            h, g, f, e, d, c, b, a = g, f, e, (d + t1) % M, c, b, a, (t1 + t2) % M
        end
        H[1] = (H[1] + a) % M; H[2] = (H[2] + b) % M; H[3] = (H[3] + c) % M; H[4] = (H[4] + d) % M
        H[5] = (H[5] + e) % M; H[6] = (H[6] + f) % M; H[7] = (H[7] + g) % M; H[8] = (H[8] + h) % M
    end
    return string.format(loadstring(base64decode("JTA4eCUwOHglMDh4JTA4eCUwOHglMDh4JTA4eCUwOHg="))(), H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8])
end

function Lic.HWID()
    if Lic._hwid then return Lic._hwid end
    local id
    pcall(function() id = game:GetService(loadstring(base64decode("UmJ4QW5hbHl0aWNzU2VydmljZQ=="))()):GetClientId() end)
    if (not id or id == loadstring(base64decode(""))()) and type(gethwid) == loadstring(base64decode("ZnVuY3Rpb24="))() then pcall(function() id = gethwid() end) end
    if (not id or id == loadstring(base64decode(""))()) and CanSaveFiles then
        local f = loadstring(base64decode("QXV0b1BhcnJ5X0hXSUQudHh0"))()
        pcall(function()
            if isfile(f) then id = readfile(f) end
            if not id or id == loadstring(base64decode(""))() then
                id = HttpService:GenerateGUID(false)
                writefile(f, id)
            end
        end)
    end
    Lic._hwid = tostring(id or loadstring(base64decode("dW5rbm93bg=="))())
    return Lic._hwid
end

function Lic.ReqFn()
    local fn
    pcall(function() fn = (syn and syn.request) or (http and http.request) or http_request or request end)
    return fn
end

function Lic.Normalize(s)
    return (tostring(s or loadstring(base64decode(""))()):upper():gsub(loadstring(base64decode("JXM="))(), loadstring(base64decode(""))()))
end

function Lic.ReadKey()
    if not CanSaveFiles then return nil end
    local ok, exists = pcall(function() return isfile(Lic.File) end)
    if not ok or not exists then return nil end
    local ok2, c = pcall(readfile, Lic.File)
    if ok2 and type(c) == loadstring(base64decode("c3RyaW5n"))() then return Lic.Normalize(c) end
    return nil
end

function Lic.SaveKey(GgfRx2bY)
    if CanSaveFiles then pcall(writefile, Lic.File, GgfRx2bY) end
end

function Lic.ClearKey()
    if type(delfile) == loadstring(base64decode("ZnVuY3Rpb24="))() then pcall(delfile, Lic.File)
    elseif CanSaveFiles then pcall(writefile, Lic.File, loadstring(base64decode(""))()) end
end

-- returns ok, info, err (loadstring(base64decode("aW52YWxpZA=="))() | loadstring(base64decode("aHdpZA=="))() | loadstring(base64decode("ZXhwaXJlZA=="))() | loadstring(base64decode("cmV2b2tlZA=="))() | loadstring(base64decode("cmF0ZQ=="))() | loadstring(base64decode("bmV0"))() | loadstring(base64decode("cHJvb2Y="))() | loadstring(base64decode("bm9yZXE="))() | loadstring(base64decode("YmFk"))())
function Lic.Verify(key)
    local fn = Lic.ReqFn()
    if not fn then return false, nil, loadstring(base64decode("bm9yZXE="))() end
    local hwid = Lic.HWID()
    local nonce = string.format(loadstring(base64decode("JWQlZA=="))(), math.random(100000, 2147483647), os.time())
    local okE, body = pcall(function()
        return HttpService:JSONEncode({
            key = key, hwid = hwid, nonce = nonce, uid = LocalPlayer.UserId, name = LocalPlayer.Name, ver = loadstring(base64decode("Ny4w"))(),
        })
    end)
    if not okE then return false, nil, loadstring(base64decode("YmFk"))() end
    local ok, res = pcall(fn, {
        Url = Lic.URL .. loadstring(base64decode("L3ZlcmlmeQ=="))(), Method = loadstring(base64decode("UE9TVA=="))(),
        Headers = { [loadstring(base64decode("Q29udGVudC1UeXBl"))()] = loadstring(base64decode("YXBwbGljYXRpb24vanNvbg=="))() }, Body = body,
    })
    if not ok or type(res) ~= loadstring(base64decode("dGFibGU="))() or type(res.Body) ~= loadstring(base64decode("c3RyaW5n"))() then return false, nil, loadstring(base64decode("bmV0"))() end
    local okD, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
    if not okD or type(data) ~= loadstring(base64decode("dGFibGU="))() then return false, nil, loadstring(base64decode("bmV0"))() end
    if Lic.SECRET ~= loadstring(base64decode(""))() then
        local exp = string.format(loadstring(base64decode("JWQ="))(), tonumber(data.expires) or 0)
        local want = Lic.SHA256(nonce .. loadstring(base64decode("fA=="))() .. key .. loadstring(base64decode("fA=="))() .. hwid .. loadstring(base64decode("fA=="))() .. (data.ok and loadstring(base64decode("MQ=="))() or loadstring(base64decode("MA=="))()) .. loadstring(base64decode("fA=="))() .. exp .. loadstring(base64decode("fA=="))() .. Lic.SECRET)
        if data.proof ~= want then return false, nil, loadstring(base64decode("cHJvb2Y="))() end
    end
    if data.ok ~= true then return false, nil, tostring(data.reason or loadstring(base64decode("aW52YWxpZA=="))()) end
    local now = tonumber(data.now) or os.time()
    return true, { type = tostring(data.type or loadstring(base64decode("Y3VzdG9t"))()), expires = tonumber(data.expires) or 0, offset = now - os.time() }
end

Lic.Msgs = {
    invalid = loadstring(base64decode("SW52YWxpZCBrZXku"))(), bad = loadstring(base64decode("SW52YWxpZCBrZXku"))(),
    hwid = loadstring(base64decode("VGhpcyBrZXkgaXMgYm91bmQgdG8gYW5vdGhlciBkZXZpY2UgKEhXSUQgbWlzbWF0Y2gpLg=="))(),
    expired = loadstring(base64decode("VGhpcyBrZXkgaGFzIGV4cGlyZWQu"))(), revoked = loadstring(base64decode("VGhpcyBrZXkgaGFzIGJlZW4gcmV2b2tlZC4="))(),
    net = loadstring(base64decode("Q291bGQgbm90IHJlYWNoIHRoZSBsaWNlbnNlIHNlcnZlci4="))(), proof = loadstring(base64decode("SW52YWxpZCBzZXJ2ZXIgcmVzcG9uc2Uu"))(),
    noreq = loadstring(base64decode("WW91ciBleGVjdXRvciBoYXMgbm8gSFRUUCByZXF1ZXN0IGZ1bmN0aW9uLg=="))(), rate = loadstring(base64decode("VG9vIG1hbnkgYXR0ZW1wdHMuIFBsZWFzZSB3YWl0IGEgbW9tZW50Lg=="))(),
}
function Lic.Msg(e) return L.T(Lic.Msgs[e] or loadstring(base64decode("SW52YWxpZCBrZXku"))()) end

function Lic.Prompt(firstMsg, prefill)
    local gui = Create(loadstring(base64decode("U2NyZWVuR3Vp"))(), {
        Name = loadstring(base64decode("QXV0b1BhcnJ5TGljZW5zZQ=="))(), ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 50,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = GetGuiParent(),
    })
    local card = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.fromOffset(380, 270), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = gui,
    })
    Corner(card, 12)
    Stroke(card, Theme.Accent)
    Create(loadstring(base64decode("VUlHcmFkaWVudA=="))(), { Color = ColorSequence.new(Color3.fromRGB(30, 46, 68), Color3.fromRGB(14, 21, 33)), Rotation = 90, Parent = card })
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -60, 0, 24), Position = UDim2.new(0, 22, 0, 16), BackgroundTransparency = 1, Text = loadstring(base64decode("VkVYT1JB"))(),
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -44, 0, 16), Position = UDim2.new(0, 22, 0, 42), BackgroundTransparency = 1, Text = loadstring(base64decode("TGljZW5zZSBhY3RpdmF0aW9u"))(),
        TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })
    local closeB = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, -38, 0, 14), BackgroundColor3 = Theme.Raised, Text = loadstring(base64decode("WA=="))(),
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 12, BorderSizePixel = 0, Parent = card,
    })
    Corner(closeB, 6)

    local boxFrame = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -44, 0, 46), Position = UDim2.new(0, 22, 0, 80), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = card,
    })
    Corner(boxFrame, 8)
    local boxStroke = Stroke(boxFrame)
    local box = Create(loadstring(base64decode("VGV4dEJveA=="))(), {
        Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1,
        Text = prefill or loadstring(base64decode(""))(), PlaceholderText = loadstring(base64decode("WFhYWC1YWFhYLVhYWFgtWFhYWA=="))(), PlaceholderColor3 = Theme.Muted,
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 16, ClearTextOnFocus = false, Parent = boxFrame,
    })
    box.Focused:Connect(function() boxStroke.Color = Theme.Accent end)
    box.FocusLost:Connect(function() boxStroke.Color = Theme.Stroke end)

    local status = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -44, 0, 36), Position = UDim2.new(0, 22, 0, 134), BackgroundTransparency = 1, Text = loadstring(base64decode(""))(),
        TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = card,
    })
    local function setStatus(msg, color)
        status.Text = L.T(msg)
        status.TextColor3 = color or Theme.SubText
    end
    if firstMsg then status.Text = firstMsg; status.TextColor3 = Theme.Bad end

    local btn = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = UDim2.new(1, -44, 0, 42), Position = UDim2.new(0, 22, 0, 178), BackgroundColor3 = Theme.Accent, Text = loadstring(base64decode("QWN0aXZhdGU="))(),
        TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0, Parent = card,
    })
    Corner(btn, 8)
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -44, 0, 14), Position = UDim2.new(0, 22, 1, -30), BackgroundTransparency = 1,
        Text = loadstring(base64decode("SFdJRDog"))() .. Lic.HWID():sub(1, 14), TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
    })

    local result, busy = nil, false
    local function submit()
        if busy then return end
        local key = Lic.Normalize(box.Text)
        if #key < 8 then setStatus(loadstring(base64decode("RW50ZXIgeW91ciBsaWNlbnNlIGtleS4="))(), Theme.Warn) return end
        busy = true
        setStatus(loadstring(base64decode("Q2hlY2tpbmcuLi4="))(), Theme.SubText)
        task.spawn(function()
            local ok, info, err = Lic.Verify(key)
            busy = false
            if ok then
                Lic.Key, Lic.Info = key, info
                Lic.SaveKey(key)
                setStatus(loadstring(base64decode("TGljZW5zZSBhY3RpdmF0ZWQh"))(), Theme.Good)
                task.wait(0.6)
                result = true
            else
                status.Text = Lic.Msg(err)
                status.TextColor3 = Theme.Bad
            end
        end)
    end
    btn.MouseButton1Click:Connect(submit)
    box.FocusLost:Connect(function(enter) if enter then submit() end end)
    closeB.MouseButton1Click:Connect(function() result = false end)

    while result == nil do task.wait(0.1) end
    gui:Destroy()
    return result
end

function Lic.UpdateLabel()
    local lbl = Lic.UI and Lic.UI.LicenseLabel
    if not lbl then return end
    local i = Lic.Info
    local line
    if not Lic.Enabled or not i then
        line = L.T(loadstring(base64decode("TGljZW5zZQ=="))()) .. loadstring(base64decode("OiAt"))()
    elseif i.expires == 0 then
        line = L.T(loadstring(base64decode("TGljZW5zZQ=="))()) .. loadstring(base64decode("OiA="))() .. L.T(i.type) .. loadstring(base64decode("ICg="))() .. L.T(loadstring(base64decode("bmV2ZXIgZXhwaXJlcw=="))()) .. loadstring(base64decode("KQ=="))()
    else
        local rem = math.max(0, i.expires - (os.time() + i.offset))
        line = string.format(loadstring(base64decode("JXM6ICVzICglcyAlZGQgJTAyZGggJTAyZG0p"))(), L.T(loadstring(base64decode("TGljZW5zZQ=="))()), L.T(i.type), L.T(loadstring(base64decode("ZXhwaXJlcyBpbg=="))()),
            math.floor(rem / 86400), math.floor((rem % 86400) / 3600), math.floor((rem % 3600) / 60))
    end
    lbl.Text = line .. loadstring(base64decode("XG5IV0lEOiA="))() .. Lic.HWID():sub(1, 12)
end

function Lic.StartRecheck()
    if not Lic.Enabled or Lic.Started then return end
    Lic.Started = true
    task.spawn(function()
        while Lic.Alive do
            task.wait(Lic.Recheck)
            if not Lic.Alive then break end
            local ok, info, err = Lic.Verify(Lic.Key)
            if ok then
                Lic.Info = info
            elseif err ~= loadstring(base64decode("bmV0"))() then   -- ağ hatasında oturum kapatılmaz
                if Lic.UI and Lic.UI.Toast then Lic.UI.Toast(L.T(loadstring(base64decode("TGljZW5zZSBjaGVjayBmYWlsZWQuIFNjcmlwdCB3aWxsIHVubG9hZC4="))()), true) end
                task.wait(3)
                if _G.AutoParrySystem and _G.AutoParrySystem.Unload then _G.AutoParrySystem.Unload() end
                break
            end
        end
    end)
end

if Lic.Enabled then
    local key = Lic.ReadKey()
    local ok, info, err = false, nil, nil
    if key and key ~= loadstring(base64decode(""))() then ok, info, err = Lic.Verify(key) end
    if ok then
        Lic.Key, Lic.Info, Lic.Ok = key, info, true
    else
        Lic.Ok = Lic.Prompt(err and Lic.Msg(err) or nil, key)
    end
else
    Lic.Ok = true
end
if not Lic.Ok then
    _G.AutoParrySystem = nil
    return
end
Lic.Alive = true
AutoExec.Queue()



-- STATE

local Profiles = {}          -- [isim] = skill listesi
local ActiveProfile = loadstring(base64decode("RGVmYXVsdA=="))()
local Skills = {}            -- aktif profilin listesi (Profiles[ActiveProfile])
local SkillRows = {}
local SelectedSkillId = nil
local SkillSearch = loadstring(base64decode(""))()

local Discovered = {}        -- [ident] = entry
local DiscoveredRows = {}    -- [ident] = row
local DiscoveredCount = 0
local Dirty = {}             -- [ident] = true
local DiscoverySeq = 0
local DiscoverySearch = loadstring(base64decode(""))()
local DiscoverySort = loadstring(base64decode("TmV3ZXN0"))()
local TypeFilter = loadstring(base64decode("QWxs"))()
local ResortScheduled = false

local Monitor = { Target = nil, Paused = false }   -- Target: nil = kapalı, loadstring(base64decode("Kg=="))() = herkes, loadstring(base64decode("bnBj"))() = NPC'ler, yoksa oyuncu adı

local ParryStore   = {}      -- [key] = rec
local MonitorStore = {}      -- [key] = rec
local Sources      = {}      -- [player] = src
local Npcs         = {}      -- [model] = src
local NpcConns     = {}
local NpcSerial    = 0
local Pollers      = {}      -- polling ile taranan Animator'lar
local NpcScanOn    = false

local ParryRuntime = {
    TriggeredTracks = setmetatable({}, { __mode = loadstring(base64decode("aw=="))() }),
}
local Fresh = setmetatable({}, { __mode = loadstring(base64decode("aw=="))() })   -- yeni eklenen instance'lar (iç parçaları ayıklamak için)
local Capturing = false      -- tuş atama sırasında GgfRx2bYısayolları devre dışı bırakır

local Learned = {}           -- [ident] = { vuruş zamanları }
local Recent = {}            -- son başlayan skill olayları
local HitStamp = 0           -- en son hasar aldığın an
-- SelfAct: kendi son skill aksiyonunun zamanı (kendi nesneni yok saymak için)
local LocalHealth = { Conn = nil, Last = 0, Anim = nil, SelfAct = 0 }

local KeyHeld, HeldKey, KeyToken, HeldSince = false, nil, 0, 0

local PreviewState = {
    Dummy = nil, Animator = nil, Track = nil, Camera = nil, WorldModel = nil,
    CamDistance = 9, CamYaw = 180, CamPitch = 10, Paused = false,
    CurrentAnimId = nil, CurrentAnimName = nil, SourcePlayer = nil,
}

local UI = {}
local function DestroySnaps()
    local function kill(src: any)
        if src and src.Snap then
            pcall(function() src.Snap:Destroy() end)
            src.Snap = nil
        end
    end
    for _, e in Discovered do kill(e.LastSrc) end
    for _, s in Sources do kill(s) end
    for _, s in Npcs do kill(s) end
    UI.SnapCount = 0
end
local Connections = {}
local OpenDropdownList = nil

-- Performans yardımcıları: yerel karakter önbelleği, animator tarama sayacı, bounding-box önbelleği
local Poll = { Tick = 0, BB = setmetatable({}, { __mode = loadstring(base64decode("aw=="))() }) }

function Poll.Local()
    local ch = LocalPlayer.Character
    if ch ~= Poll.Char or not Poll.Root or not Poll.Root.Parent then
        Poll.Char = ch
        Poll.Root = ch and ch:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) or nil
        Poll.Hum = ch and ch:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))()) or nil
    end
    return Poll.Root, Poll.Hum
end

function Poll.EntryRoot(entry)
    local r = entry.Root
    if r and r.Parent then return r end
    local char = entry.Src.GetChar()
    r = char and (char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) or char.PrimaryPart) or nil
    entry.Root = r
    return r
end


-- SKILL HELPERS (Skill / Anim / Object - birbirinden bağımsıhDmnWKlx)

local function EffectiveKey(skill)
    local GgfRx2bY = Trim(skill.Key)
    if GgfRx2bY ~= loadstring(base64decode(""))() then return GgfRx2bY end
    return skill.Name
end

local function SkillIdent(skill)
    if skill.Type == loadstring(base64decode("U2tpbGw="))() then
        return loadstring(base64decode("c2tpbGw6"))() .. EffectiveKey(skill):lower()
    elseif skill.Type == loadstring(base64decode("T2JqZWN0"))() then
        return loadstring(base64decode("b2JqZWN0Og=="))() .. skill.ObjName:lower() .. loadstring(base64decode("QA=="))() .. skill.ObjParent:lower()
    end
    return loadstring(base64decode("YW5pbTo="))() .. skill.AnimId
end

-- Anim: a = animId | Skill: a = anahtar | Object: a = isim, b = parent adı
local function SkillMatches(s, kind, a, b)
    if s.Type ~= kind then return false end
    if kind == loadstring(base64decode("QW5pbQ=="))() then return s.AnimId ~= loadstring(base64decode(""))() and s.AnimId == a end
    if kind == loadstring(base64decode("U2tpbGw="))() then return EffectiveKey(s):lower() == a:lower() end
    return s.ObjName ~= loadstring(base64decode(""))() and s.ObjName:lower() == a:lower()
        and (s.ObjParent == loadstring(base64decode(""))() or s.ObjParent:lower() == (b or loadstring(base64decode(""))()):lower())
end

local function FindSkill(kind, a, b, anyState)
    for _, s in ipairs(Skills) do
        if (anyState or s.Enabled) and SkillMatches(s, kind, a, b) then return s end
    end
    return nil
end

local function SkillForEntry(entry)
    local a = entry.AnimId
    if entry.Kind == loadstring(base64decode("U2tpbGw="))() then a = entry.Key elseif entry.Kind == loadstring(base64decode("T2JqZWN0"))() then a = entry.ObjName end
    return FindSkill(entry.Kind, a, entry.ObjParent, true)
end

local function LearnedAvg(ident)
    local l = Learned[ident]
    if not l or #l == 0 then return nil end
    local sum = 0
    for _, v in ipairs(l) do sum += v end
    return sum / #l
end


-- OUTFIT (Misc) - sadece senin client'ında görünür

local Outfit = { Worn = nil }
local OutfitNames, RemoveOutfit, ApplyOutfitOffset, WearOutfit
do

local function ClothingFolder()
    return ReplicatedStorage:FindFirstChild(loadstring(base64decode("Q2xvdGhpbmc="))()) or ReplicatedStorage:FindFirstChild(loadstring(base64decode("Q2xvdGhpbmc="))(), true)
end

-- Normal / Broken klasörü olan her GgfRx2bYıyafet listelenir
function OutfitNames()
    local names = {}
    local folder = ClothingFolder()
    if folder then
        for _, c in ipairs(folder:GetChildren()) do
            if c:FindFirstChild(loadstring(base64decode("Tm9ybWFs"))()) or c:FindFirstChild(loadstring(base64decode("QnJva2Vu"))()) then table.insert(names, c.Name) end
        end
    end
    table.sort(names)
    return names
end

-- ---------- Mevcut armoru gizleme (v7.1: 7GzvlMabıGgfRx2bYıcı değil, baş bölgesi korumalı) ----------
local BodyNames = {}
for _, n in ipairs({
    loadstring(base64decode("aGVhZA=="))(), loadstring(base64decode("dG9yc28="))(), loadstring(base64decode("aHVtYW5vaWRyb290cGFydA=="))(), loadstring(base64decode("bGVmdCBhcm0="))(), loadstring(base64decode("cmlnaHQgYXJt"))(), loadstring(base64decode("bGVmdCBsZWc="))(), loadstring(base64decode("cmlnaHQgbGVn"))(),
    loadstring(base64decode("dXBwZXJ0b3Jzbw=="))(), loadstring(base64decode("bG93ZXJ0b3Jzbw=="))(),
    loadstring(base64decode("bGVmdHVwcGVyYXJt"))(), loadstring(base64decode("bGVmdGxvd2VyYXJt"))(), loadstring(base64decode("bGVmdGhhbmQ="))(), loadstring(base64decode("cmlnaHR1cHBlcmFybQ=="))(), loadstring(base64decode("cmlnaHRsb3dlcmFybQ=="))(), loadstring(base64decode("cmlnaHRoYW5k"))(),
    loadstring(base64decode("bGVmdHVwcGVybGVn"))(), loadstring(base64decode("bGVmdGxvd2VybGVn"))(), loadstring(base64decode("bGVmdGZvb3Q="))(), loadstring(base64decode("cmlnaHR1cHBlcmxlZw=="))(), loadstring(base64decode("cmlnaHRsb3dlcmxlZw=="))(), loadstring(base64decode("cmlnaHRmb290"))(),
    loadstring(base64decode("aHVtYW5vaWQ="))(), loadstring(base64decode("YW5pbWF0ZQ=="))(), loadstring(base64decode("aGVhbHRo"))(), loadstring(base64decode("Ym9keSBjb2xvcnM="))(), loadstring(base64decode("c2hpcnQ="))(), loadstring(base64decode("cGFudHM="))(), loadstring(base64decode("c2hpcnQgZ3JhcGhpYw=="))(), loadstring(base64decode("ZmFjZQ=="))(),
    loadstring(base64decode("Y2xpZW50b3V0Zml0"))(),
}) do BodyNames[n] = true end

local GenericNames = { handle = true, part = true, meshpart = true, union = true, model = true,
    normal = true, broken = true, rootpart = true, wedge = true, base = true }

-- Bu kelimeleri içeren isimler asla gizlenmez (saç, 7GzvlMabühDmnWKlx, kafa vb.)
local HeadWords = {
    loadstring(base64decode("aGFpcg=="))(), loadstring(base64decode("aGVhZA=="))(), loadstring(base64decode("ZmFjZQ=="))(), loadstring(base64decode("ZXll"))(), loadstring(base64decode("YnJvdw=="))(), loadstring(base64decode("YmVhcmQ="))(), loadstring(base64decode("bXVzdGFjaGU="))(), loadstring(base64decode("bW91c3RhY2hl"))(), loadstring(base64decode("bW91dGg="))(), loadstring(base64decode("bm9zZQ=="))(),
    loadstring(base64decode("bGFzaA=="))(), loadstring(base64decode("c2NhbHA="))(), loadstring(base64decode("ZnJpbmdl"))(), loadstring(base64decode("cG9ueXRhaWw="))(), loadstring(base64decode("YnJhaWQ="))(), loadstring(base64decode("c2t1bGw="))(), loadstring(base64decode("aGF0"))(), loadstring(base64decode("aGVsbQ=="))(), loadstring(base64decode("aG9vZA=="))(), loadstring(base64decode("bWFzaw=="))(),
    loadstring(base64decode("Y3Jvd24="))(), loadstring(base64decode("aG9ybg=="))(), loadstring(base64decode("Z2xhc3Nlcw=="))(), loadstring(base64decode("aGVhZGJhbmQ="))(),
}
local HeadAccTypes = { Hat = true, Hair = true, Face = true, Eyebrow = true, Eyelash = true }

local function ArmorNameSet()
    local set = {}
    local folder = ClothingFolder()
    if not folder then return set end
    for _, o in ipairs(folder:GetChildren()) do
        local on = o.Name:lower()
        if not BodyNames[on] and not GenericNames[on] then set[on] = true end
        for _, d in ipairs(o:GetDescendants()) do
            if d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or d:IsA(loadstring(base64decode("TW9kZWw="))()) or d:IsA(loadstring(base64decode("QWNjZXNzb3J5"))()) then
                local n = d.Name:lower()
                if not BodyNames[n] and not GenericNames[n] then set[n] = true end
            end
        end
    end
    return set
end

local function PartsOf(inst)
    local t = {}
    if inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then t[1] = inst end
    for _, d in ipairs(inst:GetDescendants()) do
        if d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then t[#t + 1] = d end
    end
    return t
end

-- instance'ın TÜM parçaları boyun hizasının üstünde ve kafaya yakınsa = baş eşyası
local function InHeadZone(inst, head)
    if not head or not head.Parent then return false end
    local parts = PartsOf(inst)
    if #parts == 0 then return false end
    local hs = head.Size
    local reach = math.max(hs.X, hs.Z) * 1.6
    local hcf = head.CFrame
    for _, p in ipairs(parts) do
        local lp = hcf:PointToObjectSpace(p.Position)
        if lp.Y < -hs.Y * 0.5 - 0.25 or math.sqrt(lp.X * lp.X + lp.Z * lp.Z) > reach then return false end
    end
    return true
end

local function IsHeadStuff(inst, char, head)
    local cur = inst
    while cur and cur ~= char do
        if cur == head then return true end
        local n = cur.Name:lower()
        for _, w in ipairs(HeadWords) do
            if n:find(w, 1, true) then return true end
        end
        if cur:IsA(loadstring(base64decode("QWNjZXNzb3J5"))()) then
            local ok, t = pcall(function() return cur.AccessoryType.Name end)
            if ok and HeadAccTypes[t] then return true end
        end
        cur = cur.Parent
    end
    local top = inst
    while top.Parent and top.Parent ~= char do top = top.Parent end
    return InHeadZone(top, head) or InHeadZone(inst, head)
end

local function IsArmorInstance(inst, char, worn, names, head)
    if not (inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or inst:IsA(loadstring(base64decode("TW9kZWw="))()) or inst:IsA(loadstring(base64decode("QWNjZXNzb3J5"))())) then return false end
    if inst == char or not inst:IsDescendantOf(char) then return false end
    for _, a in ipairs(worn.Added) do
        if inst == a or inst:IsDescendantOf(a) then return false end   -- bizim giydirdiğimiz parçalar
    end
    if inst:FindFirstAncestorOfClass(loadstring(base64decode("VG9vbA=="))()) then return false end
    local n = inst.Name:lower()
    if BodyNames[n] or GenericNames[n] then return false end
    if IsHeadStuff(inst, char, head) then return false end
    if inst.Parent == char and not inst:IsA(loadstring(base64decode("QWNjZXNzb3J5"))()) then return true end
    return names[n] == true
end

-- Hiçbir şey silinmez / reparent edilmez: sadece Transparency = 1, kaldırınca eski değere döner
local function Conceal(worn, inst)
    worn.Roots[inst] = true
    local list = {}
    if inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then list[1] = inst end
    for _, d in ipairs(inst:GetDescendants()) do
        if d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or d:IsA(loadstring(base64decode("RGVjYWw="))()) or d:IsA(loadstring(base64decode("VGV4dHVyZQ=="))()) then list[#list + 1] = d end
    end
    for _, o in ipairs(list) do
        if not worn.HiddenSet[o] then
            local ok, orig = pcall(function() return o.Transparency end)
            if ok and orig < 1 then
                local conn = o:GetPropertyChangedSignal(loadstring(base64decode("VHJhbnNwYXJlbmN5"))()):Connect(function()
                    if Outfit.Worn == worn and o.Transparency ~= 1 then o.Transparency = 1 end
                end)
                worn.HiddenSet[o] = true
                table.insert(worn.Hidden, { Inst = o, Orig = orig, Conn = conn })
                o.Transparency = 1
            end
        end
    end
end

local function HideArmor(worn, names)
    local char = worn.Char
    local head = char:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
    for _, d in ipairs(char:GetDescendants()) do
        if d.Parent and not worn.HiddenSet[d] and IsArmorInstance(d, char, worn, names, head) then
            Conceal(worn, d)
        end
    end
end

function RemoveOutfit()
    local w = Outfit.Worn
    if not w then return end
    Outfit.Worn = nil
    if w.Conn then pcall(function() w.Conn:Disconnect() end) end
    for _, inst in ipairs(w.Added) do pcall(function() inst:Destroy() end) end
    for _, h in ipairs(w.Hidden) do
        pcall(function()
            h.Conn:Disconnect()
            if h.Inst.Parent then h.Inst.Transparency = h.Orig end
        end)
    end
    for _, cn in ipairs(w.Conns or {}) do pcall(function() cn:Disconnect() end) end
    for _, c in ipairs(w.Cloth) do
        pcall(function() if c.Inst.Parent then c.Inst[c.Prop] = c.Orig end end)
    end
end

-- Offset: HRP rest-pose uzayında uygulanır (uzvun o anki dönüşünden bağımsıhDmnWKlx)
-- C0 = Pre * Offset * Post
function ApplyOutfitOffset()
    local w = Outfit.Worn
    if not w or not w.Welds then return end
    local body = CFrame.new(Config.OutfitX, Config.OutfitY, Config.OutfitZ)
    local limb = CFrame.new(Config.LimbX, Config.LimbY, Config.LimbZ)
    for _, e in ipairs(w.Welds) do
        if e.Weld.Parent then
            e.Weld.C0 = e.Pre * (e.Group == loadstring(base64decode("TGltYg=="))() and limb or body) * e.Post
        end
    end
end

-- ---------- İsimden uzuv tespiti ----------
-- Kısaltmalar: LA / RA / LL / RL / T ... (MeshPart adı sadece loadstring(base64decode("TEE="))() olabiliyor)
local NameAbbrev = {
    la = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("TA=="))() }, lua = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("TA=="))() }, lla = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("TA=="))() }, lfa = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("TA=="))() },
    ra = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("Ug=="))() }, rua = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("Ug=="))() }, rla = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("Ug=="))() }, rfa = { loadstring(base64decode("QXJt"))(), loadstring(base64decode("Ug=="))() },
    ll = { loadstring(base64decode("TGVn"))(), loadstring(base64decode("TA=="))() }, lul = { loadstring(base64decode("TGVn"))(), loadstring(base64decode("TA=="))() }, lll = { loadstring(base64decode("TGVn"))(), loadstring(base64decode("TA=="))() },
    rl = { loadstring(base64decode("TGVn"))(), loadstring(base64decode("Ug=="))() }, rul = { loadstring(base64decode("TGVn"))(), loadstring(base64decode("Ug=="))() }, rll = { loadstring(base64decode("TGVn"))(), loadstring(base64decode("Ug=="))() },
    t = { loadstring(base64decode("VG9yc28="))() }, ut = { loadstring(base64decode("VG9yc28="))() },
}
local KindWords = {
    Torso = { loadstring(base64decode("dG9yc28="))(), loadstring(base64decode("Y2hlc3Q="))() },
    Arm   = { loadstring(base64decode("YXJt"))(), loadstring(base64decode("aGFuZA=="))(), loadstring(base64decode("c2hvdWxkZXI="))(), loadstring(base64decode("c2xlZXZl"))(), loadstring(base64decode("Z2xvdmU="))(), loadstring(base64decode("YnJhY2Vy"))(), loadstring(base64decode("Z2F1bnRsZXQ="))(), loadstring(base64decode("d3Jpc3Q="))(), loadstring(base64decode("ZWxib3c="))() },
    Leg   = { loadstring(base64decode("bGVn"))(), loadstring(base64decode("Zm9vdA=="))(), loadstring(base64decode("ZmVldA=="))(), loadstring(base64decode("dGhpZ2g="))(), loadstring(base64decode("c2hpbg=="))(), loadstring(base64decode("a25lZQ=="))(), loadstring(base64decode("Ym9vdA=="))(), loadstring(base64decode("c2hvZQ=="))(), loadstring(base64decode("Z3JlYXZl"))(), loadstring(base64decode("c2FuZGFs"))(), loadstring(base64decode("Y2FsZg=="))() },
}
local KindOrder = { loadstring(base64decode("VG9yc28="))(), loadstring(base64decode("QXJt"))(), loadstring(base64decode("TGVn"))() }
local SideTails = { loadstring(base64decode("YXJt"))(), loadstring(base64decode("bGVn"))(), loadstring(base64decode("aGFuZA=="))(), loadstring(base64decode("Zm9vdA=="))(), loadstring(base64decode("dXBwZXI="))(), loadstring(base64decode("bG93ZXI="))(), loadstring(base64decode("c2hvdWxkZXI="))(), loadstring(base64decode("dGhpZ2g="))(), loadstring(base64decode("c2hpbg=="))(), loadstring(base64decode("Zm9yZWFybQ=="))() }

local function SideOfName(raw)
    local s = raw:lower()
    if s:find(loadstring(base64decode("bGVmdA=="))(), 1, true) then return loadstring(base64decode("TA=="))() end
    if s:find(loadstring(base64decode("cmlnaHQ="))(), 1, true) then return loadstring(base64decode("Ug=="))() end
    if s:match(loadstring(base64decode("XmxbJXNfJS0lLl0="))()) or s:match(loadstring(base64decode("WyVzXyUtJS5dbCQ="))()) then return loadstring(base64decode("TA=="))() end
    if s:match(loadstring(base64decode("XnJbJXNfJS0lLl0="))()) or s:match(loadstring(base64decode("WyVzXyUtJS5dciQ="))()) then return loadstring(base64decode("Ug=="))() end
    local c = (s:gsub(loadstring(base64decode("WyVzXyUtJS5d"))(), loadstring(base64decode(""))()))
    local f, rest = c:sub(1, 1), c:sub(2)
    if f == loadstring(base64decode("bA=="))() or f == loadstring(base64decode("cg=="))() then
        for _, w in ipairs(SideTails) do
            if rest:sub(1, #w) == w then return (f == loadstring(base64decode("bA=="))()) and loadstring(base64decode("TA=="))() or loadstring(base64decode("Ug=="))() end
        end
    end
    return nil
end

-- returns kind (loadstring(base64decode("QXJt"))() | loadstring(base64decode("TGVn"))() | loadstring(base64decode("VG9yc28="))() | nil), side (loadstring(base64decode("TA=="))() | loadstring(base64decode("Ug=="))() | nil)
local function ParseName(raw)
    local c = (raw:lower():gsub(loadstring(base64decode("WyVzXyUtJS5d"))(), loadstring(base64decode(""))()))
    local ab = NameAbbrev[c]
    if ab then return ab[1], ab[2] end
    -- loadstring(base64decode("YXJtb3I="))() / loadstring(base64decode("YXJtYXR1cmU="))() / loadstring(base64decode("aGFuZGxl"))() yanlışlıkla kol sayılmasın
    local GgfRx2bY = (c:gsub(loadstring(base64decode("YXJtb3U/cg=="))(), loadstring(base64decode(""))()):gsub(loadstring(base64decode("YXJtYXR1cmU="))(), loadstring(base64decode(""))()):gsub(loadstring(base64decode("aGFuZGxl"))(), loadstring(base64decode(""))()))
    local kind
    for _, kd in ipairs(KindOrder) do
        for _, w in ipairs(KindWords[kd]) do
            if GgfRx2bY:find(w, 1, true) then kind = kd break end
        end
        if kind then break end
    end
    return kind, SideOfName(raw)
end

-- Parçanın kendi adına ve (clone'a kadar) üst klasör/model adlarına bakar; en yakın eşleşme kazanır
local function ClassifyPart(p, stop)
    local kind, side
    local cur = p
    while cur and cur ~= stop do
        local GgfRx2bY, s = ParseName(cur.Name)
        if GgfRx2bY and not kind then kind = GgfRx2bY end
        if s and not side then side = s end
        cur = cur.Parent
    end
    return kind, side
end

-- R6 isimleri + R6'daki sabit konum (HumanoidRootPart'a göre); R15'te konum canlı hesaplanır
local LimbR6 = {
    ArmL = { loadstring(base64decode("TGVmdCBBcm0="))(), CFrame.new(-1.5, 0, 0) }, ArmR = { loadstring(base64decode("UmlnaHQgQXJt"))(), CFrame.new(1.5, 0, 0) },
    LegL = { loadstring(base64decode("TGVmdCBMZWc="))(), CFrame.new(-0.5, -2, 0) }, LegR = { loadstring(base64decode("UmlnaHQgTGVn"))(), CFrame.new(0.5, -2, 0) },
}
local LimbR15 = {
    ArmL = loadstring(base64decode("TGVmdFVwcGVyQXJt"))(), ArmR = loadstring(base64decode("UmlnaHRVcHBlckFybQ=="))(), LegL = loadstring(base64decode("TGVmdFVwcGVyTGVn"))(), LegR = loadstring(base64decode("UmlnaHRVcHBlckxlZw=="))(),
}

-- Varsayılan konumlar. Anahtar: GgfRx2bYıyafet adının GgfRx2bYüçüGgfRx2bY harf / harf-dışı-karaktersiz hali (içeriyorsa eşleşir)
local DefaultOffsets = {
    { loadstring(base64decode("YXNjZW5kZWRhbmJ1"))(),      -0.03,  0.13, -0.01 },
    { loadstring(base64decode("YXNjZW5kZWRha2F0c3VraQ=="))(),   0.00, -1.72, -0.04,   0.00, -1.73, -0.01 },
    { loadstring(base64decode("YWthdHN1a2lsZWFkZXI="))(),     0.00,  0.07,  0.00,   0.00, 0.06, 0.00 },
    { loadstring(base64decode("YXZlbmdlcnM="))(),           0.01,  0.26,  0.11,   0.00, 0.11, -0.01 },
    { loadstring(base64decode("YXZhbmdlcnM="))(),           0.01,  0.26,  0.11,   0.00, 0.11, -0.01 },
    { loadstring(base64decode("ZGVzZXJ0YXBwcmVudGljZQ=="))(),   0.00,  0.03, -0.01 },
    { loadstring(base64decode("ZHVyYW5h"))(),            -0.01,  0.06, -0.01 },
    { loadstring(base64decode("ZmlnaHRlcnM="))(),           0.00,  0.07,  0.00 },
    { loadstring(base64decode("bW9vbnJhZ3M="))(),           0.00,  0.00,  0.00 },
    { loadstring(base64decode("b3JhbmdlanVtcHN1aXQ="))(),     0.00,  0.36,  0.55 },
    { loadstring(base64decode("cmVhbmltYXRlZGNsb2Fr"))(),   -0.04, -1.48, -0.14,   0.00, 0.09, 0.00 },   -- gövde, kol/bacak
}

-- Kıyafet için ofseti seçer (kullanıcı kaydı > varsayılan > 0) ve slider'ları günceller
local function LoadOffset(name)
    local UTZeUWBZ, 7GzvlMab, hDmnWKlx, lx, ly, lz = 0, 0, 0, 0, 0, 0
    local saved = Config.OutfitOffsets[name]
    if type(saved) == loadstring(base64decode("dGFibGU="))() then
        UTZeUWBZ, 7GzvlMab, hDmnWKlx = saved[1] or 0, saved[2] or 0, saved[3] or 0
        lx, ly, lz = saved[4] or UTZeUWBZ, saved[5] or 7GzvlMab, saved[6] or hDmnWKlx
    else
        local key = (name:lower():gsub(loadstring(base64decode("W14lYV0="))(), loadstring(base64decode(""))()))
        for _, d in ipairs(DefaultOffsets) do
            if key:find(d[1], 1, true) then
                UTZeUWBZ, 7GzvlMab, hDmnWKlx = d[2], d[3], d[4]
                lx, ly, lz = d[5] or UTZeUWBZ, d[6] or 7GzvlMab, d[7] or hDmnWKlx
                break
            end
        end
    end
    Config.OutfitX, Config.OutfitY, Config.OutfitZ = UTZeUWBZ, 7GzvlMab, hDmnWKlx
    Config.LimbX, Config.LimbY, Config.LimbZ = lx, ly, lz
    local sl = UI.OffsetSliders
    if sl then
        sl.X.Set(UTZeUWBZ); sl.Y.Set(7GzvlMab); sl.Z.Set(hDmnWKlx)
        sl.LX.Set(lx); sl.LY.Set(ly); sl.LZ.Set(lz)
    end
end
Outfit.LoadOffset = LoadOffset

function WearOutfit(name, silent)
    local function fail(msg)
        if not silent then SetStatus(msg, true) end
        return false
    end
    local char = LocalPlayer.Character
    if not char then return fail(loadstring(base64decode("Tm8gY2hhcmFjdGVyLg=="))()) end
    local hrp = char:WaitForChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))(), 5)
    if not hrp then return fail(loadstring(base64decode("SHVtYW5vaWRSb290UGFydCBub3QgZm91bmQu"))()) end
    local folder = ClothingFolder()
    if not folder then return fail(loadstring(base64decode("UmVwbGljYXRlZFN0b3JhZ2UgPiBDbG90aGluZyBub3QgZm91bmQu"))()) end
    local outfit = folder:FindFirstChild(name)
    if not outfit then return fail(loadstring(base64decode("T3V0Zml0IG5vdCBmb3VuZDog"))() .. tostring(name)) end

    LoadOffset(name)
    local broken = Config.OutfitBroken
    local variant = outfit:FindFirstChild(broken and loadstring(base64decode("QnJva2Vu"))() or loadstring(base64decode("Tm9ybWFs"))())
        or outfit:FindFirstChild(broken and loadstring(base64decode("Tm9ybWFs"))() or loadstring(base64decode("QnJva2Vu"))())
        or outfit

    RemoveOutfit()
    local worn = {
        Char = char, Added = {}, Hidden = {}, HiddenSet = {}, Roots = {}, Cloth = {}, Welds = {}, Conn = nil,
    }
    Outfit.Worn = worn
    local attachedLimbs = 0

    local ok, err = pcall(function()
        -- ---------- REST POZ: animasyondan bağımsıhDmnWKlx ----------
        -- Part1.CFrame = Part0.CFrame * C0 * C1^-1 zinciriyle her parçanın HRP'ye göre rest konumu
        local motorOf = {}
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA(loadstring(base64decode("TW90b3I2RA=="))()) and d.Part0 and d.Part1 then motorOf[d.Part1] = d end
        end
        local restCache = {}
        local function restRel(part)
            if part == hrp then return CFrame.new() end
            local c = restCache[part]
            if c ~= nil then return c or nil end
            restCache[part] = false   -- döngü koruması
            local m = motorOf[part]
            local r
            if m then
                local base = restRel(m.Part0)
                if base then r = base * m.C0 * m.C1:Inverse() end
            end
            restCache[part] = r or false
            return r
        end

        -- Shirt / Pants: karakterdeki TÜM Shirt/Pants'in template'i değiştirilir (silinmez),
        -- oyun geri değiştirirse tekrar uygulanır, kaldırınca eski değere döner
        worn.Conns = worn.Conns or {}
        local function findCloth(class)
            local fallback
            for _, c in ipairs(outfit:GetDescendants()) do
                if c:IsA(class) then
                    if (c.Name:lower():find(loadstring(base64decode("YnJva2Vu"))(), 1, true) ~= nil) == broken then return c end
                    fallback = fallback or c
                end
            end
            return fallback
        end
        local function swapCloth(class, prop)
            local src = findCloth(class)
            if not src then return end
            local target = src[prop]
            local function setOne(inst)
                local known = false
                for _, c in ipairs(worn.Cloth) do if c.Inst == inst then known = true break end end
                if not known then
                    table.insert(worn.Cloth, { Inst = inst, Prop = prop, Orig = inst[prop], Target = target })
                    table.insert(worn.Conns, inst:GetPropertyChangedSignal(prop):Connect(function()
                        if Outfit.Worn == worn and inst[prop] ~= target then inst[prop] = target end
                    end))
                end
                if inst[prop] ~= target then inst[prop] = target end
            end
            local found = false
            for _, c in ipairs(char:GetDescendants()) do
                if c:IsA(class) then found = true; setOne(c) end
            end
            if not found then
                local new = src:Clone()
                new.Parent = char
                table.insert(worn.Added, new)
            end
            table.insert(worn.Conns, char.DescendantAdded:Connect(function(c)
                if c:IsA(class) then
                    task.defer(function() if Outfit.Worn == worn then setOne(c) end end)
                end
            end))
        end
        swapCloth(loadstring(base64decode("U2hpcnQ="))(), loadstring(base64decode("U2hpcnRUZW1wbGF0ZQ=="))())
        swapCloth(loadstring(base64decode("UGFudHM="))(), loadstring(base64decode("UGFudHNUZW1wbGF0ZQ=="))())
        -- oyun geç 7GzvlMabüklemede GgfRx2bYıyafeti ezerse ilk 10 sn boyunca tekrar uygula
        task.spawn(function()
            for _ = 1, 20 do
                task.wait(0.5)
                if Outfit.Worn ~= worn then return end
                for _, c in ipairs(worn.Cloth) do
                    if c.Target and c.Inst.Parent and c.Inst[c.Prop] ~= c.Target then c.Inst[c.Prop] = c.Target end
                end
            end
        end)

        local clone
        if variant:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
            clone = Instance.new(loadstring(base64decode("TW9kZWw="))())
            variant:Clone().Parent = clone
        else
            clone = variant:Clone()
        end
        clone.Name = loadstring(base64decode("Q2xpZW50T3V0Zml0"))()

        local parts = {}
        for _, d in ipairs(clone:GetDescendants()) do
            if d:IsA(loadstring(base64decode("THVhU291cmNlQ29udGFpbmVy"))()) then
                d:Destroy()
            elseif d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                d.Anchored = false
                d.CanCollide = false
                d.CanTouch = false
                d.CanQuery = false
                d.Massless = true
                table.insert(parts, d)
            end
        end
        if #parts == 0 then error(loadstring(base64decode("b3V0Zml0IGhhcyBubyBwYXJ0cw=="))()) end

        -- 1) Parça türü (Arm / Leg / Torso) ve taraf (L / R)
        local kindOf, sideOf = {}, {}
        for _, p in ipairs(parts) do kindOf[p], sideOf[p] = ClassifyPart(p, clone) end

        -- 2) KöGgfRx2bY parça
        local function pick(pred)
            for _, p in ipairs(parts) do if pred(p) then return p end end
        end
        local root = pick(function(p) local n = p.Name:lower() return n == loadstring(base64decode("cm9vdHBhcnQ="))() or n == loadstring(base64decode("aHVtYW5vaWRyb290cGFydA=="))() end)
            or pick(function(p) return kindOf[p] == loadstring(base64decode("VG9yc28="))() end)
            or (clone:IsA(loadstring(base64decode("TW9kZWw="))()) and clone.PrimaryPart or nil)
            or pick(function(p) return not kindOf[p] end)
            or parts[1]
        kindOf[root], sideOf[root] = nil, nil

        -- 3) Eklem grafiği
        local function inClone(UTZeUWBZ) return UTZeUWBZ ~= nil and UTZeUWBZ:IsDescendantOf(clone) end
        local adj, joints = {}, {}
        for _, d in ipairs(clone:GetDescendants()) do
            if d:IsA(loadstring(base64decode("Sm9pbnRJbnN0YW5jZQ=="))()) or d:IsA(loadstring(base64decode("V2VsZENvbnN0cmFpbnQ="))()) then
                local a, b = d.Part0, d.Part1
                if inClone(a) and inClone(b) then
                    adj[a] = adj[a] or {}
                    adj[b] = adj[b] or {}
                    table.insert(adj[a], d)
                    table.insert(adj[b], d)
                    table.insert(joints, d)
                else
                    d:Destroy()
                end
            end
        end
        local function step(eZOvv25u, from)
            if eZOvv25u:IsA(loadstring(base64decode("V2VsZENvbnN0cmFpbnQ="))()) then
                local other = (eZOvv25u.Part0 == from) and eZOvv25u.Part1 or eZOvv25u.Part0
                return other, from.CFrame:ToObjectSpace(other.CFrame)
            end
            local c = eZOvv25u.C0 * eZOvv25u.C1:Inverse()
            if eZOvv25u.Part0 == from then return eZOvv25u.Part1, c end
            return eZOvv25u.Part0, c:Inverse()
        end

        -- 4) Kökten BFS
        local rel, gk, gs = { [root] = CFrame.new() }, {}, {}
        local queue, qi = { root }, 1
        while queue[qi] do
            local p = queue[qi]
            qi += 1
            for _, eZOvv25u in ipairs(adj[p] or {}) do
                local other, tf = step(eZOvv25u, p)
                if other and not rel[other] then
                    rel[other] = rel[p] * tf
                    local GgfRx2bY = kindOf[other]
                    if GgfRx2bY then
                        if GgfRx2bY == loadstring(base64decode("QXJt"))() or GgfRx2bY == loadstring(base64decode("TGVn"))() then gk[other], gs[other] = GgfRx2bY, sideOf[other] end
                    else
                        gk[other], gs[other] = gk[p], gs[p]
                    end
                    table.insert(queue, other)
                end
            end
        end
        local orphan = {}
        for _, p in ipairs(parts) do
            if not rel[p] then
                orphan[p] = root.CFrame:ToObjectSpace(p.CFrame)
                local GgfRx2bY = kindOf[p]
                if GgfRx2bY == loadstring(base64decode("QXJt"))() or GgfRx2bY == loadstring(base64decode("TGVn"))() then gk[p], gs[p] = GgfRx2bY, sideOf[p] end
            end
        end
        local function offsetOf(p) return rel[p] or orphan[p] or CFrame.new() end

        -- 5) Hedef uzuvlar: rest poz (animasyon değil). Motor bulunamazsa sabit R6 konumuna düşer.
        local cache = {}
        local function limbTarget(kind, side)
            local key = kind .. side
            if cache[key] ~= nil then return cache[key] or nil end
            local info = LimbR6[key]
            local limb = info and char:FindFirstChild(info[1])
            local relToHrp
            if limb then
                relToHrp = restRel(limb) or info[2]
            else
                limb = char:FindFirstChild(LimbR15[key])
                if limb then relToHrp = restRel(limb) or hrp.CFrame:ToObjectSpace(limb.CFrame) end
            end
            local center = relToHrp
            local chain = {
                ArmL = { loadstring(base64decode("TGVmdExvd2VyQXJt"))(), loadstring(base64decode("TGVmdEhhbmQ="))() }, ArmR = { loadstring(base64decode("UmlnaHRMb3dlckFybQ=="))(), loadstring(base64decode("UmlnaHRIYW5k"))() },
                LegL = { loadstring(base64decode("TGVmdExvd2VyTGVn"))(), loadstring(base64decode("TGVmdEZvb3Q="))() }, LegR = { loadstring(base64decode("UmlnaHRMb3dlckxlZw=="))(), loadstring(base64decode("UmlnaHRGb290"))() },
            }
            if limb and relToHrp and LimbR15[key] and limb.Name == LimbR15[key] and chain[key] then
                local sum, n = relToHrp.Position, 1
                for _, nm in ipairs(chain[key]) do
                    local q = char:FindFirstChild(nm)
                    local r = q and restRel(q)
                    if r then sum += r.Position; n += 1 end
                end
                center = CFrame.new(sum / n)
            end
            cache[key] = (limb and relToHrp) and { Limb = limb, Rel = relToHrp, Center = center } or false
            return cache[key] or nil
        end

        local target = {}
        for _, p in ipairs(parts) do
            if p ~= root and gk[p] then
                local side = gs[p] or ((offsetOf(p).Position.X < 0) and loadstring(base64decode("TA=="))() or loadstring(base64decode("Ug=="))())
                local t = limbTarget(gk[p], side)
                if t then target[p] = t end
            end
        end

        -- 6) Uzuvlara gidecek parçaların eklemleri silinir
        for _, eZOvv25u in ipairs(joints) do
            if eZOvv25u.Parent and (target[eZOvv25u.Part0] or target[eZOvv25u.Part1]) then eZOvv25u:Destroy() end
        end
        local reach, q2, i2 = { [root] = true }, { root }, 1
        while q2[i2] do
            local p = q2[i2]
            i2 += 1
            for _, eZOvv25u in ipairs(adj[p] or {}) do
                if eZOvv25u.Parent then
                    local other = (eZOvv25u.Part0 == p) and eZOvv25u.Part1 or eZOvv25u.Part0
                    if other and not reach[other] then
                        reach[other] = true
                        table.insert(q2, other)
                    end
                end
            end
        end

        -- Mevcut armoru gizle (baş / saç / 7GzvlMabühDmnWKlx korunur, hiçbir şey silinmez)
        local armorNames
        if Config.HideArmor then
            armorNames = ArmorNameSet()
            HideArmor(worn, armorNames)
        end

        -- Clone'u önce yerine koy (henühDmnWKlx karakterde değil: serbest düşme / fırlama olmaz)
        clone.PrimaryPart = root
        clone:PivotTo(hrp.CFrame)

        -- Gövde: rest pozdaki Torso / UpperTorso'ya weld
        local torso = char:FindFirstChild(loadstring(base64decode("VG9yc28="))()) or char:FindFirstChild(loadstring(base64decode("VXBwZXJUb3Jzbw=="))()) or hrp
        local torsoRel = restRel(torso) or CFrame.new()
        local mainPre = torsoRel:Inverse()
        local main = Instance.new(loadstring(base64decode("V2VsZA=="))())
        main.Name = loadstring(base64decode("T3V0Zml0V2VsZA=="))()
        main.Part0, main.Part1, main.C0 = torso, root, mainPre
        main.Parent = root
        table.insert(worn.Welds, { Weld = main, Pre = mainPre, Post = CFrame.new(), Group = loadstring(base64decode("Qm9keQ=="))() })

        for _, p in ipairs(parts) do
            if p ~= root then
                local t = target[p]
                if t then
                    local pre, post = t.Rel:Inverse(), offsetOf(p)
                    if orphan[p] then
                        -- eklemi olmayan uzuv parçası (LeftArm / RightArm): şablon konumu güvenilmez, uzvun merkezine oturt
                        post = CFrame.new(t.Center.Position) * post.Rotation
                    end
                    local w = Instance.new(loadstring(base64decode("V2VsZA=="))())
                    w.Name = loadstring(base64decode("T3V0Zml0TGltYldlbGQ="))()
                    w.Part0, w.Part1, w.C0 = t.Limb, p, pre * post
                    w.Parent = p
                    table.insert(worn.Welds, { Weld = w, Pre = pre, Post = post, Group = loadstring(base64decode("TGltYg=="))() })
                    attachedLimbs += 1
                elseif not reach[p] then
                    local w = Instance.new(loadstring(base64decode("V2VsZA=="))())
                    w.Name = loadstring(base64decode("T3V0Zml0Um9vdFdlbGQ="))()
                    w.Part0, w.Part1, w.C0 = root, p, offsetOf(p)
                    w.Parent = p
                end
            end
        end
        ApplyOutfitOffset()

        clone.Parent = char
        table.insert(worn.Added, clone)

        -- Oyun sonradan armor eklerse (re-equip / geç 7GzvlMabükleme) onu da gizle
        if Config.HideArmor then
            local head = char:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
            worn.Conn = char.DescendantAdded:Connect(function(d)
                if not (d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or d:IsA(loadstring(base64decode("TW9kZWw="))()) or d:IsA(loadstring(base64decode("QWNjZXNzb3J5"))())) then return end
                task.defer(function()
                    if Outfit.Worn ~= worn or not Config.HideArmor or not d.Parent then return end
                    if not d:IsDescendantOf(char) then return end
                    -- gizlenmiş bir armor modelinin içine geç gelen parça
                    local c = d.Parent
                    while c and c ~= char do
                        if worn.Roots[c] then Conceal(worn, d) return end
                        c = c.Parent
                    end
                    if IsArmorInstance(d, char, worn, armorNames, head) then Conceal(worn, d) end
                end)
            end)
        end

        -- AnimationController içindeki Animation'ları döngüde oynat (pelerin vb.)
        task.spawn(function()
            local animator = clone:FindFirstChildWhichIsA(loadstring(base64decode("QW5pbWF0b3I="))(), true)
            if not animator then return end
            for _, d in ipairs(clone:GetDescendants()) do
                if d:IsA(loadstring(base64decode("QW5pbWF0aW9u"))()) and d.AnimationId ~= loadstring(base64decode(""))() then
                    pcall(function()
                        local tr = animator:LoadAnimation(d)
                        tr.Looped = true
                        tr:Play()
                    end)
                end
            end
        end)
    end)
    if not ok then
        RemoveOutfit()
        return fail(loadstring(base64decode("T3V0Zml0IGVycm9yOiA="))() .. tostring(err))
    end

    Config.OutfitActive = true
    QueueSave()
    if not silent then
        SetStatus(string.format(loadstring(base64decode("V2VhcmluZzogJXMgICglZCBsaW1iIHBhcnRzIGF0dGFjaGVkLCAlZCBvbGQgYXJtb3IgcGFydChzKSBoaWRkZW4p"))(),
            name, attachedLimbs, #worn.Hidden))
    end
    return true
end


end -- outfit scope
-- UI PRIMITIVES

local function SetBase(btn, color)
    btn:SetAttribute(loadstring(base64decode("QmFzZQ=="))(), color)
    btn.BackgroundColor3 = color
end

local function AttachHover(btn)
    btn.MouseEnter:Connect(function()
        local base = btn:GetAttribute(loadstring(base64decode("QmFzZQ=="))())
        if base then Tween(btn, { BackgroundColor3 = base:Lerp(Color3.new(1, 1, 1), 0.1) }) end
    end)
    btn.MouseLeave:Connect(function()
        local base = btn:GetAttribute(loadstring(base64decode("QmFzZQ=="))())
        if base then Tween(btn, { BackgroundColor3 = base }) end
    end)
end

local function MakeButton(parent, text, color, size, pos)
    local btn = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = size or UDim2.new(1, 0, 0, 34), Position = pos or UDim2.new(0, 0, 0, 0),
        Text = text, TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamBold, TextSize = 12,
        BorderSizePixel = 0, AutoButtonColor = false, Parent = parent,
    })
    Corner(btn, 7)
    SetBase(btn, color or Theme.Accent)
    AttachHover(btn)
    return btn
end

-- Tür rozeti (SKILL / ANIM / OBJECT)
local function MakeBadge(parent, kind, pos)
    local b = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(0, 54, 0, 16), Position = pos, BorderSizePixel = 0, Text = loadstring(base64decode(""))(),
        Font = Enum.Font.GothamBold, TextSize = 10, Parent = parent,
    })
    Corner(b, 4)
    local function set(GgfRx2bY)
        local c = KindColor[GgfRx2bY] or Theme.Muted
        b.Text = string.upper(GgfRx2bY)
        b.TextColor3 = c
        b.BackgroundColor3 = c:Lerp(Theme.Card, 0.8)
    end
    set(kind)
    return b, set
end

local function CreateSection(parent, text)
    local l = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1, Text = string.upper(text),
        TextColor3 = Theme.SubText, Font = Enum.Font.GothamBold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Parent = parent,
    })
    Order(l, parent)
    return l
end

local function CreateNote(parent, text, height, color)
    local l = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, height or 32), BackgroundTransparency = 1, Text = text,
        TextColor3 = color or Theme.SubText, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent,
    })
    Order(l, parent)
    return l
end

local function CreateButton(parent, text, callback, color)
    local btn = MakeButton(parent, text, color or Theme.Accent)
    btn.TextSize = 13
    Order(btn, parent)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- defs = { {text, callback, color}, ... }
local function CreateButtonRow(parent, defs)
    local row = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Parent = parent })
    Order(row, parent)
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), {
        FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder, Parent = row,
    })
    local n = #defs
    local buttons = {}
    for i, d in ipairs(defs) do
        local b = MakeButton(row, d[1], d[3] or Theme.Accent, UDim2.new(1 / n, -6 * (n - 1) / n, 1, 0))
        b.LayoutOrder = i
        b.MouseButton1Click:Connect(function() d[2](b) end)
        buttons[i] = b
    end
    return row, buttons
end

local function CreateCard(parent, height)
    local card = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, 0, 0, height), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = parent,
    })
    Order(card, parent)
    Corner(card, 8)
    Stroke(card)
    return card
end

local function CreateToggle(parent, text, default, callback, desc)
    local h = desc and 58 or 40
    local container = CreateCard(parent, h)
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -76, 0, 18), Position = UDim2.new(0, 12, 0, desc and 9 or (h - 18) / 2),
        BackgroundTransparency = 1, Text = text, TextColor3 = Theme.Text, Font = Enum.Font.GothamMedium,
        TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = container,
    })
    if desc then
        Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -76, 0, 26), Position = UDim2.new(0, 12, 0, 28), BackgroundTransparency = 1,
            Text = desc, TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = container,
        })
    end
    local state = default
    local switch = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = UDim2.new(0, 42, 0, 22), Position = UDim2.new(1, -54, 0.5, -11),
        BackgroundColor3 = state and Theme.Accent or Theme.Muted, Text = loadstring(base64decode(""))(), AutoButtonColor = false,
        BorderSizePixel = 0, Parent = container,
    })
    Corner(switch, 11)
    local knob = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = switch,
    })
    Corner(knob, 8)
    local function render(animated)
        local col = state and Theme.Accent or Theme.Muted
        local pos = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        if animated then
            Tween(switch, { BackgroundColor3 = col }, 0.15)
            Tween(knob, { Position = pos }, 0.15)
        else
            switch.BackgroundColor3 = col
            knob.Position = pos
        end
    end
    switch.MouseButton1Click:Connect(function()
        state = not state
        render(true)
        callback(state)
    end)
    return {
        Frame = container,
        Set = function(v) state = v; render(false) end,
        Get = function() return state end,
    }
end

local function CreateSlider(parent, name, min, max, default, decimals, callback, unit)
    decimals = decimals or 0
    local function fmt(v)
        local s = decimals > 0 and string.format(loadstring(base64decode("JS4="))() .. decimals .. loadstring(base64decode("Zg=="))(), v) or tostring(v)
        return s .. (unit or loadstring(base64decode(""))())
    end
    local container = CreateCard(parent, 54)
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -110, 0, 16), Position = UDim2.new(0, 12, 0, 8), BackgroundTransparency = 1,
        Text = name, TextColor3 = Theme.Text, Font = Enum.Font.GothamMedium, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = container,
    })
        local valueLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(0, 100, 0, 16), Position = UDim2.new(1, -112, 0, 8), BackgroundTransparency = 1,
        Text = fmt(default), TextColor3 = Theme.Accent, Font = Enum.Font.GothamBold, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right, Parent = container,
    })
    local hit = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = UDim2.new(1, -24, 0, 20), Position = UDim2.new(0, 12, 0, 28), BackgroundTransparency = 1,
        Text = loadstring(base64decode(""))(), AutoButtonColor = false, Parent = container,
    })
    local bar = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, -3), BackgroundColor3 = Theme.Raised,
        BorderSizePixel = 0, Parent = hit,
    })
    Corner(bar, 3)
    local fill = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), 0, 1, 0),
        BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = bar,
    })
    Corner(fill, 3)
    local knob = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = fill,
    })
    Corner(knob, 7)

    local value = default
    local function updateFromX(UTZeUWBZ)
        local rel = math.clamp((UTZeUWBZ - hit.AbsolutePosition.X) / math.max(hit.AbsoluteSize.X, 1), 0, 1)
        local raw = min + (max - min) * rel
        if decimals > 0 then
            local mult = 10 ^ decimals
            raw = math.floor(raw * mult + 0.5) / mult
        else
            raw = math.floor(raw + 0.5)
        end
        value = raw
        fill.Size = UDim2.new((raw - min) / (max - min), 0, 1, 0)
        valueLabel.Text = fmt(raw)
        callback(raw)
    end
    hit.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateFromX(input.Position.X)
            TrackDrag(function(i) updateFromX(i.Position.X) end)
        end
    end)

    return {
        Frame = container,
        Set = function(v)
            value = math.clamp(v, min, max)
            fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            valueLabel.Text = fmt(value)
        end,
        Get = function() return value end,
    }
end

local function CreateTextField(parent, caption, default, callback, multiline, placeholder)
    local container = CreateCard(parent, multiline and 100 or 56)
    local stroke = container:FindFirstChildOfClass(loadstring(base64decode("VUlTdHJva2U="))())
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -24, 0, 14), Position = UDim2.new(0, 12, 0, 7), BackgroundTransparency = 1,
        Text = caption, TextColor3 = Theme.SubText, Font = Enum.Font.GothamBold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = container,
    })
    local box = Create(loadstring(base64decode("VGV4dEJveA=="))(), {
        Size = UDim2.new(1, -24, 1, -30), Position = UDim2.new(0, 12, 0, 24), BackgroundTransparency = 1,
        Text = default or loadstring(base64decode(""))(), PlaceholderText = placeholder or loadstring(base64decode(""))(), PlaceholderColor3 = Theme.Muted,
        TextColor3 = Theme.Text, Font = Enum.Font.Gotham,
        TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = multiline and true or false, MultiLine = multiline and true or false,
        ClearTextOnFocus = false, TextTruncate = multiline and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd,
        Parent = container,
    })
    box.Focused:Connect(function() stroke.Color = Theme.Accent end)
    box.FocusLost:Connect(function()
        stroke.Color = Theme.Stroke
        if callback then callback(box.Text) end
    end)
    return box
end

-- Yan yana seçenek butonları (Detection Type)
local function CreateSegmented(parent, caption, options, current, onChange)
    local container = CreateCard(parent, 66)
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -24, 0, 14), Position = UDim2.new(0, 12, 0, 7), BackgroundTransparency = 1,
        Text = caption, TextColor3 = Theme.SubText, Font = Enum.Font.GothamBold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = container,
    })
    local row = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -24, 0, 30), Position = UDim2.new(0, 12, 0, 28), BackgroundTransparency = 1, Parent = container,
    })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), {
        FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = row,
    })
    local n = #options
    for i, opt in ipairs(options) do
        local selected = (opt == current)
        local b = MakeButton(row, string.upper(opt), selected and (KindColor[opt] or Theme.Accent) or Theme.Raised,
            UDim2.new(1 / n, -6 * (n - 1) / n, 1, 0))
        b.LayoutOrder = i
        b.MouseButton1Click:Connect(function()
            if opt ~= current then onChange(opt) end
        end)
    end
    return container
end

local function CreateKeybind(parent, label, getter, setter)
    local container = CreateCard(parent, 40)
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -170, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
        Text = label, TextColor3 = Theme.Text, Font = Enum.Font.GothamMedium, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = container,
    })
    local btn = MakeButton(container, getter().Name, Theme.Raised, UDim2.new(0, 150, 0, 26), UDim2.new(1, -162, 0.5, -13))
    btn.MouseButton1Click:Connect(function()
        if Capturing then return end
        Capturing = true
        L.Set(btn, loadstring(base64decode("UHJlc3MgYSBrZXkuLi4="))())
        local conn = nil
        local function finish(key)
            if not conn then return end
            conn:Disconnect()
            conn = nil
            if key then setter(key) end
            btn.Text = getter().Name
            task.defer(function() Capturing = false end)
        end
        conn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                finish(input.KeyCode ~= Enum.KeyCode.Escape and input.KeyCode or nil)
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                finish(nil) -- boşa tıklama = iptal
            end
        end)
        task.delay(8, function() finish(nil) end) -- zaman aşımı
    end)
    return btn
end

-- hDmnWKlx: kardeş elemanlar arasındaki katman; üstteki dropdown'a daha bü7GzvlMabüGgfRx2bY hDmnWKlx ver.
local function CreateDropdown(parent, label, options, default, callback, hDmnWKlx, onOpen)
    local container = CreateCard(parent, 38)
    container.ZIndex = hDmnWKlx or 5
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(0, 70, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
        Text = label, TextColor3 = Theme.SubText, Font = Enum.Font.GothamBold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = container,
    })
    local btn = MakeButton(container, tostring(default) .. loadstring(base64decode("ICDilr4="))(), Theme.Raised, UDim2.new(1, -92, 0, 26), UDim2.new(0, 82, 0.5, -13))
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.TextColor3 = Theme.Text

    local listFrame = Create(loadstring(base64decode("U2Nyb2xsaW5nRnJhbWU="))(), {
        Size = UDim2.new(1, -92, 0, 0), Position = UDim2.new(0, 82, 1, 4), BackgroundColor3 = Theme.Panel,
        BorderSizePixel = 0, Visible = false, ZIndex = 20, ScrollBarThickness = 3,
        CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = container,
    })
    Corner(listFrame, 7)
    Stroke(listFrame)
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { SortOrder = Enum.SortOrder.LayoutOrder, Parent = listFrame })

    local api = { Frame = container }
    local current = default

    local function rebuild(opts)
        for _, c in ipairs(listFrame:GetChildren()) do
            if c:IsA(loadstring(base64decode("VGV4dEJ1dHRvbg=="))()) then c:Destroy() end
        end
        listFrame.Size = UDim2.new(1, -92, 0, math.min(#opts, 6) * 28)
        for i, opt in ipairs(opts) do
            local item = MakeButton(listFrame, tostring(opt), Theme.Panel, UDim2.new(1, 0, 0, 28))
            item.ZIndex = 21
            item.LayoutOrder = i
            item.Font = Enum.Font.Gotham
            item.TextSize = 13
            item.TextColor3 = (opt == current) and Theme.Accent or Theme.Text
            item.MouseButton1Click:Connect(function()
                current = opt
                btn.Text = tostring(opt) .. loadstring(base64decode("ICDilr4="))()
                listFrame.Visible = false
                OpenDropdownList = nil
                callback(opt)
            end)
        end
    end
    rebuild(options)

    btn.MouseButton1Click:Connect(function()
        if listFrame.Visible then
            listFrame.Visible = false
            OpenDropdownList = nil
            return
        end
        if OpenDropdownList then OpenDropdownList.Visible = false end
        if onOpen then rebuild(onOpen()) end
        listFrame.Visible = true
        OpenDropdownList = listFrame
    end)

    api.Set = function(v) current = v; btn.Text = tostring(v) .. loadstring(base64decode("ICDilr4="))() end
    api.Get = function() return current end
    return api
end

local function CreateScrollList(parent, size, pos)
    local scroll = Create(loadstring(base64decode("U2Nyb2xsaW5nRnJhbWU="))(), {
        Size = size or UDim2.new(1, 0, 1, 0), Position = pos or UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
        ScrollBarImageColor3 = Theme.Muted, CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y, Parent = parent,
    })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = scroll })
    Create(loadstring(base64decode("VUlQYWRkaW5n"))(), { PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 8), Parent = scroll })
    return scroll
end

local function CreateSearchBox(parent, placeholder, onChange)
    local container = CreateCard(parent, 38)
    local stroke = container:FindFirstChildOfClass(loadstring(base64decode("VUlTdHJva2U="))())
    local input = Create(loadstring(base64decode("VGV4dEJveA=="))(), {
        Size = UDim2.new(1, -24, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
        PlaceholderText = placeholder, Text = loadstring(base64decode(""))(), TextColor3 = Theme.Text, PlaceholderColor3 = Theme.Muted,
        Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false, Parent = container,
    })
    input.Focused:Connect(function() stroke.Color = Theme.Accent end)
    input.FocusLost:Connect(function() stroke.Color = Theme.Stroke end)
    input:GetPropertyChangedSignal(loadstring(base64decode("VGV4dA=="))()):Connect(function() onChange(input.Text:lower()) end)
    return input
end

-- Bilgi kutuları satırı. defs = { {key, caption, initialText}, ... }
local function CreateStatRow(parent, defs)
    local row = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 0, 62), BackgroundTransparency = 1, Parent = parent })
    Order(row, parent)
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), {
        FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = row,
    })
    local n = #defs
    local labels = {}
    for i, d in ipairs(defs) do
        local card = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.new(1 / n, -8 * (n - 1) / n, 1, 0), BackgroundColor3 = Theme.Card, BorderSizePixel = 0,
            LayoutOrder = i, Parent = row,
        })
        Corner(card, 8)
        Stroke(card)
        labels[d[1]] = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -20, 0, 26), Position = UDim2.new(0, 10, 0, 8), BackgroundTransparency = 1,
            Text = d[3], TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 17,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = card,
        })
        Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -20, 0, 14), Position = UDim2.new(0, 10, 0, 36), BackgroundTransparency = 1,
            Text = d[2], TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
        })
    end
    return labels
end


-- MAIN WINDOW

local function CreateWindow()
    local gui = Create(loadstring(base64decode("U2NyZWVuR3Vp"))(), {
        Name = loadstring(base64decode("QXV0b1BhcnJ5VUlfVjY="))(), ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = GetGuiParent(),
    })

    local main = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 920, 0, 580), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = gui,
    })
    Corner(main, 12)
    Stroke(main)
    local uiScale = Create(loadstring(base64decode("VUlTY2FsZQ=="))(), { Parent = main })
    UI.ScaleBase = 1
    pcall(function()
        local vp = workspace.CurrentCamera.ViewportSize
        UI.ScaleBase = math.clamp(math.min(vp.X / 960, vp.Y / 620), 0.5, 1)
    end)
    UI.Scale = uiScale
    UI.ApplyScale = function() uiScale.Scale = UI.ScaleBase * math.clamp(Config.UIScale, 0.6, 1.3) end
    UI.ApplyScale()

    -- Buz gradyanı (arka plan rengi gradyandan gelir)
    Create(loadstring(base64decode("VUlHcmFkaWVudA=="))(), {
        Color = ColorSequence.new(Color3.fromRGB(30, 46, 68), Color3.fromRGB(13, 19, 30)),
        Rotation = 90, Parent = main,
    })

    -- Kar yağışı (arka katman)
    local snowLayer = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 0,
        ClipsDescendants = true, Parent = main,
    })
    Corner(snowLayer, 12)
    -- Kar: Lua'da kare başına işlem yok, TweenService (motor tarafı) ile döngü
    local rng = Random.new()
    UI.SnowLayer = snowLayer
    UI.SnowTweens = {}
    UI.SetSnow = function(on)
        snowLayer.Visible = on
        for _, t in ipairs(UI.SnowTweens) do
            if on then t:Play() else t:Pause() end
        end
    end
    for i = 1, 22 do
        local size = rng:NextInteger(2, 4)
        local UTZeUWBZ = rng:NextInteger(4, 916)
        local sway = rng:NextInteger(4, 12)
        local wrap = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.fromOffset(size, size), Position = UDim2.fromOffset(UTZeUWBZ, -8),
            BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 0, Parent = snowLayer,
        })
        local f = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.new(1, 0, 1, 0), Position = UDim2.fromOffset(-sway, 0), BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = rng:NextNumber(0.35, 0.75), BorderSizePixel = 0, ZIndex = 0, Parent = wrap,
        })
        Corner(f, size)
        local fall = TweenService:Create(wrap,
            TweenInfo.new(rng:NextNumber(9, 18) * (3 / size), Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1),
            { Position = UDim2.fromOffset(UTZeUWBZ, 590) })
        local swing = TweenService:Create(f,
            TweenInfo.new(rng:NextNumber(1.6, 3.2), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            { Position = UDim2.fromOffset(sway, 0) })
        table.insert(UI.SnowTweens, fall)
        table.insert(UI.SnowTweens, swing)
        task.delay(rng:NextNumber(0, 3), function()
            if Config.Snow and snowLayer.Parent then fall:Play(); swing:Play() end
        end)
    end
    snowLayer.Visible = Config.Snow

    local function MakeDraggable(handle)
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local dragStart, startPos = input.Position, main.Position
                TrackDrag(function(i)
                    local d = (i.Position - dragStart) / uiScale.Scale
                    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
                end)
            end
        end)
    end

    -- Sidebar
    local sidebar = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 160, 1, 0), BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = main,
    })
    Corner(sidebar, 12)
    Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(1, -14, 0, 0),
        BackgroundColor3 = Theme.Sidebar, BorderSizePixel = 0, Parent = sidebar,
    })

    local brand = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 0, 64), BackgroundTransparency = 1, Parent = sidebar })
    MakeDraggable(brand)
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -32, 0, 22), Position = UDim2.new(0, 18, 0, 16), BackgroundTransparency = 1,
        Text = loadstring(base64decode("VkVYT1JB"))(), TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = brand,
    })
    Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -32, 0, 14), Position = UDim2.new(0, 18, 0, 38), BackgroundTransparency = 1,
        Text = loadstring(base64decode("UFZQIE1BTkFHRVI="))(), TextColor3 = Theme.Accent, Font = Enum.Font.GothamBold, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = brand,
    })

    local tabHolder = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -16, 1, -130), Position = UDim2.new(0, 8, 0, 70), BackgroundTransparency = 1, Parent = sidebar,
    })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = tabHolder })

    -- Durum hapı (Auto-Parry açıGgfRx2bY/kapalı)
    local pill = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -20, 0, 34), Position = UDim2.new(0, 10, 1, -46),
        BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = sidebar,
    })
    Corner(pill, 8)
    Stroke(pill)
    UI.PillDot = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 8, 0, 8), Position = UDim2.new(0, 12, 0.5, -4), BackgroundColor3 = Theme.Muted,
        BorderSizePixel = 0, Parent = pill,
    })
    Corner(UI.PillDot, 4)
    UI.PillText = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -34, 1, 0), Position = UDim2.new(0, 28, 0, 0), BackgroundTransparency = 1,
        Text = loadstring(base64decode("QXV0by1QYXJyeSBPRkY="))(), TextColor3 = Theme.Text, Font = Enum.Font.GothamMedium, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = pill,
    })

    local pillBtn = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = loadstring(base64decode(""))(), ZIndex = 5, Parent = pill,
    })
    pillBtn.MouseButton1Click:Connect(function() SetEnabled(not Config.AutoParryEnabled) end)

    -- Üst çubuk
    local topBar = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -160, 0, 44), Position = UDim2.new(0, 160, 0, 0), BackgroundTransparency = 1, Parent = main,
    })
    MakeDraggable(topBar)
    local pageTitle = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -70, 1, 0), Position = UDim2.new(0, 20, 0, 0), BackgroundTransparency = 1,
        Text = loadstring(base64decode(""))(), TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = topBar,
    })
    local closeBtn = MakeButton(topBar, loadstring(base64decode("WA=="))(), Theme.Raised, UDim2.new(0, 28, 0, 28), UDim2.new(1, -40, 0.5, -14))
    closeBtn.MouseEnter:Connect(function() Tween(closeBtn, { BackgroundColor3 = Theme.Bad }) end)
    closeBtn.MouseButton1Click:Connect(function() main.Visible = false end)

    -- Alt durum çubuğu
    local statusBar = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -160, 0, 26), Position = UDim2.new(0, 160, 1, -26), BackgroundTransparency = 1, Parent = main,
    })
    Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -24, 0, 1), Position = UDim2.new(0, 12, 0, 0), BackgroundColor3 = Theme.Stroke,
        BorderSizePixel = 0, Parent = statusBar,
    })
    UI.StatusLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -40, 1, 0), Position = UDim2.new(0, 20, 0, 0), BackgroundTransparency = 1,
        Text = loadstring(base64decode("UmVhZHk="))(), TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = statusBar,
    })

    local content = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, -160, 1, -70), Position = UDim2.new(0, 160, 0, 44), BackgroundTransparency = 1, Parent = main,
    })

    -- Toast bildirimleri (sağ alt, kendiliğinden kaybolur)
    local toastHolder = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 290, 1, -90), Position = UDim2.new(1, -302, 0, 50), BackgroundTransparency = 1,
        ZIndex = 60, Parent = main,
    })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), {
        Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom, Parent = toastHolder,
    })
    local toastN = 0
    UI.Toast = function(text, isError)
        toastN += 1
        local kids = toastHolder:GetChildren()
        local count = 0
        for _, GgfRx2bY in ipairs(kids) do if GgfRx2bY:IsA(loadstring(base64decode("RnJhbWU="))()) then count += 1 end end
        if count >= 4 then
            for _, GgfRx2bY in ipairs(kids) do if GgfRx2bY:IsA(loadstring(base64decode("RnJhbWU="))()) then GgfRx2bY:Destroy() break end end
        end
        local col = isError and Theme.Bad or Theme.Accent
        local card = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = Theme.Card, BackgroundTransparency = 0.6,
            BorderSizePixel = 0, LayoutOrder = toastN, ZIndex = 60, Parent = toastHolder,
        })
        Corner(card, 8)
        local st = Stroke(card, col)
        Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.new(0, 3, 1, -12), Position = UDim2.new(0, 6, 0, 6), BackgroundColor3 = col,
            BorderSizePixel = 0, ZIndex = 61, Parent = card,
        })
        local lbl = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -26, 1, -8), Position = UDim2.new(0, 18, 0, 4), BackgroundTransparency = 1, Text = text,
            TextColor3 = Theme.Text, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 61, Parent = card,
        })
        Tween(card, { BackgroundTransparency = 0.05 }, 0.2)
        task.delay(3.4, function()
            if not card.Parent then return end
            Tween(card, { BackgroundTransparency = 1 }, 0.3)
            Tween(lbl, { TextTransparency = 1 }, 0.3)
            Tween(st, { Transparency = 1 }, 0.3)
            task.delay(0.35, function() if card.Parent then card:Destroy() end end)
        end)
    end

    -- Küçült / bü7GzvlMabüt
    local minimized = false
    local minBtn = MakeButton(topBar, loadstring(base64decode("LQ=="))(), Theme.Raised, UDim2.new(0, 28, 0, 28), UDim2.new(1, -74, 0.5, -14))
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            main.ClipsDescendants = true
            content.Visible = false
            statusBar.Visible = false
            Tween(main, { Size = UDim2.new(0, 920, 0, 48) }, 0.18)
        else
            content.Visible = true
            statusBar.Visible = true
            Tween(main, { Size = UDim2.new(0, 920, 0, 580) }, 0.18)
            task.delay(0.2, function() main.ClipsDescendants = false end)
        end
    end)

    -- Açılış animasyonu
    UI.ToggleMain = function(show)
        if show == nil then show = not main.Visible end
        if show then
            local target = UI.ScaleBase * math.clamp(Config.UIScale, 0.6, 1.3)
            uiScale.Scale = target * 0.92
            main.Visible = true
            Tween(uiScale, { Scale = target }, 0.16)
        else
            main.Visible = false
        end
    end

    local tabs, pages, tabCount = {}, {}, 0
    local function SelectTab(name)
        for tabName, t in pairs(tabs) do
            local active = tabName == name
            t.Active = active
            t.Bar.Visible = active
            t.Button.BackgroundTransparency = active and 0 or 1
            t.Button.TextColor3 = active and Theme.Text or Theme.SubText
            pages[tabName].Visible = active
        end
        pageTitle.Text = L.T(name)
        UI.CurTab = name
        if OpenDropdownList then OpenDropdownList.Visible = false; OpenDropdownList = nil end
    end

    local function AddTab(name)
        tabCount += 1
        local btn = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
            Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = Theme.Card, BackgroundTransparency = 1, Text = name,
            TextColor3 = Theme.SubText, Font = Enum.Font.GothamMedium, TextSize = 13, BorderSizePixel = 0,
            AutoButtonColor = false, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = tabCount, Parent = tabHolder,
        })
        Corner(btn, 8)
        Create(loadstring(base64decode("VUlQYWRkaW5n"))(), { PaddingLeft = UDim.new(0, 16), Parent = btn })
        local bar = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.new(0, 3, 0, 18), Position = UDim2.new(0, -12, 0.5, -9), BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0, Visible = false, Parent = btn,
        })
        Corner(bar, 2)
        local rec = { Button = btn, Bar = bar, Active = false }
        btn.MouseEnter:Connect(function()
            if not rec.Active then Tween(btn, { BackgroundTransparency = 0.6 }) end
        end)
        btn.MouseLeave:Connect(function()
            if not rec.Active then Tween(btn, { BackgroundTransparency = 1 }) end
        end)
        btn.MouseButton1Click:Connect(function() SelectTab(name) end)

        local page = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = false, Parent = content })
        Create(loadstring(base64decode("VUlQYWRkaW5n"))(), {
            PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 8),
            Parent = page,
        })
        tabs[name], pages[name] = rec, page
        return page
    end

    return { Gui = gui, Main = main, AddTab = AddTab, SelectTab = SelectTab }
end

local StatusToken = 0
SetStatus = function(text, isError)
    if not UI.StatusLabel then return end
    text = L.T(text)
    StatusToken += 1
    local token = StatusToken
    UI.StatusLabel.Text = text
    if isError and UI.Toast then UI.Toast(text, true) end
    UI.StatusLabel.TextColor3 = isError and Theme.Bad or Theme.SubText
    task.delay(6, function()
        if token == StatusToken and UI.StatusLabel then
            UI.StatusLabel.Text = L.T(loadstring(base64decode("UmVhZHk="))())
            UI.StatusLabel.TextColor3 = Theme.Muted
        end
    end)
end


-- BUILD WINDOW + TABS

Window = CreateWindow()

local parryPage    = Window.AddTab(loadstring(base64decode("QXV0by1QYXJyeQ=="))())
local monitorPage  = Window.AddTab(loadstring(base64decode("QW5pbWF0aW9uIE1vbml0b3I="))())
local skillsPage   = Window.AddTab(loadstring(base64decode("U2tpbGxz"))())
local miscPage     = Window.AddTab(loadstring(base64decode("TWlzYw=="))())
local settingsPage = Window.AddTab(loadstring(base64decode("U2V0dGluZ3M="))())

--------------------------------------------------------
-- AUTO-PARRY TAB
--------------------------------------------------------
do
    local scroll = CreateScrollList(parryPage)
    CreateSection(scroll, loadstring(base64decode("Q29udHJvbA=="))())
    UI.EnableToggle = CreateToggle(scroll, loadstring(base64decode("RW5hYmxlIEF1dG8tUGFycnk="))(), Config.AutoParryEnabled, function(v)
        SetEnabled(v)
    end, loadstring(base64decode("UHJlc3NlcyB0aGUgcGFycnkga2V5IHdoZW4gYSBza2lsbCwgYW5pbWF0aW9uIG9yIG9iamVjdCBpcyBkZXRlY3RlZCBpbiByYW5nZS4="))())

    UI.Stats = CreateStatRow(scroll, {
        { loadstring(base64decode("SG9va2Vk"))(), loadstring(base64decode("U291cmNlcyBob29rZWQ="))(), loadstring(base64decode("MA=="))() },
        { loadstring(base64decode("U2tpbGxz"))(), loadstring(base64decode("QWN0aXZlIHNraWxscw=="))(), loadstring(base64decode("MA=="))() },
        { loadstring(base64decode("TGFzdA=="))(), loadstring(base64decode("TGFzdCBwYXJyeQ=="))(), loadstring(base64decode("Tm9uZQ=="))() },
    })

    CreateSection(scroll, loadstring(base64decode("T3B0aW9ucw=="))())
    CreateToggle(scroll, loadstring(base64decode("U2hvdyBoaXRib3hlcyAvIHBhcnJ5IHJlYXNvbg=="))(), Config.DebugVis, function(v)
        Config.DebugVis = v
        if not v then DebugClearAll() end
        QueueSave()
    end, loadstring(base64decode("RHJhd3MgZGV0ZWN0aW9uIHJhbmdlcyBpbiB0aGUgd29ybGQgYW5kIHNob3dzIHdoeSB0aGUgcGFycnkga2V5IHdhcyBwcmVzc2VkLg=="))())
    CreateToggle(scroll, loadstring(base64decode("UGluZyBjb21wZW5zYXRpb24="))(), Config.PingComp, function(v) Config.PingComp = v; QueueSave() end)
    CreateToggle(scroll, loadstring(base64decode("SWdub3JlIGZyaWVuZHM="))(), Config.IgnoreFriends, function(v) Config.IgnoreFriends = v; QueueSave() end)
    CreateToggle(scroll, loadstring(base64decode("SW5jbHVkZSBOUENz"))(), Config.IncludeNpcs, function(v)
        Config.IncludeNpcs = v
        SyncNpcs()
        QueueSave()
    end, loadstring(base64decode("QWxzbyBwYXJyaWVzIGFuaW1hdGlvbnMsIHNraWxscyBhbmQgb2JqZWN0cyBjb21pbmcgZnJvbSBOUENzLg=="))())
    CreateTextField(scroll, loadstring(base64decode("SUdOT1JFRCBQTEFZRVJTIChjb21tYSBzZXBhcmF0ZWQp"))(), Config.Ignored, function(text)
        Config.Ignored = text
        RebuildIgnored()
        QueueSave()
    end)
end

--------------------------------------------------------
-- ANIMATION MONITOR TAB
--------------------------------------------------------
local monitorLeft = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(0.58, -8, 1, 0), BackgroundTransparency = 1, Parent = monitorPage })
local monitorRight = Create(loadstring(base64decode("RnJhbWU="))(), {
    Size = UDim2.new(0.42, 0, 1, 0), Position = UDim2.new(0.58, 0, 0, 0),
    BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, Parent = monitorPage,
})
Corner(monitorRight, 10)
Stroke(monitorRight)

do
    local top = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 0, 238), BackgroundTransparency = 1, ZIndex = 10, Parent = monitorLeft })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = top })

    local header = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, Text = loadstring(base64decode("Tm90IHdhdGNoaW5n"))(),
        TextColor3 = Theme.SubText, Font = Enum.Font.GothamBold, TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = top,
    })
    Order(header, top)
    UI.MonitorHeader = header

    UI.WatchDropdown = CreateDropdown(top, loadstring(base64decode("V0FUQ0g="))(), { loadstring(base64decode("T2Zm"))(), loadstring(base64decode("RXZlcnlvbmU="))(), loadstring(base64decode("TlBDcw=="))() }, loadstring(base64decode("T2Zm"))(), function(v)
        if v == loadstring(base64decode("T2Zm"))() then SetWatchTarget(nil)
        elseif v == loadstring(base64decode("RXZlcnlvbmU="))() then SetWatchTarget(loadstring(base64decode("Kg=="))())
        elseif v == loadstring(base64decode("TlBDcw=="))() then SetWatchTarget(loadstring(base64decode("bnBj"))())
        else SetWatchTarget(v) end
    end, 10, function()
        local names = { loadstring(base64decode("T2Zm"))(), loadstring(base64decode("RXZlcnlvbmU="))(), loadstring(base64decode("TlBDcw=="))() }
        for _, p in ipairs(Players:GetPlayers()) do table.insert(names, p.Name) end
        return names
    end)

    CreateSearchBox(top, loadstring(base64decode("U2VhcmNoIGJ5IG5hbWUgb3IgSUQuLi4="))(), function(text)
        DiscoverySearch = text
        ResortDiscoveredList()
    end)

    CreateDropdown(top, loadstring(base64decode("U09SVA=="))(), { loadstring(base64decode("TmV3ZXN0"))(), loadstring(base64decode("T2xkZXN0"))(), loadstring(base64decode("TmFtZQ=="))(), loadstring(base64decode("UGxheSBDb3VudA=="))() }, loadstring(base64decode("TmV3ZXN0"))(), function(v)
        DiscoverySort = v
        ResortDiscoveredList()
    end, 9)

    CreateDropdown(top, loadstring(base64decode("VFlQRQ=="))(), { loadstring(base64decode("QWxs"))(), loadstring(base64decode("QW5pbQ=="))(), loadstring(base64decode("U2tpbGw="))(), loadstring(base64decode("T2JqZWN0"))() }, loadstring(base64decode("QWxs"))(), function(v)
        TypeFilter = v
        ResortDiscoveredList()
    end, 8)

    CreateButtonRow(top, {
        { loadstring(base64decode("UGF1c2U="))(), function(b)
            Monitor.Paused = not Monitor.Paused
            L.Set(b, Monitor.Paused and loadstring(base64decode("UmVzdW1l"))() or loadstring(base64decode("UGF1c2U="))())
            SetBase(b, Monitor.Paused and Theme.Warn or Theme.Raised)
            UpdateMonitorHeader()
        end, Theme.Raised },
        { loadstring(base64decode("Q2xlYXI="))(), function() ClearDiscoveredHistory() end, Theme.Bad },
    })

    UI.DiscoveredContainer = CreateScrollList(monitorLeft, UDim2.new(1, 0, 1, -246), UDim2.new(0, 0, 0, 246))
    UI.ListHint = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 80), BackgroundTransparency = 1, Text = loadstring(base64decode(""))(), TextColor3 = Theme.Muted,
        Font = Enum.Font.Gotham, TextSize = 13, TextWrapped = true, LayoutOrder = 0, Parent = UI.DiscoveredContainer,
    })
end

do
    local panel = monitorRight
    Create(loadstring(base64decode("VUlQYWRkaW5n"))(), {
        PaddingTop = UDim.new(0, 12), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12),
        Parent = panel,
    })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = panel })

    local viewport = Create(loadstring(base64decode("Vmlld3BvcnRGcmFtZQ=="))(), {
        Size = UDim2.new(1, 0, 0, 230), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Active = true,
        Ambient = Color3.fromRGB(190, 190, 190), LightColor = Color3.fromRGB(255, 255, 255),
        LightDirection = Vector3.new(-1, -1, -0.5), Parent = panel,
    })
    Order(viewport, panel)
    Corner(viewport, 8)
    Stroke(viewport)

    local camera = Create(loadstring(base64decode("Q2FtZXJh"))(), { FieldOfView = 50, Parent = viewport })
    viewport.CurrentCamera = camera
    PreviewState.Camera = camera
    PreviewState.WorldModel = Create(loadstring(base64decode("V29ybGRNb2RlbA=="))(), { Parent = viewport })

    viewport.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local last = input.Position
            TrackDrag(function(i)
                local delta = i.Position - last
                last = i.Position
                PreviewState.CamYaw = (PreviewState.CamYaw - delta.X * 0.5) % 360
                PreviewState.CamPitch = math.clamp(PreviewState.CamPitch + delta.Y * 0.5, -80, 80)
                UpdatePreviewCamera()
            end)
        end
    end)
    viewport.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            PreviewState.CamDistance = math.clamp(
                PreviewState.CamDistance - input.Position.Z * math.max(1, (PreviewState.Radius or 3) / 3),
                PreviewState.CamMin or 4, PreviewState.CamMax or 20)
            UpdatePreviewCamera()
        end
    end)

    UI.PreviewNameLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, Text = loadstring(base64decode("Tm8gYW5pbWF0aW9uIHNlbGVjdGVk"))(),
        TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Parent = panel,
    })
    Order(UI.PreviewNameLabel, panel)

    UI.PreviewIdLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 14), BackgroundTransparency = 1, Text = loadstring(base64decode("UHJlc3MgUHJldmlldyBvbiBhbiBhbmltYXRpb24="))(),
        TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Parent = panel,
    })
    Order(UI.PreviewIdLabel, panel)

    -- İlerleme çubuğu (tıkla / sürükle ile sar)
    local progress = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
        Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, Text = loadstring(base64decode(""))(), AutoButtonColor = false, Parent = panel,
    })
    Order(progress, panel)
    local bar = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0, 4), BackgroundColor3 = Theme.Raised,
        BorderSizePixel = 0, Parent = progress,
    })
    Corner(bar, 3)
    UI.ProgressFill = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = bar })
    Corner(UI.ProgressFill, 3)
    UI.TimeLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 14), BackgroundTransparency = 1,
        Text = loadstring(base64decode("MC4wMCAvIDAuMDAgcw=="))(), TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = progress,
    })

    local function scrub(UTZeUWBZ)
        local t = PreviewState.Track
        if t and t.Length > 0 then
            local rel = math.clamp((UTZeUWBZ - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), 0, 1)
            pcall(function() t.TimePosition = rel * t.Length end)
        end
    end
    progress.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            scrub(input.Position.X)
            TrackDrag(function(i) scrub(i.Position.X) end)
        end
    end)

    local _, b = CreateButtonRow(panel, {
        { loadstring(base64decode("UGxheQ=="))(), function()
            local t = PreviewState.Track
            if not t then
                if PreviewState.CurrentAnimId then
                    LoadAndPlayPreview(PreviewState.CurrentAnimId, PreviewState.CurrentAnimName, PreviewState.SourcePlayer)
                end
                return
            end
            if not t.IsPlaying then
                PreviewState.Paused = false
                t:Play()
                t:AdjustSpeed(1)
            else
                PreviewState.Paused = not PreviewState.Paused
                t:AdjustSpeed(PreviewState.Paused and 0 or 1)
            end
        end, Theme.Accent },
        { loadstring(base64decode("UmVwbGF5"))(), function()
            if PreviewState.CurrentAnimId then
                LoadAndPlayPreview(PreviewState.CurrentAnimId, PreviewState.CurrentAnimName, PreviewState.SourcePlayer)
            end
        end, Theme.Raised },
    })
    UI.PlayButton = b[1]
end

--------------------------------------------------------
-- SKILLS TAB
--------------------------------------------------------
local skillsLeft = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(0.44, -8, 1, 0), BackgroundTransparency = 1, Parent = skillsPage })
local skillsRight = Create(loadstring(base64decode("RnJhbWU="))(), {
    Size = UDim2.new(0.56, 0, 1, 0), Position = UDim2.new(0.44, 0, 0, 0),
    BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, Parent = skillsPage,
})
Corner(skillsRight, 10)
Stroke(skillsRight)

do
    local top = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 0, 86), BackgroundTransparency = 1, Parent = skillsLeft })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = top })
    CreateSearchBox(top, loadstring(base64decode("U2VhcmNoIHNraWxscy4uLg=="))(), function(text)
        SkillSearch = text
        ResortSkillList()
    end)
    CreateButtonRow(top, {
        { loadstring(base64decode("KyBOZXcgU2tpbGw="))(), function()
            local skill = AddSkill(loadstring(base64decode("TmV3IFNraWxs"))(), nil)
            SelectSkill(skill.Id)
        end, Theme.Accent },
        { loadstring(base64decode("QWxsIE9u"))(), function() SetAllEnabled(true) end, Theme.Raised },
        { loadstring(base64decode("QWxsIE9mZg=="))(), function() SetAllEnabled(false) end, Theme.Raised },
    })

    UI.SkillListContainer = CreateScrollList(skillsLeft, UDim2.new(1, 0, 1, -94), UDim2.new(0, 0, 0, 94))
    UI.SkillHint = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, 0, 0, 80), BackgroundTransparency = 1, Text = loadstring(base64decode("Tm8gc2tpbGxzIHlldC5cbkFkZCBvbmUgZnJvbSB0aGUgQW5pbWF0aW9uIE1vbml0b3Iu"))(),
        TextColor3 = Theme.Muted, Font = Enum.Font.Gotham, TextSize = 13, TextWrapped = true, LayoutOrder = 0,
        Parent = UI.SkillListContainer,
    })
end

do
    local holder = Create(loadstring(base64decode("RnJhbWU="))(), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Parent = skillsRight })
    Create(loadstring(base64decode("VUlQYWRkaW5n"))(), {
        PaddingTop = UDim.new(0, 12), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 4), PaddingBottom = UDim.new(0, 8),
        Parent = holder,
    })
    UI.SkillEditContainer = CreateScrollList(holder)
end

--------------------------------------------------------
-- MISC TAB
--------------------------------------------------------
do
    local scroll = CreateScrollList(miscPage)
    CreateSection(scroll, loadstring(base64decode("Q2xvdGhpbmc="))())

    -- Tüm GgfRx2bYıyafet kontrolleri bu panelin içinde; toggle kapalıyken gizli
    local panel = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
        Visible = Config.ClothingUI, Parent = scroll,
    })
    Create(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = panel })

    CreateToggle(scroll, loadstring(base64decode("Q2xvdGhpbmcgc3lzdGVt"))(), Config.ClothingUI, function(v)
        Config.ClothingUI = v
        panel.Visible = v
        if v then
            if Config.Outfit ~= loadstring(base64decode(""))() then WearOutfit(Config.Outfit, true) end
        else
            Config.OutfitActive = false
            RemoveOutfit()
        end
        QueueSave()
    end, loadstring(base64decode("Q2xpZW50LXNpZGUgb3V0Zml0cy4gVHVybiBvbiB0byBzaG93IHRoZSBjb250cm9scy4="))())
    Order(panel, scroll)

    UI.OutfitDropdown = CreateDropdown(panel, loadstring(base64decode("T1VURklU"))(), OutfitNames(),
        Config.Outfit ~= loadstring(base64decode(""))() and Config.Outfit or loadstring(base64decode("U2VsZWN0IG91dGZpdA=="))(), function(v)
            if v == loadstring(base64decode("KG5vbmUgZm91bmQp"))() then return end
            Config.Outfit = v
            QueueSave()
            WearOutfit(v)
        end, 9, function()
            local n = OutfitNames()
            if #n == 0 then n = { loadstring(base64decode("KG5vbmUgZm91bmQp"))() } end
            return n
        end)
    CreateToggle(panel, loadstring(base64decode("SGlkZSBlcXVpcHBlZCBhcm1vcg=="))(), Config.HideArmor, function(v)
        Config.HideArmor = v
        QueueSave()
        if Outfit.Worn and Config.Outfit ~= loadstring(base64decode(""))() then WearOutfit(Config.Outfit) end
    end, loadstring(base64decode("SGlkZXMgdGhlIGFybW9yIHlvdSBhbHJlYWR5IHdlYXIgKGUuZy4gQXNjZW5kZWQgU2VuanUpIHNvIHRoZSBzZWxlY3RlZCBvdXRmaXQgcmVwbGFjZXMgaXQgaW5zdGVhZCBvZiBzdGFja2luZy4="))())
    CreateToggle(panel, loadstring(base64decode("QnJva2VuIHZhcmlhbnQ="))(), Config.OutfitBroken, function(v)
        Config.OutfitBroken = v
        QueueSave()
        if Outfit.Worn and Config.Outfit ~= loadstring(base64decode(""))() then WearOutfit(Config.Outfit) end
    end, loadstring(base64decode("V2VhcnMgdGhlIEJyb2tlbiBzZXQgKEJyb2tlbiBmb2xkZXIsIFNoaXJ0QnJva2VuLCBQYW50c0Jyb2tlbiku"))())
    CreateToggle(panel, loadstring(base64decode("UmUtYXBwbHkgb24gcmVzcGF3bg=="))(), Config.OutfitReapply, function(v)
        Config.OutfitReapply = v
        QueueSave()
    end, loadstring(base64decode("UHV0cyB0aGUgc2VsZWN0ZWQgb3V0Zml0IGJhY2sgb24gYWZ0ZXIgeW91IHJlc3Bhd24u"))())
    CreateSection(panel, loadstring(base64decode("UG9zaXRpb24gYWRqdXN0"))())
    local function offChanged()
        ApplyOutfitOffset()
        if Config.Outfit ~= loadstring(base64decode(""))() then
            Config.OutfitOffsets[Config.Outfit] = {
                Config.OutfitX, Config.OutfitY, Config.OutfitZ,
                Config.LimbX, Config.LimbY, Config.LimbZ,
            }
        end
        QueueSave()
    end
    UI.OffsetSliders = {
        X = CreateSlider(panel, loadstring(base64decode("T2Zmc2V0IFggKGxlZnQgLyByaWdodCk="))(), -5, 5, Config.OutfitX, 2, function(v) Config.OutfitX = v; offChanged() end, loadstring(base64decode("IHN0"))()),
        Y = CreateSlider(panel, loadstring(base64decode("T2Zmc2V0IFkgKHVwIC8gZG93bik="))(), -5, 5, Config.OutfitY, 2, function(v) Config.OutfitY = v; offChanged() end, loadstring(base64decode("IHN0"))()),
        Z = CreateSlider(panel, loadstring(base64decode("T2Zmc2V0IFogKGZvcndhcmQgLyBiYWNrKQ=="))(), -5, 5, Config.OutfitZ, 2, function(v) Config.OutfitZ = v; offChanged() end, loadstring(base64decode("IHN0"))()),
        LX = CreateSlider(panel, loadstring(base64decode("TGltYnMgWCAoYXJtcyAvIGxlZ3Mp"))(), -5, 5, Config.LimbX, 2, function(v) Config.LimbX = v; offChanged() end, loadstring(base64decode("IHN0"))()),
        LY = CreateSlider(panel, loadstring(base64decode("TGltYnMgWSAoYXJtcyAvIGxlZ3Mp"))(), -5, 5, Config.LimbY, 2, function(v) Config.LimbY = v; offChanged() end, loadstring(base64decode("IHN0"))()),
        LZ = CreateSlider(panel, loadstring(base64decode("TGltYnMgWiAoYXJtcyAvIGxlZ3Mp"))(), -5, 5, Config.LimbZ, 2, function(v) Config.LimbZ = v; offChanged() end, loadstring(base64decode("IHN0"))()),
    }
    CreateButton(panel, loadstring(base64decode("UmVzZXQgb2Zmc2V0cyB0byBkZWZhdWx0"))(), function()
        if Config.Outfit == loadstring(base64decode(""))() then return end
        Config.OutfitOffsets[Config.Outfit] = nil
        Outfit.LoadOffset(Config.Outfit)
        ApplyOutfitOffset()
        QueueSave()
    end, Theme.Raised)
    CreateButtonRow(panel, {
        { loadstring(base64decode("V2VhciBhZ2Fpbg=="))(), function()
            if Config.Outfit == loadstring(base64decode(""))() then SetStatus(loadstring(base64decode("U2VsZWN0IGFuIG91dGZpdCBmaXJzdC4="))(), true) return end
            WearOutfit(Config.Outfit)
        end, Theme.Accent },
        { loadstring(base64decode("UmVtb3Zl"))(), function()
            Config.OutfitActive = false
            RemoveOutfit()
            QueueSave()
            SetStatus(loadstring(base64decode("T3V0Zml0IHJlbW92ZWQgKHlvdXIgb3JpZ2luYWwgYXJtb3IgaXMgYmFjayku"))())
        end, Theme.Bad },
    })
    CreateNote(panel, loadstring(base64decode("T25seSB5b3UgY2FuIHNlZSB0aGlzLiBMaXN0cyBldmVyeSBvdXRmaXQgaW4gUmVwbGljYXRlZFN0b3JhZ2UgPiBDbG90aGluZyB0aGF0IGhhcyBhIE5vcm1hbCAvIEJyb2tlbiBmb2xkZXIuIEFybXMsIGxlZ3MgYW5kIHRvcnNvIGFyZSBkZXRlY3RlZCBmcm9tIHBhcnQgYW5kIG1vZGVsIG5hbWVzIChMQSwgUkEsIExMLCBSTCwgVCwgTGVmdCBBcm0sIC4uLiku"))(), 58)
end

--------------------------------------------------------
-- SETTINGS TAB
--------------------------------------------------------
do
    local scroll = CreateScrollList(settingsPage)

    CreateSection(scroll, loadstring(base64decode("SW50ZXJmYWNl"))())
    UI.LangDropdown = CreateDropdown(scroll, loadstring(base64decode("TEFOR1VBR0U="))(), L.Langs, Config.Language, function(v)
        L.SetLang(v)
    end, 10)
    do
        local tok = 0
        CreateSlider(scroll, loadstring(base64decode("VUkgc2NhbGU="))(), 0.6, 1.3, Config.UIScale, 2, function(v)
            Config.UIScale = v
            tok += 1
            local my = tok
            -- sürükleme sırasında pencere bü7GzvlMabü7GzvlMabüp kaymasın: bırakınca uygula
            task.delay(0.35, function() if my == tok then UI.ApplyScale() end end)
            QueueSave()
        end, loadstring(base64decode("eA=="))())
    end
    UI.SnowToggle = CreateToggle(scroll, loadstring(base64decode("U25vdyBlZmZlY3Q="))(), Config.Snow, function(v)
        Config.Snow = v
        UI.SetSnow(v)
        QueueSave()
    end, loadstring(base64decode("QW5pbWF0ZWQgc25vd2ZhbGwgaW4gdGhlIHdpbmRvdyBiYWNrZ3JvdW5kIChkaXNhYmxlIGZvciBtYXggRlBTKS4="))())

    CreateToggle(scroll, loadstring(base64decode("QXV0byBleGVjdXRl"))(), Config.AutoExecute, function(v)
        Config.AutoExecute = v
        if v then AutoExec.Queue() end
        QueueSave()
    end, loadstring(base64decode("UmUtcnVucyB0aGUgc2NyaXB0IGF1dG9tYXRpY2FsbHkgd2hlbiB5b3Ugam9pbiBhbm90aGVyIHNlcnZlciBvciB0ZWxlcG9ydC4="))())

    if Lic.Enabled then
        CreateSection(scroll, loadstring(base64decode("TGljZW5zZQ=="))())
        UI.LicenseLabel = CreateNote(scroll, loadstring(base64decode(""))(), 34, Theme.Good)
        CreateButton(scroll, loadstring(base64decode("TG9nIG91dCAvIGNoYW5nZSBrZXk="))(), function()
            Lic.ClearKey()
            if _G.AutoParrySystem and _G.AutoParrySystem.Unload then _G.AutoParrySystem.Unload() end
        end, Theme.Raised)
    end

    CreateSection(scroll, loadstring(base64decode("UHJvZmlsZQ=="))())
    UI.ProfileDropdown = CreateDropdown(scroll, loadstring(base64decode("QUNUSVZF"))(), { loadstring(base64decode("RGVmYXVsdA=="))() }, loadstring(base64decode("RGVmYXVsdA=="))(), function(v)
        SwitchProfile(v)
    end, 9, function() return ProfileNames() end)
    local nameBox = CreateTextField(scroll, loadstring(base64decode("TkVXIFBST0ZJTEUgTkFNRQ=="))(), loadstring(base64decode(""))(), nil)
    CreateButtonRow(scroll, {
        { loadstring(base64decode("Q3JlYXRl"))(), function()
            if CreateProfile(nameBox.Text) then nameBox.Text = loadstring(base64decode(""))() end
        end, Theme.Accent },
        { loadstring(base64decode("RGVsZXRlIGN1cnJlbnQ="))(), function() DeleteProfile() end, Theme.Bad },
    })
    CreateButton(scroll, loadstring(base64decode("UmVzdG9yZSByZWNvbW1lbmRlZCBjb25maWc="))(), function() UI.RestoreDefaults() end, Theme.Raised)

    CreateSection(scroll, loadstring(base64decode("RGV0ZWN0aW9u"))())
    CreateTextField(scroll, loadstring(base64decode("U0tJTEwgVkFMVUUgTkFNRSAoYXR0cmlidXRlIC8gdmFsdWUgb2JqZWN0KQ=="))(), Config.SkillValueName, function(text)
        text = Trim(text)
        if text == loadstring(base64decode(""))() then return end
        if text ~= Config.SkillValueName then
            Config.SkillValueName = text
            RebuildHooks()
            QueueSave()
            SetStatus(loadstring(base64decode("U2tpbGwgdmFsdWUgbmFtZTog"))() .. text)
        end
    end, false, loadstring(base64decode("Q3VycmVudFNraWxs"))())
    CreateNote(scroll, loadstring(base64decode("U2tpbGwtdHlwZSBza2lsbHMgcmVhZCB0aGlzIHZhbHVlIGZyb20gUmVwbGljYXRlZFN0b3JhZ2UgPiBTZXR0aW5ncyA+IFtwbGF5ZXIgbmFtZV0sIGFuZCBhbHNvIGZyb20gdGhlIGNoYXJhY3RlciwgaXRzIEh1bWFub2lkIG9yIHRoZSBwbGF5ZXIgKGF0dHJpYnV0ZSBvciBWYWx1ZSBvYmplY3QpLg=="))(), 32)

    CreateSection(scroll, loadstring(base64decode("S2V5YmluZHM="))())
    CreateKeybind(scroll, loadstring(base64decode("VG9nZ2xlIFVJ"))(), function() return Config.UIKeybind end, function(GgfRx2bY) Config.UIKeybind = GgfRx2bY; QueueSave() end)
    CreateKeybind(scroll, loadstring(base64decode("VG9nZ2xlIEF1dG8tUGFycnk="))(), function() return Config.ToggleKey end, function(GgfRx2bY) Config.ToggleKey = GgfRx2bY; QueueSave() end)
    CreateKeybind(scroll, loadstring(base64decode("UGFycnkga2V5IChpbi1nYW1lKQ=="))(), function() return Config.ParryKey end, function(GgfRx2bY) Config.ParryKey = GgfRx2bY; QueueSave() end)

    CreateSection(scroll, loadstring(base64decode("SW1wb3J0IC8gRXhwb3J0"))())
    local jsonBox = CreateTextField(scroll, loadstring(base64decode("U0tJTExTIE9GIENVUlJFTlQgUFJPRklMRSAoSlNPTik="))(), loadstring(base64decode(""))(), nil, true)
    CreateButtonRow(scroll, {
        { loadstring(base64decode("RXhwb3J0"))(), function()
            local json = ExportSkills()
            if json then
                jsonBox.Text = json
                if type(setclipboard) == loadstring(base64decode("ZnVuY3Rpb24="))() then pcall(setclipboard, json) end
                SetStatus(loadstring(base64decode("RXhwb3J0ZWQg"))() .. #Skills .. loadstring(base64decode("IHNraWxsKHMpLg=="))())
            else
                SetStatus(loadstring(base64decode("RXhwb3J0IGZhaWxlZC4="))(), true)
            end
        end, Theme.Raised },
        { loadstring(base64decode("SW1wb3J0"))(), function()
            local count, err = ImportSkills(jsonBox.Text)
            if count then SetStatus(loadstring(base64decode("SW1wb3J0ZWQg"))() .. count .. loadstring(base64decode("IHNraWxsKHMpLg=="))())
            else SetStatus(loadstring(base64decode("SW1wb3J0IGZhaWxlZDog"))() .. tostring(err), true) end
        end, Theme.Accent },
    })

    if not CanSaveFiles then
        CreateNote(scroll, loadstring(base64decode("RmlsZSBhY2Nlc3MgaXMgbm90IGF2YWlsYWJsZSBpbiB0aGlzIGV4ZWN1dG9yLiBDaGFuZ2VzIGFyZSBsb3N0IG9uIHJlc3RhcnQgLSB1c2UgRXhwb3J0IHRvIGtlZXAgeW91ciBza2lsbHMu"))(), 46, Theme.Warn)
    end

    CreateSection(scroll, loadstring(base64decode("U2NyaXB0"))())
    CreateButton(scroll, loadstring(base64decode("VW5sb2FkIFNjcmlwdA=="))(), function()
        if _G.AutoParrySystem and _G.AutoParrySystem.Unload then _G.AutoParrySystem.Unload() end
    end, Theme.Bad)
end


-- SOURCES (oyuncu + NPC) VE HOOK'LAR (animasyon + skill değeri)

-- src = { Key, Name, Id, IsPlayer, Friend, GetChar }
local function GetSource(player)
    local s = Sources[player]
    if s then return s end
    s = {
        Key = player, Name = player.Name, Id = tostring(player.UserId), IsPlayer = true, Friend = false,
        GetChar = function() return player.Character end,
    }
    Sources[player] = s
    if player ~= LocalPlayer then
        task.spawn(function()
            local ok, r = pcall(function() return LocalPlayer:IsFriendsWith(player.UserId) end)
            if ok then s.Friend = r end
        end)
    end
    return s
end

local function IsIgnored(src)
    if not src.IsPlayer then return false end
    if Config.IgnoreFriends and src.Friend then return true end
    return IgnoredSet[src.Name:lower()] == true
end

-- Karakter / Humanoid / Player üzerindeki loadstring(base64decode("Q3VycmVudFNraWxs"))() değerini izler
-- (attribute veya ValueBase). handler(src, value, existing)
local function WatchSkillValue(src, char, handler, scanExisting)
    local conns = {}
    local name = Config.SkillValueName
    if name == loadstring(base64decode(""))() then return conns end

    local function hookAttr(obj)
        if not obj then return end
        local ok, sig = pcall(function() return obj:GetAttributeChangedSignal(name) end)
        if not ok then return end
        table.insert(conns, sig:Connect(function() handler(src, obj:GetAttribute(name), false) end))
        local initial = obj:GetAttribute(name)
        if scanExisting and initial ~= nil then handler(src, initial, true) end
    end
    local function hookValue(v)
        table.insert(conns, v.Changed:Connect(function(wmbP3alF) handler(src, wmbP3alF, false) end))
        if scanExisting then handler(src, v.Value, true) end
    end

    hookAttr(char)
    hookAttr(char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))()))
    local holders = { char }
    if src.IsPlayer then
        hookAttr(src.Key)
        table.insert(holders, src.Key)
    end
    for _, h in ipairs(holders) do
        local v = h:FindFirstChild(name, true)
        if v and v:IsA(loadstring(base64decode("VmFsdWVCYXNl"))()) then hookValue(v) end
        table.insert(conns, h.DescendantAdded:Connect(function(d)
            if d.Name == name and d:IsA(loadstring(base64decode("VmFsdWVCYXNl"))()) then hookValue(d) end
        end))
    end

    -- Bloodlines: ReplicatedStorage > Settings > [oyuncu adı] > CurrentSkill (StringValue)
    if src.IsPlayer then
        local RS = ReplicatedStorage
        local function watchFolder(folder)
            local v = folder:FindFirstChild(name)
            if v and v:IsA(loadstring(base64decode("VmFsdWVCYXNl"))()) then hookValue(v) end
            table.insert(conns, folder.ChildAdded:Connect(function(c)
                if c.Name == name and c:IsA(loadstring(base64decode("VmFsdWVCYXNl"))()) then hookValue(c) end
            end))
        end
        local function watchSettings(settings)
            local f = settings:FindFirstChild(src.Name)
            if f then watchFolder(f) end
            table.insert(conns, settings.ChildAdded:Connect(function(c)
                if c.Name == src.Name then watchFolder(c) end
            end))
        end
        local settings = RS:FindFirstChild(loadstring(base64decode("U2V0dGluZ3M="))())
        if settings then watchSettings(settings) end
        table.insert(conns, RS.ChildAdded:Connect(function(c)
            if c.Name == loadstring(base64decode("U2V0dGluZ3M="))() then watchSettings(c) end
        end))
    end
    return conns
end

-- Sunucunun oynattığı (NPC) animasyonlar için AnimationPlayed'e ek olarak tarama yapar
local function PollAnimators()
    -- Parry kapalı ve Monitor kapalıyken hiç tarama yapılmaz
    if not (Config.AutoParryEnabled or Monitor.Target) then return end
    Poll.Tick += 1
    local lroot = Poll.Local()
    local lpos = lroot and lroot.Position
    local near = math.max(60, UI.MaxSkillDist or 60) + 15
    local farTurn = (Poll.Tick % 6 == 0)          -- uzaktakiler 6 turda bir taranır
    local hardLimit = Monitor.Target and math.huge or 300
    for entry in pairs(Pollers) do
        local animator = entry.Animator
        if not animator.Parent or not entry.Rec.Alive then
            Pollers[entry] = nil
        else
            local skip = false
            if lpos then
                local r = Poll.EntryRoot(entry)
                if r then
                    local d = (r.Position - lpos).Magnitude
                    if d > (entry.Limit or hardLimit) then skip = true
                    elseif d > near and not farTurn then skip = true end
                elseif not farTurn then
                    skip = true
                end
            end
            if not skip then
                local ok, tracks = pcall(animator.GetPlayingAnimationTracks, animator)
                if ok then
                    local playing = entry.Playing
                    if not playing then playing = {}; entry.Playing = playing else table.clear(playing) end
                    for _, t in ipairs(tracks) do
                        playing[t] = true
                        entry.Fire(t, false, false, true)
                    end
                    local seen = entry.Seen
                    if seen then
                        for t in pairs(seen) do
                            if not playing[t] and not t.IsPlaying then
                                seen[t] = nil
                                ParryRuntime.TriggeredTracks[t] = nil
                            end
                        end
                    end
                end
            end
        end
    end
end

local function HookAnimator(rec, src, animator, handlers, scanExisting, limit)
    if rec.Animators[animator] then return end
    rec.Animators[animator] = true
    local seen = setmetatable({}, { __mode = loadstring(base64decode("aw=="))() })

    -- fresh: taramayla bulunan track zaten uzun süredir oynuyorsa (menzile yeni girdi) tetiklenmesini engeller
    local function fire(track, existing, silent, fresh)
        if seen[track] then return end
        seen[track] = true
        local sc
        sc = track.Stopped:Connect(function()
            seen[track] = nil
            sc:Disconnect()
        end)
        if fresh and not scanExisting and track.TimePosition > 0.3 then silent = true end
        if not silent then handlers.Anim(src, track, existing) end
    end

    table.insert(rec.AnimConns, animator.AnimationPlayed:Connect(function(track) fire(track, false) end))
    local ok, playing = pcall(function() return animator:GetPlayingAnimationTracks() end)
    if ok then
        for _, t in ipairs(playing) do fire(t, true, not scanExisting) end
    end
    do
        local entry = { Animator = animator, Src = src, Rec = rec, Fire = fire, Limit = limit, Seen = seen }
        Pollers[entry] = true
        rec.PollEntries[entry] = true
    end
end

-- handlers = { Anim = fn(src, track, existing), Skill = fn(src, value, existing) }
local function HookSource(store, src, handlers, scanExisting, limit)
    if store[src.Key] then return end
    local rec = { Alive = true, AnimConns = {}, Animators = {}, PollEntries = {} }
    store[src.Key] = rec

    local function clearAnim()
        DisconnectAll(rec.AnimConns)
        rec.AnimConns = {}
        for e in pairs(rec.PollEntries) do Pollers[e] = nil end
        rec.PollEntries = {}
        rec.Animators = {}
    end
    rec.ClearAnim = clearAnim

    local function onCharacter(char)
        clearAnim()
        DisconnectAll(rec.Skill)
        rec.Skill = nil
        task.spawn(function()
            if not rec.Alive or src.GetChar() ~= char then return end
            if handlers.Skill then
                rec.Skill = WatchSkillValue(src, char, handlers.Skill, scanExisting)
                UpdateEngineStatus()
            end
            if not handlers.Anim then return end
            local function tryHook(d)
                if d:IsA(loadstring(base64decode("QW5pbWF0b3I="))()) and rec.Alive and src.GetChar() == char then
                    HookAnimator(rec, src, d, handlers, scanExisting, limit)
                    UpdateEngineStatus()
                end
            end
            for _, d in ipairs(char:GetDescendants()) do tryHook(d) end
            table.insert(rec.AnimConns, char.DescendantAdded:Connect(tryHook))
        end)
    end

    if src.IsPlayer then
        rec.CharConn = src.Key.CharacterAdded:Connect(onCharacter)
        if src.Key.Character then onCharacter(src.Key.Character) end
    else
        onCharacter(src.Key)
    end
end

local function UnhookSource(store, key)
    local rec = store[key]
    if not rec then return end
    rec.Alive = false
    if rec.ClearAnim then rec.ClearAnim() end
    if rec.CharConn then rec.CharConn:Disconnect() end
    DisconnectAll(rec.Skill)
    store[key] = nil
end

-- NPC: Animator'ı olan (Humanoid ya da AnimationController), oyuncuya ait olmayan modeller
local function NpcModelOf(animator)
    local c = animator.Parent
    if not c then return nil end
    if c:IsA(loadstring(base64decode("TW9kZWw="))()) then return c end
    local m = c.Parent
    if m and m:IsA(loadstring(base64decode("TW9kZWw="))()) then return m end
    return nil
end

local function IsNpc(m)
    if Players:GetPlayerFromCharacter(m) then return false end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and (m == p.Character or m:IsDescendantOf(p.Character)) then return false end
    end
    return true
end

local function AddNpc(model)
    if Npcs[model] or not IsNpc(model) then return end
    NpcSerial += 1
    local src = {
        Key = model, Name = model.Name, Id = loadstring(base64decode("bnBj"))() .. NpcSerial, IsPlayer = false, Friend = false,
        GetChar = function() return model end,
    }
    Npcs[model] = src
    if Config.IncludeNpcs then HookSource(ParryStore, src, ParryHandlers, false, PARRY_POLL_RANGE) end
    if Monitor.Target == loadstring(base64decode("Kg=="))() or Monitor.Target == loadstring(base64decode("bnBj"))() then
        HookSource(MonitorStore, src, MonitorHandlers, true)
    end
end

local function RemoveNpc(model)
    if not Npcs[model] then return end
    UnhookSource(ParryStore, model)
    UnhookSource(MonitorStore, model)
    Npcs[model] = nil
end

SetNpcs = function(on)
    NpcScanOn = on
    for m in pairs(Npcs) do RemoveNpc(m) end
    for _, c in ipairs(NpcConns) do c:Disconnect() end
    NpcConns = {}
    if not on then UpdateEngineStatus() return end

    local function consider(d)
        if d:IsA(loadstring(base64decode("QW5pbWF0b3I="))()) then
            local m = NpcModelOf(d)
            if m then AddNpc(m) end
        end
    end
    task.spawn(function()
        local n = 0
        for _, d in ipairs(workspace:GetDescendants()) do
            if not NpcScanOn then return end
            consider(d)
            n += 1
            if n % 400 == 0 then task.wait() end   -- bü7GzvlMabüGgfRx2bY haritalarda donmayı önler
        end
    end)
    NpcConns[1] = workspace.DescendantAdded:Connect(function(d)
        if d:IsA(loadstring(base64decode("QW5pbWF0b3I="))()) then task.defer(consider, d) end
    end)
    NpcConns[2] = workspace.DescendantRemoving:Connect(function(d)
        if Npcs[d] then RemoveNpc(d) end
    end)
    UpdateEngineStatus()
end

-- NPC taraması: Include NPCs açıkken ya da Monitor loadstring(base64decode("RXZlcnlvbmU="))()/loadstring(base64decode("TlBDcw=="))() izlerken çalışır
SyncNpcs = function()
    local want = Config.IncludeNpcs or Monitor.Target == loadstring(base64decode("Kg=="))() or Monitor.Target == loadstring(base64decode("bnBj"))()
    if want and not NpcScanOn then
        SetNpcs(true)
    elseif not want and NpcScanOn then
        SetNpcs(false)
    elseif want then
        for model, src in pairs(Npcs) do
            if Config.IncludeNpcs then HookSource(ParryStore, src, ParryHandlers, false, PARRY_POLL_RANGE)
            else UnhookSource(ParryStore, model) end
        end
        UpdateEngineStatus()
    end
end


-- DISCOVERY MANAGER (Anim / Skill / Object)

local function EntryVisible(entry)
    if TypeFilter ~= loadstring(base64decode("QWxs"))() and entry.Kind ~= TypeFilter then return false end
    if DiscoverySearch ~= loadstring(base64decode(""))() then
        if not (entry.NameLower:find(DiscoverySearch, 1, true) or entry.Id:lower():find(DiscoverySearch, 1, true)) then
            return false
        end
    end
    local target = Monitor.Target
    if entry.Kind ~= loadstring(base64decode("T2JqZWN0"))() and target and target ~= loadstring(base64decode("Kg=="))() then
        if target == loadstring(base64decode("bnBj"))() then return entry.HasNpc == true end
        return entry.Players[target] == true
    end
    return true
end

local function SortCmp(a, b)
    if DiscoverySort == loadstring(base64decode("T2xkZXN0"))() then return a.Seq < b.Seq end
    if DiscoverySort == loadstring(base64decode("TmFtZQ=="))() and a.NameLower ~= b.NameLower then return a.NameLower < b.NameLower end
    if DiscoverySort == loadstring(base64decode("UGxheSBDb3VudA=="))() and a.PlayCount ~= b.PlayCount then return a.PlayCount > b.PlayCount end
    return a.Seq > b.Seq
end

UpdateMonitorHeader = function()
    if not UI.MonitorHeader then return end
    local text, color
    if not Monitor.Target then
        text, color = L.T(loadstring(base64decode("Tm90IHdhdGNoaW5n"))()), Theme.SubText
    else
        local who = (Monitor.Target == loadstring(base64decode("Kg=="))()) and L.T(loadstring(base64decode("ZXZlcnlvbmU="))()) or (Monitor.Target == loadstring(base64decode("bnBj"))() and loadstring(base64decode("TlBDcw=="))() or Monitor.Target)
        if Monitor.Paused then text, color = L.T(loadstring(base64decode("UGF1c2VkIC0g"))()) .. who, Theme.Warn
        else text, color = L.T(loadstring(base64decode("V2F0Y2hpbmcg"))()) .. who, Theme.Good end
    end
    UI.MonitorHeader.Text = string.format(loadstring(base64decode("JXMgICB8ICAgJWQgJXM="))(), text, DiscoveredCount, L.T(DiscoveredCount == 1 and loadstring(base64decode("ZW50cnk="))() or loadstring(base64decode("ZW50cmllcw=="))()))
    UI.MonitorHeader.TextColor3 = color
end

ResortDiscoveredList = function()
    local list = {}
    for _, e in pairs(Discovered) do table.insert(list, e) end
    table.sort(list, SortCmp)
    local visible = 0
    for i, entry in ipairs(list) do
        local row = DiscoveredRows[entry.Id]
        if row then
            row.Frame.LayoutOrder = i
            local show = EntryVisible(entry)
            row.Frame.Visible = show
            if show then visible += 1 end
        end
    end
    if UI.ListHint then
        UI.ListHint.Visible = (visible == 0)
        if not Monitor.Target then
            UI.ListHint.Text = L.T(loadstring(base64decode("U2V0IFdBVENIIHRvIGEgcGxheWVyLCBOUENzIG9yIEV2ZXJ5b25lIChhbmltYXRpb25zICsgc2tpbGxzKS5cbk9iamVjdHMgc3Bhd25pbmcgaW4gdGhlIHdvcmtzcGFjZSBhcmUgcmVjb3JkZWQgd2hpbGUgV0FUQ0ggaXMgb24u"))())
        elseif DiscoveredCount == 0 then
            UI.ListHint.Text = L.T(loadstring(base64decode("V2FpdGluZyBmb3IgYWN0aXZpdHkuLi5cbk1ha2UgdGhlIHBsYXllciAvIE5QQyB1c2UgYSBza2lsbC4="))())
        else
            UI.ListHint.Text = L.T(loadstring(base64decode("Tm8gZW50cmllcyBtYXRjaCB0aGUgY3VycmVudCBmaWx0ZXIu"))())
        end
    end
    UpdateMonitorHeader()
end

local function ScheduleResort()
    if ResortScheduled then return end
    ResortScheduled = true
    task.defer(function()
        ResortScheduled = false
        ResortDiscoveredList()
    end)
end

local function EntryInfo(entry)
    if entry.Kind == loadstring(base64decode("QW5pbQ=="))() then
        local sk = SkillForEntry(entry)
        local hit = LearnedAvg(sk and SkillIdent(sk) or entry.Id)
        return string.format(loadstring(base64decode("SUQgJXMgICB8ICAg"))() .. L.T(loadstring(base64decode("cGxheWVk"))()) .. loadstring(base64decode("ICVkICAgfCAgICVzJXM="))(),
            entry.AnimId:match(loadstring(base64decode("JWQr"))()) or entry.AnimId, entry.PlayCount, entry.LastPlayer,
            hit and string.format(loadstring(base64decode("ICAgfCAgIA=="))() .. L.T(loadstring(base64decode("aGl0"))()) .. loadstring(base64decode("ICUuMmZz"))(), hit) or loadstring(base64decode(""))())
    elseif entry.Kind == loadstring(base64decode("U2tpbGw="))() then
        local sk = SkillForEntry(entry)
        local hit = LearnedAvg(sk and SkillIdent(sk) or entry.Id)
        return string.format(L.T(loadstring(base64decode("dXNlZA=="))()) .. loadstring(base64decode("ICVkICAgfCAgICVzJXM="))(), entry.PlayCount, entry.LastPlayer,
            hit and string.format(loadstring(base64decode("ICAgfCAgIA=="))() .. L.T(loadstring(base64decode("aGl0"))()) .. loadstring(base64decode("ICUuMmZz"))(), hit) or loadstring(base64decode(""))())
    end
    local sk = SkillForEntry(entry)
    local hit = LearnedAvg(sk and SkillIdent(sk) or entry.Id)
    return string.format(L.T(loadstring(base64decode("c3Bhd25lZA=="))()) .. loadstring(base64decode("ICVkJXM="))(), entry.PlayCount, hit and string.format(loadstring(base64decode("ICAgfCAgIA=="))() .. L.T(loadstring(base64decode("aGl0"))()) .. loadstring(base64decode("ICUuMmZz"))(), hit) or loadstring(base64decode(""))())
end

RefreshDiscoveredRow = function(entry)
    local row = DiscoveredRows[entry.Id]
    if not row then return end
    row.Name.Text = entry.Name
    row.Info.Text = EntryInfo(entry)
    row.Dot.BackgroundColor3 = (entry.Playing > 0) and Theme.Good or Theme.Muted
end

RefreshDiscoveredLinks = function()
    for _, row in pairs(DiscoveredRows) do
        local exists = SkillForEntry(row.Entry) ~= nil
        L.Set(row.AddBtn, exists and loadstring(base64decode("RWRpdCBTa2lsbA=="))() or loadstring(base64decode("QWRkIFNraWxs"))())
        SetBase(row.AddBtn, exists and Theme.Raised or Theme.Accent)
    end
end

BuildDiscoveredRow = function(entry)
    local frame = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = Theme.Card, BorderSizePixel = 0, Parent = UI.DiscoveredContainer,
    })
    Corner(frame, 8)
    Stroke(frame)

    local dot = Create(loadstring(base64decode("RnJhbWU="))(), {
        Size = UDim2.new(0, 8, 0, 8), Position = UDim2.new(0, 12, 0.5, -4), BackgroundColor3 = Theme.Muted,
        BorderSizePixel = 0, Parent = frame,
    })
    Corner(dot, 4)

    local nameLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -200, 0, 20), Position = UDim2.new(0, 30, 0, 8), BackgroundTransparency = 1,
        Text = entry.Name, TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = frame,
    })
    MakeBadge(frame, entry.Kind, UDim2.new(0, 30, 0, 30))
    local infoLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
        Size = UDim2.new(1, -250, 0, 14), Position = UDim2.new(0, 90, 0, 31), BackgroundTransparency = 1,
        Text = loadstring(base64decode(""))(), TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = frame,
    })

    if entry.Kind == loadstring(base64decode("QW5pbQ=="))() then
        local previewBtn = MakeButton(frame, loadstring(base64decode("UHJldmlldw=="))(), Theme.Raised, UDim2.new(0, 62, 0, 28), UDim2.new(1, -158, 0.5, -14))
        previewBtn.MouseButton1Click:Connect(function()
            OpenPreviewFor(entry.AnimId, entry.Name, entry.LastSrc)
        end)
    end

    local addBtn = MakeButton(frame, loadstring(base64decode("QWRkIFNraWxs"))(), Theme.Accent, UDim2.new(0, 80, 0, 28), UDim2.new(1, -90, 0.5, -14))
    addBtn.MouseButton1Click:Connect(function()
        local existing = SkillForEntry(entry)
        if existing then
            Window.SelectTab(loadstring(base64decode("U2tpbGxz"))())
            SelectSkill(existing.Id)
            return
        end
        local shortName = entry.Kind == loadstring(base64decode("T2JqZWN0"))() and entry.ObjName or entry.Name
        local skill = AddSkill(shortName, {
            Type = entry.Kind, AnimId = entry.AnimId, Key = entry.Key,
            ObjName = entry.ObjName, ObjParent = entry.ObjParent,
        })
        Window.SelectTab(loadstring(base64decode("U2tpbGxz"))())
        SelectSkill(skill.Id)
    end)

    DiscoveredRows[entry.Id] = { Frame = frame, Dot = dot, Name = nameLabel, Info = infoLabel, AddBtn = addBtn, Entry = entry }
    RefreshDiscoveredRow(entry)
    local exists = SkillForEntry(entry) ~= nil      -- sadece bu satır (tüm liste taranmaz)
    L.Set(addBtn, exists and loadstring(base64decode("RWRpdCBTa2lsbA=="))() or loadstring(base64decode("QWRkIFNraWxs"))())
    SetBase(addBtn, exists and Theme.Raised or Theme.Accent)
end

-- kind: loadstring(base64decode("QW5pbQ=="))() | loadstring(base64decode("U2tpbGw="))() | loadstring(base64decode("T2JqZWN0"))(); meta = { AnimId, Key, ObjName, ObjParent }
RecordDiscovered = function(kind, ident, name, meta, srcName, isNpc, src)
    local entry = Discovered[ident]
    local isNew = false
    if not entry then
        if kind == loadstring(base64decode("T2JqZWN0"))() and DiscoveredCount >= MAX_OBJECT_ENTRIES then return nil end
        isNew = true
        DiscoverySeq += 1
        DiscoveredCount += 1
        entry = {
            Id = ident, Kind = kind, Name = name, NameLower = name:lower(), Seq = DiscoverySeq,
            PlayCount = 0, Playing = 0, LastPlayer = srcName or loadstring(base64decode(""))(), Players = {}, HasNpc = false,
            AnimId = meta.AnimId or loadstring(base64decode(""))(), Key = meta.Key or loadstring(base64decode(""))(), ObjName = meta.ObjName or loadstring(base64decode(""))(), ObjParent = meta.ObjParent or loadstring(base64decode(""))(),
        }
        Discovered[ident] = entry
    end
    local firstForSource = srcName ~= nil and not entry.Players[srcName]
    if isNpc and not entry.HasNpc then entry.HasNpc = true; firstForSource = true end
    entry.PlayCount += 1
    if src then entry.LastSrc = src end
    if srcName then
        entry.LastPlayer = srcName
        entry.Players[srcName] = true
    end

    if isNew then
        pcall(BuildDiscoveredRow, entry)
        ScheduleResort()     -- sadece YENİ girişte sıralanır; tekrar edenler yerinde kalır
    else
        Dirty[ident] = true
        if firstForSource then ScheduleResort() end
    end
    return entry
end

ClearDiscoveredHistory = function()
    DestroySnaps()
    for _, row in pairs(DiscoveredRows) do row.Frame:Destroy() end
    DiscoveredRows = {}
    Discovered = {}
    DiscoveredCount = 0
    Dirty = {}
    ResortDiscoveredList()
    SetStatus(loadstring(base64decode("TGlzdCBjbGVhcmVkLg=="))())
end

OnMonitorAnimation = function(src, track)
    if Monitor.Paused or not Monitor.Target then return end
    local animId = TrackAnimId(track)
    if not animId then return end
    local entry = RecordDiscovered(loadstring(base64decode("QW5pbQ=="))(), loadstring(base64decode("YW5pbTo="))() .. animId, TrackAnimName(track), { AnimId = animId }, src.Name, not src.IsPlayer, src)
    if not entry then return end
if not src.Snap and (UI.SnapCount or 0) < 80 then
    local ch = src.GetChar()
    if ch and ch:IsA(loadstring(base64decode("TW9kZWw="))()) and ch:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))(), true) then
        local was = ch.Archivable
        pcall(function() ch.Archivable = true end)
        local okc, cl = pcall(function() return ch:Clone() end)
        pcall(function() ch.Archivable = was end)
        if okc and cl then
            src.Snap = cl
            UI.SnapCount = (UI.SnapCount or 0) + 1
        end
    end
end
    entry.Playing += 1
    local conn
    conn = track.Stopped:Connect(function()
        if conn then conn:Disconnect() end
        entry.Playing = math.max(0, entry.Playing - 1)
        Dirty[entry.Id] = true
    end)
end

OnMonitorSkill = function(src, value)
    local key = ValueToKey(value)
    local prev = src.MonSkill
    if prev and prev ~= key then
        local pe = Discovered[loadstring(base64decode("c2tpbGw6"))() .. prev:lower()]
        if pe then pe.Playing = math.max(0, pe.Playing - 1); Dirty[pe.Id] = true end
    end
    src.MonSkill = (key ~= loadstring(base64decode(""))()) and key or nil
    if key == loadstring(base64decode(""))() or prev == key then return end
    if Monitor.Paused or not Monitor.Target then return end
    local entry = RecordDiscovered(loadstring(base64decode("U2tpbGw="))(), loadstring(base64decode("c2tpbGw6"))() .. key:lower(), key, { Key = key }, src.Name, not src.IsPlayer)
    if entry then entry.Playing += 1 end
end

-- Hedef: nil = kapalı, loadstring(base64decode("Kg=="))() = herkes, loadstring(base64decode("bnBj"))() = NPC'ler, loadstring(base64decode("aXNpbQ=="))() = tek oyuncu
SetWatchTarget = function(target)
    for key in pairs(MonitorStore) do UnhookSource(MonitorStore, key) end
    Monitor.Target = target

    if target == loadstring(base64decode("Kg=="))() then
        for _, p in ipairs(Players:GetPlayers()) do
            HookSource(MonitorStore, GetSource(p), MonitorHandlers, true)
        end
        for _, src in pairs(Npcs) do HookSource(MonitorStore, src, MonitorHandlers, true) end
    elseif target == loadstring(base64decode("bnBj"))() then
        for _, src in pairs(Npcs) do HookSource(MonitorStore, src, MonitorHandlers, true) end
    elseif target then
        local p = Players:FindFirstChild(target)
        if p and p:IsA(loadstring(base64decode("UGxheWVy"))()) then
            HookSource(MonitorStore, GetSource(p), MonitorHandlers, true)
        else
            SetStatus(loadstring(base64decode("UGxheWVyIG5vdCBmb3VuZDog"))() .. tostring(target), true)
            Monitor.Target = nil
            target = nil
        end
    end

    local label = loadstring(base64decode("T2Zm"))()
    if target == loadstring(base64decode("Kg=="))() then label = loadstring(base64decode("RXZlcnlvbmU="))() elseif target == loadstring(base64decode("bnBj"))() then label = loadstring(base64decode("TlBDcw=="))() elseif target then label = target end
    if UI.WatchDropdown then UI.WatchDropdown.Set(label) end
    SyncNpcs()
    ResortDiscoveredList()
    UpdateEngineStatus()
end

-- loadstring(base64decode("Q3VycmVudFNraWxs"))() adı değişince tüm hook'ları yeniden kurar
RebuildHooks = function()
    for key in pairs(ParryStore) do UnhookSource(ParryStore, key) end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then HookSource(ParryStore, GetSource(p), ParryHandlers, false) end
    end
    if Config.IncludeNpcs then
        for _, src in pairs(Npcs) do HookSource(ParryStore, src, ParryHandlers, false, PARRY_POLL_RANGE) end
    end
    SetWatchTarget(Monitor.Target)
end


-- SKILL MANAGER

local function SkillFromData(s, newId)
    -- Eski sürümlerdeki StartupOffset, Delay'e eklenir; HoldTime artıGgfRx2bY Dur
    local delay = (tonumber(s.Delay) or Defaults.Delay) + (tonumber(s.StartupOffset) or 0)
    local t = s.Type
    if t ~= loadstring(base64decode("U2tpbGw="))() and t ~= loadstring(base64decode("T2JqZWN0"))() then t = loadstring(base64decode("QW5pbQ=="))() end   -- tür yazmayan eski kayıtlar Anim'dir
    -- Türe ait olmayan alanlar temizlenir (Skill/Object kayıtlarında AnimId kalıntısı kalmaz)
    local isAnim, isSkill, isObj = (t == loadstring(base64decode("QW5pbQ=="))()), (t == loadstring(base64decode("U2tpbGw="))()), (t == loadstring(base64decode("T2JqZWN0"))())
    local dist = math.clamp(tonumber(s.Dist) or Defaults.Dist, 5, 150)
    return {
        Id = newId and GenerateId() or (s.Id or GenerateId()),
        Name = (type(s.Name) == loadstring(base64decode("c3RyaW5n"))() and s.Name ~= loadstring(base64decode(""))()) and s.Name or loadstring(base64decode("VW5uYW1lZA=="))(),
        Type = t,
        AnimId = isAnim and NormalizeAnimId(s.AnimId or loadstring(base64decode(""))()) or loadstring(base64decode(""))(),
        Key = (isSkill and type(s.Key) == loadstring(base64decode("c3RyaW5n"))()) and s.Key or loadstring(base64decode(""))(),
        ObjName = (isObj and type(s.ObjName) == loadstring(base64decode("c3RyaW5n"))()) and s.ObjName or loadstring(base64decode(""))(),
        ObjParent = (isObj and type(s.ObjParent) == loadstring(base64decode("c3RyaW5n"))()) and s.ObjParent or loadstring(base64decode(""))(),
        Enabled = (s.Enabled ~= false),
        Dist = dist,
        Delay = math.clamp(delay, 0, 2),
        Hold = (s.Hold == true),
        Dur = math.clamp(tonumber(s.Dur) or tonumber(s.HoldTime) or Defaults.Dur, 0.05, 5),
    }
end

SaveData = function()
    if not CanSaveFiles then return false end
    local ok, encoded = pcall(function()
        return HttpService:JSONEncode({
            Version = 7,
            ActiveProfile = ActiveProfile,
            Profiles = Profiles,
            Settings = {
                PingComp = Config.PingComp, IgnoreFriends = Config.IgnoreFriends, IncludeNpcs = Config.IncludeNpcs,
                Ignored = Config.Ignored, SkillValueName = Config.SkillValueName,
                UIKeybind = Config.UIKeybind.Name, ParryKey = Config.ParryKey.Name, ToggleKey = Config.ToggleKey.Name,
                Outfit = Config.Outfit, OutfitBroken = Config.OutfitBroken,
                OutfitReapply = Config.OutfitReapply, OutfitActive = Config.OutfitActive,
                HideArmor = Config.HideArmor,
                DebugVis = Config.DebugVis,
                Language = Config.Language, UIScale = Config.UIScale, Snow = Config.Snow,AutoExecute = Config.AutoExecute,
                DeclinedDefault = Config.DeclinedDefault,
                ClothingUI = Config.ClothingUI,
                OutfitX = Config.OutfitX, OutfitY = Config.OutfitY, OutfitZ = Config.OutfitZ,
                OutfitOffsets = Config.OutfitOffsets,
            },
        })
    end)
    if not ok then return false end
    return (pcall(function() writefile(SaveFileName, encoded) end))
end

local SaveQueued = false
QueueSave = function()
    if not CanSaveFiles or SaveQueued then return end
    SaveQueued = true
    task.delay(0.6, function()
        SaveQueued = false
        SaveData()
    end)
end

ShowEmptyEditPanel = function()
    ClearChildren(UI.SkillEditContainer)
    UI.SkillEditContainer:SetAttribute(loadstring(base64decode("X24="))(), 0)
    CreateNote(UI.SkillEditContainer, loadstring(base64decode("U2VsZWN0IGEgc2tpbGwgZnJvbSB0aGUgbGlzdCB0byBlZGl0IGl0Lg=="))(), 24, Theme.Muted)
end

local function UpdateSkillHint()
    if UI.SkillHint then UI.SkillHint.Visible = (#Skills == 0) end
end

-- data: { Type, AnimId, Key, ObjName, ObjParent } (Type yoksa loadstring(base64decode("U2tpbGw="))())
AddSkill = function(name, data)
    data = data or {}
    local skill = SkillFromData({
        Name = (name ~= loadstring(base64decode(""))() and name) or loadstring(base64decode("VW5uYW1lZCBTa2lsbA=="))(), Type = data.Type or loadstring(base64decode("U2tpbGw="))(),
        AnimId = data.AnimId, Key = data.Key, ObjName = data.ObjName, ObjParent = data.ObjParent,
        Dist = Defaults.Dist, Delay = Defaults.Delay, Dur = Defaults.Dur,
    }, true)
    table.insert(Skills, skill)
    RenderSkillRow(skill)
    ResortSkillList()
    UpdateSkillHint()
    RefreshDiscoveredLinks()
    UpdateEngineStatus()
    QueueSave()
    return skill
end

DuplicateSkill = function(skillId)
    for _, s in ipairs(Skills) do
        if s.Id == skillId then
            local copy = SkillFromData(s, true)
            copy.Name = s.Name .. loadstring(base64decode("IChDb3B5KQ=="))()
            table.insert(Skills, copy)
            RenderSkillRow(copy)
            ResortSkillList()
            UpdateEngineStatus()
            QueueSave()
            return copy
        end
    end
end

DeleteSkill = function(skillId)
    for i, s in ipairs(Skills) do
        if s.Id == skillId then table.remove(Skills, i) break end
    end
    if SkillRows[skillId] then
        SkillRows[skillId].Frame:Destroy()
        SkillRows[skillId] = nil
    end
    if SelectedSkillId == skillId then
        SelectedSkillId = nil
        ShowEmptyEditPanel()
    end
    UpdateSkillHint()
    RefreshDiscoveredLinks()
    UpdateEngineStatus()
    QueueSave()
end

SetAllEnabled = function(v)
    for _, s in ipairs(Skills) do
        s.Enabled = v
        RenderSkillRow(s)
    end
    for _, s in ipairs(Skills) do
        if s.Id == SelectedSkillId then RenderSkillEditPanel(s) end
    end
    UpdateEngineStatus()
    QueueSave()
end

local function SkillDetail(skill)
    if skill.Type == loadstring(base64decode("U2tpbGw="))() then return EffectiveKey(skill) end
    if skill.Type == loadstring(base64decode("T2JqZWN0"))() then
        return skill.ObjName .. (skill.ObjParent ~= loadstring(base64decode(""))() and (loadstring(base64decode("IEAg"))() .. skill.ObjParent) or loadstring(base64decode(""))())
    end
    return skill.AnimId:match(loadstring(base64decode("JWQr"))()) or skill.AnimId
end

RenderSkillRow = function(skill)
    local row = SkillRows[skill.Id]
    if not row then
        local frame = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
            Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = Theme.Card, BorderSizePixel = 0,
            AutoButtonColor = false, Text = loadstring(base64decode(""))(), Parent = UI.SkillListContainer,
        })
        Corner(frame, 8)
        local stroke = Stroke(frame)

        local dot = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.new(0, 8, 0, 8), Position = UDim2.new(0, 12, 0.5, -4), BackgroundColor3 = Theme.Muted,
            BorderSizePixel = 0, Parent = frame,
        })
        Corner(dot, 4)
        local nameLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -44, 0, 20), Position = UDim2.new(0, 30, 0, 8), BackgroundTransparency = 1,
            Text = loadstring(base64decode(""))(), TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = frame,
        })
        local _, setBadge = MakeBadge(frame, skill.Type, UDim2.new(0, 30, 0, 30))
        local infoLabel = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -104, 0, 14), Position = UDim2.new(0, 90, 0, 31), BackgroundTransparency = 1,
            Text = loadstring(base64decode(""))(), TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = frame,
        })
        frame.MouseButton1Click:Connect(function() SelectSkill(skill.Id) end)

        row = { Frame = frame, Dot = dot, Name = nameLabel, Info = infoLabel, Stroke = stroke, SetBadge = setBadge }
        SkillRows[skill.Id] = row
    end
    row.Name.Text = skill.Name
    row.SetBadge(skill.Type)
    row.Dot.BackgroundColor3 = skill.Enabled and Theme.Good or Theme.Muted
    row.Info.Text = string.format(loadstring(base64decode("JXMgICB8ICAgJWQgJXMgICB8ICAgJXMgJS4yZnMlcw=="))(),
        SkillDetail(skill), skill.Dist, L.T(loadstring(base64decode("c3R1ZHM="))()), L.T(loadstring(base64decode("ZGVsYXk="))()), skill.Delay,
        skill.Hold and string.format(loadstring(base64decode("ICAgfCAgICVzICUuMmZz"))(), L.T(loadstring(base64decode("aG9sZA=="))()), skill.Dur) or loadstring(base64decode(""))())
    row.Name.TextColor3 = skill.Enabled and Theme.Text or Theme.Muted
    row.Stroke.Color = (SelectedSkillId == skill.Id) and Theme.Accent or Theme.Stroke
end

ResortSkillList = function()
    local sorted = {}
    for _, s in ipairs(Skills) do
        RenderSkillRow(s)
        table.insert(sorted, s)
    end
    table.sort(sorted, function(a, b) return a.Name:lower() < b.Name:lower() end)
    for i, s in ipairs(sorted) do
        local row = SkillRows[s.Id]
        if row then
            row.Frame.LayoutOrder = i
            local hay = (s.Name .. loadstring(base64decode("IA=="))() .. SkillDetail(s) .. loadstring(base64decode("IA=="))() .. s.Type):lower()
            row.Frame.Visible = (SkillSearch == loadstring(base64decode(""))() or hay:find(SkillSearch, 1, true) ~= nil)
        end
    end
end

SelectSkill = function(skillId)
    SelectedSkillId = skillId
    local skill
    for _, s in ipairs(Skills) do
        RenderSkillRow(s)
        if s.Id == skillId then skill = s end
    end
    if skill then RenderSkillEditPanel(skill) end
end

RenderSkillEditPanel = function(skill)
    local C = UI.SkillEditContainer
    ClearChildren(C)
    C:SetAttribute(loadstring(base64decode("X24="))(), 0)

    local function changed()
        RenderSkillRow(skill)
        ResortSkillList()
        RefreshDiscoveredLinks()
        QueueSave()
    end

    CreateTextField(C, loadstring(base64decode("TkFNRQ=="))(), skill.Name, function(text)
        text = Trim(text)
        if text ~= loadstring(base64decode(""))() then skill.Name = text end
        changed()
    end)

    CreateSegmented(C, loadstring(base64decode("REVURUNUSU9OIFRZUEU="))(), { loadstring(base64decode("U2tpbGw="))(), loadstring(base64decode("QW5pbQ=="))(), loadstring(base64decode("T2JqZWN0"))() }, skill.Type, function(t)
        skill.Type = t
        changed()
        RenderSkillEditPanel(skill)
    end)

    if skill.Type == loadstring(base64decode("U2tpbGw="))() then
        CreateTextField(C, loadstring(base64decode("U0tJTEwgS0VZIChleGFjdCA="))() .. Config.SkillValueName .. loadstring(base64decode("IHZhbHVlIC0gYmxhbmsgPSBzYW1lIGFzIG5hbWUp"))(), skill.Key, function(text)
            skill.Key = Trim(text)
            changed()
        end, false, loadstring(base64decode("ZS5nLiBTbW9sZGVyaW5nIEVhcnRoICAgKGJsYW5rID0gc2FtZSBhcyBuYW1lKQ=="))())
    elseif skill.Type == loadstring(base64decode("QW5pbQ=="))() then
        CreateTextField(C, loadstring(base64decode("QU5JTUFUSU9OIElE"))(), skill.AnimId, function(text)
            skill.AnimId = (Trim(text) ~= loadstring(base64decode(""))()) and NormalizeAnimId(Trim(text)) or loadstring(base64decode(""))()
            changed()
        end, false, loadstring(base64decode("ZS5nLiAxMjM0NTY3ODkw"))())
    else
        CreateTextField(C, loadstring(base64decode("T0JKRUNUIE5BTUUgKGV4YWN0LCBhcyBzaG93biBpbiBFeHBsb3Jlcik="))(), skill.ObjName, function(text)
            skill.ObjName = Trim(text)
            changed()
        end, false, loadstring(base64decode("ZS5nLiBXYXRlckRyYWdvbkhlYWQ="))())
        CreateTextField(C, loadstring(base64decode("UEFSRU5UIE5BTUUgKGJsYW5rID0gYW55IHBhcmVudCk="))(), skill.ObjParent, function(text)
            skill.ObjParent = Trim(text)
            changed()
        end, false, loadstring(base64decode("ZS5nLiBEZWJyaXM="))())
    end

    CreateToggle(C, loadstring(base64decode("RW5hYmxlZA=="))(), skill.Enabled, function(v)
        skill.Enabled = v
        RenderSkillRow(skill)
        UpdateEngineStatus()
        QueueSave()
    end)

    CreateSlider(C, loadstring(base64decode("RGlzdGFuY2U="))(), 5, 150, skill.Dist, 0, function(v) skill.Dist = v; RenderSkillRow(skill); QueueSave() end, loadstring(base64decode("IHN0dWRz"))())
    CreateSlider(C, loadstring(base64decode("RGVsYXk="))(), 0, 2, skill.Delay, 2, function(v) skill.Delay = v; RenderSkillRow(skill); QueueSave() end, loadstring(base64decode("IHM="))())

    local durSlider
    CreateToggle(C, loadstring(base64decode("SG9sZA=="))(), skill.Hold, function(v)
        skill.Hold = v
        durSlider.Frame.Visible = v
        RenderSkillRow(skill)
        QueueSave()
    end, loadstring(base64decode("SG9sZHMgdGhlIHBhcnJ5IGtleSBpbnN0ZWFkIG9mIHRhcHBpbmcgaXQu"))())
    durSlider = CreateSlider(C, loadstring(base64decode("RHVyYXRpb24="))(), 0.05, 5, skill.Dur, 2, function(v)
        skill.Dur = v
        RenderSkillRow(skill)
        QueueSave()
    end, loadstring(base64decode("IHM="))())
    durSlider.Frame.Visible = skill.Hold

    local avg = LearnedAvg(SkillIdent(skill))
    if avg then
        CreateButton(C, string.format(loadstring(base64decode("VXNlIGxlYXJuZWQgdGltaW5nICAoaGl0IGF0ICUuMmYgcyk="))(), avg), function()
            skill.Delay = math.clamp(avg - LEARN_LEAD, 0, 2)
            RenderSkillRow(skill)
            QueueSave()
            RenderSkillEditPanel(skill)
        end, Theme.Good)
    end

    local defs = {}
    if skill.Type == loadstring(base64decode("QW5pbQ=="))() then
        table.insert(defs, { loadstring(base64decode("UHJldmlldw=="))(), function()
            OpenPreviewFor(skill.AnimId, skill.Name, nil)
            Window.SelectTab(loadstring(base64decode("QW5pbWF0aW9uIE1vbml0b3I="))())
        end, Theme.Raised })
    end
    table.insert(defs, { loadstring(base64decode("RHVwbGljYXRl"))(), function()
        local copy = DuplicateSkill(skill.Id)
        if copy then SelectSkill(copy.Id) end
    end, Theme.Raised })
    CreateButtonRow(C, defs)
    CreateButton(C, loadstring(base64decode("RGVsZXRlIFNraWxs"))(), function() DeleteSkill(skill.Id) end, Theme.Bad)
end

ExportSkills = function()
    local ok, json = pcall(function() return HttpService:JSONEncode(Skills) end)
    if ok then return json end
    return nil
end

ImportSkills = function(jsonText)
    if not jsonText or jsonText == loadstring(base64decode(""))() then return nil, loadstring(base64decode("RW1wdHkgaW5wdXQ="))() end
    local ok, decoded = pcall(function() return HttpService:JSONDecode(jsonText) end)
    if not ok or type(decoded) ~= loadstring(base64decode("dGFibGU="))() then return nil, loadstring(base64decode("SW52YWxpZCBKU09O"))() end
    if type(decoded.Skills) == loadstring(base64decode("dGFibGU="))() then decoded = decoded.Skills end

    local have = {}
    for _, s in ipairs(Skills) do have[SkillIdent(s)] = true end

    local imported = 0
    for _, s in ipairs(decoded) do
        if type(s) == loadstring(base64decode("dGFibGU="))() then
            local skill = SkillFromData(s, true)
            local valid = (skill.Type == loadstring(base64decode("QW5pbQ=="))() and skill.AnimId ~= loadstring(base64decode(""))())
                or (skill.Type == loadstring(base64decode("U2tpbGw="))() and EffectiveKey(skill) ~= loadstring(base64decode(""))())
                or (skill.Type == loadstring(base64decode("T2JqZWN0"))() and skill.ObjName ~= loadstring(base64decode(""))())
            if valid and not have[SkillIdent(skill)] then
                have[SkillIdent(skill)] = true
                table.insert(Skills, skill)
                RenderSkillRow(skill)
                imported += 1
            end
        end
    end
    ResortSkillList()
    UpdateSkillHint()
    RefreshDiscoveredLinks()
    UpdateEngineStatus()
    QueueSave()
    return imported
end

--------------------------------------------------------
-- PROFILES
--------------------------------------------------------
ProfileNames = function()
    local names = {}
    for n in pairs(Profiles) do table.insert(names, n) end
    table.sort(names, function(a, b)
        if a == loadstring(base64decode("RGVmYXVsdA=="))() then return true end
        if b == loadstring(base64decode("RGVmYXVsdA=="))() then return false end
        return a:lower() < b:lower()
    end)
    return names
end

SwitchProfile = function(name)
    if not Profiles[name] then return end
    ActiveProfile = name
    Skills = Profiles[name]
    for _, row in pairs(SkillRows) do row.Frame:Destroy() end
    SkillRows = {}
    SelectedSkillId = nil
    for _, s in ipairs(Skills) do RenderSkillRow(s) end
    ShowEmptyEditPanel()
    ResortSkillList()
    UpdateSkillHint()
    RefreshDiscoveredLinks()
    UpdateEngineStatus()
    QueueSave()
    if UI.ProfileDropdown then UI.ProfileDropdown.Set(name) end
    SetStatus(loadstring(base64decode("UHJvZmlsZTog"))() .. name)
end

CreateProfile = function(name)
    name = Trim(name)
    if name == loadstring(base64decode(""))() then SetStatus(loadstring(base64decode("RW50ZXIgYSBwcm9maWxlIG5hbWUu"))(), true) return false end
    if Profiles[name] then SetStatus(loadstring(base64decode("UHJvZmlsZSBhbHJlYWR5IGV4aXN0cy4="))(), true) return false end
    Profiles[name] = {}
    SwitchProfile(name)
    return true
end

DeleteProfile = function()
    if ActiveProfile == loadstring(base64decode("RGVmYXVsdA=="))() then SetStatus(loadstring(base64decode("VGhlIERlZmF1bHQgcHJvZmlsZSBjYW4ndCBiZSBkZWxldGVkLg=="))(), true) return end
    Profiles[ActiveProfile] = nil
    SwitchProfile(loadstring(base64decode("RGVmYXVsdA=="))())
end


-- PREVIEW MANAGER (R6)

do
local function Part(name, size, color)
    local p = Instance.new(loadstring(base64decode("UGFydA=="))())
    p.Name = name
    p.Size = size
    p.Color = color
    p.Material = Enum.Material.SmoothPlastic
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    p.CanCollide = false
    p.CanTouch = false
    p.CanQuery = false
    return p
end

local function Motor(name, part0, part1, c0, c1)
    local m = Instance.new(loadstring(base64decode("TW90b3I2RA=="))())
    m.Name = name
    m.Part0, m.Part1 = part0, part1
    m.C0, m.C1 = c0, c1
    m.Parent = part0
    return m
end

-- Standart R6 rig (animasyonların beklediği Motor6D isimleriyle)
local function BuildR6Rig(sourceChar)
    local skin = Color3.fromRGB(245, 205, 48)
    local blue = Color3.fromRGB(13, 105, 172)
    local green = Color3.fromRGB(75, 151, 75)

    local model = Instance.new(loadstring(base64decode("TW9kZWw="))())
    model.Name = loadstring(base64decode("UGFycnlQcmV2aWV3RHVtbXk="))()

    local hrp = Part(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))(), Vector3.new(2, 2, 1), skin)
    hrp.Transparency = 1
    local torso = Part(loadstring(base64decode("VG9yc28="))(), Vector3.new(2, 2, 1), blue)
    local head = Part(loadstring(base64decode("SGVhZA=="))(), Vector3.new(2, 1, 1), skin)
    local rArm = Part(loadstring(base64decode("UmlnaHQgQXJt"))(), Vector3.new(1, 2, 1), skin)
    local lArm = Part(loadstring(base64decode("TGVmdCBBcm0="))(), Vector3.new(1, 2, 1), skin)
    local rLeg = Part(loadstring(base64decode("UmlnaHQgTGVn"))(), Vector3.new(1, 2, 1), green)
    local lLeg = Part(loadstring(base64decode("TGVmdCBMZWc="))(), Vector3.new(1, 2, 1), green)

    local mesh = Instance.new(loadstring(base64decode("U3BlY2lhbE1lc2g="))())
    mesh.MeshType = Enum.MeshType.Head
    mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
    mesh.Parent = head

    for _, p in ipairs({ hrp, torso, head, rArm, lArm, rLeg, lLeg }) do p.Parent = model end

    torso.CFrame = CFrame.new(0, 0, 0)
    hrp.CFrame = CFrame.new(0, 0, 0)
    head.CFrame = CFrame.new(0, 1.5, 0)
    rArm.CFrame = CFrame.new(1.5, 0, 0)
    lArm.CFrame = CFrame.new(-1.5, 0, 0)
    rLeg.CFrame = CFrame.new(0.5, -2, 0)
    lLeg.CFrame = CFrame.new(-0.5, -2, 0)

    Motor(loadstring(base64decode("Um9vdEpvaW50"))(), hrp, torso,
        CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
        CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0))
    Motor(loadstring(base64decode("TmVjaw=="))(), torso, head,
        CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0),
        CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0))
    Motor(loadstring(base64decode("UmlnaHQgU2hvdWxkZXI="))(), torso, rArm,
        CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
        CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0))
    Motor(loadstring(base64decode("TGVmdCBTaG91bGRlcg=="))(), torso, lArm,
        CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
    Motor(loadstring(base64decode("UmlnaHQgSGlw"))(), torso, rLeg,
        CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0),
        CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0))
    Motor(loadstring(base64decode("TGVmdCBIaXA="))(), torso, lLeg,
        CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))

    -- Kaynak oyuncunun görünümünü (renk / GgfRx2bYıyafet / 7GzvlMabühDmnWKlx) kopyalamayı dene
    if sourceChar then
        pcall(function()
            local bc = sourceChar:FindFirstChildOfClass(loadstring(base64decode("Qm9keUNvbG9ycw=="))())
            if bc then bc:Clone().Parent = model end
            local shirt = sourceChar:FindFirstChildOfClass(loadstring(base64decode("U2hpcnQ="))())
            if shirt then shirt:Clone().Parent = model end
            local pants = sourceChar:FindFirstChildOfClass(loadstring(base64decode("UGFudHM="))())
            if pants then pants:Clone().Parent = model end
            local srcHead = sourceChar:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
            local face = srcHead and srcHead:FindFirstChildOfClass(loadstring(base64decode("RGVjYWw="))())
            if face then face:Clone().Parent = head end
        end)
    end
    if not head:FindFirstChildOfClass(loadstring(base64decode("RGVjYWw="))()) then
        pcall(function()
            local face = Instance.new(loadstring(base64decode("RGVjYWw="))())
            face.Name = loadstring(base64decode("ZmFjZQ=="))()
            face.Texture = loadstring(base64decode("cmJ4YXNzZXQ6Ly90ZXh0dXJlcy9mYWNlLnBuZw=="))()
            face.Parent = head
        end)
    end

    local hum = Instance.new(loadstring(base64decode("SHVtYW5vaWQ="))())
    hum.RigType = Enum.HumanoidRigType.R6
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    hum.Parent = model
    pcall(function() hum.EvaluateStateMachine = false end)
    local animator = Instance.new(loadstring(base64decode("QW5pbWF0b3I="))())
    animator.Parent = hum

    model.PrimaryPart = hrp
    hrp.Anchored = true   -- sadece root sabit; uzuvlar animasyonla serbestçe hareket eder
    return model, animator
end

StopPreviewTrack = function()
    if PreviewState.Track then
        pcall(function() PreviewState.Track:Stop(0) end)
        pcall(function() PreviewState.Track:Destroy() end)
        PreviewState.Track = nil
    end
end

DestroyPreviewDummy = function()
    StopPreviewTrack()
    if PreviewState.Dummy then
        PreviewState.Dummy:Destroy()
        PreviewState.Dummy = nil
        PreviewState.Animator = nil
    end
end

UpdatePreviewCamera = function()
    local dummy = PreviewState.Dummy
    if not dummy or not PreviewState.Camera then return end
    local root = dummy.PrimaryPart
    if not root then return end
    local focus = root.Position + (PreviewState.FocusOffset or Vector3.new(0, 0.5, 0))
    local yaw, pitch = math.rad(PreviewState.CamYaw), math.rad(PreviewState.CamPitch)
    local offset = Vector3.new(math.cos(pitch) * math.sin(yaw), math.sin(pitch), math.cos(pitch) * math.cos(yaw)) * PreviewState.CamDistance
    PreviewState.Camera.CFrame = CFrame.lookAt(focus + offset, focus)
end

-- source: oyuncu (Player), kaynak kaydı ({GetChar=...}), Model veya nil
local function ResolveSourceChar(source)
    if not source then return nil end
    if typeof(source) == loadstring(base64decode("SW5zdGFuY2U="))() then
        if source:IsA(loadstring(base64decode("UGxheWVy"))()) then return source.Character end
        if source:IsA(loadstring(base64decode("TW9kZWw="))()) then return source end
        return nil
    end
    if type(source) == loadstring(base64decode("dGFibGU="))() and source.GetChar then
        local ok, c = pcall(source.GetChar)
        if ok and c and c.Parent and c:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))(), true) then return c end
        if source.Snap then return source.Snap end
        if ok then return c end
    end
    return nil
end

local EffectClasses = { loadstring(base64decode("THVhU291cmNlQ29udGFpbmVy"))(), loadstring(base64decode("UGFydGljbGVFbWl0dGVy"))(), loadstring(base64decode("VHJhaWw="))(), loadstring(base64decode("QmVhbQ=="))(), loadstring(base64decode("UG9pbnRMaWdodA=="))(), loadstring(base64decode("U3BvdExpZ2h0"))(), loadstring(base64decode("U3VyZmFjZUxpZ2h0"))(), loadstring(base64decode("RmlyZQ=="))(), loadstring(base64decode("U21va2U="))(), loadstring(base64decode("U3BhcmtsZXM="))(), loadstring(base64decode("SGlnaGxpZ2h0"))(), loadstring(base64decode("U291bmQ="))(), loadstring(base64decode("QmlsbGJvYXJkR3Vp"))(), loadstring(base64decode("U3VyZmFjZUd1aQ=="))(), loadstring(base64decode("Rm9yY2VGaWVsZA=="))() }
local BodyNamesKeep = {
    [loadstring(base64decode("SGVhZA=="))()] = true, [loadstring(base64decode("VG9yc28="))()] = true, [loadstring(base64decode("TGVmdCBBcm0="))()] = true, [loadstring(base64decode("UmlnaHQgQXJt"))()] = true, [loadstring(base64decode("TGVmdCBMZWc="))()] = true, [loadstring(base64decode("UmlnaHQgTGVn"))()] = true,
    [loadstring(base64decode("VXBwZXJUb3Jzbw=="))()] = true, [loadstring(base64decode("TG93ZXJUb3Jzbw=="))()] = true, [loadstring(base64decode("TGVmdFVwcGVyQXJt"))()] = true, [loadstring(base64decode("TGVmdExvd2VyQXJt"))()] = true, [loadstring(base64decode("TGVmdEhhbmQ="))()] = true,
    [loadstring(base64decode("UmlnaHRVcHBlckFybQ=="))()] = true, [loadstring(base64decode("UmlnaHRMb3dlckFybQ=="))()] = true, [loadstring(base64decode("UmlnaHRIYW5k"))()] = true, [loadstring(base64decode("TGVmdFVwcGVyTGVn"))()] = true, [loadstring(base64decode("TGVmdExvd2VyTGVn"))()] = true,
    [loadstring(base64decode("TGVmdEZvb3Q="))()] = true, [loadstring(base64decode("UmlnaHRVcHBlckxlZw=="))()] = true, [loadstring(base64decode("UmlnaHRMb3dlckxlZw=="))()] = true, [loadstring(base64decode("UmlnaHRGb290"))()] = true,
}

local function BuildCharClone2(char)
    if not char or not char:IsA(loadstring(base64decode("TW9kZWw="))()) then return nil, loadstring(base64decode("bm90IGEgbW9kZWw="))() end
do
    local function partCount(m)
        local n = 0
        for _, d in ipairs(m:GetDescendants()) do
            if d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                n += 1
                if n > 150 then break end
            end
        end
        return n
    end
    local cur, hops = char, 0
    while partCount(cur) == 0 and hops < 3 do
        local p = cur.Parent
        if not p or not p:IsA(loadstring(base64decode("TW9kZWw="))()) or p == workspace then break end
        cur, hops = p, hops + 1
    end
    local n = partCount(cur)
    if n == 0 then return nil, loadstring(base64decode("bm8gcGFydHMgb24gY2xpZW50IChOUEMgc3RyZWFtZWQgb3V0IC8gdG9vIGZhciBhd2F5KQ=="))() end
    if hops > 0 and n > 150 then return nil, loadstring(base64decode("cGFyZW50IG1vZGVsIHRvbyBsYXJnZQ=="))() end
    char = cur
end
    local was = char.Archivable
    pcall(function() char.Archivable = true end)
    local ok, clone = pcall(function() return char:Clone() end)
    pcall(function() char.Archivable = was end)
    if not ok or not clone then return nil, loadstring(base64decode("Q2xvbmUgZmFpbGVkIChtb2RlbCBub3QgYXJjaGl2YWJsZSk="))() end

    for _, d in ipairs(clone:GetDescendants()) do
        local kill = false
        for _, c in ipairs(EffectClasses) do
            if d:IsA(c) then kill = true break end
        end
        if kill then
            pcall(function() d:Destroy() end)
        elseif d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
            d.CanCollide = false
            d.CanTouch = false
            d.CanQuery = false
            d.Anchored = false
            if d.Parent == clone and BodyNamesKeep[d.Name] and d.Transparency >= 0.95 then d.Transparency = 0 end
        end
    end

    local hum = clone:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if hum then
        pcall(function() hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end)
        pcall(function() hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff end)
        pcall(function() hum.EvaluateStateMachine = false end)
        pcall(function() hum.Health = math.max(hum.Health, 1) end)
    end

    local root = clone:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) or clone.PrimaryPart
        or clone:FindFirstChild(loadstring(base64decode("VG9yc28="))()) or clone:FindFirstChild(loadstring(base64decode("VXBwZXJUb3Jzbw=="))())
        or clone:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))(), true)
    if not root then clone:Destroy() return nil, loadstring(base64decode("bm8gcm9vdCBwYXJ0"))() end
    clone.PrimaryPart = root
    root.Anchored = true

    local animator = clone:FindFirstChildWhichIsA(loadstring(base64decode("QW5pbWF0b3I="))(), true)
    if not animator then
        local ctrl = hum or clone:FindFirstChildWhichIsA(loadstring(base64decode("QW5pbWF0aW9uQ29udHJvbGxlcg=="))(), true)
        if not ctrl then
            ctrl = Instance.new(loadstring(base64decode("QW5pbWF0aW9uQ29udHJvbGxlcg=="))())
            ctrl.Parent = clone
        end
        animator = Instance.new(loadstring(base64decode("QW5pbWF0b3I="))())
        animator.Parent = ctrl
    end

    clone:PivotTo(CFrame.new(0, 3, 0))

    -- kamera sadece görünür parçalara göre ayarlanır
    local big = math.huge
    local mn, mx = Vector3.new(big, big, big), Vector3.new(-big, -big, -big)
    local count = 0
    for _, d in ipairs(clone:GetDescendants()) do
        if d:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) and d.Transparency < 0.9 then
            local r = d.Size.Magnitude / 2
            local p = d.Position
            mn = Vector3.new(math.min(mn.X, p.X - r), math.min(mn.Y, p.Y - r), math.min(mn.Z, p.Z - r))
            mx = Vector3.new(math.max(mx.X, p.X + r), math.max(mx.Y, p.Y + r), math.max(mx.Z, p.Z + r))
            count += 1
        end
    end
    if count > 0 then
        local size = mx - mn
        PreviewState.FocusOffset = (mn + mx) / 2 - root.Position
        PreviewState.Radius = math.max(2, math.max(size.X, size.Y, size.Z) / 2)
    else
        PreviewState.FocusOffset, PreviewState.Radius = Vector3.new(0, 0.5, 0), 3.5
    end
    return clone, animator
end

CreatePreviewDummy = function(source)
    DestroyPreviewDummy()
    local char = ResolveSourceChar(source)
    local model, animator, why
    if char then
        local ok, m, a = pcall(BuildCharClone2, char)
        if ok and m then model, animator = m, a
        else why = ok and tostring(a) or tostring(m) end
    else
        why = loadstring(base64decode("Y2hhcmFjdGVyIG5vdCBmb3VuZCAocmVzcGF3bmVkIC8gbGVmdCB0aGUgZ2FtZSk="))()
    end
    if not model then
        -- sessizce varsayılan dummy'ye düş
        local ok, m, a = pcall(function() return BuildR6Rig(char) end)
        if not ok or not m then
            SetStatus(loadstring(base64decode("Q291bGQgbm90IGJ1aWxkIHRoZSBwcmV2aWV3IG1vZGVsOiA="))() .. tostring(m), true)
            return nil
        end
        model, animator = m, a
        model:PivotTo(CFrame.new(0, 3, 0))
        PreviewState.FocusOffset, PreviewState.Radius = Vector3.new(0, 0.5, 0), 3.5
        char = nil
    end
    model.Parent = PreviewState.WorldModel
    PreviewState.Dummy = model
    PreviewState.Animator = animator
    PreviewState.SourcePlayer = source
    PreviewState.SourceChar = char
    local r = PreviewState.Radius or 3.5
    PreviewState.CamDistance = math.clamp(r * 2.8 + 2, 6, 600)
    PreviewState.CamMin = r * 1.1 + 1
    PreviewState.CamMax = r * 8 + 12
    UpdatePreviewCamera()
    return model
end

LoadAndPlayPreview = function(animId, animName, source)
    local char = ResolveSourceChar(source)
    local rebuild = (not PreviewState.Dummy) or PreviewState.SourcePlayer ~= source
        or (char ~= nil and char ~= PreviewState.SourceChar)
    if rebuild then
        if not CreatePreviewDummy(source) then return false end
    end
    StopPreviewTrack()

    local anim = Instance.new(loadstring(base64decode("QW5pbWF0aW9u"))())
    anim.AnimationId = NormalizeAnimId(animId)

    local ok, track = pcall(function() return PreviewState.Animator:LoadAnimation(anim) end)
    if not ok or not track then
        anim:Destroy()
        SetStatus(loadstring(base64decode("Q291bGQgbm90IGxvYWQgdGhlIGFuaW1hdGlvbiAoaW52YWxpZCBJRCBvciBubyBhY2Nlc3MpLg=="))(), true)
        return false
    end

    track.Priority = Enum.AnimationPriority.Action
    PreviewState.Paused = false
    track:Play()
    PreviewState.Track = track
    PreviewState.CurrentAnimId = animId
    PreviewState.CurrentAnimName = animName
    return true
end

OpenPreviewFor = function(animId, animName, source)
    if not source then
        -- kaynak verilmediyse (ör. Skills sekmesi) bu animasyonu en son oynatan karakteri kullan
        local e = Discovered[loadstring(base64decode("YW5pbTo="))() .. NormalizeAnimId(animId)]
        if e and e.LastSrc then source = e.LastSrc end
    end
    UI.PreviewNameLabel.Text = animName or loadstring(base64decode("VW5rbm93bg=="))()
    local idText = loadstring(base64decode("SUQg"))() .. (tostring(animId):match(loadstring(base64decode("JWQr"))()) or tostring(animId))
    if source and source.Name then idText = idText .. loadstring(base64decode("ICAgfCAgIA=="))() .. L.T(loadstring(base64decode("U291cmNl"))()) .. loadstring(base64decode("OiA="))() .. source.Name end
    UI.PreviewIdLabel.Text = idText
    LoadAndPlayPreview(animId, animName, source)
end

UpdatePreviewProgress = function()
    if not Window.Main.Visible or UI.CurTab ~= loadstring(base64decode("QW5pbWF0aW9uIE1vbml0b3I="))() then return end
    local t = PreviewState.Track
    local label = loadstring(base64decode("UGxheQ=="))()
    if t then
        local len, pos = t.Length, t.TimePosition
        UI.TimeLabel.Text = string.format(loadstring(base64decode("JS4yZiAvICUuMmYgcw=="))(), pos, len)
        UI.ProgressFill.Size = UDim2.new(len > 0 and math.clamp(pos / len, 0, 1) or 0, 0, 1, 0)
        if not t.IsPlaying then label = loadstring(base64decode("UGxheQ=="))()
        elseif PreviewState.Paused then label = loadstring(base64decode("UmVzdW1l"))()
        else label = loadstring(base64decode("UGF1c2U="))() end
    else
        UI.TimeLabel.Text = loadstring(base64decode("MC4wMCAvIDAuMDAgcw=="))()
        UI.ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    end
    if UI.PlayLabel ~= label then
        UI.PlayLabel = label
        L.Set(UI.PlayButton, label)
    end
end


end -- preview scope
-- HIT TRACKING (hasar alma + zamanlama öğrenme)

-- ident: SkillIdent(skill); getPos: olayın kaynağının (rakip / nesne) anlıGgfRx2bY konumunu döndürür
local function NoteStart(ident, getPos)
    table.insert(Recent, { Id = ident, GetPos = getPos, T = os.clock() })
    if #Recent > 16 then table.remove(Recent, 1) end
end

-- Hasar aldığında: yakındaki en son başlayan olayın vuruş zamanını kaydeder
local function LearnFromHit()
    local lchar = LocalPlayer.Character
    local lroot = lchar and lchar:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
    if not lroot then return end
    local now = os.clock()
    for i = #Recent, 1, -1 do
        local r = Recent[i]
        if now - r.T > 1.5 then break end
        local pos = r.GetPos()
        if pos and (pos - lroot.Position).Magnitude <= 30 then
            local t = now - r.T
            if t >= 0.05 then
                local l = Learned[r.Id] or {}
                Learned[r.Id] = l
                table.insert(l, t)
                if #l > 5 then table.remove(l, 1) end
                for id, e in pairs(Discovered) do Dirty[id] = true end
            end
            return
        end
    end
end

local function HookLocalCharacter(char)
    if LocalHealth.Conn then LocalHealth.Conn:Disconnect(); LocalHealth.Conn = nil end
    if LocalHealth.Anim then LocalHealth.Anim:Disconnect(); LocalHealth.Anim = nil end
    local hum = char:WaitForChild(loadstring(base64decode("SHVtYW5vaWQ="))(), 5)
    if not hum then return end
    LocalHealth.Last = hum.Health
    LocalHealth.Conn = hum.HealthChanged:Connect(function(h)
        if h < LocalHealth.Last then
            HitStamp = os.clock()
            LearnFromHit()
        end
        LocalHealth.Last = h
    end)
    -- Kendi skill aksiyonun: yanında beliren nesneleri (kendi fireball'un vb.) yok saymak için
    local animator = GetAnimator(char)
    if animator then
        LocalHealth.Anim = animator.AnimationPlayed:Connect(function(track)
            local v = track.Priority.Value
            if v >= Enum.AnimationPriority.Action.Value and v < 1000 then LocalHealth.SelfAct = os.clock() end
        end)
    end
end


-- PARRY ENGINE

local function KeyToVK(keyCode)
    local v = keyCode.Value
    if v >= 97 and v <= 122 then return v - 32 end
    return v
end

local function SendKey(down, key)
    local ok = false
    if VirtualInputManager then
        ok = pcall(function() VirtualInputManager:SendKeyEvent(down, key, false, game) end)
    end
    if not ok and type(keypress) == loadstring(base64decode("ZnVuY3Rpb24="))() and type(keyrelease) == loadstring(base64decode("ZnVuY3Rpb24="))() then
        pcall(function()
            local vk = KeyToVK(key)
            if down then keypress(vk) else keyrelease(vk) end
        end)
    end
end

-- Tuşu güvenle bırakır (takılı kalmayı önler)
ReleaseParryKey = function()
    if not KeyHeld then return end
    KeyHeld = false
    KeyToken += 1
    SendKey(false, HeldKey)
end

local function FlashPill()
    if not UI.PillDot then return end
    UI.PillDot.BackgroundColor3 = Theme.Accent
    task.delay(0.2, function()
        if UI.PillDot then UI.PillDot.BackgroundColor3 = Config.AutoParryEnabled and Theme.Good or Theme.Muted end
    end)
end

ExecuteParry = function(skill, srcLike, active)
    PressParryKey(skill.Hold and skill.Dur or nil, active)
    local text = skill.Name .. loadstring(base64decode("IHZzIA=="))() .. srcLike.Name
    if UI.Stats then UI.Stats.Last.Text = text end
    FlashPill()
    SetStatus(loadstring(base64decode("UGFycnk6IA=="))() .. text)
end

-- Humanoid'i olmayan NPC'ler (AnimationController) için de konum döndürür
local function CharPos(src)
    local char = src.GetChar()
    if not char or not char.Parent then return nil end
    local hum = char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))())
    if hum and hum.Health <= 0 then return nil end
    local root = char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) or char.PrimaryPart
    if root then return root.Position end
    return ModelPos(char)
end

local function PingDelay(skill)
    return math.max(0, skill.Delay - (Config.PingComp and GetPing() or 0))
end

-- DEBUG GÖRSELLEŞTİRME (hitbox / parry sebebi)

local Debug = { Folder = nil, Items = {} }

local function DebugFolder()
    if Debug.Folder and Debug.Folder.Parent then return Debug.Folder end
    local f = Instance.new(loadstring(base64decode("Rm9sZGVy"))())
    f.Name = loadstring(base64decode("UGFycnlEZWJ1Zw=="))()
    pcall(function() f.Parent = gethui() end)
    if not f.Parent then f.Parent = workspace.CurrentCamera end
    Debug.Folder = f
    return f
end

local function AdorneePart(inst)
    if not inst then return nil end
    if inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then return inst end
    if inst:IsA(loadstring(base64decode("TW9kZWw="))()) then
        return inst.PrimaryPart or inst:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) or inst:FindFirstChildWhichIsA(loadstring(base64decode("QmFzZVBhcnQ="))(), true)
    end
    return nil
end

local function DebugRemove(key)
    local it = Debug.Items[key]
    if not it then return end
    Debug.Items[key] = nil
    pcall(function() it.Sphere:Destroy() end)
    if it.Gui then pcall(function() it.Gui:Destroy() end) end
end

DebugClearAll = function()
    for GgfRx2bY in pairs(Debug.Items) do DebugRemove(GgfRx2bY) end
end

-- part etrafına radius yarıçaplı GgfRx2bYüre çizer; text verilirse üstünde bilgi yazısı gösterir
local function DebugDraw(key, part, radius, color, text, ttl)
    if not Config.DebugVis or not part or not part.Parent then return end
    local it = Debug.Items[key]
    if it and it.Part ~= part then DebugRemove(key); it = nil end
    if not it then
        local folder = DebugFolder()
        local sphere = Instance.new(loadstring(base64decode("U3BoZXJlSGFuZGxlQWRvcm5tZW50"))())
        sphere.AlwaysOnTop = true
        sphere.ZIndex = 1
        sphere.Transparency = 0.85
        sphere.Adornee = part
        sphere.Parent = folder
        it = { Part = part, Sphere = sphere }
        if text then
            local gui = Instance.new(loadstring(base64decode("QmlsbGJvYXJkR3Vp"))())
            gui.Size = UDim2.fromOffset(250, 66)
            gui.StudsOffset = Vector3.new(0, 4, 0)
            gui.AlwaysOnTop = true
            gui.Adornee = part
            gui.Parent = folder
            local lbl = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))())
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 12
            lbl.TextWrapped = true
            lbl.TextStrokeTransparency = 0.4
            lbl.Parent = gui
            it.Gui, it.Label = gui, lbl
        end
        Debug.Items[key] = it
    end
    it.Sphere.Radius = radius
    it.Sphere.Color3 = color
    if it.Label and text then
        it.Label.Text = text
        it.Label.TextColor3 = color
    end
    it.Expire = os.clock() + (ttl or 0.35)
end

local function DebugTick()
    if not next(Debug.Items) then return end
    local now = os.clock()
    for GgfRx2bY, it in pairs(Debug.Items) do
        if now > it.Expire or not it.Part.Parent then DebugRemove(GgfRx2bY) end
    end
end

local DebugSerial = 0

-- Oyuncudan nesnenin en yakın kenarına olan mesafe (merkez değil, hitbox'ın 7GzvlMabüzeyi)
-- Model bounding box'ı 0.06 sn önbelleğe alınır (her karede GetBoundingBox çağrılmaz)
local function ObjDist(inst, p)
    local cf, size
    if inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
        cf, size = inst.CFrame, inst.Size
    elseif inst:IsA(loadstring(base64decode("TW9kZWw="))()) then
        local now = os.clock()
        local c = Poll.BB[inst]
        if not c or now - c.T > 0.06 then
            local ok, bcf, bsize = pcall(inst.GetBoundingBox, inst)
            if not ok then
                local pos = ModelPos(inst)
                return pos and (pos - p).Magnitude or nil
            end
            c = { T = now, CF = bcf, Size = bsize }
            Poll.BB[inst] = c
        end
        cf, size = c.CF, c.Size
    else
        return nil
    end
    local lp = cf:PointToObjectSpace(p)
    local h = size / 2
    local c2 = Vector3.new(math.clamp(lp.X, -h.X, h.X), math.clamp(lp.Y, -h.Y, h.Y), math.clamp(lp.Z, -h.Z, h.Z))
    return (lp - c2).Magnitude
end

-- RADAR: anim / skill / object için ortak mantıGgfRx2bY.
-- Menzil dışında hiçbir şey yapmaz; menzile girince delay sayar, bitince parry basar.
type RadarJob = {
    Skill: Skill, Opts: RadarOpts, Key: string,
    Delay: number, Start: number, Last: number, InTime: number,
}

local ActiveRadars: { RadarJob } = {}
local Unloaded = false

local function Radar(skill: Skill, o: RadarOpts)
    DebugSerial += 1
    local now = os.clock()
    table.insert(ActiveRadars, {
        Skill = skill, Opts = o, Key = loadstring(base64decode("cg=="))() .. DebugSerial,
        Delay = PingDelay(skill), Start = now, Last = now, InTime = 0,
    })
end

local function StepRadars()
    local count = #ActiveRadars
    if count == 0 then return end
    local now = os.clock()
    local lroot, lhum = Poll.Local()
    local ownerAlive = lroot ~= nil and lhum ~= nil and lhum.Health > 0

    for i = count, 1, -1 do
        local job = ActiveRadars[i]
        local skill, o = job.Skill, job.Opts
        local dt = now - job.Last
        job.Last = now

        local finished = Unloaded or not ownerAlive or not Config.AutoParryEnabled
            or not skill.Enabled or now - job.Start >= o.Life or not o.Alive()
        local fire = false

        if not finished then
            local d = o.Dist(lroot.Position)
            if not d then
                finished = true
            elseif d <= skill.Dist then
                local rate = if o.Rate then o.Rate() else 1
                if rate < 0.05 then rate = 1 end
                job.InTime += dt * rate
                fire = job.InTime >= job.Delay
                finished = fire

                if Config.DebugVis then
                    local part = o.Part()
                    local col = if fire then Color3.new(1, 1, 1) else Theme.Accent
                    if part then
                        DebugDraw(job.Key, part, 1, col, string.format(loadstring(base64decode("JXNcbiVzXG5kaXN0ICUuMWYgLyAlZCBzdA=="))(), skill.Name,
                            fire and loadstring(base64decode("UEFSUlkh"))() or string.format(loadstring(base64decode("SU4gUkFEQVIgLSBkZWxheSAlLjJmcw=="))(), math.max(0, job.Delay - job.InTime)),
                            d, skill.Dist), 0.8)
                    end
                    DebugDraw(loadstring(base64decode("X19zZWxm"))(), lroot, skill.Dist, if fire then Color3.new(1, 1, 1) else Theme.Good, nil, 0.35)
                end
            else
                job.InTime = 0
            end
        end

        if fire then
            -- PressParryKey içinde task.wait vtpd9YZI: döngü7GzvlMabü bloklamasın
            task.spawn(ExecuteParry, skill, { Name = o.Name }, o.Active)
        end
        if finished then
            DebugRemove(job.Key)
            local last = #ActiveRadars
            ActiveRadars[i] = ActiveRadars[last] -- swap-remove (aşağı doğru dönüldüğü için güvenli)
            ActiveRadars[last] = nil
        end
    end
end

-- ANIM
TryParry = function(src, track, skill)
    if ParryRuntime.TriggeredTracks[track] then return end
    ParryRuntime.TriggeredTracks[track] = true
    local stopConn
    stopConn = track.Stopped:Connect(function()
        stopConn:Disconnect()
        ParryRuntime.TriggeredTracks[track] = nil
    end)
    Radar(skill, {
        Name = src.Name, Life = 6,
        Part = function() return AdorneePart(src.GetChar()) end,
        Dist = function(p) local pos = CharPos(src) return pos and (pos - p).Magnitude or nil end,
        Alive = function() return track.IsPlaying and src.Key.Parent ~= nil end,
        Rate = function() return math.max(track.Speed, 0) end,
        Active = function() return track.IsPlaying end,
    })
end

-- SKILL (CurrentSkill değeri)
TryParrySkill = function(src, skill)
    local serial = src.SkillSerial
    Radar(skill, {
        Name = src.Name, Life = 2.5,
        Part = function() return AdorneePart(src.GetChar()) end,
        Dist = function(p) local pos = CharPos(src) return pos and (pos - p).Magnitude or nil end,
        Alive = function() return src.Key.Parent ~= nil and src.SkillSerial == serial end,
        Active = nil,
    })
end

-- OBJECT (kenardan ölçülür)
TryParryObject = function(skill, inst)
    Radar(skill, {
        Name = inst.Name, Life = 10,
        Part = function() return AdorneePart(inst) end,
        Dist = function(p) return ObjDist(inst, p) end,
        Alive = function() return inst.Parent ~= nil end,
        Active = function() return inst.Parent ~= nil end,
    })
end

OnParryAnimation = function(src, track, existing)
    if existing then return end
    local animId = TrackAnimId(track)
    if not animId then return end
    local any = FindSkill(loadstring(base64decode("QW5pbQ=="))(), animId, nil, true)
    if any then NoteStart(SkillIdent(any), function() return CharPos(src) end) end   -- zamanlama öğrenme
    if not Config.AutoParryEnabled or IsIgnored(src) then return end
    local skill = FindSkill(loadstring(base64decode("QW5pbQ=="))(), animId)
    if skill then TryParry(src, track, skill) end
end

OnParrySkill = function(src, value, existing)
    if existing then return end
    local key = ValueToKey(value)
    if key == loadstring(base64decode(""))() then return end
    -- aynı değer birden fazla yoldan (attribute + ValueBase vb.) gelirse tek sayılır
    local now = os.clock()
    if src.LastSkillKey == key and now - (src.LastSkillT or 0) < 0.2 then return end
    src.LastSkillKey, src.LastSkillT = key, now
    src.SkillSerial = (src.SkillSerial or 0) + 1
    local any = FindSkill(loadstring(base64decode("U2tpbGw="))(), key, nil, true)
    if any then NoteStart(SkillIdent(any), function() return CharPos(src) end) end
    if not Config.AutoParryEnabled or IsIgnored(src) then return end
    local skill = FindSkill(loadstring(base64decode("U2tpbGw="))(), key)
    if skill then TryParrySkill(src, skill) end
end

--------------------------------------------------------
-- OBJECT WATCHER (workspace'te beliren nesneler)
--------------------------------------------------------
local function ProcessObject(inst)
    local parent = inst.Parent
    if not parent then return end
    if parent:IsA(loadstring(base64decode("TW9kZWw="))()) and parent:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))()) then return end   -- karakter / NPC parçaları
    if inst:IsA(loadstring(base64decode("TW9kZWw="))()) and (inst:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))()) or Players:GetPlayerFromCharacter(inst)) then return end

    local parentName = (parent == workspace) and loadstring(base64decode("V29ya3NwYWNl"))() or parent.Name
    local name = inst.Name

    -- zamanlama öğrenme (skill'i varsa)
    local any = FindSkill(loadstring(base64decode("T2JqZWN0"))(), name, parentName, true)
    if any then NoteStart(SkillIdent(any), function() return inst.Parent and ModelPos(inst) or nil end) end

    -- parry (kendi skill'inin yanında beliren kendi nesneni yok say)
    if Config.AutoParryEnabled then
        local skill = FindSkill(loadstring(base64decode("T2JqZWN0"))(), name, parentName)
        if skill then
            local lchar = LocalPlayer.Character
            local lroot = lchar and lchar:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
            local ipos = ModelPos(inst)
            local own = false
            if lroot and ipos and (ipos - lroot.Position).Magnitude < 10
                and os.clock() - LocalHealth.SelfAct < 1.2 then
                own = true
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        local c = p.Character
                        local r = c and c:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
                        if r and (r.Position - ipos).Magnitude < 14 then own = false break end
                    end
                end
            end
            if own then
                if Config.DebugVis then SetStatus(loadstring(base64decode("T2JqZWN0IGlnbm9yZWQgKG93bik6IA=="))() .. name, true) end
            else
                if Config.DebugVis then SetStatus(loadstring(base64decode("T2JqZWN0IHRyYWNrZWQ6IA=="))() .. name .. loadstring(base64decode("IEAg"))() .. parentName) end
                TryParryObject(skill, inst)
            end
        end
    end

    -- monitor kaydı
    if Monitor.Target and not Monitor.Paused then
        local ident = loadstring(base64decode("b2JqZWN0Og=="))() .. name:lower() .. loadstring(base64decode("QA=="))() .. parentName:lower()
        local entry = RecordDiscovered(loadstring(base64decode("T2JqZWN0"))(), ident, name .. loadstring(base64decode("IEAg"))() .. parentName,
            { ObjName = name, ObjParent = parentName }, nil)
        if entry then
            entry.Playing += 1
            local conn
            conn = inst.AncestryChanged:Connect(function(_, p)
                if not p then
                    conn:Disconnect()
                    entry.Playing = math.max(0, entry.Playing - 1)
                    Dirty[entry.Id] = true
                end
            end)
        end
    end
end

local Memo = { Lower = {}, Count = 0 }
function Memo.ToLower(s)
    local v = Memo.Lower[s]
    if v then return v end
    v = s:lower()
    if Memo.Count >= 4000 then table.clear(Memo.Lower); Memo.Count = 0 end
    Memo.Lower[s] = v
    Memo.Count += 1
    return v
end
local function OnWorkspaceDescendant(inst)
    if not (Config.AutoParryEnabled or Monitor.Target) then return end
    if not (inst:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) or inst:IsA(loadstring(base64decode("TW9kZWw="))())) or inst:IsA(loadstring(base64decode("VGVycmFpbg=="))()) then return end
    -- Monitor kapalıyken yalnızca skill listesindeki nesne adları işlenir
    if not Monitor.Target and not (UI.ObjIdx and UI.ObjIdx[Memo.ToLower(inst.Name)]) then return end
    local parent = inst.Parent
    if not parent then return end
    local lchar = LocalPlayer.Character
    if lchar and inst:IsDescendantOf(lchar) then return end   -- kendi karakterin / GgfRx2bYıyafetin parçaları
    local now = os.clock()
    local fp = Fresh[parent]
    Fresh[inst] = now
    if parent:IsA(loadstring(base64decode("QWNjZXNzb3J5"))()) or parent:IsA(loadstring(base64decode("VG9vbA=="))()) then return end
    local pname = (parent == workspace) and loadstring(base64decode("V29ya3NwYWNl"))() or parent.Name
    local matched = FindSkill(loadstring(base64decode("T2JqZWN0"))(), inst.Name, pname, true) ~= nil
    if fp and now - fp < 0.5 and not matched then return end   -- yeni modelin iç parçası (skill'e eşleşmiyorsa)
    task.defer(ProcessObject, inst)
end

--------------------------------------------------------
UpdateEngineStatus = function()
    local hooked = 0
    for _, rec in pairs(ParryStore) do if rec.Skill or next(rec.Animators) then hooked += 1 end end
    local enabled = 0
    local idx, maxd = {}, 0
    for _, s in ipairs(Skills) do
        if s.Enabled then
            enabled += 1
            if s.Dist > maxd then maxd = s.Dist end
        end
        if s.Type == loadstring(base64decode("T2JqZWN0"))() and s.ObjName ~= loadstring(base64decode(""))() then idx[s.ObjName:lower()] = true end
    end
    UI.ObjIdx, UI.MaxSkillDist = idx, maxd
    if UI.Stats then
        UI.Stats.Hooked.Text = tostring(hooked)
        UI.Stats.Skills.Text = string.format(loadstring(base64decode("JWQgLyAlZA=="))(), enabled, #Skills)
    end
    if UI.PillDot then
        UI.PillDot.BackgroundColor3 = Config.AutoParryEnabled and Theme.Good or Theme.Muted
        L.Set(UI.PillText, Config.AutoParryEnabled and loadstring(base64decode("QXV0by1QYXJyeSBPTg=="))() or loadstring(base64decode("QXV0by1QYXJyeSBPRkY="))())
    end
    UpdateMonitorHeader()
end

SetEnabled = function(v)
    Config.AutoParryEnabled = v
    if not v then ReleaseParryKey() end
    if UI.EnableToggle then UI.EnableToggle.Set(v) end
    UpdateEngineStatus()
    SetStatus(v and loadstring(base64decode("QXV0by1QYXJyeSBlbmFibGVkLg=="))() or loadstring(base64decode("QXV0by1QYXJyeSBkaXNhYmxlZC4="))())
end

ParryHandlers   = { Anim = OnParryAnimation, Skill = OnParrySkill }
MonitorHandlers = { Anim = OnMonitorAnimation, Skill = OnMonitorSkill }


-- PATCH: parry tuşu mantığı (basılıyken gelen parry'ler artıGgfRx2bY süreyi uzatır / yeniden basar)
PressParryKey = function(holdTime, active)
    local R = ParryRuntime
    local isHold = holdTime ~= nil
    local dur = math.max(0.03, tonumber(holdTime) or Defaults.Tune.TAP_HOLD)

    local function extend()
        R.HoldUntil = math.max(R.HoldUntil or 0, os.clock() + dur)
        R.HeldIsHold = R.HeldIsHold or isHold
        R.HeldActive = nil
    end

    if KeyHeld then
        local age = os.clock() - HeldSince
        if age > 6 then
            ReleaseParryKey()
        elseif age < 0.35 then
            extend()
            return
        else
            ReleaseParryKey()
            task.wait(0.04)
            if KeyHeld then extend() return end
        end
    end

    local now = os.clock()
    KeyHeld = true
    HeldSince = now
    HeldKey = Config.ParryKey
    KeyToken += 1
    local token = KeyToken
    R.HoldUntil, R.HeldStart, R.HeldIsHold, R.HeldActive = now + dur, now, isHold, active
    SendKey(true, HeldKey)

    task.spawn(function()
        while os.clock() < R.HoldUntil do
            if token ~= KeyToken then return end
            if R.HeldIsHold then
                local act = R.HeldActive
                if (act and os.clock() - R.HeldStart > 0.1 and not act())
                    or HitStamp > R.HeldStart or not IsAlive(LocalPlayer.Character) then
                    break
                end
            end
            task.wait()
        end
        if token == KeyToken then ReleaseParryKey() end
    end)
end

-- INITIALIZATION

-- Kayıtlı profilleri 7GzvlMabükle. Kayıt yoksa (veya eski sürümse) önerilen varsayılan config kullanılır;
-- eski sürümdeki Default profili loadstring(base64decode("T2xkIGNvbmZpZw=="))() adıyla yedeklenir.
do
    local function LoadList(list)
        local arr = {}
        if type(list) == loadstring(base64decode("dGFibGU="))() then
            for _, s in ipairs(list) do
                if type(s) == loadstring(base64decode("dGFibGU="))() then table.insert(arr, SkillFromData(s, false)) end
            end
        end
        return arr
    end

    -- VARSAYILAN CONFIG (kullanıcının kendi listesi)
    local DEFAULT_JSON = [==[[{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("NkZBOEEwNzgtMzc5My00NzFDLUE0MkMtRDY3NkYyRTY4QkU2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("Q2xlYXZlIFJ1c2g="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.26,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("OTY1OTlFRUQtQzg4MC00NERFLUE5RDEtODVEMDBEMDQ3MUNE"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("RGVicmlz"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("V2F0ZXIgRHJhZ29u"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("V2F0ZXJEcmFnb25IZWFk"))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.03,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("RDBBNjEwQUYtQjMzQi00MkNELUFFMzYtNzBDRjFFRUFGRDBF"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgQ3Jvc3MgU2xhc2g="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("REY2OUU4MzgtMDgzMC00RkI2LThCNTktMkRCQTQ1N0VFRTI2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("V29ya3NwYWNl"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("RmlyZWJhbGw="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("RmlyZWJhbGw="))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("QTQyQzIyMzgtODY1RS00N0I2LUFCODUtODRDNDZCNTJBQkJF"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U21vbGRlcmluZyBFYXJ0aA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("MTI1M0I4QzAtMkYwMC00MDkzLTkxQ0YtODFBOUI2MjlDQjAx"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("RHluYW1pYyBFbnRyeQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("RDAxRkQzNDQtQkEyRC00NzdBLUIzMzItREIxRkE3NjZGN0E2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U3Bpbm5pbmcgRGFzaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("MTBBMkUwQkYtMTFDNy00MjdCLThCQjgtQjYwN0MwRDIxMEM2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("VGhydXN0aW5nIFN0cmlrZQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("ODdCRTk2RTctMkM0RS00RjU2LUJDQkEtMzIwNDJFQkRFRDYz"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SWNlIFNwaWtlcw=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.05,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("QTM2MzlBNzItREZDRC00ODc5LTk4MTQtRDIzRkQwQzE1QzAz"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("Qmxvb2QgRHJhZ29u"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("NkI4NEYxNTMtMDJFOS00NjUzLTk3REYtMjBDQzFFMjQ2ODgz"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("RG91YmxlIEJsb29kIERyYWdvbg=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("NDBBMzQyMTEtOTIwMy00MTFDLUJBMzEtMTQwREEwQjZFQkM1"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("VHJpcGxlIEJsb29kIERyYWdvbg=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("QkRFQTYyOEItQTEzRi00MThDLTg5RUUtQTVGMjc3NDEyQTVD"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QW1hdGVyYXN1"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("ODZGNjEzOUUtNkU5NC00RUMyLUE2MTAtNzU3QjM0NUZDQ0FB"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TTEgQ29tYm8gRW5kZXI="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("M0FGRTAxOTctOTk3OC00RkRDLTg0ODktOTVGM0Y4MUNCNTBG"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U2FzdWtlIE0y"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("N0I3RDA1NzYtRjMzRi00OUVBLTlDNDAtRTBBNjg0NDkxOTM0"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U2hpc3VpIFRocm93"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.35,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():50,loadstring(base64decode("SWQ="))():loadstring(base64decode("QjQwQUEyM0QtRjJDMS00MEI1LThCRTAtMUVDQjdBNzY4QjUz"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SGlydWRvcmE="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("NURBNkI4QUMtQUEwNi00QzIzLTkyOTgtOThBQjJERDk3MUE3"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QnV0dGVyZmx5IFNsYW0="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("Mjc3MzREQjQtNDMxQS00RDM3LTlFQ0QtMUFFQTlCMjlDNjE0"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("V29ya3NwYWNl"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("RWFydGggRHJhZ29u"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("RWFydGggRHJhZ29u"))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("NUI3Qzc0OTctRDQ2RC00OEQ4LUIwQTEtQjM0MkVFMkY1QzQ3"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("RGVicmlz"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("V29vZGVuIERyYWdvbg=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("V29vZGVuRHJhZ29uSGVhZA=="))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("QkVCMkZEOUEtMzU1RC00MkQ5LThCQjQtMzg5Q0VGNjc2OUJC"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("RGVicmlz"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SWNlIERyYWdvbg=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("Y3JhY2s="))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.05,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("MTYyRDMwMkItNzkxQS00NkZBLUJGNzEtQzQyQzFDRUY3NUFG"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("RGVicmlz"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("V29vZGVuIFNwaXJl"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("Y3JhY2s="))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.05,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.26,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("MkZGOEVGMUQtRDVBOC00RDU4LTkyMzgtOEY1N0E4NkQyNTI0"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TGFyaWF0"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("RTIxODgyREMtRkJDOC00MjRELUIzREEtM0Q0RjBGMTZEODUw"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("UHJvdHJ1ZGluZyBDaGFpbnM="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("NTVDNjcyRDMtODMxMy00RjYyLTg2MDMtNURDRERCQUQzQTI1"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("RmVybiBEYW5jZQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.5,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("MzBCNzY0QTgtODkyNC00M0IxLUI2NzUtMTlDQUUzM0VDOEZC"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgQnVsbGV0cw=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():40,loadstring(base64decode("SWQ="))():loadstring(base64decode("RDg4MjNEMzctMEEzRC00OEFELUFFNDItQkQ2RDg1OTg4MTE0"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("RWFydGggU2xhbQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.2,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzExMjg5NTMxNTYx"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("NDNGNDFENkEtMTM2Ri00OUE5LUFBMkItNzM4NDAyQzI5NkZB"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QWxtaWdodHkgUHVzaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEwOTMwMzc2OTEy"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("T2JqZWN0"))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():5,loadstring(base64decode("SWQ="))():loadstring(base64decode("NDI2MUUyRDktQzAzQS00RjUwLUI1RDQtODgwRjFEMUQxM0NE"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode("RGVicmlz"))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SWNlIFNwaWtlcyBbT2JqXQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode("SWNlU3Bpa2U="))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("REZCNDVFNDEtRTdEMi00N0QzLTgzNTUtNDEzRTc3NUZDNUFF"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("WmlnIFphZw=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("U2tpbGw="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():40,loadstring(base64decode("SWQ="))():loadstring(base64decode("RjMxRjYyNzYtNDM0Ny00NDhDLThERkUtM0I4RDlDRDcwRTg4"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SmluY2h1cmlraSBCb21i"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode(""))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():60,loadstring(base64decode("SWQ="))():loadstring(base64decode("OTZFM0M1OUMtRTY5Ni00Qzg0LTlFM0EtNzA0QkFBRjlBRDc3"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("Q29yYWwgRW1lcmdl"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzk5MDY4NTU5NTAxMzM3"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():41,loadstring(base64decode("SWQ="))():loadstring(base64decode("QTU5N0QyNDMtNUZGMy00M0MyLUI1MDMtRjBGRjJEOENCNzBC"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgVGFpbCBTd2lwZQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEyMDcwMzc0NzkxNjUxNg=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("Q0E2NUNBMzYtRTc4Ny00OTc0LUIzQTItNkIyQzE2QThBRUQ1"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgUmlnaHQgUHVuY2g="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzg2NDE0NTA4Nzg2Mzcw"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("RUU1Q0I5M0EtQkFDRS00NEI5LThERDYtNkYxNzUyM0U0MTM0"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgTGVmdCBQdW5jaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzkzMDEyMzczNzk1NTM4NA=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("MDA5RUIwNUYtRkRGMy00MUVELUIxNTktMEFBMUEzQzQ3NDg5"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgQml0ZQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzExMzQxOTUyNDMwNTY4OQ=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("NEE3NzhBMEYtNUEzRC00RjIzLThDNkItQ0UyQ0EzNEI5QzMy"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWF0YXRhYmkgQ2xvYWsgQ3Jvc3MgU2xhc2g="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEyOTUxNzcxODE4MjE3MA=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("RkNBNjhFNkYtMTM2NC00M0NBLTlGM0ItQjdFMThBMjQ4OTVE"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SXNvYnUgUmlnaHQgUHVuY2g="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzkxOTg3OTA1MTE4NTQzNQ=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("RkU4RkMxRUYtQjJEOC00NUYxLTkzNDgtRDY2NkEwQUU4MzBC"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SXNvYnUgTGVmdCBQdW5jaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEyMTkwMTA2MTQ1ODk2Ng=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("NDZCRjg5NDUtMTk1OC00MDQwLThBRkUtMkNEMUU3MzU4ODlB"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SXNvYnUgQml0ZQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzkxMTQzNjAxNDAwNTg4"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("NzgyQzNBMDYtQTM4RS00NkI5LUJCRDktNDUyMDJGQjlCOTQ4"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SXNvYnUgVGFpbCBIaXRz"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEzODk1Nzk5NTM3MTQyOA=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("NTJFRjgwQzQtNzVDRS00NDAyLTgyRDItNjQ2RkFERUJBRThB"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SXNvYnUgUGlsbGFycw=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.2,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzczMTE4MDQ4NTY5MjE0"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():30,loadstring(base64decode("SWQ="))():loadstring(base64decode("QTEzNkZBMTMtMUUwNS00REFBLUExMDYtNjUwNzA5NERGMTg2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("SXNvYnUgQmFzaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEzMzc2MTI2OTY3OTEzNQ=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("QUM0RUU5MDMtQTI4Qy00M0YzLTg4NjQtRTk2RTI4NzM5MUQy"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U2h1a2FrdSBMZWZ0IFB1bmNo"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEwNDgwNTYxMjM5ODgy"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("MDU3Q0RGNDAtQzc2MS00ODgyLThDNEItNDBDNDkxNEVCRkNE"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U2h1a2FrdSBSaWdodCBQdW5jaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzExMzA3NjcyNjAyMzE5Mw=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():45,loadstring(base64decode("SWQ="))():loadstring(base64decode("NUI5MjUyN0QtQzBDRi00RDU0LTgyRkEtRTY4QTQ5RUQwRDky"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U2h1a2FrdSBUYWlsIFN3aXBl"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEyOTIwOTA2OTYzOTg2MA=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("RTQ4NEYxOEItRDkwNy00OTIxLTlBMzktNzI2MDFBRDBDMTBF"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("U2h1a2FrdSBBcm0gU2xhbQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEzMDUzMzk2NDA1NzQyMA=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("NEQyMkY2RTEtMEY1Qy00RTg3LThDNTQtMkM0NDY5RDFFQjk2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gUmlnaHQgUHVuY2g="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEwNTk5OTczNTQ1NzkyNw=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("OEUyRERDQjEtRjM0Qy00NURBLTkxMjctRUM0REIwNzExQTUx"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gTGVmdCBQdW5jaA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzExNTkyMjEzMjY3NzMz"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("OUEyODM5QTktNzMwRC00QTY3LThBNzMtNDhEQzg1NjcxQ0E2"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gTGVmdCBTdG9tcA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzExNTkyMjEzMjY3NzMz"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():20,loadstring(base64decode("SWQ="))():loadstring(base64decode("REI4OTJBODEtMzVDMC00NkVDLUE5RjctNURFNDc2NkI1QjI1"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gUmlnaHQgU3RvbXA="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzc0Njk5NzI2ODgwNjMzOA=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():30,loadstring(base64decode("SWQ="))():loadstring(base64decode("MkQwOTA0MDMtODYyRC00RUVBLTlGODktMUNDQjUxMkEyQTY3"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gUm9vdHM="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzk5NDk1OTg5ODk2OTY2"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():30,loadstring(base64decode("SWQ="))():loadstring(base64decode("MjhBRkYzOUUtNDgwQi00NEY2LTkyMTItRERGRUY0RTRCRjcw"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gU3BpcmU="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzExNjkwNzEyNjI0NDA1Nw=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():35,loadstring(base64decode("SWQ="))():loadstring(base64decode("MDI3RDlGMDUtRUE4RS00NURBLTk0NTQtQzhGNUVCQTgwMUQ3"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("R29sZW0gRHJhZ29u"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.1,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzEyMDc1ODkwOTMwODUxMQ=="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("MDE1NzAwNkEtRThCMS00RDkwLTgzRUUtQzYzOTM0QTdCMDE0"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("Qmxvb2QgQXJyb3c="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.05,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzgzMDkzNjY2ODg1MTg0"))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.3,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("RUM3OTU5NzAtMjA2Ri00MzE0LUI5MEItQ0MyNEM5RTZGMERB"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QmFyYmFyaWFuIFJpZ2h0IFNsYW0="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.5,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzYwMzgwNDA3MjA="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.3,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("RkM2M0I5QzktODI4Ni00QTQ2LUIyMDAtMjlBRTRBQjYzQ0Y3"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QmFyYmFyaWFuIExlZnQgU2xhbQ=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.5,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzYwMzgwNDE5MTY="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.26,loadstring(base64decode("RGlzdA=="))():14,loadstring(base64decode("SWQ="))():loadstring(base64decode("ODM4NzA3OUEtN0RCOC00QjU1LThDRTAtQzUxODBBRkMzQ0ZG"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QmFyYmFyaXQgU3dpcA=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.16,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzk2NTYyOTA5NjA="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():15,loadstring(base64decode("SWQ="))():loadstring(base64decode("NDhCRUVGM0YtQTc1RC00NTkxLTk0MDAtNDFBNzRFMTc0RDBC"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("QmFyYmFyaXQgSGl0"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.3,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzk2NTU3MzIyOTE="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("ODI0RTJGMjMtODAxNC00ODNELUFEMjAtM0E3ODQ3QjNFMUZB"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWFuZGEgSGl0"))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.4,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzk5NTQ4NjA2MDE="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.24,loadstring(base64decode("RGlzdA=="))():25,loadstring(base64decode("SWQ="))():loadstring(base64decode("N0Q5NkM0OUUtREFFNS00MjY5LTg4QjAtOUVDMTM0NzQ4NTZC"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("TWFuZGEgSGl0Mg=="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.4,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzk5NTU0NTY4Nzk="))()},{loadstring(base64decode("RW5hYmxlZA=="))():true,loadstring(base64decode("VHlwZQ=="))():loadstring(base64decode("QW5pbQ=="))(),loadstring(base64decode("RHVy"))():0.5,loadstring(base64decode("RGlzdA=="))():10,loadstring(base64decode("SWQ="))():loadstring(base64decode("NUIwRDE5REEtQjk1Qy00NkJCLTlEMjYtQThBM0Y1OTU0Qjgy"))(),loadstring(base64decode("T2JqUGFyZW50"))():loadstring(base64decode(""))(),loadstring(base64decode("TmFtZQ=="))():loadstring(base64decode("Q3JhdG9zIFN3aXA="))(),loadstring(base64decode("T2JqTmFtZQ=="))():loadstring(base64decode(""))(),loadstring(base64decode("SG9sZA=="))():true,loadstring(base64decode("S2V5"))():loadstring(base64decode(""))(),loadstring(base64decode("RGVsYXk="))():0.7,loadstring(base64decode("QW5pbUlk"))():loadstring(base64decode("cmJ4YXNzZXRpZDovLzY5OTk5MjMxNjA="))()}]]==]

    local function BuildDefaultList()
        local arr = {}
        local okJ, decoded = pcall(function() return HttpService:JSONDecode(DEFAULT_JSON) end)
        if okJ and type(decoded) == loadstring(base64decode("dGFibGU="))() then
            for _, s in ipairs(decoded) do
                if type(s) == loadstring(base64decode("dGFibGU="))() then table.insert(arr, SkillFromData(s, false)) end
            end
        end
        return arr
    end

    UI.RestoreDefaults = function()
        Profiles.Default = BuildDefaultList()
        SwitchProfile(loadstring(base64decode("RGVmYXVsdA=="))())
        SetStatus(loadstring(base64decode("UmVjb21tZW5kZWQgY29uZmlnIHJlc3RvcmVkIHRvIHRoZSBEZWZhdWx0IHByb2ZpbGUu"))())
    end

    -- ---------- Varsayılan config güncelleme bildirimi ----------
    -- true: kullanıcı reddetse bile config farklıysa her execute'ta sorar
    -- false: reddedilince, varsayılan liste değişene kadar tekrar sormaz
    local REMIND_EVERY_EXECUTE = false

    local function Fingerprint(s)
        local h = 5381
        for i = 1, #s do h = (h * 33 + s:byte(i)) % 4294967291 end
        return tostring(h)
    end
    local DEFAULT_FP = Fingerprint(DEFAULT_JSON)

    local function SameAsDefault(list)
        local def = BuildDefaultList()
        if #def ~= #list then return false end
        local byId = {}
        for _, s in ipairs(list) do byId[s.Id] = s end
        for _, d in ipairs(def) do
            local s = byId[d.Id]
            if not s then return false end
            if s.Name ~= d.Name or s.Enabled ~= d.Enabled or s.Type ~= d.Type or s.Dist ~= d.Dist
                or math.abs(s.Delay - d.Delay) > 0.001 or s.Hold ~= d.Hold or math.abs(s.Dur - d.Dur) > 0.001
                or s.Key ~= d.Key or s.ObjName ~= d.ObjName or s.ObjParent ~= d.ObjParent or s.AnimId ~= d.AnimId then
                return false
            end
        end
        return true
    end

    UI.ShowUpdatePrompt = function(onAccept, onDecline)
        local main = Window.Main
        local overlay = Create(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), {
            Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.4,
            Text = loadstring(base64decode(""))(), AutoButtonColor = false, ZIndex = 100, Parent = main,
        })
        Corner(overlay, 12)
        local card = Create(loadstring(base64decode("RnJhbWU="))(), {
            Size = UDim2.fromOffset(440, 308), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            BackgroundColor3 = Theme.Panel, BorderSizePixel = 0, ZIndex = 101, Parent = overlay,
        })
        Corner(card, 12)
        Stroke(card, Theme.Good)
        Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -170, 0, 24), Position = UDim2.new(0, 20, 0, 16), BackgroundTransparency = 1,
            Text = loadstring(base64decode("VXBkYXRlIGF2YWlsYWJsZQ=="))(), TextColor3 = Theme.Text, Font = Enum.Font.GothamBold, TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
        })
        local badge = Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(0, 112, 0, 20), Position = UDim2.new(1, -132, 0, 18), BorderSizePixel = 0,
            BackgroundColor3 = Theme.Good:Lerp(Theme.Panel, 0.75), Text = loadstring(base64decode("UkVDT01NRU5ERUQ="))(), TextColor3 = Theme.Good,
            Font = Enum.Font.GothamBold, TextSize = 10, Parent = card,
        })
        Corner(badge, 5)
        Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -40, 0, 40), Position = UDim2.new(0, 20, 0, 52), BackgroundTransparency = 1,
            Text = loadstring(base64decode("WW91ciBza2lsbCBjb25maWcgZGlmZmVycyBmcm9tIHRoZSBsYXRlc3QgZGVmYXVsdCBjb25maWcu"))(), TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham, TextSize = 13, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top, Parent = card,
        })
        local yes = MakeButton(card, loadstring(base64decode("VXBkYXRlIHRvIGRlZmF1bHQgY29uZmln"))(), Theme.Good, UDim2.new(1, -40, 0, 44), UDim2.new(0, 20, 0, 102))
        yes.TextColor3 = Color3.fromRGB(8, 34, 24)
        yes.TextSize = 14
        Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -40, 0, 52), Position = UDim2.new(0, 20, 0, 152), BackgroundTransparency = 1,
            Text = loadstring(base64decode("SWYgeW91IGFjY2VwdCwgeW91ciBEZWZhdWx0IHByb2ZpbGUgd2lsbCBiZSBzd2l0Y2hlZCB0byB0aGUgcmVjb21tZW5kZWQgZGVmYXVsdCBjb25maWcuIFlvdXIgY3VycmVudCBjb25maWcgaXMgc2F2ZWQgYXMgYSBiYWNrdXAgcHJvZmlsZS4="))(),
            TextColor3 = Theme.SubText, Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = card,
        })
        local no = MakeButton(card, loadstring(base64decode("S2VlcCBteSBjb25maWc="))(), Theme.Raised, UDim2.new(1, -40, 0, 36), UDim2.new(0, 20, 0, 212))
        Create(loadstring(base64decode("VGV4dExhYmVs"))(), {
            Size = UDim2.new(1, -40, 0, 30), Position = UDim2.new(0, 20, 0, 258), BackgroundTransparency = 1,
            Text = loadstring(base64decode("WW91IGNhbiBzd2l0Y2ggbGF0ZXIgZnJvbSBTZXR0aW5ncyA+IFJlc3RvcmUgcmVjb21tZW5kZWQgY29uZmlnLg=="))(), TextColor3 = Theme.Muted,
            Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top, Parent = card,
        })
        yes.MouseButton1Click:Connect(function() overlay:Destroy(); onAccept() end)
        no.MouseButton1Click:Connect(function() overlay:Destroy(); onDecline() end)
    end

    UI.CheckDefaults = function()
        if not Saved then return end                       -- ilk kurulum: zaten varsayılan
        local cur = Profiles.Default
        if not cur or SameAsDefault(cur) then return end
        if Config.DeclinedDefault == DEFAULT_FP and not REMIND_EVERY_EXECUTE then return end
        UI.ShowUpdatePrompt(function()
            local bname = loadstring(base64decode("QmFja3VwIA=="))() .. os.date(loadstring(base64decode("JWQuJW0gJUg6JU0="))())
            while Profiles[bname] do bname = bname .. loadstring(base64decode("Kw=="))() end
            Profiles[bname] = cur
            Profiles.Default = BuildDefaultList()
            Config.DeclinedDefault = loadstring(base64decode(""))()
            SwitchProfile(loadstring(base64decode("RGVmYXVsdA=="))())
            SetStatus(loadstring(base64decode("RGVmYXVsdCBjb25maWcgYXBwbGllZC4gQmFja3VwIHNhdmVkIGFzOiA="))() .. bname)
        end, function()
            Config.DeclinedDefault = DEFAULT_FP
            QueueSave()
        end)
    end

    local version = Saved and tonumber(Saved.Version) or 0
    if Saved then
        if type(Saved.Profiles) == loadstring(base64decode("dGFibGU="))() then
            for name, list in pairs(Saved.Profiles) do
                if type(name) == loadstring(base64decode("c3RyaW5n"))() then Profiles[name] = LoadList(list) end
            end
        else
            Profiles.Default = LoadList(Saved.Skills or (#Saved > 0 and Saved or nil))
        end
    end

    if not Saved then
        Profiles.Default = BuildDefaultList()
    elseif version < 7 then
        local old = Profiles.Default
        if old and #old > 0 then Profiles[loadstring(base64decode("T2xkIGNvbmZpZw=="))()] = old end
        Profiles.Default = BuildDefaultList()
        Saved.ActiveProfile = loadstring(base64decode("RGVmYXVsdA=="))()
    end
    if not Profiles.Default then Profiles.Default = {} end

    local active = Saved and Saved.ActiveProfile
    ActiveProfile = (type(active) == loadstring(base64decode("c3RyaW5n"))() and Profiles[active]) and active or loadstring(base64decode("RGVmYXVsdA=="))()
    Skills = Profiles[ActiveProfile]
    if UI.ProfileDropdown then UI.ProfileDropdown.Set(ActiveProfile) end
    for _, s in ipairs(Skills) do RenderSkillRow(s) end
    QueueSave()
end
ResortSkillList()
UpdateSkillHint()
ShowEmptyEditPanel()

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then HookSource(ParryStore, GetSource(player), ParryHandlers, false) end
end
SyncNpcs()

table.insert(Connections, Players.PlayerAdded:Connect(function(player)
    HookSource(ParryStore, GetSource(player), ParryHandlers, false)
    if Monitor.Target == loadstring(base64decode("Kg=="))() or Monitor.Target == player.Name then
        HookSource(MonitorStore, GetSource(player), MonitorHandlers, true)
    end
end))

table.insert(Connections, Players.PlayerRemoving:Connect(function(player)
    UnhookSource(ParryStore, player)
    UnhookSource(MonitorStore, player)
    local snapSrc = Sources[player]
    if snapSrc and snapSrc.Snap then
        pcall(function() snapSrc.Snap:Destroy() end)
        snapSrc.Snap = nil
        UI.SnapCount = math.max(0, (UI.SnapCount or 1) - 1)
    end
    Sources[player] = nil
    UpdateEngineStatus()
end))

table.insert(Connections, workspace.DescendantAdded:Connect(OnWorkspaceDescendant))

table.insert(Connections, LocalPlayer.CharacterAdded:Connect(HookLocalCharacter))
if LocalPlayer.Character then task.spawn(HookLocalCharacter, LocalPlayer.Character) end

-- Kıyafeti respawn'da / script 7GzvlMabüklenince geri giy
do
    local function Reapply(char)
        if not (Config.ClothingUI and Config.OutfitActive and Config.OutfitReapply and Config.Outfit ~= loadstring(base64decode(""))()) then return end
        local t0 = os.clock()
        while os.clock() - t0 < 6 do
            local ok, loaded = pcall(function() return LocalPlayer:HasAppearanceLoaded() end)
            if ok and loaded then break end
            task.wait(0.1)
        end
        task.wait(0.6)
        if LocalPlayer.Character == char then WearOutfit(Config.Outfit, true) end
    end

    table.insert(Connections, LocalPlayer.CharacterAdded:Connect(function(char)
        RemoveOutfit()
        task.spawn(Reapply, char)
    end))
    if LocalPlayer.Character then task.spawn(Reapply, LocalPlayer.Character) end
end

table.insert(Connections, UserInputService.InputBegan:Connect(function(input, processed)
    if Capturing or UserInputService:GetFocusedTextBox() then return end
    local kc = input.KeyCode
    if kc == Enum.KeyCode.Unknown then return end
    local ui = Config.UIKeybind
    local ctrlBind = (ui == Enum.KeyCode.RightControl or ui == Enum.KeyCode.LeftControl)
    local ctrlHit = ctrlBind and (kc == Enum.KeyCode.RightControl or kc == Enum.KeyCode.LeftControl)
    if kc == ui or ctrlHit then
        UI.ToggleMain()
    elseif Config.ToggleKey ~= Enum.KeyCode.Unknown and kc == Config.ToggleKey then
        SetEnabled(not Config.AutoParryEnabled)
    end
end))

do
    local acc, pollAcc = 0, 0
    table.insert(Connections, RunService.Heartbeat:Connect(function(dt)
        UpdatePreviewProgress()
        DebugTick()
                local okR, errR = pcall(StepRadars)
        if not okR then
            table.clear(ActiveRadars) -- bozuk işi temizle, kareler boyunca hata basmasın
            warn(loadstring(base64decode("W1ZleG9yYV0gU3RlcFJhZGFyczo="))(), errR)
        end
        pollAcc += dt
        if pollAcc >= 0.033 then
            pollAcc = 0
            pcall(PollAnimators)
        end
        acc += dt
        if acc < 0.3 then return end
        acc = 0
        if UI.CurTab == loadstring(base64decode("U2V0dGluZ3M="))() and Lic.UpdateLabel then Lic.UpdateLabel() end
        for id in pairs(Dirty) do
            Dirty[id] = nil
            local entry = Discovered[id]
            if entry then RefreshDiscoveredRow(entry) end
        end
    end))
end

-- Dil değişimi: kayıtlı tüm metinleri yeniden çevirir, dinamik metinleri yeniler
L.Refresh = function()
    L.Apply()
    if UI.CurTab then Window.SelectTab(UI.CurTab) end
    UpdateEngineStatus()
    ResortDiscoveredList()
    for _, s in ipairs(Skills) do RenderSkillRow(s) end
    for _, e in pairs(Discovered) do RefreshDiscoveredRow(e) end
    RefreshDiscoveredLinks()
    if SelectedSkillId then SelectSkill(SelectedSkillId) else ShowEmptyEditPanel() end
    if Lic.UpdateLabel then Lic.UpdateLabel() end
end

L.SetLang = function(name)
    L.Lang = name
    Config.Language = name
    L.Refresh()
    QueueSave()
end

Lic.UI = UI
if UI.SetSnow then UI.SetSnow(Config.Snow) end
Lic.UpdateLabel()
Lic.StartRecheck()

Window.SelectTab(loadstring(base64decode("QXV0by1QYXJyeQ=="))())
if UI.CheckDefaults then task.delay(0.6, UI.CheckDefaults) end
ResortDiscoveredList()
UpdateEngineStatus()
pcall(CreatePreviewDummy, nil)     -- önizleme boş görünmesin
SetStatus(string.format(L.T(loadstring(base64decode("TG9hZGVkLiAlcyA9IGhpZGUvc2hvdyBVSSwgJXMgPSB0b2dnbGUgQXV0by1QYXJyeS4="))()), Config.UIKeybind.Name, Config.ToggleKey.Name))

-- UNLOAD

_G.AutoParrySystem.Unload = function()
    Unloaded = true
    table.clear(ActiveRadars)
    DestroySnaps()
    Lic.Alive = false
    for _, conn in ipairs(Connections) do pcall(function() conn:Disconnect() end) end
    if LocalHealth.Conn then LocalHealth.Conn:Disconnect() end
    if LocalHealth.Anim then LocalHealth.Anim:Disconnect() end
    ReleaseParryKey()
    DebugClearAll()
    if Debug.Folder then pcall(function() Debug.Folder:Destroy() end) end
    RemoveOutfit()
    SetNpcs(false)
    for key in pairs(ParryStore) do UnhookSource(ParryStore, key) end
    for key in pairs(MonitorStore) do UnhookSource(MonitorStore, key) end
    DestroyPreviewDummy()
    if Window and Window.Gui then Window.Gui:Destroy() end
    _G.AutoParrySystem = nil
end
end
2vdhzzJr(PTRqY)
end)(...)
