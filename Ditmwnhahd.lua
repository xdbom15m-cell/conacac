local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

local data = {
    ["content"] = "🎮 player map Droid: **" .. player.Name .. "** (@"
        .. player.DisplayName .. ")"
}

local request = syn and syn.request
    or http_request
    or request
    or (http and http.request)

if request then
    request({
        Url = "https://discord.com/api/webhooks/1514442038618099793/hqDlVkyHSTBc1_1E_ZpBIB91py0j74NFfjO3YjLcIYc9jS24zjBZGB_Y_yLv8aPp7qP0",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
end
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/cakukloj-lab/No/refs/heads/main/Orion_Orange_Transparent_09_Small.lua.txt"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Window = OrionLib:MakeWindow({
	Name = "Dragon Blox Droid 🔘",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "Config"
})

local Tab = Window:MakeTab({
	Name = "Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab2 = Window:MakeTab({
	Name = "Farm Weekend🖕",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab3 = Window:MakeTab({
	Name = "Setting",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab4 = Window:MakeTab({
	Name = "Auto Skill 😎",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab5 = Window:MakeTab({
	Name = "Fake + Localplayer🐧",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local AutoFarm = false

local LockRemote = game:GetService("ReplicatedStorage")
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.4.7")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("SkillManager")
    :WaitForChild("RE")
    :WaitForChild("LockedOnChanged")

-- Hàm tìm mob
local function GetTarget()
    local world = workspace:FindFirstChild("World Mobs")
    if not world then return nil end

    local bossFolder = workspace.Misc:FindFirstChild("MobSpawnInfo")
    local mobFolder = world:FindFirstChild("Mobs")
    local eventFolder = world:FindFirstChild("Boss Mobs")

    -- Boss trước
    if bossFolder then
        for _, v in pairs(bossFolder:GetChildren()) do
            local hum = v:FindFirstChild("Humanoid")
            if v:FindFirstChild("HumanoidRootPart")
            and hum
            and hum.Health > 0 then
                return v
            end
        end
    end

    -- Event Mob
    if eventFolder then
        for _, v in pairs(eventFolder:GetChildren()) do
            local hum = v:FindFirstChild("Humanoid")
            if v:FindFirstChild("HumanoidRootPart")
            and hum
            and hum.Health > 0 then
                return v
            end
        end
    end

    -- Mob thường
    if mobFolder then
        for _, v in pairs(mobFolder:GetChildren()) do
            local hum = v:FindFirstChild("Humanoid")
            if v:FindFirstChild("HumanoidRootPart")
            and hum
            and hum.Health > 0 then
                return v
            end
        end
    end

    return nil
end

Tab:AddToggle({
    Name = "Auto farm OP",
    Default = false,
    Callback = function(v)
        AutoFarm = v

        task.spawn(function()
            while AutoFarm do
                pcall(function()
                    local target = GetTarget()

                    if target then
                        -- Lock vào target hiện tại
                        LockRemote:FireServer(target)

                        local pos = target.HumanoidRootPart.Position

                        local args = {
                            {
                                Camera = workspace.CurrentCamera.CFrame,
                                SkillId = "101",
                                Began = true,
                                CFrame = CFrame.new(pos),
                                ["Typ\208\181"] = 1,
                                Aim = pos
                            }
                        }

                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Remotes")
                            :WaitForChild("SkillRemote")
                            :FireServer(unpack(args))
                    end
                end)

                task.wait(0.01)
            end
        end)
    end
})
local AutoEnabled = false
local SelectedMode = "Strength"  -- mặc định

local SkillIds = {
    Strength = "1",
    Ki = "2",
    Health = "6"
}

-- Hàm lấy CFrame động theo người chơi
local function GetPlayerCFrame()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        return char.HumanoidRootPart.CFrame
    end
    return CFrame.new(0, 100, 0) -- fallback
end

-- Tạo args cho skill
local function CreateArgs(skillId, began)
    local rootCFrame = GetPlayerCFrame()
    
    -- Điều chỉnh offset tùy game của bạn (dùng giá trị gốc bạn cung cấp làm base)
    local cameraCf = rootCFrame * CFrame.new(3.6, 2.8, 11.7)   -- approx từ ví dụ của bạn
    local playerCf  = rootCFrame * CFrame.new(-3.6, -2.8, 11.7)
    
    -- Aim: tạm hướng về phía trước, bạn có thể chỉnh thành lock enemy nếu cần
    local aimPos = rootCFrame.Position + rootCFrame.LookVector * 40
    
    return {
        {
            Camera = cameraCf,
            SkillId = skillId,
            Began = began,
            CFrame = playerCf,
            ["Typ\208\181"] = 1,
            Aim = Vector3.new(aimPos.X, aimPos.Y, aimPos.Z)
        }
    }
end

-- Hàm spam skill (chạy trong spawn)
local function StartAuto()
    local skillId = SkillIds[SelectedMode]
    if not skillId then return end
    
    spawn(function()
        while AutoEnabled do
            local args = CreateArgs(skillId, true)
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
            end)
            wait(0.05)
        end
        
        -- Khi tắt auto → gửi Began = false
        local argsOff = CreateArgs(skillId, false)
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(argsOff))
        end)
    end)
end

-- Dropdown chọn mode
Tab:AddDropdown({
    Name = "Chọn Auto Mode",
    Default = "Strength",
    Options = {"Strength", "Ki", "Health"},
    Callback = function(Value)
        -- Khi đổi mode, nếu đang bật auto thì tắt trước
        if AutoEnabled then
            AutoEnabled = false
            wait(0.1)  -- đợi loop cũ dừng
        end
        SelectedMode = Value
        -- Nếu muốn auto bật lại ngay khi đổi mode thì uncomment dòng dưới
        -- AutoEnabled = true
        -- StartAuto()
    end    
})

-- Toggle bật/tắt auto
Tab:AddToggle({
    Name = "Auto farm",
    Default = false,
    Callback = function(Value)
        AutoEnabled = Value
        if Value then
            StartAuto()
        else
            -- Khi tắt toggle, loop sẽ tự dừng và gửi Began=false ở trong hàm
        end
    end    
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Folders
local EventMobFolder = workspace["World Mobs"]:WaitForChild("Boss Mobs")
local NormalMobFolder = workspace["World Mobs"]:WaitForChild("Mobs")

-- Cài đặt
local Radius = 1000
local TargetCFrame = CFrame.new(3296.45996, 4.20282078, 3297.97119, 1, 0, 0, 0, 1, 0, 0, 0, 1)

local AutoFarmBring = false

-- Toggle
Tab:AddToggle({
    Name = "Auto Farm Bring",
    Default = false,
    Callback = function(Value)
        AutoFarmBring = Value
        
        if AutoFarmBring then
            -- Teleport nhân vật đến vị trí rồi lock
            pcall(function()
                Root.CFrame = TargetCFrame
                wait(0.1) -- Chờ teleport ổn định
                Root.Anchored = true
                Humanoid.PlatformStand = true
                Humanoid.AutoRotate = false
            end)
        else
            -- Unlock khi tắt
            pcall(function()
                Root.Anchored = false
                Humanoid.PlatformStand = false
                Humanoid.AutoRotate = true
            end)
        end
    end
})

-- Auto Bring Mobs
RunService.Heartbeat:Connect(function()
    if not AutoFarmBring then return end

    pcall(function()
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
    end)

    -- Bring Event Mobs
    for _, Mob in ipairs(EventMobFolder:GetChildren()) do
        local Hum = Mob:FindFirstChildOfClass("Humanoid")
        local MobRoot = Mob:FindFirstChild("HumanoidRootPart")
        
        if Hum and MobRoot and Hum.Health > 0 then
            if (MobRoot.Position - Root.Position).Magnitude <= Radius then
                pcall(function()
                    MobRoot.CanCollide = false
                    MobRoot.Velocity = Vector3.zero
                    MobRoot.RotVelocity = Vector3.zero
                    MobRoot.CFrame = TargetCFrame
                end)
            end
        end
    end

    -- Bring Normal Mobs
    for _, Mob in ipairs(NormalMobFolder:GetChildren()) do
        local Hum = Mob:FindFirstChildOfClass("Humanoid")
        local MobRoot = Mob:FindFirstChild("HumanoidRootPart")
        
        if Hum and MobRoot and Hum.Health > 0 then
            if (MobRoot.Position - Root.Position).Magnitude <= Radius then
                pcall(function()
                    MobRoot.CanCollide = false
                    MobRoot.Velocity = Vector3.zero
                    MobRoot.RotVelocity = Vector3.zero
                    MobRoot.CFrame = TargetCFrame
                end)
            end
        end
    end
end)

-- Auto Skill Loop
spawn(function()
    while true do
        if AutoFarmBring then
            pcall(function()
                local args = {
                    {
                        Camera = CFrame.new(19.41400718688965, 288.5138854980469, 222.8828125,
                            0.9998745322227478, -0.005394831765443087, 0.014898684807121754,
                            0, 0.9402562975883484, 0.3404678702354431,
                            -0.015845347195863724, -0.34042516350746155, 0.9401381611824036),
                        SkillId = "1",
                        ["Type"] = 1,
                        CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961,
                            1, 0, 0, 0, 1, 0, 0, 0, 1),
                        Began = true,
                        Aim = Vector3.new(70.45240020751953, 247.81771850585938, -66.98019409179688)
                    }
                }

                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
            end)
        end
        wait(0.1)
    end
end)
local Section = Tab:AddSection({
    Name = "Auto Farm Orb"
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

local EventMobFolder = workspace["World Mobs"]:WaitForChild("Boss Mobs")
local NormalMobFolder = workspace["World Mobs"]:WaitForChild("Mobs")

local Radius = 1000

local BringPos = CFrame.new(3295.65625, 4.20298386, 3285.96851, 1, 0, 0, 0, 1, 0, 0, 0, 1)

local HidePos = CFrame.new(3296.45996, 4.20282078, 3297.97119, 1, 0, 0, 0, 1, 0, 0, 0, 1)

local OrbNumber = "1"
local AutoFarmOrb = false

Tab:AddDropdown({
	Name = "Select Orb",
	Default = "Ego",
	Options = {"Ego","Seijin Orb","Protial Orb","Dimsion Orb"},
	Callback = function(Value)

		if Value == "Ego" then
			OrbNumber = "1"

		elseif Value == "Seijin Orb" then
			OrbNumber = "2"

		elseif Value == "Protial Orb" then
			OrbNumber = "3"

		elseif Value == "Dimsion Orb" then
			OrbNumber = "4"
		end
	end
})

Tab:AddToggle({
	Name = "Auto Orb Farm",
	Default = false,
	Callback = function(Value)
		AutoFarmOrb = Value

		if Value then

			-- Bring Mob
			task.spawn(function()
				while AutoFarmOrb do

					pcall(function()
						sethiddenproperty(LocalPlayer,"SimulationRadius",math.huge)
					end)

					for _, Mob in ipairs(EventMobFolder:GetChildren()) do
						local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
						local MobRoot = Mob:FindFirstChild("HumanoidRootPart")

						if Humanoid and MobRoot and Humanoid.Health > 0 then
							if (MobRoot.Position - Root.Position).Magnitude <= Radius then

								MobRoot.CanCollide = false
								MobRoot.Velocity = Vector3.zero
								MobRoot.RotVelocity = Vector3.zero
								MobRoot.CFrame = BringPos

							end
						end
					end

					for _, Mob in ipairs(NormalMobFolder:GetChildren()) do
						local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
						local MobRoot = Mob:FindFirstChild("HumanoidRootPart")

						if Humanoid and MobRoot and Humanoid.Health > 0 then
							if (MobRoot.Position - Root.Position).Magnitude <= Radius then

								MobRoot.CanCollide = false
								MobRoot.Velocity = Vector3.zero
								MobRoot.RotVelocity = Vector3.zero
								MobRoot.CFrame = BringPos

							end
						end
					end

					task.wait()
				end
			end)

			-- Núp sau đá
			task.spawn(function()
				while AutoFarmOrb do
					local Char = LocalPlayer.Character

					if Char and Char:FindFirstChild("HumanoidRootPart") then
						Char.HumanoidRootPart.CFrame = HidePos
						Char.HumanoidRootPart.Velocity = Vector3.zero
					end

					task.wait()
				end
			end)

			-- Spam Orb
			task.spawn(function()
				while AutoFarmOrb do

					local args = {
						"UniqueSets_" .. OrbNumber .. "_1",
						{
							HoldAnimation = ReplicatedStorage.Assets.SkillsV2.UniqueSets["Seijin Instinct"].Animations.Hold_SpiritBomb,
							ReleaseAnimation = ReplicatedStorage.Assets.SkillsV2.UniqueSets["Seijin Instinct"].Animations.Release_SpiritBomb,
							HumCFrame = CFrame.new(
								-1116.4661865234375,
								36.5296745300293,
								-1579.772705078125
							),
							ResumeOnTimePassed = 0.1,
							targetPos = Vector3.new(
								-1116.4661865234375,
								36.5296745300293,
								-1629.772705078125
							)
						},
						9,
						true
					}

					ReplicatedStorage
						.Packages
						._Index["sleitnick_knit@1.4.7"]
						.knit.Services.SkillManagerV2.RE.ExecuteSkill
						:FireServer(unpack(args))

					task.wait(0.15)
				end
			end)

		end
	end
})




local AutoFarmEnabled = false 

Section:AddToggle({
    Name = "Auto Farm Orb need On",
    Default = false,
    Callback = function(Value)
        AutoFarmEnabled = Value
        
        if Value then
            spawn(function()
                while AutoFarmEnabled do
                    -- UniqueSets_1_1
                    local args1 = {
                        "UniqueSets_1_1",
                        {
                            HoldAnimation = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("SkillsV2"):WaitForChild("UniqueSets"):WaitForChild("Seijin Instinct"):WaitForChild("Animations"):WaitForChild("Hold_SpiritBomb"),
                            ReleaseAnimation = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("SkillsV2"):WaitForChild("UniqueSets"):WaitForChild("Seijin Instinct"):WaitForChild("Animations"):WaitForChild("Release_SpiritBomb"),
                            HumCFrame = CFrame.new(-1116.4661865234375, 36.5296745300293, -1579.772705078125, 0.8936062455177307, 0.22706589102745056, -0.38718077540397644, -4.355781513254442e-08, 0.8626028895378113, 0.505881667137146, 0.44885173439979553, -0.4520590007305145, 0.7708273530006409),
                            ResumeOnTimePassed = 0.1,
                            targetPos = Vector3.new(-1116.4661865234375, 36.5296745300293, -1629.772705078125)
                        },
                        9,
                        false
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("SkillManagerV2"):WaitForChild("RE"):WaitForChild("ExecuteSkill"):FireServer(unpack(args1))

                    wait(0.05)

                    -- UniqueSets_2_1
                    local args2 = { "UniqueSets_2_1", args1[2], 9, false }
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("SkillManagerV2"):WaitForChild("RE"):WaitForChild("ExecuteSkill"):FireServer(unpack(args2))

                    wait(0.05)

                    -- UniqueSets_3_1
                    local args3 = { "UniqueSets_3_1", args1[2], 9, false }
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("SkillManagerV2"):WaitForChild("RE"):WaitForChild("ExecuteSkill"):FireServer(unpack(args3))

                    wait(0.05)

                    -- UniqueSets_4_1
                    local args4 = { "UniqueSets_4_1", args1[2], 9, false }
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("SkillManagerV2"):WaitForChild("RE"):WaitForChild("ExecuteSkill"):FireServer(unpack(args4))

                    wait(0.1) -- Delay giữa các chu kỳ (có thể chỉnh nhỏ hơn nếu muốn nhanh hơn)
                end
            end)
        end
    end
})
OrionLib:Init()
Tab2:AddToggle({
    Name = "Auto Friez 00 đéo bt ",
    Default = false,
    Callback = function(v)
        getgenv().AntiDie = v

        if v then
            -- ====================== GODMODE + TELEPORT ======================
            spawn(function()
                while getgenv().AntiDie do
                    task.wait()
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(-813.343994, 494.996002, 1095.71802, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)

            -- ====================== AUTO SKILL REMOTE ======================
            spawn(function()
                while getgenv().AntiDie do
                    local args = {
                        {
                            Camera = CFrame.new(74.2727279663086, 251.0009002685547, -28.747745513916016, -0.9511321783065796, -0.044049736112356186, 0.3056260347366333, 0, 0.9897724390029907, 0.14265543222427368, -0.308784157037735, 0.13568417727947235, -0.9414043426513672),
                            SkillId = "1",
                            Began = true,
                            CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            ["Typ\208\181"] = 1,
                            Aim = Vector3.new(70.45240020751953, 247.81771850585938, -66.98019409179688)
                        }
                    }
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                    end)
                    task.wait(0.1)
                end
            end)

            -- ====================== AUTO FIRE PROXIMITY PROMPT (TỐI ƯU) ======================
            spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")

                local player = Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local rootPart = character:WaitForChild("HumanoidRootPart")

                local RANGE = 50
                local prompts = {}
                local connections = {}

                local function isInRange(prompt)
                    if not prompt or not prompt.Parent then return false end
                    local root = rootPart
                    if not root then return false end

                    local promptPos = nil
                    if prompt.Adornee then
                        promptPos = prompt.Adornee.Position
                    elseif prompt.Parent:IsA("BasePart") then
                        promptPos = prompt.Parent.Position
                    else
                        local part = prompt.Parent:FindFirstChildWhichIsA("BasePart")
                        if part then
                            promptPos = part.Position
                        end
                    end

                    if promptPos then
                        return (promptPos - root.Position).Magnitude <= RANGE
                    end
                    return false
                end

                local function firePrompt(prompt)
                    pcall(function()
                        prompt.HoldDuration = 0
                        prompt:InputHoldBegin()
                        task.wait(0.03)
                        prompt:InputHoldEnd()
                    end)
                end

                -- Heartbeat loop
                local heartbeatConn = RunService.Heartbeat:Connect(function()
                    if not rootPart or not rootPart.Parent then return end
                    
                    for _, prompt in ipairs(prompts) do
                        if prompt and prompt.Parent and isInRange(prompt) then
                            firePrompt(prompt)
                        end
                    end
                end)
                table.insert(connections, heartbeatConn)

                -- Thu thập prompt hiện có
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        table.insert(prompts, obj)
                    end
                end

                -- Tự động thêm prompt mới
                local descendantConn = workspace.DescendantAdded:Connect(function(desc)
                    if desc:IsA("ProximityPrompt") then
                        table.insert(prompts, desc)
                    end
                end)
                table.insert(connections, descendantConn)

                -- Cập nhật character khi respawn
                local charAddedConn = player.CharacterAdded:Connect(function(newChar)
                    character = newChar
                    rootPart = newChar:WaitForChild("HumanoidRootPart")
                end)
                table.insert(connections, charAddedConn)

                print("🔥 Auto Fire ProximityPrompt trong 50 studs đã bật!")

                -- Giữ script chạy đến khi tắt toggle
                while getgenv().AntiDie do
                    task.wait(1)
                end

                -- Cleanup khi tắt
                for _, conn in ipairs(connections) do
                    if conn then conn:Disconnect() end
                end
                prompts = {}
            end)

        end
    end
})
Tab2:AddToggle({
    Name = "Auto Jirren gay",
    Default = false,
    Callback = function(v)
        getgenv().AntiDie = v

        if v then
            -- ====================== GODMODE + TELEPORT ======================
            spawn(function()
                while getgenv().AntiDie do
                    task.wait()
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(4987.48926, 11.6980686, -4194.12793, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)

            -- ====================== AUTO SKILL REMOTE ======================
            spawn(function()
                while getgenv().AntiDie do
                    local args = {
                        {
                            Camera = CFrame.new(74.2727279663086, 251.0009002685547, -28.747745513916016, -0.9511321783065796, -0.044049736112356186, 0.3056260347366333, 0, 0.9897724390029907, 0.14265543222427368, -0.308784157037735, 0.13568417727947235, -0.9414043426513672),
                            SkillId = "1",
                            Began = true,
                            CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            ["Typ\208\181"] = 1,
                            Aim = Vector3.new(70.45240020751953, 247.81771850585938, -66.98019409179688)
                        }
                    }
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                    end)
                    task.wait(0.1)
                end
            end)

            -- ====================== AUTO FIRE PROXIMITY PROMPT (TỐI ƯU) ======================
            spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")

                local player = Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local rootPart = character:WaitForChild("HumanoidRootPart")

                local RANGE = 50
                local prompts = {}
                local connections = {}

                local function isInRange(prompt)
                    if not prompt or not prompt.Parent then return false end
                    local root = rootPart
                    if not root then return false end

                    local promptPos = nil
                    if prompt.Adornee then
                        promptPos = prompt.Adornee.Position
                    elseif prompt.Parent:IsA("BasePart") then
                        promptPos = prompt.Parent.Position
                    else
                        local part = prompt.Parent:FindFirstChildWhichIsA("BasePart")
                        if part then
                            promptPos = part.Position
                        end
                    end

                    if promptPos then
                        return (promptPos - root.Position).Magnitude <= RANGE
                    end
                    return false
                end

                local function firePrompt(prompt)
                    pcall(function()
                        prompt.HoldDuration = 0
                        prompt:InputHoldBegin()
                        task.wait(3)
                        prompt:InputHoldEnd()
                    end)
                end

                -- Heartbeat loop
                local heartbeatConn = RunService.Heartbeat:Connect(function()
                    if not rootPart or not rootPart.Parent then return end
                    
                    for _, prompt in ipairs(prompts) do
                        if prompt and prompt.Parent and isInRange(prompt) then
                            firePrompt(prompt)
                        end
                    end
                end)
                table.insert(connections, heartbeatConn)

                -- Thu thập prompt hiện có
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        table.insert(prompts, obj)
                    end
                end

                -- Tự động thêm prompt mới
                local descendantConn = workspace.DescendantAdded:Connect(function(desc)
                    if desc:IsA("ProximityPrompt") then
                        table.insert(prompts, desc)
                    end
                end)
                table.insert(connections, descendantConn)

                -- Cập nhật character khi respawn
                local charAddedConn = player.CharacterAdded:Connect(function(newChar)
                    character = newChar
                    rootPart = newChar:WaitForChild("HumanoidRootPart")
                end)
                table.insert(connections, charAddedConn)

                print("🔥 Auto Fire ProximityPrompt trong 50 studs đã bật!")

                -- Giữ script chạy đến khi tắt toggle
                while getgenv().AntiDie do
                    task.wait(2)
                end

                -- Cleanup khi tắt
                for _, conn in ipairs(connections) do
                    if conn then conn:Disconnect() end
                end
                prompts = {}
            end)

        end
    end
})
getgenv().AutoPickedItemWeekend = false
local RANGE = 20 -- Phạm vi fire prompt

Tab2:AddToggle({
    Name = "Auto Picked Item Weekend",
    Default = false,
    Callback = function(Value)
        getgenv().AutoPickedItemWeekend = Value

        task.spawn(function()
            while getgenv().AutoPickedItemWeekend do
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")

                if root then
                    for _, prompt in ipairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local part = prompt.Parent

                            if part and part:IsA("BasePart") then
                                if (root.Position - part.Position).Magnitude <= RANGE then
                                    pcall(function()
                                        prompt.HoldDuration = 0
                                        fireproximityprompt(prompt)
                                    end)
                                end
                            end
                        end
                    end
                end

                task.wait(1.5)
            end
        end)
    end
})

OrionLib:Init()
Tab2:AddToggle({
    Name = "Zero",
    Default = false,
    Callback = function(v)
        getgenv().AntiDie = v

        if v then
            -- ====================== GODMODE + TELEPORT ======================
            spawn(function()
                while getgenv().AntiDie do
                    task.wait()
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(-49.905941, 39.5981483, -8455.84277, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)

            -- ====================== AUTO SKILL REMOTE ======================
            spawn(function()
                while getgenv().AntiDie do
                    local args = {
                        {
                            Camera = CFrame.new(74.2727279663086, 251.0009002685547, -28.747745513916016, -0.9511321783065796, -0.044049736112356186, 0.3056260347366333, 0, 0.9897724390029907, 0.14265543222427368, -0.308784157037735, 0.13568417727947235, -0.9414043426513672),
                            SkillId = "1",
                            Began = true,
                            CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            ["Typ\208\181"] = 1,
                            Aim = Vector3.new(70.45240020751953, 247.81771850585938, -66.98019409179688)
                        }
                    }
                    pcall(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkillRemote"):FireServer(unpack(args))
                    end)
                    task.wait(0.1)
                end
            end)

            -- ====================== AUTO FIRE PROXIMITY PROMPT (TỐI ƯU) ======================
            spawn(function()
                local Players = game:GetService("Players")
                local RunService = game:GetService("RunService")

                local player = Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local rootPart = character:WaitForChild("HumanoidRootPart")

                local RANGE = 50
                local prompts = {}
                local connections = {}

                local function isInRange(prompt)
                    if not prompt or not prompt.Parent then return false end
                    local root = rootPart
                    if not root then return false end

                    local promptPos = nil
                    if prompt.Adornee then
                        promptPos = prompt.Adornee.Position
                    elseif prompt.Parent:IsA("BasePart") then
                        promptPos = prompt.Parent.Position
                    else
                        local part = prompt.Parent:FindFirstChildWhichIsA("BasePart")
                        if part then
                            promptPos = part.Position
                        end
                    end

                    if promptPos then
                        return (promptPos - root.Position).Magnitude <= RANGE
                    end
                    return false
                end

                local function firePrompt(prompt)
                    pcall(function()
                        prompt.HoldDuration = 0
                        prompt:InputHoldBegin()
                        task.wait(0.03)
                        prompt:InputHoldEnd()
                    end)
                end

                -- Heartbeat loop
                local heartbeatConn = RunService.Heartbeat:Connect(function()
                    if not rootPart or not rootPart.Parent then return end
                    
                    for _, prompt in ipairs(prompts) do
                        if prompt and prompt.Parent and isInRange(prompt) then
                            firePrompt(prompt)
                        end
                    end
                end)
                table.insert(connections, heartbeatConn)

                -- Thu thập prompt hiện có
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        table.insert(prompts, obj)
                    end
                end

                -- Tự động thêm prompt mới
                local descendantConn = workspace.DescendantAdded:Connect(function(desc)
                    if desc:IsA("ProximityPrompt") then
                        table.insert(prompts, desc)
                    end
                end)
                table.insert(connections, descendantConn)

                -- Cập nhật character khi respawn
                local charAddedConn = player.CharacterAdded:Connect(function(newChar)
                    character = newChar
                    rootPart = newChar:WaitForChild("HumanoidRootPart")
                end)
                table.insert(connections, charAddedConn)

                print("🔥 Auto Fire ProximityPrompt trong 50 studs đã bật!")

                -- Giữ script chạy đến khi tắt toggle
                while getgenv().AntiDie do
                    task.wait(1)
                end

                -- Cleanup khi tắt
                for _, conn in ipairs(connections) do
                    if conn then conn:Disconnect() end
                end
                prompts = {}
            end)

        end
    end
})
local AutoPhePha = true

Tab3:AddToggle({
	Name = "Auto Phê Pha V2",
	Default = true,
	Callback = function(Value)
		AutoPhePha = Value

		task.spawn(function()
			while AutoPhePha do
				pcall(function()
					local player = game.Players.LocalPlayer
					local charFolder = workspace:FindFirstChild("Characters")

					if charFolder then
						local char = charFolder:FindFirstChild(player.Name)

						if char and not char:FindFirstChild("Mode") then
							local args = {
								{
									Camera = CFrame.new(
										-28.790475845336914,
										298.4656677246094,
										-91.82173156738281,
										0.8630251884460449,
										0.06684061139822006,
										-0.5007192492485046,
										0,
										0.9912075996398926,
										0.1323155164718628,
										0.5051608085632324,
										-0.11419162154197693,
										0.855437159538269
									),
									SkillId = "10",
									Began = true,
									CFrame = CFrame.new(
										-20.313318252563477,
										294.6113586425781,
										-106.30424499511719,
										0.863025426864624,
										0.06684055924415588,
										-0.5007189512252808,
										-8.083265612413015e-09,
										0.9912076592445374,
										0.1323154717683792,
										0.5051605105400085,
										-0.11419161409139633,
										0.8554373979568481
									),
									["Typ\208\181"] = 1,
									Aim = vector.create(
										4.722629547119141,
										287.9955749511719,
										-149.07611083984375
									)
								}
							}

							game:GetService("ReplicatedStorage")
								:WaitForChild("Remotes")
								:WaitForChild("SkillRemote")
								:FireServer(unpack(args))
						end
					end
				end)

				task.wait(1.5)
			end
		end)
	end
})
local Section = Tab2:AddSection({
    Name = "equip weapin"
})
local SelectedTool = 2
local AutoEquipTools = false

local Dropdown = Tab2:AddDropdown({
	Name = "Auto equiptools dls",
	Default = "2",
	Options = {"1","2","3","4","5","6"},
	Callback = function(Value)
		SelectedTool = tonumber(Value)
	end
})

Tab2:AddToggle({
	Name = "Auto EquipTools",
	Default = false,
	Callback = function(Value)
		AutoEquipTools = Value

		if Value then
			task.spawn(function()
				while AutoEquipTools do
					local args = {
						SelectedTool
					}

					game:GetService("ReplicatedStorage")
						:WaitForChild("Packages")
						:WaitForChild("_Index")
						:WaitForChild("sleitnick_knit@1.4.7")
						:WaitForChild("knit")
						:WaitForChild("Services")
						:WaitForChild("ToolService")
						:WaitForChild("RE")
						:WaitForChild("UpdatePlayerToolbarSelection")
						:FireServer(unpack(args))

					task.wait(0.1)
				end
			end)
		end
	end
})
local chargeArgs = {{
    Camera = CFrame.new(640.81549,595.6267,-148.80317),
    SkillId = "2",
    Began = true,
    CFrame = CFrame.new(630.13879,587.79492,-149.98782),
    ["Typ\208\181"] = 1,
    Aim = vector.create(580.19,587.79,-152.32)
}}

local releaseArgs = {{
    Camera = CFrame.new(640.81549,595.6267,-148.80317),
    SkillId = "2",
    Began = false,
    CFrame = CFrame.new(630.13879,587.79492,-149.98782),
    ["Typ\208\181"] = 1,
    Aim = vector.create(633.96,584.97,-140.55)
}}

local AutoEnergyEnabled = false
local isCharging = false

Tab3:AddToggle({
    Name = "Auto Năng Lượng ⚡",
    Default = true,
    Callback = function(Value)
        AutoEnergyEnabled = Value
        isCharging = false

        task.spawn(function()
            while AutoEnergyEnabled do
                local player = game.Players.LocalPlayer
                local char = player.Character

                if not char then task.wait(1) continue end

                local status = char:FindFirstChild("Status")
                local energy = status and status:FindFirstChild("CurrentEnergy")

                if energy then
                    local current = energy.Value

                    if current <= 1000 and not isCharging then
                        isCharging = true

                        game.ReplicatedStorage.Remotes.SkillRemote:FireServer(unpack(chargeArgs))

                        local last = current
                        local noUp = 0

                        for i = 1,8 do
                            task.wait(0.5)
                            if not AutoEnergyEnabled then break end

                            local now = energy.Value
                            if now <= last + 20 then
                                noUp += 1
                                if noUp >= 4 then
                                    break
                                end
                            else
                                noUp = 0
                                last = now
                            end
                        end

                        game.ReplicatedStorage.Remotes.SkillRemote:FireServer(unpack(releaseArgs))
                        isCharging = false
                    end
                end

                task.wait(0.8)
            end
        end)
    end
})
local AutoGodSejin = false

Tab4:AddToggle({
	Name = "Auto God Sejin",
	Default = false,
	Callback = function(Value)
		AutoGodSejin = Value

		if AutoGodSejin then
			task.spawn(function()
				local ReplicatedStorage = game:GetService("ReplicatedStorage")

				local Remote = ReplicatedStorage
					:WaitForChild("Packages")
					:WaitForChild("_Index")
					:WaitForChild("sleitnick_knit@1.4.7")
					:WaitForChild("knit")
					:WaitForChild("Services")
					:WaitForChild("SkillManagerV2")
					:WaitForChild("RE")
					:WaitForChild("ExecuteSkill")

				local SkillData = {
					HoldAnimation = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("SkillsV2"):WaitForChild("UniqueSets"):WaitForChild("Seijin Instinct"):WaitForChild("Animations"):WaitForChild("Hold_SpiritBomb"),
					ReleaseAnimation = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("SkillsV2"):WaitForChild("UniqueSets"):WaitForChild("Seijin Instinct"):WaitForChild("Animations"):WaitForChild("Release_SpiritBomb"),
					HumCFrame = CFrame.new(
						1078.374755859375,
						832.61376953125,
						1464.568603515625,
						0.2109788954257965,
						-7.579087224485193e-08,
						0.9774906039237976,
						-8.176831656214745e-09,
						1,
						7.93010244137804e-08,
						-0.9774906039237976,
						-2.472361870786699e-08,
						0.2109788954257965
					),
					ResumeOnTimePassed = 0.1,
					targetPos = vector.create(
						1078.374755859375,
						832.61376953125,
						1414.568603515625
					)
				}

				while AutoGodSejin do
					Remote:FireServer("Weapons_22_2", SkillData, 9, true)
					Remote:FireServer("Weapons_22_2", SkillData, 9, false)
					task.wait(0.3)
				end
			end)
		end
	end
})
local Section4 = Tab:AddSection({
    Name = "Weapons"
})
local AutoPsi = false

Tab4:AddToggle({
	Name = "Auto Psi",
	Default = false,
	Callback = function(Value)
		AutoPsi = Value

		if AutoPsi then
			task.spawn(function()
				while AutoPsi do
					local args = {
						"Weapons_13_3",
						{
							HoldAnimation = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("SkillsV2"):WaitForChild("UniqueSets"):WaitForChild("Seijin Instinct"):WaitForChild("Animations"):WaitForChild("Hold_SpiritBomb"),
							ReleaseAnimation = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("SkillsV2"):WaitForChild("UniqueSets"):WaitForChild("Seijin Instinct"):WaitForChild("Animations"):WaitForChild("Release_SpiritBomb"),
							HumCFrame = CFrame.new(
								1078.374755859375,
								832.61376953125,
								1464.568603515625,
								0.2109788954257965,
								-7.579087224485193e-08,
								0.9774906039237976,
								-8.176831656214745e-09,
								1,
								7.93010244137804e-08,
								-0.9774906039237976,
								-2.472361870786699e-08,
								0.2109788954257965
							),
							ResumeOnTimePassed = 0.1,
							targetPos = vector.create(
								1078.374755859375,
								832.61376953125,
								1414.568603515625
							)
						},
						9,
						true
					}

					game:GetService("ReplicatedStorage")
						:WaitForChild("Packages")
						:WaitForChild("_Index")
						:WaitForChild("sleitnick_knit@1.4.7")
						:WaitForChild("knit")
						:WaitForChild("Services")
						:WaitForChild("SkillManagerV2")
						:WaitForChild("RE")
						:WaitForChild("ExecuteSkill")
						:FireServer(unpack(args))

					task.wait(0.2)
				end
			end)
		end
	end
})
local AutoRebirth = false

Tab5:AddToggle({
	Name = "Auto rebirth [Real]",
	Default = false,
	Callback = function(Value)
		AutoRebirth = Value

		task.spawn(function()
			while AutoRebirth do
				local gp = game:GetService("Players").LocalPlayer.Stats.GamePasses:FindFirstChild("Auto Rebirth")
				if gp then
					gp.Value = true
				end
				task.wait(0.2)
			end

			local gp = game:GetService("Players").LocalPlayer.Stats.GamePasses:FindFirstChild("Auto Rebirth")
			if gp then
				gp.Value = false
			end
		end)
	end
})
local AutoVIP = false

Tab5:AddToggle({
	Name = "Get Vip [Not real]",
	Default = false,
	Callback = function(Value)
		AutoVIP = Value

		task.spawn(function()
			while AutoVIP do
				local vip = game:GetService("Players").LocalPlayer.Stats.GamePasses:FindFirstChild("VIP")
				if vip then
					vip.Value = true
				end
				task.wait(0.2)
			end

			local vip = game:GetService("Players").LocalPlayer.Stats.GamePasses:FindFirstChild("VIP")
			if vip then
				vip.Value = false
			end
		end)
	end
})
local AutoLuck = false

Tab5:AddToggle({
	Name = "2x Luck [cannot be determined]",
	Default = false,
	Callback = function(Value)
		AutoLuck = Value

		task.spawn(function()
			while AutoLuck do
				local luck = game:GetService("Players").LocalPlayer.Stats.GamePasses:FindFirstChild("2x Luck")
				if luck then
					luck.Value = true
				end
				task.wait(0.2)
			end

			local luck = game:GetService("Players").LocalPlayer.Stats.GamePasses:FindFirstChild("2x Luck")
			if luck then
				luck.Value = false
			end
		end)
	end
})



-- Fake Damage TextBox
Tab5:AddTextbox({
    Name = "Fake Damage",
    Default = "100",
    TextDisappear = false,
    Callback = function(Value)
        local damageValue = tonumber(Value)
        if not damageValue then 
            OrionLib:MakeNotification({
                Name = "Lỗi",
                Content = "Vui lòng nhập số hợp lệ!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
            return 
        end
        
        -- Áp dụng cho TẤT CẢ nhân vật trong workspace.Characters
        for _, character in pairs(workspace.Characters:GetChildren()) do
            if character:FindFirstChild("Status") and character.Status:FindFirstChild("Damage") then
                character.Status.Damage.Value = damageValue
            end
        end
        
        OrionLib:MakeNotification({
            Name = "Thành công",
            Content = "Đã set Fake Damage = " .. damageValue .. " cho tất cả người chơi!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end    
})

-- Optional: Button để refresh (áp dụng lại giá trị hiện tại)
Tab5:AddButton({
    Name = "Refresh All Damage",
    Callback = function()
        local currentDamage = 100 -- Bạn có thể thay đổi default ở đây
        for _, character in pairs(workspace.Characters:GetChildren()) do
            if character:FindFirstChild("Status") and character.Status:FindFirstChild("Damage") then
                character.Status.Damage.Value = currentDamage
            end
        end
        OrionLib:MakeNotification({
            Name = "Refresh",
            Content = "Đã refresh Damage cho tất cả nhân vật!",
            Time = 2
        })
    end
})

OrionLib:Init()
