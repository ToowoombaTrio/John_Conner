setwd("C:/Users/U8004449/Documents/govhack")
getwd()

hourlyT<-read.table("temp_dummy_data.csv", sep=",", header = TRUE)
head(hourlyT)
station_info<-read.table("station_numbers_new.csv", sep=",", header = TRUE)
head(station_info)

header_info<-names(hourlyT[-1])

temp_threshold<-10

hours_of_high_temps<-c()

for (x in header_info){
      hours_of_high_temps<-c(hours_of_high_temps,length(hourlyT[,x][hourlyT[,x] > temp_threshold]))
}
hours_of_high_temps

df<-data.frame(header_info,hours_of_high_temps,station_info$LATITUDE,station_info$LONGITUDE)
head(df)

#install.packages("raster")
#libarys required for mapping
library(reshape)
library(fields)
library(raster)

# create the surface to plot
spline <- Tps(data.frame(df$station_info.LONGITUDE, df$station_info.LATITUDE), df$hours_of_high_temps)
grid <- predictSurface(spline, nx = 2000, ny = 2000)
predict(spline, cbind(151.9507,-27.5598))

png(filename="QLDmap.png", height=20, width=17, units="cm", res=100)
#plot qld outline and the surface over the top of surface

yaxis<-c(-30,-10)
xaxis<-c(135,155)
border2<-read.csv("qld2.csv")
border<-read.csv("qld.csv")
plot(border$x, border$y, type="n", axes="False", xlim=xaxis, ylim=yaxis, xlab="", ylab="")
image.plot(grid, horizontal=TRUE, add=TRUE)
polygon(border2$x, border2$y, col="white", border="white")
polygon(border$x, border$y,)


dev.off()


#send email abut specific locations
our_email<-"toowoombatrio@gmail.com"
attachmentName <- "QLDmap.png"
#subscribers deatils

# do not use this as it will wipe over our subscriber data base susbscribers <- data.frame(email=character(), Location=character(), lat=numeric(), lon=numeric(), stringsAsFactors=FALSE) 
susbscribers<-read.table("susbscribers.txt")
email<-"Adam.Sparks@usq.edu.au"
my_location_name<-"Dalby"
mylat<-c(151.2660)
mylon<-c(-27.1944)
susbscribers<-rbind(susbscribers,data.frame(email, my_location_name, mylat, mylon))
write.table(susbscribers, file = "susbscribers.txt")
run<-c(1:nrow(susbscribers))
susbscribers<-cbind(susbscribers, run)

library(mailR)

for(value in susbscribers$run){
     email<-as.character(susbscribers[value,1])
     location<-as.character(susbscribers[value,2])
     lat<-as.numeric(susbscribers[value,3])
     lon<-as.numeric(susbscribers[value,4])
     hours_of_heat_stress<-as.character(round(predict(spline, cbind(lat,lon)),0))
     body_text<-paste("Hello from the Toowoomba Trio Your crops at", location, "recieved", hours_of_heat_stress, "hours of heat stress yesterday")
 
sender <- our_email
recipients <-email
send.mail(from = sender,
          to = recipients,
          subject = "Hours of heat stress yesterday",
          body = body_text,
          attach.files = attachmentName,
          smtp = list(host.name = "smtp.gmail.com", port = 465, 
                      user.name = "toowoombatrio@gmail.com",            
                      passwd = "qwertyytrewq", ssl = TRUE),
          authenticate = TRUE,
          send = TRUE)

}
file.remove("QLDmap.png")





