local Class  = require("lib.class")
local Vector = require("lib.vector")

local Texture = Class()

function Texture:init(pathToSource, frameCount, duration, looping, origin)
   self.source  = love.graphics.newImage(pathToSource)
   self.frames  = {}

   local sw, sh = self.source:getDimensions()
   local w, h   = sw / frameCount, sh
   
   for frame = 1, frameCount do
      local x = (frame - 1) * w
      self.frames[frame] = love.graphics.newQuad(x, 0, w, h, sw, sh) 
   end

   self.maxWait = duration or 0 / frameCount
   self.curWait = 0
   self.looping = looping or false

   local ox = (origin and origin.x or 0.5) * w
   local oy = (origin and origin.y or 0.5) * h
   self.origin  = Vector(ox, oy)

   self.curFrame = 1
   self.finished = false
end

function Texture:update(dt)
   if #self.frames > 1 then
      self.curWait = self.curWait + dt

      while self.curWait >= self.maxWait do
         self.curWait = self.curWait - self.maxWait

         if self.looping then
            --self.curFrame = (self.curFrame + 1) % (#self.frames + 1)
            self.curFrame = self.curFrame + 1

            if self.curFrame > #self.frames then
               self.curFrame = 1
            end
         elseif not self.finished then
            self.curFrame = self.curFrame + 1
            self.finished = self.curFrame == #self.frames
         end
      end
   end
end

function Texture:rewind()
   self.curFrame = 1
   self.curWait  = 0
end

function Texture:getCurrent()
   return self.frames[self.curFrame]
end

return Texture