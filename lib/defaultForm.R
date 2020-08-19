dF <- function(vals, dig = 1, ...){
  out <- formatC(vals, format = "f", digits = dig, ...)
  return(out)
}