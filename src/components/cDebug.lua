local Concord = require("lib.concord")

local Debug = Concord.component(function(e, ...)
   e.args = {...}
end)

return Debug