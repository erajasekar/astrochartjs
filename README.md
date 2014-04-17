astrochartjs
============

Javascript library for drawing hindu astrological charts.

Usage
-----

###Html File

* astrochartjs uses [snapsvg](http://snapsvg.io/) for rendering `svg` . So [download snapsvg](https://github.com/adobe-webplatform/Snap.svg/archive/v0.2.0.zip) and include in your html. Eg.

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


