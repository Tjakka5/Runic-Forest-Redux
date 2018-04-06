local Fluid = require("lib.fluid")

local C = require("src.components")

local DevSystem = Fluid.system({C.debug})

function DevSystem:init(e, e2)
   self.e = e
   self.e2 = e2
end

function DevSystem:update(dt)
end

function DevSystem:draw()
end

function DevSystem:keypressed(key)
   local state = self.e2:get(C.state)

   if key == "i" then state:emit("rest") end
   if key == "j" then state:emit("jump") end

   print(state.current)


end

function DevSystem:keyreleased(key)
end

function DevSystem:mousepressed(x, y, button)
end

function DevSystem:mousereleased(x, y, button)
end

return DevSystem