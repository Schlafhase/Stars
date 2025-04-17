
tick = ()->
  for name, surface of surfaces
    surface.context.clearRect 0, 0, width, height
    surface.render? surface.context if surface.dirty
    surface.dirty = false
    surface.simulate?()
  worldTime += dt
  setTimeout(tick, dt)

start = (c)->
  container = c
  setupSurface surface for name, surface of surfaces
  resize()

  for i in [0..500]
    stars.push
      x: Math.random() * 1920
      y: Math.random() * 1080
      size: Math.random() * 10
      hue: Math.random() * 360
      
  setTimeout(tick, 0)
    
Stars = ()->
  start: start