require(reshape2)
require(ggplot2)
theme_set(theme_bw())
exact = function(n, mu, n0, t)   choose(n0, n0-n)*exp(-mu*t)^(n0-n)*(1-exp(-mu*t))^n

tau_leap = function(n, mu, n0, t) {
  rate = mu*n0
  exp(-rate*t)*(rate*t)^n/factorial(n)
}
est_midpoint = function(n, mu, n0, t){
  lambda = -t*mu*n0
  rate = max(0, ceiling(n0 + 0.5*lambda))
  exp(-rate*t)*(rate*t)^n/factorial(n)
}

mypalette(1)

n0 = 100; mu = 1; t = 0.4; n = 0:150

dd = sapply(c(0.1, 0.4, 0.9), function(tau) c(exact(n, mu, n0, tau), est_midpoint(n, mu, n0, tau), tau_leap(n, mu, n0, tau)))
dd = as.data.frame(dd)
dd$n = n
dd$Method = rep(c("Exact", "Mid-point", "Poisson-leap"), each=length(n))
dd$Method = factor(dd$Method, levels=c("Exact", "Poisson-leap", "Mid-point"))
head(dd$Method)

dd_m = melt(dd, c("n", "Method"))

levels(dd_m$variable)[levels(dd_m$variable)== "V1"] = "tau == 0.1"
levels(dd_m$variable)[levels(dd_m$variable)== "V2"] = "tau == 0.4"
levels(dd_m$variable)[levels(dd_m$variable)== "V3"] = "tau == 0.9"
dd_m$n = 150-dd_m$n 
g1 = ggplot(subset(dd_m, Method=="Exact")) + 
  geom_line(aes(n, value, colour=Method)) + 
  facet_grid(.~variable, labeller=label_parsed) + 
  ylim(c(0, 0.15)) + 
  xlab("Population") + ylab("Pr(k)") + 
  scale_color_manual(values=palette()[1:3]) +
  theme(legend.position="top") 
g2 = ggplot(subset(dd_m, Method != "Mid-point")) + 
  geom_line(aes(n, value, colour=Method)) + 
  facet_grid(.~variable, labeller=label_parsed) + 
  ylim(c(0, 0.15)) + 
  xlab("Population") + ylab("Pr(k)") + 
  scale_color_manual(values=palette()[1:3]) +
  theme(legend.position="top") 

g3 = ggplot(dd_m) + 
  geom_line(aes(n, value, colour=Method)) + 
  facet_grid(.~variable, labeller=label_parsed) + ylim(c(0, 0.15)) + 
  xlab("Population") + ylab("Pr(k)") + 
  scale_color_manual(values=palette()[1:3]) +
  theme(legend.position="top") 
g3

pdf(file="graphics/figure3a.pdf",family="Palatino", 
    pointsize=16, width=16*0.8,height=10*0.5)
print(g1)
sink=dev.off()
system("pdfcrop graphics/figure3a.pdf")

pdf(file="graphics/figure3b.pdf",family="Palatino", 
    pointsize=16, width=16*0.8,height=10*0.5)
print(g2)
sink=dev.off()
system("pdfcrop graphics/figure3b.pdf")

pdf(file="graphics/figure3c.pdf",family="Palatino", 
    pointsize=16, width=16*0.8,height=10*0.5)
print(g3)
sink=dev.off()
system("pdfcrop graphics/figure3c.pdf")
