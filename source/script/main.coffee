

#main.coffee
tick = ()->
  for name, surface of surfaces
    surface.render? surface.context if surface.dirty
    surface.dirty = false
    surface.simulate?()
  worldTime += dt
  requestAnimationFrame(tick)

start = (c)->
  container = c
  setupSurface surface for name, surface of surfaces
  surfaces.nebula.canvas.style.filter = "blur(10px)"

  window.addEventListener "resize", requestResize
  window.addEventListener "scroll", mouseScroll
  resize()
  
      
  requestAnimationFrame(tick)
    
Stars = ()->
  start: start