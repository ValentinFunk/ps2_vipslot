Pointshop2.ValidHatSlots = { }

local realName = "Accessory"
local function addRestrictedHatSlot( name, ranks )
	Pointshop2.AddEquipmentSlot( name, function( item )
		local owner = item:GetOwner() 

		if not table.HasValue( ranks, owner:GetUserGroup() ) then
			return false
		end
		
		local isHat = instanceOf( Pointshop2.GetItemClassByName( "base_hat" ), item )
		if not isHat then
			return false
		end
		
		local validForSlot = item:CanBeEquippedInSlot( name ) or item:CanBeEquippedInSlot( realName )
		if not validForSlot then
			return false
		end
		
		--Check for same class items:
		for _, slotName in pairs( Pointshop2.ValidHatSlots ) do
			local equipmentItem = Pointshop2.GetItemInSlot( item:GetOwner(), slotName )
			if equipmentItem then
				--Allow to move items between slots
				if equipmentItem == item then
					continue
				end
				
				if equipmentItem.class.className == item.class.className then
					return false
				end
			end
		end
		
		return true
	end )
	table.insert( Pointshop2.ValidHatSlots, name )
end

addRestrictedHatSlot( "VIP Slot", {
	--Ranks that can use the slot
	"vip",
	"superadmin"
} )