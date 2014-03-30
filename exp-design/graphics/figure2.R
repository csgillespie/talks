library(ggplot2)
theme_set(theme_bw(base_size=14))
set.seed(1)
source("deathmodel.R")
mypalette(1)

x = gillespie(10,0.01,1,c(50,0))
dd = NULL
for (i in 1:10){
    x=gillespie(10,0.01,1,c(50,0))
    x = as.data.frame(x[1:1001,])
    x$sim = as.character(i)
    dd = rbind(dd, x)
}
colnames(dd) = c("Time", "N", "Sim")
dd$Time = signif(dd$Time, 3)
dd$Sim = as.numeric(dd$Sim)

dd_mean = data.frame(Time =seq(0, 10, 0.01), N =50*exp(-seq(0, 10, 0.01)) )

g = ggplot(data=dd[dd$Sim < 10, ], aes(Time, N))  + 
  geom_step(aes(group=Sim), alpha=1/sqrt(10)) + 
  ylab("Population")  

g1 = g + geom_line(data=dd_mean, aes(Time, N), lwd=0.6, col=3)

fname = "figure2.pdf"
pdf(fname, width=4, height=4)
print(g1)
dev.off()  
pdfcrop(fname)



