import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"



local gfx <const> = playdate.graphics

local playerSprite = nil
local playerSpeedX = 5
local facing = "LEFT"
local playerVelY = 0
local gravity = 3
local canJump=true
local jumpHeight = 40


function initGame()

   

   local playerImage = gfx.image.new("player.png")
    playerSprite = gfx.sprite.new(playerImage)
    playerSprite:moveTo( 200,120 )
    playerSprite:add()
    playerSprite:setCollideRect( 0, 0, playerSprite:getSize() )
    playerSprite:setGroups(1)
    playerSprite:setCollidesWithGroups(2)
    
   
   local stageImage = gfx.image.new("stage.png")
   stageSprite = gfx.sprite.new(stageImage)
   stageSprite:moveTo( 300,120 )
   stageSprite:add()
   stageSprite:setCollideRect( 0, 0, stageSprite:getSize() )
   stageSprite:setGroups(2)
   stageSprite:setCollidesWithGroups(1)

end

initGame()

function checkPlayerGrounded()
   
   collisionsArray = {playerSprite:checkCollisions(playerSprite.x, playerSprite.y+10)}
      
   local collisionsVal = {collisionsArray[4]}
   
   printTable({collisionsArray[4]})
   if {collisionsArray[4]} == 1 then
      playerGrounded = true
   end
  
   
end

function playerFacing()
    
    if facing == "RIGHT" then
       gfx.sprite.setImageFlip(playerSprite,gfx.kImageFlippedX)
       playerSprite:add()
    end
    if facing == "LEFT" then
       gfx.sprite.setImageFlip(playerSprite,gfx.kImageUnflipped)
       playerSprite:add()
    end
end


function playerGravity()
    
    if playerVelY >= 21 then
    playerVelY = 20
 else playerVelY = playerVelY+gravity
 end
 
    
    playerSprite:moveWithCollisions(playerSprite.x, playerSprite.y+playerVelY)
   
end

function playdate.update()

playerGravity()

if playdate.buttonIsPressed( playdate.kButtonLeft ) then
    playerSprite:moveWithCollisions(playerSprite.x-playerSpeedX, playerSprite.y)
    facing = "LEFT"
    playerFacing()
end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
    playerSprite:moveWithCollisions(playerSprite.x+playerSpeedX, playerSprite.y)
    facing="RIGHT"
    playerFacing()
end
if playdate.buttonIsPressed( playdate.kButtonDown ) then
    playerSprite:moveWithCollisions(playerSprite.x, playerSprite.y+playerSpeedX)
    
end
if playdate.buttonIsPressed( playdate.kButtonUp ) then
    playerSprite:moveWithCollisions(playerSprite.x, playerSprite.y-playerSpeedX)
    
end


checkPlayerGrounded()

if playdate.buttonIsPressed( playdate.kButtonA ) and canJump == true then
playerVelY = playerVelY - jumpHeight
canJump = false
 end
 if playerGrounded == true then
    canJump = true
 end
 
 if playdate.buttonIsPressed( playdate.kButtonB ) then
 canJump = true
 end

 gfx.sprite.update() -- note: DO NOT DELETE THIS. THIS IS VERY IMPORTANT.


end
