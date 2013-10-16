mypalette = function(set = 0, alpha=255) {
  if(set==0)
    palette("default")
  else if(set ==1 ) {#I want hue - pimp
    palette(c(rgb(200,79,178, alpha=alpha,maxColorValue=255), 
          rgb(105,147,45, alpha=alpha, maxColorValue=255),
          rgb(85,130,169, alpha=alpha, maxColorValue=255),
          rgb(204,74,83, alpha=alpha, maxColorValue=255),
          rgb(183,110,39, alpha=alpha, maxColorValue=255),
          rgb(131,108,192, alpha=alpha, maxColorValue=255),
          rgb(63,142,96, alpha=alpha, maxColorValue=255)))
  }  else  {#I want hue - pimp
    palette(c(rgb(170,93,152, maxColorValue=255),
              rgb(103,143,57, maxColorValue=255),
              rgb(196,95,46, maxColorValue=255),
              rgb(79,134,165, maxColorValue=255),
              rgb(205,71,103, maxColorValue=255),
              rgb(203,77,202, maxColorValue=255),
              rgb(115,113,206, maxColorValue=255)))

  }  
}

setnicepar = function(...)  {
  #cl = match.call()
  #if(!match("mfrow", names(cl), 0L)) mfrow = c(1,1)
  par(mar=c(3,3,2,1), 
      mgp=c(2,0.4,0), tck=-.01,
      cex.axis=0.9, las=1,...)
}
