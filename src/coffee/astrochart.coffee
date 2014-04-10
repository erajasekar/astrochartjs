###
Created by Rajasekar Elango on 4/3/14.
###



###@AstroChart = (element) ->
  element###

@AstroChart = (elementId) ->
  this.elementId = elementId

  draw : (data, options) =>
    svg = Snap(elementId)
    houseSize = new Dimension(options.width,options.height);
    Point startPosition = new Point(0,0);
    for houseData in data
      for houseNo of houseData
        Point housePosition = startPosition.move((+houseNo + 1) * houseSize.width, startPosition.y);
        console.log(houseData[houseNo]);
        console.log(housePosition)
        drawHouse(svg, housePosition , houseSize, houseData[houseNo])

getItems = (data) ->
  switch(data.length)
    when 1
      items = [new Item(data[0], new Cell(1,1))]
    when 2
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(2,2))
              ]
    when 3
      items = [
                new Item(data[0], new Cell(0,1)),
                new Item(data[1], new Cell(2,0)),
                new Item(data[2], new Cell(2,2))
               ]
    when 4
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(0,2)),
                new Item(data[2], new Cell(2,0)),
                new Item(data[3], new Cell(2,2))
              ]
    when 5
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(0,2)),
                new Item(data[2], new Cell(2,0)),
                new Item(data[3], new Cell(2,2)),
                new Item(data[4], new Cell(1,1)),
             ]
    when 6
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(0,1)),
                new Item(data[2], new Cell(0,2)),
                new Item(data[3], new Cell(2,0)),
                new Item(data[4], new Cell(2,1)),
                new Item(data[5], new Cell(2,2))
              ]
    when 7
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(0,1)),
                new Item(data[2], new Cell(0,2)),
                new Item(data[3], new Cell(2,0)),
                new Item(data[4], new Cell(2,1)),
                new Item(data[5], new Cell(2,2)),
                new Item(data[6], new Cell(1,1))
              ]
    when 8
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(0,1)),
                new Item(data[2], new Cell(0,2)),
                new Item(data[3], new Cell(2,0)),
                new Item(data[4], new Cell(2,1)),
                new Item(data[5], new Cell(2,2)),
                new Item(data[6], new Cell(1,0)),
                new Item(data[7], new Cell(1,2))
              ]
    when 9
      items = [
                new Item(data[0], new Cell(0,0)),
                new Item(data[1], new Cell(0,1)),
                new Item(data[2], new Cell(0,2)),
                new Item(data[3], new Cell(1,0)),
                new Item(data[4], new Cell(1,1)),
                new Item(data[5], new Cell(1,2)),
                new Item(data[6], new Cell(2,0)),
                new Item(data[7], new Cell(2,1)),
                new Item(data[8], new Cell(2,2))
              ]
  items

drawHouse = (svg, housePosition, houseSize, data) ->
  svg.rect(housePosition.x, housePosition.y, houseSize.width, houseSize.height).attr
    fill: "white"
    stroke: "black"

  ##TODO compute offset based on percent
  Dimension scaledSize = houseSize.scale(0.05, 0.2);
  Point cellPosition = housePosition.move( scaledSize.width, scaledSize.height);
  for item in getItems(data)
     point = findLocation(cellPosition, houseSize, item.cell)
     svg.text(point.x, point.y, item.text)
  return;

findLocation = (cellPosition,houseSize,cell) ->
  gridWidth = houseSize.width / 3
  gridHeight = houseSize.height / 3
  point = cellPosition.move( (cell.row * gridWidth) , (cell.col * gridHeight) );
  console.log point
  point



