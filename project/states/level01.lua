TDF.States.Level01 = {}

local state = TDF.States.Level01
state.Entities = {}
state.Solids = {}

local levelSolids = {
	{ 500, 576-157, 55*2, 55*4 },
	{ 500+500, 576-157, 55*2, 55*4 },
	{ 500+500+500, 576-157, 55*8, 55*4 },
	{ -55*10, 576-55, 55*100, 55*10 },

}

function state:init()
	
	for i = 1, #levelSolids do
		v = levelSolids[i]
		local newSolid = Grass( v[1],v[2],v[3],v[4] )

		TDF.AddClassToGameState( self, newSolid )
		table.insert( self.Solids, newSolid )

	end

	local newHero = Hero( 0, 576-102-64, 70-40, 107-20 )

	newHero:SetCollisionTable( self.Solids )

	TDF.AddClassToGameState( self, newHero )

	local newMob = Mob(500, 200, 56-20, 56-20)

	newMob:SetCollisionTable( self.Solids )
    TDF.AddClassToGameState( self, newMob )

	-- create a trigger to make the jumping do the happen
	local jumpTrigger = Trigger( 420, 576-55-2, 16, 2 )

	function jumpTrigger:RunOnEntity( ent )
		if ent.type == "Hero" then
			ent:Jump()
		end
	end

	TDF.AddClassToGameState( self, jumpTrigger )

	local jumpTrigger = Trigger( 420 + 500, 576-55-2, 16, 2 )

	function jumpTrigger:RunOnEntity( ent )
		if ent.type == "Hero" then
			ent:Jump()
		end
	end

	--TDF.AddClassToGameState( self, jumpTrigger )

	local jumpTrigger = Trigger( 420 + 500 + 500, 576-55-2, 16, 2 )

	function jumpTrigger:RunOnEntity( ent )
		if ent.type == "Hero" then
			ent:Jump()
		end
	end

	--TDF.AddClassToGameState( self, jumpTrigger )


	local player = Ghost( 100, 100, 40, 40)

	TDF.AddClassToGameState( self, player )

	self.player = player
end

function state:enter()
	
end

function state:leave()

end

function state:keypressed( key, isRepeat )
	if key == " " then

		if self.player.possessing == false then

			local foundcollider = false
			local target = nil
			for k,v in ipairs( self.Entities ) do
				if v.type == "Mob" then
					if TDF.CheckCollide( v, self.player ) then
						foundcollider = true
						target = v
					end
				end
			end

			if target then
				target:Possess( self.player )
				self.player.possesstarget = target
				self.player.possessing = true
			end

		elseif self.player.possessing then

			self.player.possesstarget:UnPossess()
			self.player.possessing = false
			self.player.possesstarget = nil
		end

	end
end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )

	-- check trigger collisions
	for k, v in ipairs( self.Entities ) do
		if v.type == "Trigger" then
			for k2, v2 in ipairs( self.Entities ) do
				if v2.type ~= "Solid" and v2.hitbox then
					local collide, horz, vert = TDF.CheckCollide( v, v2 )
					if collide and v2 then
						v:RunOnEntity( v2 )
					end
				end
			end
		end
	end
end

function state:draw( )
	TDF.Cam:attach()
	--love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )

	TDF.Cam:detach()

end
