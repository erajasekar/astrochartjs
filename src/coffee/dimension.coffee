class Dimension
  constructor: (@width, @height) ->

  scale: (x, y) -> new Dimension(@width * x, @height * y)