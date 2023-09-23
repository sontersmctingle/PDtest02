local gfx <const> = playdate.graphics

function playerFacing()
	
	if facing == 1 then
	   gfx.sprite.setImage(playerImage,"flipX")
	end
	if facing == 0 then
	   gfx.sprite.setImage(playerImage)
	end
end

function initGame()

	local playerImage = gfx.image.new("player.png")

	playerSprite = gfx.sprite.new(playerImage)
	playerSprite:moveTo( 200,120 )
	playerSprite:add()

end
