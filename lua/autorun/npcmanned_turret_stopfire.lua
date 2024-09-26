if SERVER then
    AddCSLuaFile()
    util.AddNetworkString( "npcmanned_TurretBlockAttackToggle" )

elseif CLIENT then
    local shouldBlockAttack = false

    net.Receive( "npcmanned_TurretBlockAttackToggle", function()
        local blockBit = net.ReadBit()

        if blockBit == 1 then
            shouldBlockAttack = true
        elseif blockBit == 0 then
            shouldBlockAttack = false
        end
    end )


    hook.Add( "CreateMove", "npcmanned_RedirectTurretAttack", function( cmd )
        local ply = LocalPlayer()

        if shouldBlockAttack and IsValid( ply ) and bit.band( cmd:GetButtons(), IN_ATTACK ) > 0 then
            cmd:SetButtons( bit.bor( cmd:GetButtons() - IN_ATTACK, IN_BULLRUSH ) )

        end

        if shouldBlockAttack and IsValid( ply ) and bit.band( cmd:GetButtons(), IN_ATTACK2 ) > 0 then
            cmd:SetButtons( bit.bor( cmd:GetButtons() - IN_ATTACK2, IN_BULLRUSH ) )

        end
    end )
end
