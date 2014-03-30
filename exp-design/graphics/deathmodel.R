gillespie = function ( maxtime , d_t , b , SI.vec )
{
  time = 0; tstep = 0;
  i = 2
  len = (maxtime / d_t)+2
  SI.matrix = matrix (0 ,nrow = len , ncol = 2)
  SI.matrix[1,] = c(0, SI.vec[1])
  Time = vector(length = len)
  while ( time < maxtime )
  {
    # Calculate the overall rate
    rate = b*SI.vec[1] 
    if (rate == 0) # everything is dead .
      time = maxtime
    else
      time = time + rexp(1 , rate )
    # Store values at discrete intervals
    while ( time > tstep & time <= maxtime )
    {
      SI.matrix[i ,]= c(tstep+d_t, SI.vec[1])
      Time[i] = tstep
      tstep = tstep + d_t
      i = i +1
    }
    # Don ’t go by maxtime
    if ( time >= maxtime ){
      #SI.matrix[i ,1]= SI.vec[1]
      break 
    }
    # Choose which reaction happens
    SI.vec[1] = SI.vec[1]-1
  }
  return ( SI.matrix) 
}

 