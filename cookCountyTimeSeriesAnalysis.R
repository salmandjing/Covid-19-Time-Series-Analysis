---
title: "cookCountyTimeSeriesAnalysis"
author: "Salman D"
date: "6/2/2021"
output: html_document
---

```{R}

library(xts)
library(zoo)

# Import Data Set
cookData = read.csv("C:/Users/salma/OneDrive/Desktop/Blackwell Scholars/cookCountyData.csv", header=TRUE)
#Normalizing Dates
cookData$ReportDate = as.Date(cookData$ReportDate)
```

Time Series Plot
```{R}
#cookData <- xts(cookData$VALUE, order.by = cookData$DatE)
plot(x=as.Date(cookData$ReportDate), y=cookData$ConfirmedCases, main="Cook County Confirmed Cases", xlab = "Reported Date", ylab = "Confirmed Cases")

# Error: there are - nums in data
```

```{R}
#Calculate New cases 
dailyNewCases = rep(0,nrow(cookData))
dailyNewCases[1] = cookData[1,"ConfirmedCases"]
for(i in 2:nrow(cookData)){
  dailyNewCases[i] = cookData[i,"ConfirmedCases"] - cookData[i-1,"ConfirmedCases"] 
}

cookData["dailyNewCases"] = dailyNewCases
```

Histogram of Cases
```{R}
hist(dailyNewCases)

arModel = ar(dailyNewCases)
summary(arModel)



#pacf()  


#Library(Changepoint) - cpt.mean()
```

QQplot
```{R}
qqnorm(dailyNewCases)
qqline(dailyNewCases,col='red')

```

ACF Graph
```{R}
acf(dailyNewCases)
#high correlation coeff all around?
```

PACF Graph
```{R}
pacf(dailyNewCases)
```

Regression
```{R}
lmData =lm(dailyNewCases ~ cookData$ReportDate)
summary(lmData)
plot(dailyNewCases ~ cookData$ReportDate)

```
