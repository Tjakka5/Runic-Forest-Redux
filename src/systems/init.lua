local PATH = (...):gsub('%.init$', '')

return {
   spriteRenderer = require(PATH..".sSpriteRenderer"),
   
   devSystem = require(PATH..".sDevSystem"),
}