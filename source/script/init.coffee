
noise.seed Math.random()

surfaces = 
  stars:
    dirty: true
  nebula:
    dirty: true

container = null
stars = []

width = 0
height = 0

leftGlowStrength = 1
rightGlowStrength = 0.9

worldTime = 0
dt = 10

period = 1/800
speed = 0.2

absolutePos = (elm)->
  elm.style.position = "absolute"
  elm.style.top = elm.style.left = "0"
  elm.style.width = elm.style.height = "100%"


setupSurface = (surface)->
  surface.canvas = document.createElement "canvas"
  container.appendChild surface.canvas
  absolutePos surface.canvas
  surface.context = surface.canvas.getContext "2d"

resize = ()->
  width = container.offsetWidth
  height = container.offsetHeight
  for name, surface of surfaces
    surface.canvas.width = width
    surface.canvas.height = height
    surface.render?()
  null
  
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