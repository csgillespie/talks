figure1 = function(add_lines = TRUE){
  
  if(add_lines) mypalette(1, 40)
  else mypalette(1, 200)
  setnicepar(xaxs='i',yaxs='i')
  plot(h$time, h$h1, 
       frame=FALSE, axes=FALSE,
       type="l", ylim=c(0, 200), col=4, 
       panel.first=abline(h=seq(50, 200, 50),  
                          lwd=3, col="lightgray", lty="dotted"), 
       xlab="", ylab="Hazard", 
       xlim=c(0, 30), cex.lab=0.9)
  lines(h$time, h$h2, col=2)
  lines(h$time, h$h3, col=6)
  axis(2, seq(0,  200, 50), seq(0,  200, 50), tick=F, cex.axis=0.8)
  axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)
  
 
  mypalette(1)
  text(2, 110, expression(h[1]), col=4, lwd=2, font.main=1, cex=1.2)
  text(5, 130, expression(h[2]), col=2, lwd=2, font.main=1, cex=1.2)
  text(10, 110, expression(h[3]), col=6, lwd=2, font.main=1, cex=1.2)
  if(!add_lines) return(NULL)
  mypalette(1, 200)
  h1 = h[h$max ==1, ]
  h1a = h1[h1$time < 15,]
  h1b = h1[h1$time > 15,]
  lines(h1a$time, h1a$h1, lwd=2, col=4)
  lines(h1b$time, h1b$h1, lwd=2, col=4)
  
  h2 = h[h$max ==2, ]
  h2a = h2[h2$time < 15,]
  h2b = h2[h2$time > 15,]
  lines(h2a$time, h2a$h2, lwd=2, col=2)
  lines(h2b$time, h2b$h2, lwd=2, col=2)
  
  h3 = h[h$max ==3, ]
  h3a = h3[h3$time < 20,]
  h3b = h3[h3$time > 20,]
  lines(h3a$time, h3a$h3, lwd=2, col=6)
  lines(h3b$time, h3b$h3, lwd=2, col=6)
}

figure2 = function(add_lines=TRUE){
  
  if(add_lines) mypalette(1, 40)
  else mypalette(1, 200)
  
  setnicepar(xaxs='i',yaxs='i')
  #h = steps
  plot(steps$time, steps$h1,
       frame=FALSE, axes=FALSE,
       type="l", ylim=c(0, 1), col=4, 
       panel.first=abline(h=seq(0.2,  1, 0.2),  
                          lwd=3, col="lightgray", lty="dotted"), 
       xlab="", ylab=expression(tau), 
       xlim=c(0, 30), cex.lab=0.9)
  
  lines(steps$time, steps$h2, col=2)
  lines(steps$time, steps$h3, col=6)
  axis(2, seq(0.2,  1, 0.2), seq(0.2,  1, 0.2), tick=F, cex.axis=0.8)
  axis(1, seq(0, 30, 10), seq(0, 30, 10), cex.axis=0.8)
  
  mypalette(1)
  text(2, 110, expression(h[1]), col=4, lwd=2, font.main=1, cex=1.2)
  text(5, 160, expression(h[2]), col=2, lwd=2, font.main=1, cex=1.2)
  text(10, 110, expression(h[3]), col=6, lwd=2, font.main=1, cex=1.2)
  if(!add_lines) return(NULL)
  mypalette(1, 200)
  
  h1 = steps[steps$min ==1, ]
  h1a = h1[h1$time < 3,]
  h1b = h1[h1$time > 3,]
  lines(h1a$time, h1a$h1, lwd=2, col=4)
  lines(h1b$time, h1b$h1, lwd=2, col=4)
  
  
  h2 = steps[steps$min ==2, ]
  h2a = h2[h2$time < 18,]
  h2b = h2[h2$time > 18,]
  lines(h2a$time, h2a$h2, lwd=2, col=2)
  lines(h2b$time, h2b$h2, lwd=2, col=2)
  
  h3 = steps[steps$min ==3, ]
  h3a = h3[h3$time < 20,]
  h3b = h3[h3$time > 20,]
  lines(h3a$time, h3a$h3, lwd=2, col=6)
  lines(h3b$time, h3b$h3, lwd=2, col=6)
  
  
}