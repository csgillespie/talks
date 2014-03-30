library(issb)
source("helper.R")
mypalette(1)

set.seed(1)
demo("lv", ask=FALSE)
source("id.R")
lv = gillespie(model, 30)
id = gillespie(id_model, 30)


## Figure 1
fname = "figure1a.pdf"
pdf(fname, width=4, height=4)
setnicepar()
plot(lv[,1], lv[,2], 
     type="l", col=1,
     ylim=c(0, 400), 
     xlab="Time", ylab="Population", 
     panel.first=grid(lwd=2), 
     lwd=2)
lines(lv[,1], lv[,3], col=2,lwd=2)
lines(id[,1], id[,2], col=3,lwd=2)
dev.off()  
pdfcrop(fname)

## Figure 2
set.seed(1)
demo("lv", ask=FALSE)
source("id.R")
lv1 = gillespie(model, 30, 1)
id1 = gillespie(id_model, 30, 1)
mypalette(1, 100)
fname = "figure1b.pdf"
pdf(fname, width=4, height=4)
setnicepar()
plot(lv[,1], lv[,2], 
     type="l", col=1,
     ylim=c(0, 400), 
     xlab="Time", ylab="Population", 
     panel.first=grid(lwd=2))
lines(lv[,1], lv[,3], col=2)
lines(id[,1], id[,2], col=3)

mypalette(1)
points(lv1[,1], lv1[,2], 
     bg=1, pch=21)
points(lv1[,1], lv1[,3], pch=21, bg=2)
points(id1[,1], id1[,2], pch=21, bg=3)
dev.off()  
pdfcrop(fname)

## Figure 3
fname = "figure1c.pdf"
pdf(fname, width=4, height=4)
setnicepar()

mypalette(1, 100)
plot(lv[,1], lv[,2], 
     type="l", col=1,
     ylim=c(0, 400), 
     xlab="Time", ylab="Population", 
     panel.first=grid(lwd=2))
lines(lv[,1], lv[,3], col=2)
lines(id[,1], id[,2], col=3)

mypalette(1)
points(lv1[,1], lv1[,2], 
       bg=1, pch=21)
dev.off()  
pdfcrop(fname)


## Figure 4
fname = "figure1d.pdf"
pdf(fname, width=4, height=4)
mypalette(1, 100)
setnicepar()

plot(lv[,1], lv[,2], 
     type="l", col=1,
     ylim=c(0, 400), 
     xlab="Time", ylab="Population", 
     panel.first=grid(lwd=2))
lines(lv[,1], lv[,3], col=2)
lines(id[,1], id[,2], col=3)
mypalette(1, 50)

mypalette(1)
points(lv1[,1], 
       lv1[,2]+ rnorm(nrow(lv1), 0, 20), 
       bg=1, pch=21)
dev.off()  
pdfcrop(fname)


  








