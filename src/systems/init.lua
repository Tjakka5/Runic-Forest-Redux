local PATH = (...):gsub('%.init$', '')

return {
   spriteRenderer = require(PATH..".sSpriteRenderer"),
   physics = require(PATH..".sPhysics"),

   devSystem = require(PATH..".sDevSystem"),
}