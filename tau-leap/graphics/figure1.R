## See https://github.com/csgillespie/In-silico-Systems-Biology
##for the issb package

set.seed(1)
source("helperfunctions.R")
library(issb)
library(RColorBrewer)


demo(lv, ask=FALSE)
maxtime=30
d= gillespie(model, maxtime)

l = list(4)
for(i in 1:4) 
  l[[i]] =  gillespie(model, maxtime)

g = multiple_sims(model, maxtime=maxtime, tstep=0.01, 
                  no_sims=20, no_cores=4, gillespie)


mypalette(1, 200)

pdf(file="graphics/figure1a.pdf",family="Palatino", pointsize=16, width=16*0.4,height=10*0.4)

setnicepar(xaxs='i',yaxs='i')
plot(d[,1], d[,2], type="s", frame=FALSE, axes=FALSE,
     panel.first=abline(h=seq(100, 500, 100),  lwd=3, col="lightgray", lty="dotted"), 
     xlab="", ylab="Population", 
     xlim=c(0, 30), ylim=c(0, 505), col=3, lwd=2, cex.lab=0.9)

lines(d[,1], d[,3], col=4, lwd=2)

axis(2, seq(0,  500, 100), seq(0, 500, 100), tick=F, cex.axis=0.8)
axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)
title("Stochastic realisations", adj=0, cex.main=0.9, font.main=2, col.main="black")

mypalette(1)
text(11, 20, "Prey", col=3, lwd=2, font.main=2)
text(11, 360, "Predator", col=4, lwd=2, font.main=2)
sink=dev.off()

system("pdfcrop graphics/figure1a.pdf")

mypalette(1, 60)
###############################
pdf(file="graphics/figure1b.pdf",family="Palatino", pointsize=16, width=16*0.4,height=10*0.4)
setnicepar(xaxs='i',yaxs='i')

plot(d[,1], d[,2], type="n", frame=FALSE, axes=FALSE,
     panel.first=abline(h=seq(100, 500, 100),  lwd=3, col="lightgray", lty="dotted"), 
     xlab="Time", ylab="Population", 
     xlim=c(0, 30), ylim=c(0, 505),  lwd=2, col=3, cex.lab=0.9)

for(i in 1:4) {
  d = l[[i]]
  lines(d[,1], d[,2], type="s", col=3, lwd=2)
  lines(d[,1], d[,3], type="s", col=4, lwd=2)
}

axis(2, seq(0,  500, 100), seq(0, 500, 100), tick=F, cex.axis=0.8)
axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)
mypalette(1)

x = unique(g[,2])
y_prey  = tapply(g[,3], g[,2], mean)
y_pred  = tapply(g[,4], g[,2], mean)
lines(x,y_prey, col=3, lwd=4)
lines(x,y_pred, col=4, lwd=4)
sink=dev.off()

system("pdfcrop graphics/figure1b.pdf")
