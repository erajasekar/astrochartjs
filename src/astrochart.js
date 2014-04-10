/**
 * Created by Rajasekar Elango on 4/3/14.
 */

function drawChart() {
    s = Snap(800, 600);
    var cellWidth = 100;
    var cellHeight = 100;

    s.rect(0, 0, cellWidth, cellHeight).attr({
        fill: 'white',
        stroke: 'black'
    });
    var planets = ["Su", "Mo", "Ma", "Me", "Ju", "Ve" , "Sa", "Ra", "Ke"];


    var x = 5;
    var y = 20;
    var xspacing = cellWidth / 3 ;
    var yspacing = cellHeight / 3;

    for (var i = 0; i < planets.length; ++i) {
        var planet = planets[i];

        var point = findLocation({x:x, y:y, width:cellWidth, height:cellHeight, gridPosition:i})
        s.text(point.x, point.y, planet);
    }

}

function findLocation(cell){
    var x = cell.x;
    var y = cell.y;
    var cellWidth = cell.width;
    var cellHeight = cell.height;
    var gridPosition = cell.gridPosition;
    var xMultiplier = Math.floor(gridPosition / 3 );
    var yMultiplier = (gridPosition % 3 );
    var gridWidth = cellWidth / 3;
    var gridHeight = cellHeight / 3;
    var point = {x:(xMultiplier * gridWidth) + x, y:(yMultiplier * gridHeight) + y};
    console.log(point);
    return point;

}