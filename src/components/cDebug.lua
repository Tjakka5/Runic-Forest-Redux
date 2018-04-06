local Fluid = require("lib.fluid")

local Debug = Fluid.component(function(e, ...)
   e.args = {...}
end)

return Debug