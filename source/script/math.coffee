

# math.coffee
clamp = (x, a, b)->
  return Math.min (Math.max x, a), b
  
clamp01 = (x)->
  return clamp x, 0,1