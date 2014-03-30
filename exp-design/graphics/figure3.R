source("deathmodel.R")
library(ggplot2)
library(grid)
theme_set(theme_bw(base_size=14))

vplayout = function(x, y) 
  viewport(layout.pos.row = x, layout.pos.col = y)

set.seed(1)
dd = NULL
for (i in 1:3) {
  x=gillespie(10,0.01,1,c(50,0))
  x = as.data.frame(x[1:1001,])
  x$sim = as.character(i)
  dd = rbind(dd, x)
}
colnames(dd) = c("Time", "N", "Sim")
dd$Time = signif(dd$Time, 3)
dd$Sim = as.numeric(dd$Sim)

post= function(x, N, time) {
  dbinom(N,50,exp(-time*x))/sum(dbinom(N,50,exp(-time*x)))
}

x = seq(0, 3 ,0.01)
d = NULL
for(i in 1:3) { 
  for(time in c(1, 3, 5)) {
    tmp = data.frame(x=x)
    tmp$time = paste("Time =", time)
    tmp$post = post(x, dd[dd$Time == time,]$N[i], time)
    tmp$sim = i
    d= rbind(d, tmp)
  }
}

dd_pts = dd[dd$Sim == 1 & is.element(dd$Time, c(1.00, 3.00, 5.00)), ]
dd_pts$col = factor(1:3)
g1a = ggplot(data=dd[dd$Sim == 1, ], aes(Time, N))  + 
  geom_step(aes(group=Sim)) + ylab("Population") + 
  geom_point(data=dd_pts, aes(Time, N, colour=col), size=4) + 
  scale_color_manual(guide=FALSE, values = 1:3)

dd_pts = dd[dd$Sim == 2 & is.element(dd$Time, c(1.00, 3.00, 5.00)), ]
dd_pts$col = factor(1:3)
g1b = ggplot(data=dd[dd$Sim == 1, ], aes(Time, N))  + 
  geom_step(aes(group=Sim), alpha=0.3) + 
  ylab("Population") + 
  geom_step(data=dd[dd$Sim == 2, ], aes(Time, N)) + 
  geom_point(data=dd_pts, aes(Time, N, colour=col), size=4) + 
  scale_color_manual(guide=FALSE, values = 1:3)

dd_pts = dd[dd$Sim == 3 & is.element(dd$Time, c(1.00, 3.00, 5.00)), ]
dd_pts$col = factor(1:3)
g1c = ggplot(data=dd[is.element(dd$Sim, 1:2), ], aes(Time, N))  + 
  geom_step(aes(group=Sim), alpha=0.3) + 
  ylab("Population") + 
  geom_step(data=dd[dd$Sim == 3, ], aes(Time, N))  + 
  geom_point(data=dd_pts, aes(Time, N, colour=col), size=4) + 
  scale_color_manual(guide=FALSE, values = 1:3)

g2a = ggplot(d[d$sim==1,], aes(x, post)) + 
  geom_line(aes(colour=time)) + facet_grid(~time) + 
  xlab(expression(theta)) + 
  ylab(expression(paste("", pi,"(",theta,"|",bold(d),")"))) + 
  ylim(c(0, 0.03)) + 
  scale_color_manual(guide=FALSE, values = 1:3)
  
g2b = ggplot(d[d$sim==1,], aes(x, post)) + 
  geom_line(aes(colour=time), alpha=0.3) + 
  geom_line(data=d[d$sim==2,], aes(x, post, colour=time)) +
  facet_grid(~time) + 
  xlab(expression(theta)) + 
  ylab(expression(paste("", pi,"(",theta,"|",bold(d),")"))) + 
  ylim(c(0, 0.03))+ 
  scale_color_manual(guide=FALSE, values = 1:3)

g2c = ggplot(d[is.element(d$sim, 1:2),], aes(x, post)) + 
  geom_line(aes(colour=time, group=sim), alpha=0.3) + 
  geom_line(data=d[d$sim==3,], aes(x, post,colour=time)) +
  facet_grid(~time) + 
  xlab(expression(theta)) + 
  ylab(expression(paste("", pi,"(",theta,"|",bold(d),")"))) + 
  ylim(c(0, 0.03)) + 
  scale_color_manual(guide=FALSE, values = 1:3)
g2c


C = 1.25
fname = "figure3a.pdf"
pdf(fname, width=8/C, height=6/C)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1)))
print(g1a, vp = vplayout(1, 1))
print(g2a, vp = vplayout(2, 1))
dev.off()  
pdfcrop(fname)

fname = "figure3b.pdf"
pdf(fname, width=8/C, height=6/C)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1)))
print(g1b, vp = vplayout(1, 1))
print(g2b, vp = vplayout(2, 1))
dev.off()  
pdfcrop(fname)

fname = "figure3c.pdf"
pdf(fname, width=8/C, height=6/C)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1)))
print(g1c, vp = vplayout(1, 1))
print(g2c, vp = vplayout(2, 1))
dev.off()  
pdfcrop(fname)



