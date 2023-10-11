local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatEvent = ReplicatedStorage.CombatEvent

local PunchEffects = game.ReplicatedStorage.Effects.Characters.Saitama.OneThousandPunches.OneThousandPunchesfx
local HugePunch = game.ReplicatedStorage.Effects.Characters.Saitama.Ultimates.SeriousPunch.SeriousPunchFX

local TS = game:GetService("TweenService")
local SS = game:GetService("SoundService")

local D = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")

local RagdollHandler = require(ServerStorage.Modules.RagdollHandler)
local RockModule = require(ServerStorage.Modules.RockModule)

local stunHandler = require(ServerStorage.Modules.StunHandlerV2)

local LeftPunchAnimation = Instance.new("Animation")
LeftPunchAnimation.AnimationId = "rbxassetid://14738078813"

local RightPunchAnimation = Instance.new("Animation")
RightPunchAnimation.AnimationId = "rbxassetid://14738148844"

local HugePunchAnimation = Instance.new("Animation")
HugePunchAnimation.AnimationId = "rbxassetid://14711383038"

CombatEvent.OnServerEvent:Connect(function(plr,Humanoid)
	local AnimationTrack3 = ReplicatedStorage.UltAnims.Kick
	local AnimationTrack4 = ReplicatedStorage.UltAnims.SpamPunch
	local char = plr.Character
	local hum = char.Humanoid
	local rootpart = char.HumanoidRootPart
	local PunchEffectsClone = PunchEffects:Clone()
	local attacking = char:GetAttribute("Attacking")
	local punching = char:GetAttribute("Punching")
	local stunned = char:GetAttribute("Stunned")
	if attacking or stunned or punching then return end
	
	local Anim3 = hum:LoadAnimation(AnimationTrack3)
	local Anim4 = hum:LoadAnimation(AnimationTrack4)
	Anim4:Play()
	char:SetAttribute("Attacking", true)
	local Tina = ReplicatedStorage.Effects.HitFX.Characters.Saitama.NormalPunch.ArmFX
	local Tts = Tina:Clone()
	Tts.Parent = char
	local weld = Instance.new("Weld")
	weld.Parent = plr.Character:FindFirstChild("Right Arm")
	weld.Part0 = plr.Character:FindFirstChild("Right Arm")
	weld.Part1 = Tts
	weld.C0 = CFrame.new(0, 0, 0)

	D:AddItem(Tts,4)
	
	
	local Ti2 = ReplicatedStorage.Effects.HitFX.Characters.Saitama.NormalPunch.ArmFX
	local Tt2 = Ti2:Clone()
	Tt2.Parent = char
	local weld = Instance.new("Weld")
	weld.Parent = plr.Character:FindFirstChild("Left Arm")
	weld.Part0 = plr.Character:FindFirstChild("Left Arm")
	weld.Part1 = Tt2

	weld.C0 = CFrame.new(0, 0, 0)

	D:AddItem(Tt2,4)
	
	wait(0.4)
	for i = 1,12,2 do
		

		
		local minijump = Instance.new("BodyVelocity",plr.Character:FindFirstChild("HumanoidRootPart"))
		minijump.MaxForce = Vector3.new(999999,999999,999999)
		minijump.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 1 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 0
		D:AddItem(minijump, 0.3)

		
		PunchEffectsClone.Orientation= char:FindFirstChild("Left Arm").Orientation
		PunchEffectsClone.Position = char:FindFirstChild("Left Arm").Position
		PunchEffectsClone.Parent = game.Workspace
		PunchEffectsClone.P2:Emit(31)
		PunchEffectsClone.P2b:Emit(31)
		PunchEffectsClone.P4b:Emit(31)
		PunchEffectsClone.P5:Emit(31)
		PunchEffectsClone.P6.Enabled = true


					local xa = Instance.new("Part")
		xa.Size = Vector3.new(10,10,15)
		xa.CanCollide = false
		xa.Transparency = 1
		xa.Material = Enum.Material.ForceField
		xa.BrickColor = BrickColor.new("Really red")
		xa.Anchored = true
		xa.Parent = workspace.Ignore
		xa.CFrame = rootpart.CFrame * CFrame.new(0,0,0)

		D:AddItem(xa, .05)
		for i,v in pairs(workspace:GetPartsInPart(xa))do

			local a = v.Parent:FindFirstChild("Humanoid")

			if v.Parent:FindFirstChild("Humanoid") and v.Parent ~= char and v.Parent:FindFirstChild("Hit"..plr.Name) == nil then

				local newCframe = rootpart.CFrame * CFrame.new(0,1, -3)
				local lookPosition = Vector3.new(rootpart.Position.X, v.Parent:FindFirstChild("HumanoidRootPart").Position.Y, rootpart.Position.Z)


				v.Parent:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(newCframe.Position, lookPosition)
		

				if a.Health > 20 then
					local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
					VeloCity.MaxForce = Vector3.new(60000,60000,60000)
					VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 1 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 1

					D:AddItem(VeloCity, 0.6)


					stunHandler.Stun(a,1.2)
			
					v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 0.1
					v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false
					
				else
					local newCframe = rootpart.CFrame * CFrame.new(0,1, -3)
					local lookPosition = Vector3.new(rootpart.Position.X, v.Parent:FindFirstChild("HumanoidRootPart").Position.Y, rootpart.Position.Z)


					v.Parent:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(newCframe.Position, lookPosition)
					local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
					VeloCity.MaxForce = Vector3.new(60000,60000,60000)
					VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 10 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 5

					D:AddItem(VeloCity, 0.6)
					stunHandler.Stun(a,3)
					v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 0.01
					
				end
				end

			end
		wait(0.01)
	
		PunchEffectsClone.Orientation= char:FindFirstChild("Right Arm").Orientation
		PunchEffectsClone.Position = char:FindFirstChild("Right Arm").Position
		PunchEffectsClone.Parent = game.Workspace
		local x = Instance.new("Part")
		x.Size = Vector3.new(10,10,10)
		x.CanCollide = false
		x.Transparency = 1
		x.Material = Enum.Material.ForceField
		x.BrickColor = BrickColor.new("Really red")
		x.Anchored = true
		x.Parent = workspace.Ignore
		x.CFrame = rootpart.CFrame * CFrame.new(0,0,-2)

		D:AddItem(x, .05)
		for i,v in pairs(workspace:GetPartsInPart(x))do

			local a = v.Parent:FindFirstChild("Humanoid")

			if v.Parent:FindFirstChild("Humanoid") and v.Parent ~= char and v.Parent:FindFirstChild("Hit"..plr.Name) == nil then
		


if a.Health > 20 then
					
					local newCframe = rootpart.CFrame * CFrame.new(0,1, -3)
					local lookPosition = Vector3.new(rootpart.Position.X, v.Parent:FindFirstChild("HumanoidRootPart").Position.Y, rootpart.Position.Z)


					v.Parent:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(newCframe.Position, lookPosition)
					
					local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
					VeloCity.MaxForce = Vector3.new(60000,60000,60000)
					VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 1 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * -1

					D:AddItem(VeloCity, 0.6)


					stunHandler.Stun(a,1.2)


					v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 0.1
					v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false
					
	else
					
					local newCframe = rootpart.CFrame * CFrame.new(0,1, -3)
					local lookPosition = Vector3.new(rootpart.Position.X, v.Parent:FindFirstChild("HumanoidRootPart").Position.Y, rootpart.Position.Z)


					v.Parent:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(newCframe.Position, lookPosition)					
					local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
					VeloCity.MaxForce = Vector3.new(60000,60000,60000)
					VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 5 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 5


					D:AddItem(VeloCity, 0.6)
					v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 0.01

					
				end
			end
			
		end
				wait(0.3)
		end
	

	local a2 = Instance.new("Part")
	a2.Size = Vector3.new(10,10,15)
	a2.CanCollide = false
	a2.Transparency = 1
	a2.Material = Enum.Material.ForceField
	a2.BrickColor = BrickColor.new("Really red")
	a2.Anchored = true
	a2.Parent = workspace.Ignore
	a2.CFrame = rootpart.CFrame * CFrame.new(0,0,0)

	D:AddItem(a2, .05)
	for i,v in pairs(workspace:GetPartsInPart(a2))do

		local a = v.Parent:FindFirstChild("Humanoid")

		if v.Parent:FindFirstChild("Humanoid") and v.Parent ~= char and v.Parent:FindFirstChild("Hit"..plr.Name) == nil then

				local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
				VeloCity.MaxForce = Vector3.new(60000,60000,60000)
				VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 15 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 3
D:AddItem(VeloCity,0.3)
		end

	end
	
	Anim4:Stop()
	Anim3:Play()
	wait(0.2)
	PunchEffectsClone:Destroy()
	local minijump = Instance.new("BodyVelocity",plr.Character:FindFirstChild("HumanoidRootPart"))
	minijump.MaxForce = Vector3.new(999999,999999,999999)
	minijump.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 15 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 15
	D:AddItem(minijump, 0.3)
	
	local Tin = ReplicatedStorage.Effects.HitFX.Characters.Saitama.NormalPunch.ArmFX
	local Tt = Tin:Clone()
	Tt.Parent = char
	local weld = Instance.new("Weld")
	weld.Parent = plr.Character:FindFirstChild("Right Leg")
	weld.Part0 = plr.Character:FindFirstChild("Right Leg")
	weld.Part1 = Tt
	weld.C0 = CFrame.new(0, 0, 0)

	D:AddItem(Tt,2.5)

	
	
	wait(0.2)
	local Sound2 = ReplicatedStorage.Sounds.Stomp
	local S2 = Sound2:Clone()
	S2.Parent = rootpart
	S2:Play()

	D:AddItem(S2, 4)

	local x3 = Instance.new("Part")
	x3.Size = Vector3.new(20,20,20)
	x3.CanCollide = false
	x3.Transparency = 1
	x3.Material = Enum.Material.ForceField
	x3.BrickColor = BrickColor.new("Really red")
	x3.Anchored = true
	wait(0.2)
	x3.Parent = workspace.Ignore
	x3.CFrame = rootpart.CFrame * CFrame.new(0,1,-10)
	
	D:AddItem(x3, 0.005)
	
	local HugePunchEffectClone = HugePunch:Clone()
	HugePunchEffectClone.Parent =game.Workspace
	HugePunchEffectClone.CFrame = rootpart.CFrame * CFrame.new(0,0,-10)
	HugePunchEffectClone.Rotation = Vector3.new(0,180,0)
	
	HugePunchEffectClone.A1.SmokeFront:Emit(15)
	HugePunchEffectClone.A1.SmokeSides:Emit(15)
	HugePunchEffectClone.A2.P1:Emit(1)
	HugePunchEffectClone.A2.P2:Emit(1)
	HugePunchEffectClone.A2.P3:Emit(1)
	HugePunchEffectClone.A2.P4:Emit(1)
	
	for i,v in pairs(workspace:GetPartsInPart(x3))do

		local a = v.Parent:FindFirstChild("Humanoid")

		if v.Parent:FindFirstChild("Humanoid") and v.Parent ~= char and v.Parent:FindFirstChild("Hit"..plr.Name) == nil then

			if v.Parent:FindFirstChild("Humanoid").Health > 20 then
				local newCframe = rootpart.CFrame * CFrame.new(0,0, -4)
				local lookPosition = Vector3.new(rootpart.Position.X, v.Parent:FindFirstChild("HumanoidRootPart").Position.Y, rootpart.Position.Z)


				v.Parent:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(newCframe.Position, lookPosition)

				local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
				VeloCity.MaxForce = Vector3.new(60000,60000,60000)
				VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 70 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 7

				D:AddItem(VeloCity, .25)

				stunHandler.Stun(a,3)

				v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 2.5

				local FallAnim = game.ReplicatedStorage.Animations.Characters.Saitama.NormalPunch.FallBack
				local fallplay =v.Parent:FindFirstChild("Humanoid"):LoadAnimation(FallAnim)
				fallplay:Play()

	

				-- ELSE --
			elseif v.Parent:FindFirstChild("Humanoid").Health <= 20 then

				local newCframe = rootpart.CFrame * CFrame.new(0,0, -4)
				local lookPosition = Vector3.new(rootpart.Position.X, v.Parent:FindFirstChild("HumanoidRootPart").Position.Y, rootpart.Position.Z)				
				v.Parent:FindFirstChild("HumanoidRootPart").CFrame = CFrame.lookAt(newCframe.Position, lookPosition)				
				v.Parent:FindFirstChild("Torso").Anchored = true
				wait()
				v.Parent:FindFirstChild("Torso").Anchored = false

				local VeloCity = Instance.new("BodyVelocity",v.Parent:FindFirstChild("HumanoidRootPart"))
				VeloCity.MaxForce = Vector3.new(60000,60000,60000)
				VeloCity.Velocity = char:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 500 + char:FindFirstChild("HumanoidRootPart").CFrame.UpVector * 7

				D:AddItem(VeloCity, .50)


				v.Parent:FindFirstChild("Humanoid").Health = v.Parent:FindFirstChild("Humanoid").Health - 100
				RagdollHandler.ragdoll(v,4)
				-- TRAIL --
				hum.Health = hum.Health + 15
			end
		end
	end
	char:SetAttribute("Attacking", false)
	wait(1.5)
	HugePunchEffectClone:Destroy()
	
end)


