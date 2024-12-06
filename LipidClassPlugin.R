library(lipidr)
library(ggplot2)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")
source("RIO.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }

}

run <- function() {}

output <- function(outputfile) {
	d = readRDS(paste(pfix, parameters["annotate", 2], sep="/"))
   lipid_classes = rowData(d)$Class %in% readSequential(paste(pfix, parameters["classes", 2], sep="/"))
groups = d$BileAcid != parameters["exclude", 2]
d = d[lipid_classes, groups]
saveRDS(d, outputfile)
}

