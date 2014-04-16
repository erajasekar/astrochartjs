###
/**
* AstroChart is the top level class that provides api to draw hindu astrological charts
*
* @author Rajasekar Elango
*
/
###


@AstroChart = (elementId) ->
  this.elementId = elementId

  draw : (data, options) =>
    svg = Snap(elementId)

    addStyleSheet(elementId, options)

    Point startPosition = new Point(0,0);

    chartSize = new Dimension(options.width,options.height);

    svg.rect(startPosition.x, startPosition.y, chartSize.width, chartSize.height).attr(class:'chart');

    drawTitle(svg, startPosition, chartSize, options.title);

    houseSpacingWidth = CONSTANTS.get('HOUSE_SPACING_WIDTH');
    houseSpacingHeight = CONSTANTS.get('HOUSE_SPACING_HEIGHT');
    houseSize = computeHouseSize(chartSize, houseSpacingWidth, houseSpacingHeight);

    for houseNo in [1,2,3,4,5,6,7,8,9,10,11,12]
      Cell houseCell = getCellForHouse(houseNo)
      Point housePosition = startPosition.move((houseCell.row * (houseSize.width + houseSpacingWidth)), (houseCell.col * (houseSize.height + houseSpacingHeight)));
      log("--------")
      log(startPosition)
      log(housePosition)
      drawHouse(svg, housePosition , houseSize, houseNo, data[houseNo], options)

addStyleSheet = (elementId, options) =>
  svgElement = document.querySelector( elementId );
  styleElement = svgElement.getElementsByTagName("style")?[0]
  styleElement = if styleElement then styleElement else document.createElement( "style" );
  styleElement.setAttribute("type", "text/css");
  styleSheetUrl = if options.styleSheet then options.styleSheet else  CONSTANTS.get('DEFAULT_STYLE_SHEET')
  styleData = document.createTextNode(" @import url(#{styleSheetUrl})");
  styleElement.appendChild(styleData)
  svgElement.appendChild(styleElement);

getCellForHouse = (houseNo) ->
  switch (houseNo)
    when 1 then new Cell(1,0)
    when 2 then new Cell(2,0)
    when 3 then new Cell(3,0)
    when 4 then new Cell(3,1)
    when 5 then new Cell(3,2)
    when 6 then new Cell(3,3)
    when 7 then new Cell(2,3)
    when 8 then new Cell(1,3)
    when 9 then new Cell(0,3)
    when 10 then new Cell(0,2)
    when 11 then new Cell(0,1)
    when 12 then new Cell(0,0)
    else throw "houseNo should be between 1 and 12"

getItems = (data) ->
  switch(data?.length)
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

drawHouse = (svg, housePosition, houseSize, houseNumber, data, options) ->
  svg.rect(housePosition.x, housePosition.y, houseSize.width, houseSize.height).attr(class:'house');
  Dimension scaledSize = houseSize.scale(CONSTANTS.get('CELL_WIDTH_OFFSET_PERCENT'), CONSTANTS.get('CELL_HEIGHT_OFFSET_PERCENT'));
  Point cellPosition = housePosition.move( scaledSize.width, scaledSize.height);
  items = getItems(data)
  if items?
    for item in items
       point = computeCellLocation(cellPosition, houseSize, item.cell)
       styleClass = if /~R$/.test(item.text) then 'house retrograde' else 'house'
       svg.text(point.x, point.y, item.text).attr(class:styleClass, id : formatId(item.text));
  Point houseNumberLocation = computeHouseNumberLocation(housePosition, houseSize)

  if options.showHouseNumbers
    startHouseNumbersFrom = if options.startHouseNumbersFrom then options.startHouseNumbersFrom else 1;
    svg.text(houseNumberLocation.x, houseNumberLocation.y, computeHouseNumber(houseNumber, startHouseNumbersFrom)).attr(class :'houseNumber')
  return;

drawTitle = (svg, chartPosition, chartSize, title) ->
  Point titlePosition = computeTitleLocation(chartPosition, chartSize);
  text = svg.text(titlePosition.x, titlePosition.y , title).attr(class:'title');
  text.selectAll("tspan:nth-child(n+2)").attr({
              dy: "1.2em",
              x: titlePosition.x
          });


computeHouseNumberLocation = (housePosition, houseSize) ->
  Dimension scaledSize = houseSize.scale(CONSTANTS.get('HOUSE_NUMBER_WIDTH_OFFSET_PERCENT'), CONSTANTS.get('HOUSE_NUMBER_HEIGHT_OFFSET_PERCENT'));
  Point position = housePosition.move( scaledSize.width, scaledSize.height);
  return position

computeHouseNumber = (houseNumber, startHouseNumbersFrom) ->
  ((houseNumber - startHouseNumbersFrom) %% 12) + 1

computeCellLocation = (cellPosition,houseSize,cell) ->
  cellWidth = houseSize.width / CONSTANTS.get('CELL_TOTAL_ROWS')
  cellHeight = houseSize.height / CONSTANTS.get('CELL_TOTAL_COLS')
  point = cellPosition.move( (cell.row * cellWidth) , (cell.col * cellHeight) );
  log(point)
  point

computeTitleLocation = (chartPosition, chartSize) ->
  offset = chartSize.scale(0.5, 0.5)
  chartPosition.move(offset.width, offset.height)

computeHouseSize = (chartSize, houseSpacingWidth, houseSpacingHeight)->
  new Dimension(((chartSize.width - (3 * houseSpacingWidth))/4), ((chartSize.height - (3 * houseSpacingHeight))/4))

formatId = (text) ->
  text.replace(/\s+/g, "_")

log = (msg) ->
  CONSTANTS.get('DEBUG') and console.log(msg)


