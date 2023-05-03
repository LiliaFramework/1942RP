--[[ MODEL INFO
Recommended FOV: 65 +-5

Hold type:  slam

Sequences/ACTS(30 fps):

idle		ACT_VM_IDLE
lock		ACT_VM_PRIMARYATTACK
unlock		ACT_VM_SECONDARYATTACK
lock_alt	ACT_VM_PICKUP
unlock_alt	ACT_VM_RELEASE
draw		ACT_VM_DRAW
press_1		ACT_VM_HITCENTER
press_2		ACT_VM_HITCENTER2
no
--]]
if CLIENT then
    SWEP.PrintName = "Keys"
    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
end

SWEP.PrintName = "House Keys"
SWEP.Author = "Leonheart"
SWEP.Instructions = "Left click to lock\nRight click to unlock"
SWEP.Base = "weapon_base"
SWEP.UseHands = true
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Keys"
SWEP.ViewModel = "models/barata/keys/weapons/c_key.mdl"
SWEP.WorldModel = "models/barata/keys/weapons/w_key.mdl"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self:SetHoldType("slam")
end

function SWEP:Deploy()
    self:SetHoldType("slam")
    self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 5)
    local client = self:GetOwner()
    local character = client:getChar()
    local entity = client:GetEyeTrace().Entity
    local tab = entity:GetSaveTable()

    for a, variable in pairs(self.AvailableHouses) do
        if variable.id ~= character:getData("property_owned", "nil") then
            client:ChatPrint("Uh-oh, you are not meant to have this SWEP!")

            return
        else
            if entity:GetName() == variable.door1 or entity:GetName() == variable.door2 or entity:GetName() == variable.door3 or entity:GetName() == variable.door4 or entity:GetName() == variable.door5 then
                if tab.m_bLocked then
                    client:ChatPrint("You unlocked this door!")
                    entity:Fire("unlock", "", .1)
                else
                    client:ChatPrint("You locked this door!")
                    entity:Fire("lock", "", .1)
                end
            else
                client:ChatPrint("This key doesn't fit here!")
            end
        end
    end
end