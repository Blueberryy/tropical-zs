AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.Slot = 5
SWEP.Tier = 6

SWEP.StatDPS = 1
SWEP.StatDPR = 4
SWEP.StatRange = 1
SWEP.StatSpecial = 5

SWEP.PrintName = "The Boomstick"
SWEP.Description = "fires all its shells at once. Sends you flying"

SWEP.TranslationName = "wep_boomstick"
SWEP.TranslationDesc = "wep_d_boomstick"

if CLIENT then
	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.65, 0, -8)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFlip = false
end

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadDelay = 0.5

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Damage = 300
SWEP.Primary.NumShots = BULLETPATTERN_SHOTGUN
SWEP.Primary.Delay = 1

SWEP.Recoil = 7.5

SWEP.Primary.ClipSize = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 28
SWEP.HeadshotMulti = 1.5

SWEP.ConeMax = 11.5
SWEP.ConeMin = 10

SWEP.MaxStock = 2

SWEP.WeightClass = WEIGHT_MEDIUM

SWEP.FireAnimSpeed = 0.4
SWEP.Knockback = 80

SWEP.PumpActivity = ACT_SHOTGUN_PUMP
SWEP.PumpSound = Sound("Weapon_Shotgun.Special1")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound(self.Primary.Sound)

	local clip = self:Clip1()

	self:ShootBullets(self.Primary.Damage * clip, self.Primary.NumShots, self:GetCone())

	self:TakePrimaryAmmo(clip)
	owner:ViewPunch(clip * 0.5 * self.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))

	owner:SetGroundEntity(NULL)
	owner:SetVelocity(-self.Knockback * clip * owner:GetAimVector())

	self.IdleAnimation = CurTime() + self:SequenceDuration()
end
