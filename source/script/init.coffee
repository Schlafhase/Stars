
# init.coffee
noise.seed Math.random()

surfaces = 
  stars:
    dirty: true
  nebula:
    dirty: true

container = null
stars = []
particles = []

width = 0
height = 0

leftGlowStrength = 1
rightGlowStrength = 0.9

worldTime = 0
dt = 10

period = 1/800
speed = 0.03

periodNebula = 1/1000
speedNebula = 0.3

clusterSize = 100

#averageParticleLifetime = 10000
#particleLifetimeVariation = 5000

absolutePos = (elm)->
  elm.style.position = "absolute"
  elm.style.top = elm.style.left = "0"
  elm.style.width = elm.style.height = "100%"


setupSurface = (surface)->
  surface.canvas = document.createElement "canvas"
  container.appendChild surface.canvas unless surface.visible == false
  absolutePos surface.canvas
  surface.context = surface.canvas.getContext "2d"
  
generateStars = (count)->
  for i in [0..count]
    stars.push
      x: Math.random() * width
      y: Math.random() * height
      size: Math.random() * 10
      hue: Math.random() * 360
      brightness: 1

generateParticles = (count)->
  for i in [0..count/clusterSize]
    surfaces.nebula.spawnCluster()

resize = ()->
  width = container.offsetWidth
  height = container.offsetHeight
  for name, surface of surfaces
    surface.canvas.width = width
    surface.canvas.height = height
  stars = []
  particles = []
  generateStars(200)
#  generateParticles(500)
  null

requestResize = ()->
  widthChanged = 2 < Math.abs width - container.offsetWidth
  heightChanged = 50 < Math.abs height - container.offsetHeight
  if widthChanged or heightChanged
    requestAnimationFrame ()->
      resize()
  
CanvasRenderingContext2D.prototype.drawCircle = (x, y, radius, color, alpha)->
  this.globalAlpha = alpha
  this.beginPath()
  this.arc x, y, radius, 0, 2 * Math.PI
  this.fillStyle = color
  this.fill()
  this.closePath()

CanvasRenderingContext2D.prototype.drawCircleFadingOut = (x, y, radius, color, alpha)->
  this.globalAlpha = alpha
  this.beginPath()
  this.arc x, y, radius, 0, 2 * Math.PI
  
  gradient = this.createRadialGradient x, y, 1, x, y, radius
  gradient.addColorStop 0, color
  gradient.addColorStop 1, "transparent"
  this.fillStyle = gradient
  
  this.fill()
  this.closePath()
  
mouseScroll = (e)->
  star.y += star.size for star in stars
#  p.y += p.hue/10 for p in particles