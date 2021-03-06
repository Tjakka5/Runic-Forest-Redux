love.graphics.setDefaultFilter("nearest", "nearest")

local Concord = require("lib.concord").init({
   useEvents = true
})
local Vector = require("lib.vector")

local C = require("src.components")
local S = require("src.systems")
local O = require("src.objects")

local Game = require("src.instances.game")
Concord.addInstance(Game)

local spriteRenderer = S.spriteRenderer()
local physics = S.physics(0.8, 10)

Game:addSystem(spriteRenderer, "update")
Game:addSystem(physics, "update")

Game:addSystem(spriteRenderer, "draw")
Game:addSystem(physics, "draw", "drawDebug")

local testEntity = Concord.entity()
:give(C.transform, Vector(500, 100))
:give(C.sprite, {
   idle      = O.texture("assets/entities/enemies/bat/idle.png", 2, 0.1, true),
   attacking = O.texture("assets/entities/enemies/bat/attacking.png", 1, 0, false),
})
:give(C.state, "idle", {
   idle = {
      attack = "attacking",
   },
   attacking = {
      rest = "idle",
   }
})
:give(C.body, Vector(-30, 200))

--Game:addEntity(testEntity)

local testEntity2 = Concord.entity()
:give(C.transform, Vector(300, 100))
:give(C.sprite, {
   idle    = O.texture("assets/entities/enemies/slime/idle.png", 1),
   jumping = O.texture("assets/entities/enemies/slime/jump.png", 6, 0.1, true),
})
:give(C.state, "idle", {
   idle = {
      jump = "jumping",
   },
   jumping = {
      rest = "idle",
   }
})
:give(C.body, Vector(300, 0), nil, nil, 0)

Game:addEntity(testEntity2)

local devSystem = S.devSystem(testEntity, testEntity2)
Game:addSystem(devSystem, "update")
Game:addSystem(devSystem, "draw")
Game:addSystem(devSystem, "keypressed")
Game:addSystem(devSystem, "keyreleased")
Game:addSystem(devSystem, "mousepressed")
Game:addSystem(devSystem, "mousereleased")