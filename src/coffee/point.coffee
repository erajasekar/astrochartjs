class Point
  constructor: (@x, @y) ->

  move: (x, y) -> new Point(@x + x, @y + y)