Hero = TDF.Class{ __includes = {ENTITY} }

function Hero:Initialize()

	self.type = "Hero"
	self.dx = 100
	self.grounded = false
	self.hitbox.h = self.hitbox.h - 4

	--animation
	self.image = love.graphics.newImage('assets/spritesheets/knight.png')
	local g = anim8.newGrid(self.w+40, self.h+20, self.image:getWidth(), self.image:getHeight())
	self.animation = anim8.newAnimation(g('1-7','1-2','1-5','3-3'), 0.03)

	--generate a name
	self.FancyName = "Default Name"
	local name = TDF.Names[ math.random( #TDF.Names ) ]
	local adj = TDF.Adjectives[ math.random( #TDF.Adjectives ) ]
	self.FancyName = "Sir "..name.." the "..adj

    --load audio
    dir = "assets/sounds/"
    self.audio = {}
    self.audio.death = love.audio.newSource(dir .. "death1.mp3", "static")
    self.audio.win = {}
    for i = 1, 6 do
        table.insert(self.audio.win, love.audio.newSource(dir .. "voice/win" .. i .. ".wav"))
    end
end

function Hero:IsOnGround()
	return self.grounded
end

function Hero:draw()
	if not self.alive then
		love.graphics.setColor( 255,0,0, 255 )
	end
	self.animation:draw( self.image, self.x-20, self.y-20 )
end

function Hero:Jump()
	if self:IsOnGround() then
		--print("grounded and jumping")
		self.dy = -200
		--print( self.dx, self.dy )
		self.grounded = false
	end
end

function Hero:OnCollide( ent1, vert, horz )
	--self.grounded = true
	if vert then
		self.grounded = true
	end
	if horz then
		--print("hit wall")
		self.dx = -10
		self.x = self.x + self.dx/60

		self:Jump()
	end
end

function Hero:Update2( dt )
	--self:Jump()
	self.animation:update( dt * ( math.abs(self.dx) / 100 ) )
	self.ddx = 70
	if self:IsOnGround() == false then self.ddx = 0 end
	self.dx = math.clamp( self.dx, -1000, 70 )

    if self.x > 2325 and not winState then
        self.audio.win[math.random(6)]:play()
        winState = true
    end

    if winState then
		self.dy = -200
		self.grounded = false
    end
end

function Hero:OnKill()
	self:Jump()
	self.dx = 0
    self.audio.death:play()
end
