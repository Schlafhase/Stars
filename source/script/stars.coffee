
# stars.coffee
surfaces.stars.render = (ctx)->
  return false unless stars.length > 0

  surfaces.stars.context.clearRect 0, 0, width, height
  
  for star in stars
    # outer glow
    ctx.drawCircleFadingOut star.x, star.y, star.size*1.5*star.brightness, "hsl(#{star.hue}, 20%, #{50*star.brightness}%)", 0.1
    
    # inner glow
    ctx.drawCircle star.x, star.y, star.size/2*star.brightness, "hsl(#{star.hue}, 40%, #{50*star.brightness}%)", 0.1
    
    # star
    ctx.drawCircle star.x, star.y, (Math.min star.size/5, 1), "hsl(#{star.hue}, 50%, #{90*star.brightness}%)", 1
  
  ctx.drawCircleFadingOut 200, height+300, 1500*leftGlowStrength, "blue", 0.03
  ctx.drawCircleFadingOut width, 0, 1500*rightGlowStrength, "orange", 0.03
    
  true
  
surfaces.stars.simulate = ()->
  for star in stars
    v = noise.perlin2(star.x*period*star.size, star.y*period*star.size) * Math.PI * 2
    star.x += Math.sin(v)*speed
    star.y += Math.cos(v)*speed

    [star.x, star.y] = outOfBounds star.x, star.y, star.size
    
    star.brightness = noise.perlin2(star.x*star.size*0.1, star.y*star.size*0.1)/2 + 1.2
    if star.brightness < 0
      console.log v
    
  surfaces.stars.dirty = true
  
outOfBounds = (x, y, size)->
  if x - size*1.5 > width
    return [-size*1.4, y]
  else if x + size*1.5 < 0
    return [width+size*1.4, y]
  else if y - size*1.5 > height
    return [x, -size*1.4]
  else if y + size*1.5 < 0
    return [x, height+size*1.4]
  return [x, y]