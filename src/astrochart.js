/**
 * Created by Rajasekar Elango on 4/3/14.
 */

function drawChart() {
    s = Snap(800, 600);

    s.rect(0, 0, 100, 100).attr({
        fill: 'white',
        stroke: 'black'
    });
    s.text(5, 10, "Sun");
}