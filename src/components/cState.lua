local Concord = require("lib.concord")

local State = Concord.component(function(e, initialState, states)
   e.current = initialState or "default"
   e.states  = states       or {}
end, true)

function State.emit(e, action)
   local current = e.states[e.current]
   e.current = current[action] or e.current
end

return State