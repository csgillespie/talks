pdfcrop = function(fname, rm=TRUE) {
  cmd = paste("pdfcrop", fname)
  if(rm) cmd = paste(cmd, "&& rm", fname)
  system(cmd)
}