AddCSLuaFile()

SWEP.PrintName = "Knife"
SWEP.Description = "Deals 4x damage in the back. You move faster with this in your hands."

SWEP.TranslationName = "wep_swissarmyknife"
SWEP.TranslationDesc = "wep_d_swissarmyknife"

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.Tier = 1

SWEP.StatDPS = 3
SWEP.StatDPR = 5
SWEP.StatRange = 1
SWEP.StatSpecial =  5

SWEP.HoldType = "knife"

SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 19
SWEP.MeleeRange = 52
SWEP.MeleeSize = 0.875
SWEP.BackstabMultiplier = 4


SWEP.WeightClass = WEIGHT_ZERO

SWEP.Primary.Delay = 0.85

SWEP.HitDecal = "Manhackcut"

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
SWEP.MissGesture = SWEP.HitGesture

SWEP.HitAnim = ACT_VM_MISSCENTER
SWEP.MissAnim = ACT_VM_PRIMARYATTACK

SWEP.NoHitSoundFlesh = true

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.085)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav")
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/knife/knife_hitwall1.wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("weapons/knife/knife_hit"..math.random(4)..".wav")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() and not self.m_BackStabbing then
		local hitentyaw = hitent:GetForward():Angle().yaw
		local owneryaw = self:GetOwner():GetForward():Angle().yaw
		local yawDiff = math.abs(hitentyaw - owneryaw)

		if(yawDiff <= 90 or yawDiff >= 270) then
			self.m_BackStabbing = true
			self.MeleeDamage = self.MeleeDamage * self.BackstabMultiplier
		end
	end
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
	if self.m_BackStabbing then
		self.m_BackStabbing = false

		self.MeleeDamage = self.MeleeDamage / self.BackstabMultiplier
	end
end

if SERVER then
	function SWEP:InitializeHoldType()
		self.ActivityTranslate = {}
		self.ActivityTranslate[ACT_HL2MP_IDLE] = ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslate[ACT_HL2MP_WALK] = ACT_HL2MP_WALK_KNIFE
		self.ActivityTranslate[ACT_HL2MP_RUN] = ACT_HL2MP_RUN_KNIFE
		self.ActivityTranslate[ACT_HL2MP_IDLE_CROUCH] = ACT_HL2MP_IDLE_CROUCH_PHYSGUN
		self.ActivityTranslate[ACT_HL2MP_WALK_CROUCH] = ACT_HL2MP_WALK_CROUCH_KNIFE
		self.ActivityTranslate[ACT_HL2MP_GESTURE_RANGE_ATTACK] = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
		self.ActivityTranslate[ACT_HL2MP_GESTURE_RELOAD] = ACT_HL2MP_GESTURE_RELOAD_KNIFE
		self.ActivityTranslate[ACT_HL2MP_JUMP] = ACT_HL2MP_JUMP_KNIFE
		self.ActivityTranslate[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_KNIFE
	end
end