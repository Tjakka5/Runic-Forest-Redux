local Concord = require("lib.concord")

local C = require("src.components")

local Physics = Concord.system({C.transform, C.body})

function Physics:init(friction, gravity)
   self.friction = friction or 0
   self.gravity  = gravity or 0
end

function Physics:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local body      = e:get(C.body)

      body.velocity.y = body.velocity.y + self.gravity * body.gravityScale * dt

      local vx = (body.velocity.x * (self.friction * body.airCoef) * dt)
      body.velocity.x = body.velocity.x > 0 and math.max(0, body.velocity.x - vx) or body.velocity.x
      body.velocity.x = body.velocity.x < 0 and math.min(0, body.velocity.x - vx) or body.velocity.x

      transform.position:add(body.velocity * dt)
   end
end

function Physics:drawDebug()
   love.graphics.push("all")
   love.graphics.setColor(255, 0, 0)

   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local body      = e:get(C.body)

      local x1, y1 = transform.position:unpack()
      local x2, y2 = (transform.position + body.velocity / 5):unpack()

      love.graphics.line(x1, y1, x2, y2)
   end

   love.graphics.pop()
end

return Physics