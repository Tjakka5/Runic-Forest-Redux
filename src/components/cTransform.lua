local Fluid  = require("lib.fluid")
local Vector = require("lib.vector")

local Transform = Fluid.component(function(e, position, facing)
   e.position = position or Vector(0, 0)
   e.facing   = facing   or 1
end)

return Transform
