###
Created by Rajasekar Elango on 4/3/14.
###


@AstroChart = (element) ->
  element

AstroChart.drawChart = ->
  svg = Snap(800, 600)
  houseSize = new Dimension(100,100);
  svg.rect(0, 0, houseSize.width, houseSize.height).attr
    fill: "white"
    stroke: "black"

  ###planets = [
    "Su"
    "Mo"
    "Ma"
    "Me"
    "Ju"
    "Ve"
    "Sa"
    "Ra"
    "Ke"
  ]###

  planets = [
      "Mo"]

  drawHouse(svg, new Point(5,20), houseSize, planets);

  ### x = 5
  y = 20
  xspacing = cellWidth / 3
  yspacing = cellHeight / 3
  i = 0

  while i < planets.length
    planet = planets[i]
    point = findLocation(
      new Point(x,y),
      new Dimension(cellWidth, cellHeight),
      i
    )
    s.text point.x, point.y, planet
    ++i###

  return

getCells = (items) ->
  switch(items.length)
    when 1
      cells = [new Cell(1,1, items[0])]
    when 2
      cells = [new Cell(0,0, items[0]), new Cell(2,2, items[1])]
  cells

drawHouse = (svg, housePosition, houseSize, items) ->
  for cell in getCells(items)
     point = findLocation(housePosition, houseSize, cell)
     svg.text(point.x, point.y, cell.item)
  return;

findLocation = (housePosition,houseSize,cell) ->
  gridWidth = houseSize.width / 3
  gridHeight = houseSize.height / 3
  point = housePosition.move( (cell.row * gridWidth) , (cell.col * gridHeight) );
  console.log point
  point



