# John_Conner
GovHack 2016

[![Travis-CI Build Status](https://travis-ci.org/ToowoombaTrio/John_Conner.svg?branch=master)](https://travis-ci.org/ToowoombaTrio/John_Conner)

The John Conner project was initiated by the Toowoomba Trio to tackle a major and growing problem faced by Qld vegetable growers. This challenge is Identifying and responding to heat stress in their crops. High temperatures can cause considerable stress to crops, reducing yields and the quality of the produce grown. However, if the stress is identified early enough remedial action can be taken to minimise the damage and save the crop. The John Conner project provides a timely warning system for farmers when a heat stress event has likely occurred. Please watch our YouTube video describing the John Conner Project. The John Conner project is built in the R environment, an open source statistical programing environment. It utilises the QLD SILO patch point weather data, available from the QLD government data portal, and models hourly data using a temperature from [chillR](https://www.google.com.au/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwiuzaPjw53OAhXHHZQKHTWSCO8QFggdMAA&url=https%3A%2F%2Fcran.r-project.org%2Fpackage%3DchillR&usg=AFQjCNEIRLgNXIVRHBXk0sqkM9Z1RiR_qw&sig2=nze6usBjw95mnsgL7u0vdQ) This downscaling is validated against the BoM hourly temperature data set, an official GovHack data set, to show that there is good agreement between the modelled hourly data and the observed BoM data.

## Install this package
To install this R package and recreate what we've done this weekend for Govhack2016. Install the package and check out our vignette that details how to recreate what we've done.

```r
install.packages("devtools", dependencies = TRUE)
devtools::install_github("ToowoombaTrio/John_Conner")
```
