function love.conf(t)
   t.identity              = "Runic Forest Redux"
   t.appendidentity        = true
   t.version               = "11.0"
   t.console               = true
   t.accelerometerjoystick = false
   t.gammacorrect          = true

   t.audio.mixwithsystem = false
   
   t.window.title  = "Runic Forest Redux"
   t.window.icon   = nil
   t.window.width  = 1280
   t.window.height = 720
   t.window.vsync  = 0

   t.modules.data     = false
   t.modules.joystick = false
   t.modules.physics  = false
   t.modules.thread   = false
   t.modules.touch    = false
   t.modules.video    = false
end