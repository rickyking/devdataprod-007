weatherDataShinyApp
========================================================
author: Yi JIN
date: 2014-11-20
font-family: 'Helvetica'




Idea
========================================================

My idea to create this application is to make a package/API more playable. By using the package [weatherData](http://ram-n.github.io/weatherData/).

The package try to get the data from [Weather Undergroud](http://www.wunderground.com). This is really interesting to get the historical data to do the analysis. 

My application illustrate the main functionality of the package: get the airport code for the city and with the code get the weather data with or without detailed information in the selected date range.

Functionality of Airport Code search
========================================================

With the function `getStationCode()`, here is an example:


```r
getStationCode("New York") 
```

```
[[1]]
          Station State airportCode
1095 New York JFK    NY        KJFK
1099     New York    NY        KLGA

[[2]]
[1] "USA NEW YORK           03-DEC-13"                                                       
[2] "USA NY NEW YORK/ARTCC   KZNY  ZNY          40 48N  073 06W   48         A          8 US"
```

The first element return the two results of the search. We then put the search result in "select input" widget to leave the user to choose the airport.


Check data availability
========================================================

<small>
Each time, we provide the action button "check availability". Once the user click on that button. We will use the function `checkDataAvailabilityForDateRange()` in order to see if the data is available. Here is an example of return (1 for available):


```r
checkDataAvailabilityForDateRange("KJFK", start="2014-11-20", end = "2014-11-20")
```

```
[1] 1
```
</small>

Get and show the data
========================================================

Once the data is available. Click on the "Get data" button. Now you should wait a moment in order to get the real time data via API of weather underground.


```r
getWeatherForDate("KJFK", start="2014-11-20", end = "2014-11-20", opt_detailed = T)
```

