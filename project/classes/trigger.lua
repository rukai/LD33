Trigger = TDF.Class{ __includes = {Solid} }

function Trigger:Initialize()
	self.type = "Trigger"

    self.activated = false

    --animation
    self.image = love.graphics.newImage('assets/spritesheets/spring.png')
    local g = anim8.newGrid(69, 77, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(g('1-7','1-2', 6, 3), 0.03)

    --audio
    self.audio = love.audio.newSource("assets/sounds/spring.mp3")
end

function Trigger:draw()
	love.graphics.setColor( 255,255,255 )
    self.animation:draw(self.image, self.x, self.y-65)
end

function Trigger:update(dt)
    self.animation:update(dt)
end

function Trigger:RunOnEntity( ent )
    if ent.type == "Hero" and not self.activated then
        ent:Jump()
        self.audio:play()
        self.activated = true
    end
end
