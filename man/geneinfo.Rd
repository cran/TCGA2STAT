\name{geneinfo}
\alias{geneinfo}
\docType{data}
\title{
	Gene Map for hg19 
}
\description{
A matrix of information on genes from the human reference genome version 19; used when merging CNV data at gene level with \code{CNTools}.
}
\usage{data("geneinfo")}
\format{
  A data frame with 22705 observations on the following 5 variables.
  \describe{
    \item{\code{chrom}}{ - chromosome a gene is on.}
    \item{\code{start}}{ - starting coordinate of a gene.}
    \item{\code{end}}{ - ending coordinate of a gene.}
    \item{\code{geneid}}{ - entrez gene ID.}
    \item{\code{genename}}{ - official gene symbol.}
  }
}
\keyword{datasets}
