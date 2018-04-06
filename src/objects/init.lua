local PATH = (...):gsub('%.init$', '')

return {
   texture = require(PATH..".oTexture"),
}