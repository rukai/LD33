TDF.States.Ingame_Test = {}

local state = TDF.States.Ingame_Test
state.Entities = {}
state.Solids = {}

local levelSolids = {
	{ 0, 300, 400, 100 },
	{ 200, 0, 24, 1000 }
}

function state:init()
	
	for k,v in ipairs( levelSolids ) do

		local newSolid = Solid( v[1],v[2],v[3],v[4] )

		TDF.AddClassToGameState( self, newSolid )
		table.insert( self.Solids, newSolid )

	end

	local newHero = Hero( 100, 100, 32, 64 )

	newHero:SetCollisionTable( self.Solids )

	TDF.AddClassToGameState( self, newHero )

	local player = Ghost( 100,100, 20, 20 )

	TDF.AddClassToGameState( self, player )
end

function state:enter()
	
end

function state:leave()

end

function state:update( dt )
	TDF.UpdateGameStateEntities( self, dt )
end

function state:draw( )
	TDF.Cam:attach()
	--love.graphics.print("Menu State", 32, 32)
	TDF.DrawGameStateEntities( self )

	TDF.Cam:detach()

end
