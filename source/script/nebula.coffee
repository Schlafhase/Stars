
#nebula.coffee

surfaces.nebula.spawnCluster = ()->
  h = Math.random() * height
  w = Math.random() * width
  for j in [0..clusterSize]
    particles.push
      x: w + Math.random() * 200 - 100
      y: h + Math.random() * 200 - 100
      a: (j%2 == 0) * Math.PI
#      birthday: worldTime
#      lifetime: averageParticleLifetime + Math.random() * particleLifetimeVariation - particleLifetimeVariation/2

surfaces.nebula.render = (ctx)->
  return false unless particles.length > 0
  
  surfaces.nebula.canvas.style.opacity = worldTime/5000
  
  ctx.save()
  ctx.globalCompositeOperation = "destination-in"
  ctx.globalAlpha = 1
  ctx.fillStyle = "rgba(255, 255, 255, 0.95)"
  ctx.fillRect 0, 0, width, height
  ctx.restore()
  
  ctx.globalCompositeOperation = "source-over"

  for p in particles
    ctx.drawCircle p.x, p.y, 0.2, "hsl(#{p.hue}, 100%, 50%)", 0.05

  true

surfaces.nebula.simulate = ()->
  if particles.length < 500
    surfaces.nebula.spawnCluster()
  
  for p, i in particles by -1
#    if worldTime - p.birthday > p.lifetime
#      delete particles.splice i, 1
#      console.log "killed particle"
#      continue
    v = noise.perlin2(p.x*periodNebula, p.y*periodNebula)
    a = v * Math.PI * 2
    p.x += Math.sin(a+p.a)*speedNebula
    p.y += Math.cos(a+p.a)*speedNebula
    
    p.hue = v * 160 + 200

    [p.x, p.y] = outOfBounds p.x, p.y, 5
    

  surfaces.nebula.dirty = true