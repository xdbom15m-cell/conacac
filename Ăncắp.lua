local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Auto Atom Max",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by You",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RayConfig",
        FileName = "AutoAtomMax"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Variables
local AutoRangeAtom = false
local AutoDanhThuong = false
local AutoPhePha = true
local SelectedTool = 2
local AutoEquipTools = false
local AutoNextArea = false

-- ==================== TOGGLE ====================

MainTab:CreateToggle({
    Name = "Auto Range Atom",
    CurrentValue = false,
    Flag = "AutoRangeAtom",
    Callback = function(Value)
        AutoRangeAtom = Value
        if Value then
            task.spawn(function()
                while AutoRangeAtom do
                    local atom = workspace:FindFirstChild("World Mobs") 
                        and workspace["World Mobs"]:FindFirstChild("Event Mobs") 
                        and workspace["World Mobs"]["Event Mobs"]:FindFirstChild("Atom Max")

                    if atom then
                        local hitbox = atom:FindFirstChild("Hitbox") or atom:FindFirstChild("HumanoidRootPart") or atom.PrimaryPart
                        if hitbox and hitbox:IsA("BasePart") then
                            hitbox.Size = Vector3.new(700, 700, 700)
                            hitbox.CanCollide = false
                            hitbox.Massless = true
                        end
                    end
                    task.wait(0.2)
                end
            end)
        end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Trình",
    CurrentValue = false,
    Flag = "AutoTrinh",
    Callback = function(Value)
        AutoDanhThuong = Value
        if Value then
            task.spawn(function()
                while AutoDanhThuong do
                    local args = {{ 
                        Camera = CFrame.new(74.2727279663086, 251.0009002685547, -28.747745513916016, -0.9511321783065796, -0.044049736112356186, 0.3056260347366333, 0, 0.9897724390029907, 0.14265543222427368, -0.308784157037735, 0.13568417727947235, -0.9414043426513672),
                        SkillId = "101",
                        Began = true,
                        CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961),
                        ["Typ\208\181"] = 1,
                        Aim = vector.create(70.45240020751953, 247.81771850585938, -66.98019409179688)
                    }}
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                    task.wait(0.1)
                end
            end)
        end
    end,
})

MainTab:CreateToggle({
    Name = "Auto đánh thường",
    CurrentValue = false,
    Flag = "AutoDanhThuong",
    Callback = function(Value)
        AutoDanhThuong = Value
        if Value then
            task.spawn(function()
                while AutoDanhThuong do
                    local args = {{ 
                        Camera = CFrame.new(74.2727279663086, 251.0009002685547, -28.747745513916016, -0.9511321783065796, -0.044049736112356186, 0.3056260347366333, 0, 0.9897724390029907, 0.14265543222427368, -0.308784157037735, 0.13568417727947235, -0.9414043426513672),
                        SkillId = "1",
                        Began = true,
                        CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961),
                        ["Typ\208\181"] = 1,
                        Aim = vector.create(70.45240020751953, 247.81771850585938, -66.98019409179688)
                    }}
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                    task.wait(0.25)
                end
            end)
        end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Phê Pha V2",
    CurrentValue = true,
    Flag = "AutoPhePhaV2",
    Callback = function(Value)
        AutoPhePha = Value
        if Value then
            task.spawn(function()
                while AutoPhePha do
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local charFolder = workspace:FindFirstChild("Characters")
                        if charFolder then
                            local char = charFolder:FindFirstChild(player.Name)
                            if char and not char:FindFirstChild("Mode") then
                                local args = {{
                                    Camera = CFrame.new(-28.790475845336914, 298.4656677246094, -91.82173156738281, 0.8630251884460449, 0.06684061139822006, -0.5007192492485046, 0, 0.9912075996398926, 0.1323155164718628, 0.5051608085632324, -0.11419162154197693, 0.855437159538269),
                                    SkillId = "10",
                                    Began = true,
                                    CFrame = CFrame.new(-20.313318252563477, 294.6113586425781, -106.30424499511719, 0.863025426864624, 0.06684055924415588, -0.5007189512252808, -8.083265612413015e-09, 0.9912076592445374, 0.1323154717683792, 0.5051605105400085, -0.11419161409139633, 0.8554373979568481),
                                    ["Typ\208\181"] = 1,
                                    Aim = vector.create(4.722629547119141, 287.9955749511719, -149.07611083984375)
                                }}
                                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                            end
                        end
                    end)
                    task.wait(1.5)
                end
            end)
        end
    end,
})

MainTab:CreateDropdown({
    Name = "Auto EquipTools DLS",
    Options = {"1", "2", "3", "4", "5", "6"},
    CurrentOption = {"2"},
    Flag = "EquipToolDropdown",
    Callback = function(Options)
        SelectedTool = tonumber(Options[1])
    end,
})

MainTab:CreateToggle({
    Name = "Auto EquipTools",
    CurrentValue = false,
    Flag = "AutoEquipTools",
    Callback = function(Value)
        AutoEquipTools = Value
        if Value then
            task.spawn(function()
                while AutoEquipTools do
                    pcall(function()
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Packages")
                            :WaitForChild("_Index")
                            :WaitForChild("sleitnick_knit@1.4.7")
                            :WaitForChild("knit")
                            :WaitForChild("Services")
                            :WaitForChild("ToolService")
                            :WaitForChild("RE")
                            :WaitForChild("UpdatePlayerToolbarSelection")
                            :FireServer(SelectedTool)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end,
})

local AutoNextArea = false

MainTab:CreateToggle({
    Name = "Auto NextArea",
    CurrentValue = false,
    Flag = "AutoNextArea",
    Callback = function(Value)
        AutoNextArea = Value

        if Value then
            task.spawn(function()
                while AutoNextArea do
                    pcall(function()
                        local stage = workspace:FindFirstChild("Dungeon")
                            and workspace.Dungeon:FindFirstChild("Stages")
                            and workspace.Dungeon.Stages:FindFirstChild("0")

                        if stage then
                            local nextArea = stage:FindFirstChild("NextArea")
                            local container = nextArea and nextArea:FindFirstChild("Container")

                            if container and container:GetChildren()[4] then
                                local prompt = nextArea.Part.Attachment:FindFirstChild("ProximityPrompt")
                                if prompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end)

                    task.wait(0.2)
                end
            end)
        end
    end
})
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Cập nhật character khi respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    hrp = newChar:WaitForChild("HumanoidRootPart")
end)

local AutoGodmode = false
local mainConnection

local HEIGHT_ABOVE = 14

MainTab:CreateToggle({
    Name = "Auto Skill + Godmode V2 (Chạy Liên Tục)",
    CurrentValue = false,
    Flag = "AutoGodmodeV2",
    Callback = function(Value)
        AutoGodmode = Value
        
        if Value then
            mainConnection = RunService.Heartbeat:Connect(function()
                if not AutoGodmode then return end
                if not hrp or not hrp.Parent then return end
                
                local bossFolder = workspace:FindFirstChild("World Mobs") 
                                  and workspace["World Mobs"]:FindFirstChild("Event Mobs")
                
                if not bossFolder then return end
                
                -- Tìm boss gần nhất (chỉ boss còn sống)
                local closestBoss = nil
                local closestDist = math.huge
                
                for _, mob in ipairs(bossFolder:GetChildren()) do
                    local humanoid = mob:FindFirstChild("Humanoid")
                    local root = mob:FindFirstChild("HumanoidRootPart")
                    if root and humanoid and humanoid.Health > 0 then
                        local dist = (hrp.Position - root.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestBoss = mob
                        end
                    end
                end
                
                if not closestBoss or not closestBoss:FindFirstChild("HumanoidRootPart") then
                    return
                end
                
                local bossHRP = closestBoss.HumanoidRootPart
                local targetPos = bossHRP.Position + Vector3.new(0, HEIGHT_ABOVE, 0)
                
                -- Fix rơi + giật mạnh
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                
                -- Tween mượt
                local tweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                local tween = TweenService:Create(hrp, tweenInfo, {
                    CFrame = CFrame.new(targetPos, bossHRP.Position)
                })
                tween:Play()
                
                -- Auto Skill chỉ khi gần
                if closestDist <= 30 then
                    local args = {
                        "Weapons_20_3",
                        {
                            TargetPos = Vector3.new(-409.91522216796875, 1356.2965087890625, 95.83793640136719)
                        },
                        18
                    }
                    pcall(function()
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Packages")
                            :WaitForChild("_Index")
                            :WaitForChild("sleitnick_knit@1.4.7")
                            :WaitForChild("knit")
                            :WaitForChild("Services")
                            :WaitForChild("SkillManagerV2")
                            :WaitForChild("RE")
                            :WaitForChild("ExecuteSkill"):FireServer(unpack(args))
                    end)
                end
            end)
        else
            if mainConnection then
                mainConnection:Disconnect()
                mainConnection = nil
            end
        end
    end
})
local AutoStartDungeon = false

MainTab:CreateToggle({
    Name = "Auto StartDungeon Atom Max",
    CurrentValue = false,
    Flag = "AutoStartDungeonAtomMax",
    Callback = function(Value)
        AutoStartDungeon = Value

        if Value then
            task.spawn(function()
                local StartDungeon = game:GetService("ReplicatedStorage")
                    :WaitForChild("Packages")
                    :WaitForChild("_Index")
                    :WaitForChild("sleitnick_knit@1.4.7")
                    :WaitForChild("knit")
                    :WaitForChild("Services")
                    :WaitForChild("DungeonLobbyService")
                    :WaitForChild("RF")
                    :WaitForChild("StartDungeon")

                local waiting = false

                while AutoStartDungeon do
                    pcall(function()
                        local atom = workspace:FindFirstChild("World Mobs")
                            and workspace["World Mobs"]:FindFirstChild("Event Mobs")
                            and workspace["World Mobs"]["Event Mobs"]:FindFirstChild("Atom Max")

                        if atom and not waiting then
                            local hum = atom:FindFirstChild("Humanoid")

                            if hum and hum.MaxHealth > 0 and hum.Health >= hum.MaxHealth then
                                waiting = true

                                repeat
                                    task.wait(0.2)
                                until not AutoStartDungeon
                                    or not hum.Parent
                                    or hum.Health <= 0

                                if AutoStartDungeon then
                                    task.wait(2.8)
                                    pcall(function()
                                        StartDungeon:InvokeServer()
                                    end)
                                end

                                waiting = false
                            end
                        end
                    end)

                    task.wait(0.2)
                end
            end)
        end
    end
})
local AutoMode = false

MainTab:CreateToggle({
    Name = "Auto Mode",
    CurrentValue = false,
    Flag = "AutoMode",
    Callback = function(Value)
        AutoMode = Value

        if Value then
            task.spawn(function()
                while AutoMode do
                    pcall(function()
                        local Players = game:GetService("Players")
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")

                        local player = Players.LocalPlayer
                        local char = workspace:WaitForChild("Characters"):FindFirstChild(player.Name)

                        if char and not char:FindFirstChild("Mode") then
                            local args = {
                                [1] = {
                                    ["Camera"] = CFrame.new(-245.3279571533203, 38.8448486328125, 55.62938690185547, 0.7663952708244324, 0.2027481198310852, -0.6095338463783264, 0, 0.9488838911056519, 0.31562548875808716, 0.642369270324707, -0.24189388751983643, 0.7272201180458069),
                                    ["SkillId"] = "10",
                                    ["Began"] = true,
                                    ["CFrame"] = CFrame.new(-237.7087860107422, 33.199527740478516, 46.53913497924805, 0.4414682388305664, -5.453785867359784e-09, -0.8972768783569336, -1.12957136977343e-08, 1, -1.1635744812110715e-08, 0.8972768783569336, 1.5272194175963705e-08, 0.4414682388305664),
                                    ["Typе"] = 1,
                                    ["Aim"] = Vector3.new(-192.84494018554688, 33.199527740478516, 24.465723037719727)
                                }
                            }

                            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                        end
                    end)

                    task.wait(0.5)
                end
            end)
        end
    end
})
local AutoLockAtom = false

MainTab:CreateToggle({
    Name = "Auto Lock Atom",
    CurrentValue = false,
    Flag = "AutoLockAtom",
    Callback = function(Value)
        AutoLockAtom = Value

        if Value then
            task.spawn(function()
                while AutoLockAtom do
                    pcall(function()
                        local atom = workspace:FindFirstChild("World Mobs")
                            and workspace["World Mobs"]:FindFirstChild("Event Mobs")
                            and workspace["World Mobs"]["Event Mobs"]:FindFirstChild("Atom Max")

                        if atom then
                            game:GetService("ReplicatedStorage")
                                :WaitForChild("Packages")
                                :WaitForChild("_Index")
                                :WaitForChild("sleitnick_knit@1.4.7")
                                :WaitForChild("knit")
                                :WaitForChild("Services")
                                :WaitForChild("SkillManager")
                                :WaitForChild("RE")
                                :WaitForChild("LockedOnChanged")
                                :FireServer(atom)
                        end
                    end)

                    task.wait(0.2)
                end
            end)
        end
    end,
})
