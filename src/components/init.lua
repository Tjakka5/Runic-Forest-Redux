local PATH = (...):gsub('%.init$', '')

return {
   transform = require(PATH..".cTransform"),
   sprite = require(PATH..".cSprite"),
   state = require(PATH..".cState"),
   body = require(PATH..".cBody"),

   debug = require(PATH..".cDebug")
}