source("graphics/figure4_functions.R")
set.seed(1)
library(issb)
library(RColorBrewer)
demo(lv, ask=FALSE)
maxtime =30
d = gillespie(model, maxtime)

s = model$get_stoic()
d = as.data.frame(d)
head(d)


i = 1600
steps = data.frame(time = d$Time, h1=0, h2=0, h3=0)
for(i in 1:nrow(d)) {
  x = unlist(d[i, 2:3, drop=T])
  xi = model$get_haz(x) %*% t(abs(s))
  denom = xi %*% t(model$get_jacobian(x))
  ddt = 0.1*sum(model$get_haz(x))/denom
  steps[i,2:4] = ddt
}


rexp(1, 1.2)

steps$min = apply(steps[,2:4], 1, function(i) which.min(i))

h = data.frame(time = d$Time, 
               h1=d$Prey*model$get_pars()[1], 
               h2 = d$Prey*d$Predator*model$get_pars()[2], 
               h3 = d$Predator*model$get_pars()[3])

h$max = apply(h[,2:4], 1, function(i) which.max(i))


################################################################################################
#Figure 4a
pdf(file="graphics/figure4a.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=16*0.4)
layout(matrix(c(1,3, 1,3, 2,3, 2,4), 4, 2, byrow=TRUE))
figure1(FALSE)
sink=dev.off()
system("pdfcrop graphics/figure4a.pdf")

pdf(file="graphics/figure4b.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=16*0.4)
layout(matrix(c(1,3, 1,3, 2,3, 2,4), 4, 2, byrow=TRUE))
figure1(FALSE)
figure2(FALSE)
sink=dev.off()
system("pdfcrop graphics/figure4a.pdf")


pdf(file="graphics/figure4c.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=16*0.4)
layout(matrix(c(1,3, 1,3, 2,3, 2,4), 4, 2, byrow=TRUE))
figure1()
figure2()
sink=dev.off()
system("pdfcrop graphics/figure4c.pdf")



##############################################################################################
#

pdf(file="graphics/figure4d.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=16*0.4)

layout(matrix(c(1,3, 1,3, 2,3, 2,4), 4, 2, byrow=TRUE))

figure1()
figure2()
abline(h = mean(select_taus),  col=1, lwd=3)
text(12, 0.1, expression(paste("Mean ", tau)), col=1, lwd=2, font.main=1, cex=0.8)
abline(h=mean(1/rowSums(h[,2:4])), col=3, lwd=2)

select_taus = apply(steps[,2:5], 1, function(i) i[1:3][i[4]])
hist(select_taus, xlim=c(0, 0.5), breaks="fd", border="white", col="grey50", 
     xlab=expression(tau), main=NULL, ylim=c(0, 1000))
abline(h=0, col="black")

boxplot(select_taus, horizontal=TRUE, frame=FALSE, ylim=c(0, 0.5), axes=F, ylim=c(0, 1))
abline(v=seq(0, 0.5, 0.1), lwd=3, col="lightgray", lty="dotted")

boxplot(select_taus, horizontal=TRUE, add=T, frame=F, axes=F, col="grey50")
axis(1, seq(0,  0.5, 0.1), seq(0, 0.5, 0.1),  
     cex.axis=0.8, label=T, tick=T, lwd=-1, lwd.ticks=1)

sink=dev.off()
system("pdfcrop graphics/figure4d.pdf")


#########################################################################










