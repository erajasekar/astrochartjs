astrochartjs
============

Javascript library for drawing hindu astrological charts. You can look at demo of charts drawn using astrochartjs [at demo page](http://erajasekar.github.io/astrochartjs-demo/)

Usage
-----

###Html File

* astrochartjs uses [snapsvg](http://snapsvg.io/) for rendering `svg` . So [download snapsvg](https://github.com/adobe-webplatform/Snap.svg/archive/v0.2.0.zip) and include `snap.svg.js` file from `dist` folder in your html. Eg.

```html
<script src="../lib/snapsvg/snap.svg.js"></script>
```

* [Download astrochartjs](https://github.com/erajasekar/astrochartjs/archive/master.zip) and include `astrochart.js` from `dist` dir in your html. Eg

```html
<script src="../dist/astrochart.js"></script>
```

* Add a `svg` element to your html file with unique id. Eg:

```html
<svg id="chart" />
```

###Javascript

* Create instance of `AstroChart` by passing `id` of `svg` element in html. 

```javascript
var astroChart = new AstroChart("#chart");
```
* Call draw method with chart data and options to draw chart. Eg:

```javascript
var options = {
        'title': ['Rasi', '11/04/2014 07:00AM', 'Erode, Tamil Nadu, India'],
            'width': 600,
            'height': 400
};

var astroChart = new AstroChart("#chart");
astroChart.draw({
    1: ["Su", "Ke"],
    3: ["Ju"],
    6: ["Ma", "Asc"],
    7: ["Mo", "Sa", "Ra"],
    11: ["Ve"],
    12: ["Me"]
}, options);
```

**`draw()` method parameters**

|Name|Type|Description
|----|----|----------
data |Object| Map of chart data with house number (1 to 12) as key and array of planets in that house as value. In above example first house contains **"Su"** and **"Ke"**, second house contains **"Ju"** etc.. 
options|Object| Map of key/value pair of options


**Supported `options`**

|Name|Type  |Description
|----|------|----------
width|int|Width of the chart
height|int|Height of the chart
styleSheet|url string|Url of custom stylesheet to use
showHouseNumbers|boolean|Show house number on each house of the chart
startHouseNumbersFrom|int(1-12)|Starting house number when showHouseNumbers is true. Useful if you want to begin numbering from Ascendant.


