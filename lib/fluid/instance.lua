local PATH = (...):gsub('%.[^%.]+$', '')

local List = require(PATH..".list")

local Instance = {}
Instance.__index = Instance

--- Creates a new Instance.
-- @return The new instance
function Instance.new()
   local instance = setmetatable({
      entities     = List(),
      systems      = List(),
      events       = {},
      removed      = {},
   }, Instance)

   return instance
end

--- Adds an Entity to the Instance.
-- @param e The Entity to add
-- @return self
function Instance:addEntity(e)
   e.instances:add(self)
   self.entities:add(e)
   self:checkEntity(e)

   return self
end

--- Checks an Entity against all the systems in the Instance.
-- @param e The Entity to check
-- @return self
function Instance:checkEntity(e)
   for i = 1, self.systems.size do
      self.systems:get(i):__check(e)
   end

   return self
end

--- Marks an Entity as removed from the Instance.
-- @param e The Entity to mark
-- @return self
function Instance:removeEntity(e)
   self.removed[#self.removed + 1] = e

   return self
end

--- Completely removes all marked Entities in the Instance.
-- @return self
function Instance:flush()
   if #self.removed > 0 then
      for i = 1, #self.removed do
         local e = self.removed[i]

         e.instances:remove(self)
         self.entities:remove(e)

         for i = 1, self.systems.size do
            self.systems:get(i):__remove(e)
         end
      end

      self.removed = {}
   end

   return self
end

--- Adds a System to the Instance.
-- @param system The System to add
-- @param eventName The Event to register to
-- @param callback The function name to call. Defaults to eventName
-- @param enabled If the system is enabled. Defaults to true
-- @return self
function Instance:addSystem(system, eventName, callback, enabled)
   if system.__instance and system.__instance ~= self then
      error("System already in instance '" ..tostring(system.__instance).."'")
   end

   if not self.systems:has(system) then
      self.systems:add(system)
      system.__instance = self
   end

   if eventName then
      self.events[eventName] = self.events[eventName] or {}

      local i = #self.events[eventName] + 1
      self.events[eventName][i] = {
         system   = system,
         callback = callback or eventName,
         enabled  = enabled == nil and true or enabled,
      }
   end

   return self
end

--- Enables a System in the Instance.
-- @param system The System to enable
-- @param eventName The Event it was registered to
-- @param callback The callback it was registered with. Defaults to eventName
-- @return self
function Instance:enableSystem(system, eventName, callback)
   return self:setSystem(system, eventName, callback, true)
end

--- Disables a System in the Instance.
-- @param system The System to disable
-- @param eventName The Event it was registered to
-- @param callback The callback it was registered with. Defaults to eventName
-- @return self
function Instance:disableSystem(system, eventName, callback)
   return self:setSystem(system, eventName, callback, false)
end

--- Sets a System 'enable' in the Instance.
-- @param system The System to set
-- @param eventName The Event it was registered to
-- @param callback The callback it was registered with. Defaults to eventName
-- @param enable The state to set it to
-- @return self
function Instance:setSystem(system, eventName, callback, enable)
   callback = callback or eventName

   local listeners = self.events[eventName]

   if listeners then
      for i = 1, #listeners do
         local listener = listeners[i]

         if listener.system == system and listener.callback == callback then
            listener.enabled = enable
            break
         end
      end
   end

   return self
end

--- Emits an Event in the Instance.
-- @param eventName The Event that should be emitted
-- @param ... Parameters passed to listeners
-- @return self
function Instance:emit(eventName, ...)
   self:flush()
   
   local listeners = self.events[eventName]

   if listeners then
      for i = 1, #listeners do
         local listener = listeners[i]

         if listener.enabled then
            listener.system[listener.callback](listener.system, ...)
         end
      end
   end

   return self
end

return setmetatable(Instance, {
   __call = function(_, ...) return Instance.new(...) end,
})
