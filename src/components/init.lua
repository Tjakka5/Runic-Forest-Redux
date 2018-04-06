local PATH = (...):gsub('%.init$', '')

return {
   transform = require(PATH..".cTransform"),
   sprite = require(PATH..".cSprite"),
   state = require(PATH..".cState"),

   debug = require(PATH..".cDebug")
}