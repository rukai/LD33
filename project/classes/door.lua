Door = TDF.Class{ __includes = {Solid} }

function Door:Initialize()
	self.type = "Door"
    self.image = love.graphics.newImage('assets/images/door.png')
end

function Door:draw()
    love.graphics.setColor( 255,255,255 )
    love.graphics.draw(self.image, self.x, self.y)
end
