h = function(x, pars) {
  hazs = numeric(length(pars))
  hazs[1] = pars[1]
  hazs[2] = pars[2]*x[1]
  return(hazs)
}

smat = matrix(0,nrow=1,ncol=2)
smat[1,1] = 1
smat[1,2] = -1
rownames(smat) = c("X")
initial = 0
pars = c(10,0.1)
id_model = create_model(smat, h, initial, pars)
