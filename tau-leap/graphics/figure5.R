library(issb)
demo(lv, ask=FALSE)
maxtime= 30
sims = 20000
set.seed(3543)


##This takes a while. Can load data from previous sims:
## g = readRDS("data/LV_gil.RData")
##d = readRDS("data/LV_pleap.RData")

g = multiple_sims(model, maxtime=maxtime, tstep=maxtime, 
                  no_sims=sims, no_cores=2, gillespie)

d = NULL
epsilons = seq(0.05, 0.25, by=0.025)
for(i in seq_along(epsilons)) {
  epsilon = epsilons[i]
  for(mid_point in c(TRUE, FALSE)) {
    tl = multiple_sims(model, maxtime=maxtime, tstep=maxtime, 
                       no_sims=sims, no_cores=2, tau_leap, 
                       mid_point=mid_point, epsilon=epsilon)
    
    q_g = as.data.frame(apply(tl[seq(2, nrow(tl), 2),3:4], 2, quantile))
    q_g$simulator = paste0("tau", "-mid"[mid_point])
    q_g$ddt = i*0.09
    q_g$epsilon = epsilon
    d = rbind(d, q_g)
  }
  
  pl = multiple_sims(model, maxtime=maxtime, tstep=maxtime, 
                     no_sims=sims, no_cores=2, simulator=pleap, 
                     ddt=i*0.09)
  
  
  q_g = as.data.frame(apply(pl[seq(2, nrow(pl), 2),3:4], 2, quantile))
  q_g$simulator = "pleap"
  q_g$ddt = i*0.09
  q_g$epsilon = epsilon
  d = rbind(d, q_g)
}

######################################################################
#Load previous runs
##g = readRDS("data/LV_gil.RData")
##d = readRDS("data/LV_pleap.RData")

exact = apply(g[seq(2, nrow(g), 2),3:4], 2, median)
exact = data.frame(variable = names(exact), value=as.vector(exact))


library(ggplot2)
library(reshape2)
theme_set(theme_bw(base_size=8))

d$type = 1:5
dd = subset(d,d$type==3 & d$ddt < 0.7)[, 1:4]
dd_m = melt(dd, c("simulator", "ddt"))
dd_m$simulator = factor(dd_m$simulator)
dummy = data.frame(variable = c("Prey", "Predator"), value=numeric(6))
levels(dummy$variable) = c("Prey", "Predator")
dummy$simulator = rep(levels(dd_m$simulator), each=2)
labs = c(expression("p-leap"), expression(paste(tau, "-leap")),   expression(paste(tau, "-leap + mid")))


g0= ggplot(data=dummy, aes(simulator, value)) +
  geom_blank() +
  facet_grid(.~variable) +
  xlab("Simulator") + ylab("Population") + 
  labs(colour=expression(paste(Delta, " t"))) +
  scale_x_discrete(labels=labs) +
  scale_colour_brewer(type="qual", palette="Paired") +
  geom_hline(data=exact,aes(yintercept=value) ) +
  ylim(c(0, 400)) 


g1 = g0 + 
  geom_line(data=subset(dd_m,simulator=="pleap"), aes(colour=factor(ddt), group=factor(ddt)), size=1)  +
  geom_point(data=subset(dd_m,simulator=="pleap"), aes(colour=factor(ddt)), size=2)

g2 = g0 +  geom_line(data=subset(dd_m,simulator!="tau-mid"), aes(colour=factor(ddt), group=factor(ddt)), size=1) +
  geom_point(data=subset(dd_m,simulator!="tau-mid"), aes(colour=factor(ddt)), size=2) 

g3 = g0 + geom_line(data=dd_m, aes(colour=factor(ddt), group=factor(ddt)), size=1) +
  geom_point(data=dd_m, aes(colour=factor(ddt)), size=2) 

pdf(file="graphics/figure5a.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=10*0.4)
print(g1)
sink=dev.off()
system("pdfcrop graphics/figure5a.pdf")

pdf(file="graphics/figure5b.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=10*0.4)
print(g2)
sink=dev.off()
system("pdfcrop graphics/figure5b.pdf")

pdf(file="graphics/figure5c.pdf",
    family="Palatino", pointsize=16, width=16*0.4,height=10*0.4)
print(g3)
sink=dev.off()
system("pdfcrop graphics/figure5c.pdf")

