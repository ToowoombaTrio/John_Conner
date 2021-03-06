# John_Conner

GovHack 2016

[![Travis-CI Build Status](https://travis-ci.org/ToowoombaTrio/John_Conner.svg?branch=master)](https://travis-ci.org/ToowoombaTrio/John_Conner)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ToowoombaTrio/John_Conner?branch=master&svg=true)](https://ci.appveyor.com/project/ToowoombaTrio/John_Conner)

# Note

> This repository is a historical archive of the original John Conner project that was constructed during #GovHack2016 by the ToowoombaTrio. Any further development of the package is being conducted in the [WINS](https://github.com/ToowoombaTrio/WINS) repository. This R package and repository will not be updated further.

The John Conner project was initiated by the Toowoomba Trio to tackle a major and growing problem faced by Queensland vegetable growers. This challenge is Identifying and responding to heat stress in their crops. High temperatures can cause considerable stress to crops, reducing yields and the quality of the produce grown. However, if the stress is identified early enough remedial action can be taken to minimise the damage and save the crop. The John Conner project provides a timely warning system for farmers when a heat stress event has likely occurred. Please watch our [YouTube video]("https://www.youtube.com/watch?v=yECTDHx794E") describing the John Conner Project. The John Conner project is built in the R environment, an open source statistical programing environment. It utilises the QLD SILO patch point weather data, available from the QLD government data portal, and models hourly data using a temperature from [chillR](https://cran.r-project.org/web/packages/chillR/index.html). This downscaling is validated against the BoM hourly temperature data set, an official #GovHack 2016 data set, to show that there is good agreement between the modelled hourly data and the observed BoM data.

## Install this package

To install this R package and recreate what we've done this weekend for Govhack2016. Install the package and check out our vignette that details how to recreate what we've done.

```r
install.packages("devtools", dependencies = TRUE)
devtools::install_github("ToowoombaTrio/John_Conner")
```
