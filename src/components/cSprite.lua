local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local Sprite = Concord.component(function(e, textures, color, shear)
   e.textures = textures or {}
   e.color    = color    or {255, 255, 255, 255}
   e.shear    = shear    or Vector(0, 0)
end)

return Sprite