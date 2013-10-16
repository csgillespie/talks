library(issb)
library(RColorBrewer)


set.seed(3)
theta = exp(runif(3*6, -8, 8))
theta = matrix(theta, ncol=3)

demo(lv, ask=FALSE)
maxtime=30


l = list()
for(i in 1:6) {
  model$get_pars(theta[i,])
  l[[i]] = as.data.frame(gillespie(model, maxtime, 0.5))    
  cat(i, "\n")
}
mypalette(1, 200)
pdf(file="graphics/figure2.pdf",
    family="Palatino", pointsize=16, width=10*0.4,height=15*0.4)
setnicepar(xaxs='i',yaxs='i', mfrow=c( 3, 1))
d = l[[1]]
plot(d[,1], d[,2], type="s", frame=FALSE, axes=FALSE,
     panel.first=abline(h=seq(20, 100, 20),  lwd=3, col="lightgray", lty="dotted"), 
     xlab="", ylab="Population", 
     xlim=c(0, 30), ylim=c(0, 100), col=3, lwd=2, cex.lab=0.9)
lines(d[,1], d[,3], col=4, lwd=2)
axis(2, seq(0,  100, 20), seq(0, 100, 20), tick=F, cex.axis=0.8)
axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)
title("Gillespie simulations", adj=0, cex.main=0.9, font.main=2, col.main="black")

d = l[[3]]
range(c(d[,2], d[,3]))
plot(d[,1], d[,2], type="s", frame=FALSE, axes=FALSE,
     panel.first=abline(h=seq(4e2, 2e3, 4e2),  lwd=3, col="lightgray", lty="dotted"), 
     xlab="", ylab="Population", 
     xlim=c(0, 30), ylim=c(0, 2e3), col=3, lwd=2, cex.lab=0.9)
lines(d[,1], d[,3], col=4, lwd=2)

axis(2, seq(0, 2e3, 4e2), seq(0, 2e3, 4e2), tick=F, cex.axis=0.8)
axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)


d = l[[2]]
range(c(d[,2], d[,3]))
plot(d[,1], d[,2], type="s", frame=FALSE, axes=FALSE,
     panel.first=abline(h=seq(1e3, 1e4, 2e3),  lwd=3, col="lightgray", lty="dotted"), 
     xlab="", ylab="Population", 
     xlim=c(0, 30), ylim=c(0, 1e4), col=3, lwd=2, cex.lab=0.9)
lines(d[,1], d[,3], col=4, lwd=2)
axis(2, seq(0, 1e4, 2e3), seq(0, 1e4, 2e3), tick=F, cex.axis=0.8)
axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)
sink=dev.off()

system("pdfcrop graphics/figure2.pdf")




