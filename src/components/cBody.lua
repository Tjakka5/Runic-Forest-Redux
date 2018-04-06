local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local Body = Concord.component(function(e, velocity, airCoef, groundCoef, gravityScale)
   e.velocity     = velocity     or Vector(0, 0)
   e.airCoef      = airCoef      or 1
   e.groundCoef   = groundCoef   or 1
   e.gravityScale = gravityScale or 1
end)

return Body