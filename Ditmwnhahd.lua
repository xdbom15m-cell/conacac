local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/cakukloj-lab/No/refs/heads/main/Orion_Orange_Transparent_09_Small.lua.txt"))()
local Window = OrionLib:MakeWindow({
	Name = "hideoutngu | Sangigy9 Cleaned",
	HidePremium = false,
	SaveConfig = false,
	ConfigFolder = "MobFarm"
})

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

local EventMobFolder = workspace["World Mobs"]:WaitForChild("Event Mobs")
local NormalMobFolder = workspace["World Mobs"]:WaitForChild("Mobs")

local Radius = 1000
local TargetCFrame = CFrame.new(41.9730225, 276.267853, 316.27887)

local AutoBring = true 

-- ĐỊNH NGHĨA HÀM GETGARRIOT TRƯỚC ĐỂ TRÁNH LỖI NIL VALUE
local function GetGarriot()
	for _, v in ipairs(EventMobFolder:GetChildren()) do
		if v.Name == "Garriot" then
			return v
		end
	end
end

Tab:AddToggle({
	Name = "Auto Bring 1 Chỗ",
	Default = true,
	Callback = function(Value)
		AutoBring = Value
	end
})

RunService.Heartbeat:Connect(function()
	if not AutoBring then return end

	pcall(function()
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
	end)

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
				end)
			end
		end
	end

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
				end)
			end
		end
	end
end)

local SSJBDamage = false
Tab:AddToggle({
	Name = "Ssjb x0.25 Damage",
	Default = false,
	Callback = function(Value)
		SSJBDamage = Value
		if Value then
			task.spawn(function()
				while SSJBDamage do
					local args = {"Weapons_14_2", {}, 76}
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
					task.wait(0.1)
				end
			end)
		end
	end
})

getgenv().AutoBlast = false
Tab:AddToggle({
	Name = "Auto Energy Blast",
	Default = false,
	Callback = function(Value)
		getgenv().AutoBlast = Value
		if Value then
			task.spawn(function()
				local TargetPosition = Vector3.new(41.9730225, 276.267853, 316.27887)
				local MobFolder = workspace["World Mobs"]:WaitForChild("Event Mobs")
				task.wait(2)

				while getgenv().AutoBlast do
					local TargetCF = nil
					local ClosestDist = math.huge

					for _, Mob in pairs(MobFolder:GetChildren()) do
						local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
						local MobRoot = Mob:FindFirstChild("HumanoidRootPart")

						if Humanoid and MobRoot and Humanoid.Health > 0 then
							local Dist = (MobRoot.Position - TargetPosition).Magnitude
							if Dist < ClosestDist then
								ClosestDist = Dist
								TargetCF = MobRoot.CFrame
							end
						end
					end

					if not TargetCF then
						TargetCF = CFrame.new(TargetPosition)
					end

					local args = {
						{
							Camera = TargetCF * CFrame.new(0, 10, -30),
							SkillId = "101",
							Began = true,
							CFrame = TargetCF,
							["Typ\208\181"] = 1,
							Aim = TargetCF.Position
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

Tab:AddToggle({
    Name = "Auto Play (Next Area)",
    Default = false,
    Callback = function(Value)
        _G.AutoPlay = Value
        task.spawn(function()
            while _G.AutoPlay do
                pcall(function()
                    workspace:WaitForChild("Dungeon"):WaitForChild("Stages"):WaitForChild("0"):WaitForChild("NextArea"):WaitForChild("DungeonNextAreaPad"):WaitForChild("RE"):WaitForChild("Interact"):FireServer(unpack({true}))
                end)
                task.wait(2.4)
            end
        end)
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
				task.wait(1.5)
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
								Text = "Chờ 5 giây vào trận tiếp...",
								Duration = 5
							})
							task.wait(5) -- Thay đổi từ 999999 thành 5 giây hợp lý hơn

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

Tab:AddToggle({
    Name = "Godmode",
    Default = false, -- Sửa từ falsee thành false
    Callback = function(v)
        getgenv().AntiDie = v
        task.spawn(function()
            while getgenv().AntiDie do
                task.wait()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(70.4524002, 247.817719, -16.9801903)
                    char.HumanoidRootPart.Velocity = Vector3.zero
                end
            end
        end)
    end
})

local SpectateMob = false
local CurrentCamera = workspace.CurrentCamera
Tab:AddToggle({
	Name = "Spectator Boss",
	Default = false,
	Callback = function(Value)
		SpectateMob = Value
		if not SpectateMob then
			CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			return
		end

		task.spawn(function()
			while SpectateMob do
				task.wait(3)
				local worldMobs = workspace:FindFirstChild("World Mobs")
				if worldMobs then
					local eventMobs = worldMobs:FindFirstChild("Event Mobs")
					if eventMobs then
						local mobList = {}
						for _, mob in pairs(eventMobs:GetChildren()) do
							local hum = mob:FindFirstChildOfClass("Humanoid")
							if hum and hum.Health > 0 then
								table.insert(mobList, hum)
							end
						end
						if #mobList > 0 then
							CurrentCamera.CameraSubject = mobList[math.random(1, #mobList)]
						end
					end
				end
			end
		end)
	end
})

Tab:AddToggle({
	Name = "Auto lock",
	Default = false,
	Callback = function(Value)
		getgenv().AutoLock = Value
		task.spawn(function()
			while getgenv().AutoLock do
				local garriot = GetGarriot()
				if garriot then
					game:GetService("ReplicatedStorage")
						:WaitForChild("Packages")
						:WaitForChild("_Index")
						:WaitForChild("sleitnick_knit@1.4.7")
						:WaitForChild("knit")
						:WaitForChild("Services")
						:WaitForChild("SkillManager")
						:WaitForChild("RE")
						:WaitForChild("LockedOnChanged")
						:FireServer(unpack({garriot}))
				end
				task.wait(0.2)
			end
		end)
	end
})

local AutoPhePha = false
Tab:AddToggle({
	Name = "Auto Phê Pha V2",
	Default = false,
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
							local args = {{
								Camera = CFrame.new(-28.79, 298.46, -91.82, 0.86, 0.06, -0.5, 0, 0.99, 0.13, 0.5, -0.11, 0.85),
								SkillId = "10",
								Began = true,
								CFrame = CFrame.new(-20.31, 294.61, -106.3),
								["Typ\208\181"] = 1,
								Aim = vector.create(4.72, 287.99, -149.07)
							}}
							game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
						end
					end
				end)
				task.wait(1.5) -- Sửa lại cooldown hợp lý từ 99995 giây thành 1.5 giây
			end
		end)
	end
})

local chargeArgs = {{
    Camera = CFrame.new(640.81,595.62,-148.8),
    SkillId = "2",
    Began = true,
    CFrame = CFrame.new(630.13,587.79,-149.9),
    ["Typ\208\181"] = 1,
    Aim = vector.create(580.19,587.79,-152.32)
}}

local releaseArgs = {{
    Camera = CFrame.new(640.81,595.62,-148.8),
    SkillId = "2",
    Began = false,
    CFrame = CFrame.new(630.13,587.79,-149.9),
    ["Typ\208\181"] = 1,
    Aim = vector.create(633.96,584.97,-140.55)
}}

local AutoEnergyEnabled = false
local isCharging = false

Tab:AddToggle({
    Name = "Auto Năng Lượng ⚡",
    Default = false,
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
                                if noUp >= 4 then break end
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

local TargetName = "10bdtr05"
Tab:AddTextbox({
	Name = "Tên Roblox",
	Default = "10bdtr05",
	TextDisappear = true,
	Callback = function(Value)
		TargetName = Value
	end
})

Tab:AddButton({
	Name = "Check & Activate",
	Callback = function()
		local Characters = workspace:FindFirstChild("Characters")
		if not Characters then return end

		local Char = Characters:FindFirstChild(TargetName)
		if not Char or Char:FindFirstChild("Mode") then return end

		local args = {{
			Camera = CFrame.new(74.27, 251.0, -28.74),
			SkillId = "10",
			Began = true,
			CFrame = CFrame.new(70.45, 247.81, -16.98),
			["Typ\208\181"] = 1,
			Aim = vector.create(70.45, 247.81, -66.98)
		}}

		game:GetService("ReplicatedStorage").Remotes.SkillRemote:FireServer(unpack(args))
	end
})

OrionLib:Init()
