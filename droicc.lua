local Blacklist = {
    [""] = true,
    ["Player2"] = true,
    ["Player3"] = true
}

game.Players.PlayerAdded:Connect(function(player)
    if Blacklist[player.Name] then
        player:Kick("Kêu oggy unban đi")
    end
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    if Blacklist[player.Name] then
        player:Kick("Kêu oggy unban đi ")
    end
end
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

local data = {
    ["content"] = "🎮 Người dùng hideout: **" .. player.Name .. "** (@"
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
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Window = OrionLib:MakeWindow({
	Name = "chetmemaydi",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "Config"
})

local Tab = Window:MakeTab({
	Name = "ocho",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab2 = Window:MakeTab({
	Name = "oclon",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
-- ================== HIT INSTINCT (Chỉ spam Tool đang cầm) ==================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

local EventMobFolder = workspace["World Mobs"]:WaitForChild("Event Mobs")
local NormalMobFolder = workspace["World Mobs"]:WaitForChild("Mobs")

local Radius = 1000
local TargetCFrame = CFrame.new(41.9730225, 276.267853, 316.27887)

local AutoBring = true -- MỞ SẴN

Tab:AddToggle({
	Name = "Auto Bring 1 Chỗ",
	Default = true,
	Callback = function(Value)
		AutoBring = Value
	end
})

-- Biến cấu hình: Đặt true để tự bay tới quái, false nếu chỉ muốn hút quái một chỗ
local AutoTeleportToMob = true 

RunService.Heartbeat:Connect(function()
	if not AutoBring then
		return
	end

	pcall(function()
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
	end)

	-- Biến tạm để lưu vị trí con quái đầu tiên tìm thấy phục vụ cho việc Teleport
	local TargetMobRoot = nil 

	-- 1. Xử lý gom quái sự kiện (Event Mobs)
	for _, Mob in ipairs(EventMobFolder:GetChildren()) do
		local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
		local MobRoot = Mob:FindFirstChild("HumanoidRootPart")

		if Humanoid and MobRoot and Humanoid.Health > 0 then
			if (MobRoot.Position - Root.Position).Magnitude <= Radius then
				pcall(function()
					MobRoot.CanCollide = false
					MobRoot.Velocity = Vector3.zero
					MobRoot.RotVelocity = Vector3.zero
					MobRoot.CFrame = TargetCFrame
					
					-- Lưu lại quái sự kiện/boss để lát nữa nhân vật bay tới
					if not TargetMobRoot then TargetMobRoot = MobRoot end
				end)
			end
		end
	end

	-- 2. Xử lý gom quái thường (Normal Mobs)
	for _, Mob in ipairs(NormalMobFolder:GetChildren()) do
		local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
		local MobRoot = Mob:FindFirstChild("HumanoidRootPart")

		if Humanoid and MobRoot and Humanoid.Health > 0 then
			if (MobRoot.Position - Root.Position).Magnitude <= Radius then
				pcall(function()
					MobRoot.CanCollide = false
					MobRoot.Velocity = Vector3.zero
					MobRoot.RotVelocity = Vector3.zero
					MobRoot.CFrame = TargetCFrame
					
					-- Nếu chưa có quái Event thì lấy tạm quái thường để bay tới
					if not TargetMobRoot then TargetMobRoot = MobRoot end
				end)
			end
		end
	end

	-- 3. Phần code mới thêm: Teleport nhân vật đến quái đang bị gom (Cao hơn đầu quái 5 studs)
	if AutoTeleportToMob and TargetMobRoot then
		pcall(function()
			-- Cập nhật lại Character và Root đề phòng trường hợp bạn bị chết/reset nhân vật
			local CurrentChar = LocalPlayer.Character
			if CurrentChar and CurrentChar:FindFirstChild("HumanoidRootPart") then
				local CurrentRoot = CurrentChar.HumanoidRootPart
				CurrentRoot.CFrame = TargetMobRoot.CFrame * CFrame.new(0, 5, 0)
				CurrentRoot.Velocity = Vector3.zero
			end
		end)
	end
end)

OrionLib:Init()
Tab:AddToggle({
    Name = "Auto Play (Next Area)",
    Default = true,
    Flag = "AutoPlay",
    Callback = function(Value)
        _G.AutoPlay = Value
        spawn(function()
            while _G.AutoPlay do
                local args = {true}
                pcall(function()
                    workspace:WaitForChild("Dungeon"):WaitForChild("Stages"):WaitForChild("0"):WaitForChild("NextArea"):WaitForChild("DungeonNextAreaPad"):WaitForChild("RE"):WaitForChild("Interact"):FireServer(unpack(args))
                end)
                task.wait(2.4)
            end
        end)
    end
})
local AutoFarm = true

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
    local mobFolder = world:FindFirstChild("Event Mobs")
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
    Default = true,
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

                task.wait(0.001)
            end
        end)
    end
})

OrionLib:Init()
local AutoPhePha = true

Tab:AddToggle({
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
Tab:AddToggle({
    Name = "oc con cho",
    Default = false,
    Callback = function(v)
        getgenv().AntiDie = v
        spawn(function()
            while getgenv().AntiDie do
                task.wait()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(72.5913544, 222.065781, 279.876312, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                    char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                end
            end
        end)
    end
})

OrionLib:Init()

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

Tab:AddToggle({
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
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    hrp = newChar:WaitForChild("HumanoidRootPart")
end)

local AutoNgungu = true
local mainConnection

local HEIGHT_ABOVE = 9.8

Tab:AddToggle({
    Name = "Auto ngungu",
    Default = true,
    Callback = function(Value)
        AutoNgungu = Value

        if Value then
            mainConnection = RunService.Heartbeat:Connect(function()
                if not AutoNgungu then return end
                if not hrp or not hrp.Parent then return end

                local bossFolder = workspace:FindFirstChild("World Mobs")
                    and workspace["World Mobs"]:FindFirstChild("Event Mobs")

                if not bossFolder then return end

                -- Chỉ chạy khi Garriot tồn tại
                local garriot = bossFolder:FindFirstChild("Garriot")
                if not garriot then return end

                local humanoid = garriot:FindFirstChild("Humanoid")
                local bossHRP = garriot:FindFirstChild("HumanoidRootPart")

                if not humanoid or not bossHRP or humanoid.Health <= 0 then
                    return
                end

                local closestDist = (hrp.Position - bossHRP.Position).Magnitude
                local targetPos = bossHRP.Position + Vector3.new(0, HEIGHT_ABOVE, 0)

                hrp.Velocity = Vector3.zero
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero

                local tween = TweenService:Create(
                    hrp,
                    TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                    {
                        CFrame = CFrame.new(targetPos, bossHRP.Position)
                    }
                )

                tween:Play()

                if closestDist <= 30 then
                    local args = {
                        "Weapons_20_3",
                        {
                            TargetPos = bossHRP.Position
                        },
                        18
                    }

                    pcall(function()
                        game:GetService("ReplicatedStorage")
                            .Packages._Index["sleitnick_knit@1.4.7"]
                            .knit.Services.SkillManagerV2.RE.ExecuteSkill
                            :FireServer(unpack(args))
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
getgenv().AutoStart = false

Tab:AddToggle({
	Name = "Auto Start",
	Default = false,
	Callback = function(Value)
		getgenv().AutoStart = Value

		task.spawn(function()
			local started = false

			while getgenv().AutoStart do
				task.wait(1)

				local worldMobs = workspace:FindFirstChild("World Mobs")
				local eventMobs = worldMobs and worldMobs:FindFirstChild("Event Mobs")
				local garriot = eventMobs and eventMobs:FindFirstChild("Garriot")

				if garriot then
					local humanoid = garriot:FindFirstChildOfClass("Humanoid")

					if humanoid then
						if humanoid.Health > 0 then
							started = true
						end

						if started and humanoid.Health <= 0 then
							started = false

							game:GetService("StarterGui"):SetCore("SendNotification", {
								Title = "Auto Start",
								Text = "25s start tiếp...",
								Duration = 5
							})

							task.wait(4.5)

							if getgenv().AutoStart then
								game:GetService("ReplicatedStorage")
									:WaitForChild("Packages")
									:WaitForChild("_Index")
									:WaitForChild("sleitnick_knit@1.4.7")
									:WaitForChild("knit")
									:WaitForChild("Services")
									:WaitForChild("DungeonLobbyService")
									:WaitForChild("RF")
									:WaitForChild("StartDungeon")
									:InvokeServer()
							end
						end
					end
				end
			end
		end)
	end
})


local AutoStart = true
local Running = false

local EventMobs = workspace:WaitForChild("World Mobs"):WaitForChild("Event Mobs")

local StartDungeon = game:GetService("ReplicatedStorage")
	:WaitForChild("Packages")
	:WaitForChild("_Index")
	:WaitForChild("sleitnick_knit@1.4.7")
	:WaitForChild("knit")
	:WaitForChild("Services")
	:WaitForChild("DungeonLobbyService")
	:WaitForChild("RF")
	:WaitForChild("StartDungeon")

local function GetGarriot()
	for _, v in ipairs(EventMobs:GetChildren()) do
		if v.Name == "Garriot" then
			return v
		end
	end
end

task.spawn(function()
	while true do
		if AutoStart and not Running then
			local Boss = GetGarriot()

			if Boss then
				local Humanoid = Boss:FindFirstChildOfClass("Humanoid")

				if Humanoid and Humanoid.Health <= 0 then
					Running = true

					task.wait(4)

					while AutoStart do
						pcall(function()
							StartDungeon:InvokeServer()
						end)

						task.wait(0.1)
					end

					Running = false
				end
			end
		end

		task.wait(0.5)
	end
end)

Tab:AddToggle({
	Name = "Auto Start Rejoin",
	Default = true,
	Callback = function(Value)
		AutoStart = Value
	end
})

OrionLib:Init()
Tab:AddToggle({
	Name = "Auto lock all mobs",
	Default = true,
	Callback = function(Value)
		getgenv().AutoLock = Value

		task.spawn(function()
			while getgenv().AutoLock do
				local worldMobs = workspace:FindFirstChild("World Mobs")

				if worldMobs then
					for _, folder in ipairs(worldMobs:GetChildren()) do
						for _, mob in ipairs(folder:GetChildren()) do
							if mob:IsA("Model") then
								game:GetService("ReplicatedStorage")
									.Packages._Index["sleitnick_knit@1.4.7"]
									.knit.Services.SkillManager.RE.LockedOnChanged
									:FireServer(mob)

								task.wait(0.05)
							end
						end
					end
				end

				task.wait(0.01)
			end
		end)
	end
})

local AutoSkill = true

Tab:AddToggle({
	Name = "Auto Skill",
	Default = true,
	Callback = function(Value)
		AutoSkill = Value

		if AutoSkill then
			task.spawn(function()
				while AutoSkill do
					local args = {
						{
							Camera = CFrame.new(
								74.2727279663086, 251.0009002685547, -28.747745513916016,
								-0.9511321783065796, -0.044049736112356186, 0.3056260347366333,
								0, 0.9897724390029907, 0.14265543222427368,
								-0.308784157037735, 0.13568417727947235, -0.9414043426513672
							),
							SkillId = "108",
							Began = true,
							CFrame = CFrame.new(70.45240020751953, 247.81771850585938, -16.98019027709961),
							["Typе"] = 1,
							Aim = Vector3.new(70.45240020751953, 247.81771850585938, -66.98019409179688)
						}
					}

					game:GetService("ReplicatedStorage")
						:WaitForChild("Remotes")
						:WaitForChild("SkillRemote")
						:FireServer(unpack(args))

					task.wait(0.1)
				end
			end)
		end
	end
})

OrionLib:Init()
local AutoRejoinStart = true

Tab:AddToggle({
	Name = "Auto rejoin start",
	Default = true,
	Callback = function(Value)
		AutoRejoinStart = Value

		if Value then
			task.spawn(function()
				while AutoRejoinStart do
					pcall(function()
						game:GetService("ReplicatedStorage")
							:WaitForChild("Packages")
							:WaitForChild("_Index")
							:WaitForChild("sleitnick_knit@1.4.7")
							:WaitForChild("knit")
							:WaitForChild("Services")
							:WaitForChild("DungeonLobbyService")
							:WaitForChild("RF")
							:WaitForChild("StartDungeon")
							:InvokeServer()
					end)

					task.wait(18 * 60) -- 18 phút
				end
			end)
		end
	end
})
local AutoRejoinStart = true

Tab:AddToggle({
	Name = "Auto rejoin start",
	Default = true,
	Callback = function(Value)
		AutoRejoinStart = Value

		if Value then
			task.spawn(function()
				while AutoRejoinStart do
					pcall(function()
						game:GetService("ReplicatedStorage")
							:WaitForChild("Packages")
							:WaitForChild("_Index")
							:WaitForChild("sleitnick_knit@1.4.7")
							:WaitForChild("knit")
							:WaitForChild("Services")
							:WaitForChild("DungeonLobbyService")
							:WaitForChild("RF")
							:WaitForChild("StartDungeon")
							:InvokeServer()
					end)

					task.wait(18 * 61) -- 18 phút
				end
			end)
		end
	end
})
			
