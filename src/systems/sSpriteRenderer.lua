local Fluid = require("lib.fluid")

local C = require("src.components")

local SpriteRenderer = Fluid.system({C.transform, C.sprite})

local function getState(e)
   local sprite = e:get(C.sprite)
   local state  = e:get(C.state)

   return state and sprite.textures[state.current] and state.current or "default"
end

function SpriteRenderer:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local sprite = e:get(C.sprite)
      
      local texture = sprite.textures[getState(e)]
      texture:update(dt)
   end
end

function SpriteRenderer:draw()
   love.graphics.push("all")

   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local sprite    = e:get(C.sprite)

      local texture = sprite.textures[getState(e)]
      local x, y = math.floor(transform.position.x + 0.5), math.floor(transform.position.y + 0.5)

      love.graphics.setColor(sprite.color)
      love.graphics.draw(texture.source, texture:getCurrent(), x, y, 0, 4, 4, texture.origin.x, texture.origin.y, sprite.shear.x, sprite.shear.y)
   end

   love.graphics.pop()
end

return SpriteRenderer