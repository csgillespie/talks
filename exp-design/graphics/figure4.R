mypalette(1)
source("helper.R")
ut_ex = read.csv("../data/exact_d1.csv")
ut_gp = read.csv("../data/gp_d1.csv")

fname = "figure4a.pdf"
pdf(fname, width=4*0.9, height=4*0.9)
setnicepar()
plot(ut_gp$x, ut_gp$u,
     xlab="Time", ylab="Expected Utility", 
     type="l", col=1, 
     panel.first=grid(lwd=1.5), 
     ylim=c(100, 140), xlim=c(0, 10))
lines(ut_ex$x, ut_ex$u, col=2, lwd=2)

dev.off()
pdfcrop(fname)

########################################################
ut_ex = c(133.13, 142.29, 146.08, 148.01)
ut_gp = c(133.13, 142.04, 145.83, 147.58)

mypalette(1, alpha=100)
fname = "figure4b.pdf"
pdf(fname, width=4*0.9, height=4*0.9)
setnicepar()
plot(1:4, ut_gp, 
     pch=21, bg=1, 
     ylab="Expected Utility", 
     xlab="#Design points", 
     panel.first=grid(lwd=1.5), 
     ylim=c(130, 150), xlim=c(1, 4), 
     axes=FALSE, cex=1.2)
axis(1, 1:4)
axis(2, seq(130, 150, 5))

points(1:4, ut_ex, pch=24, bg=2, cex=1.2)

dev.off()
pdfcrop(fname)
