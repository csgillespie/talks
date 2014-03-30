library(ggplot2)
source("helper.R")

theme_set(theme_bw(base_size=14))
ut = read.csv("../data/ut_d2_0_10.csv")

g = ggplot(ut, aes(x, y)) +
  geom_raster(aes(fill = u))+
  scale_x_continuous(expand=c(0, 0), limit=c(0,9.99)) +
  scale_y_continuous(expand=c(0, 0),limit=c(0,9.99)) +
  xlab("Design Point 1") +
  ylab("Design Point 2")

g1 = g + facet_grid(~type)
g2 = g1 + 
  stat_contour(bins=25,colour="#6baed6", aes(z=u)) +
  scale_fill_gradientn (name = expression(u(t[1], t[2])),
    colours=colorRampPalette (c ("#fff5f0","#ef3b2c","#67000d"),
                               bias=0.1) (50))  +
  theme(legend.position="top")

d = data.frame(x=c(0, 9.99, 9.99, 9.9, 0), y=c(0, 0, 9.99, 9.99, 0.1), z=0)

g2 = g2 + geom_polygon(data=d, mapping=aes(x=x, y=y), fill="white")
g2
################################################################

ut = read.csv("../data/ut_d2_0_4.csv")
#ut = ut[ut$type=="GP",]
range(ut$x)

#ut = ut[ut$type=="Exact",]; range(ut$x);range(ut$y)
g3 = ggplot(ut, aes(x, y)) +
  geom_raster(aes(fill = u))+
  scale_x_continuous(expand=c(0, 0), limit=c(0.,3.925)) +
  scale_y_continuous(expand=c(0, 0),limit=c(0,3.925)) +
  xlab("Design Point 1") +
  ylab("Design Point 2") + facet_wrap(~type) 
g3


g4=g3 + stat_contour(bins=25,colour="#6baed6", aes(z=u)) +
  scale_fill_gradientn (
    colours=colorRampPalette (c ("#fff5f0","#ef3b2c","#67000d"),
                              bias=0.1) (50)) +
  theme(legend.position="none")


d = data.frame(x=c(0, 3.925, 3.925, 3.85, 0), y=c(0, 0, 3.925, 3.925, 0.1), z=0)

g5 = g4 + geom_polygon(data=d, mapping=aes(x=x, y=y), fill="white")


library(grid)
vplayout = function(x, y)
  viewport(layout.pos.row = x, layout.pos.col = y)



fname = "figure5.pdf"
pdf(fname, width=7, height=7)
grid.newpage()
pushViewport(viewport(layout = grid.layout(100, 100)))
offset = 4
print(g2, vp = vplayout(1:(50+offset), 1:100))
print(g5, vp = vplayout((50+offset):100, 2:100))
dev.off()  
pdfcrop(fname)


