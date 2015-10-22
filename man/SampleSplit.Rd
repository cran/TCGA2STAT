\name{SampleSplit}
\alias{SampleSplit}
\title{
	Split the Data by Sample Types.
}
\description{
Split the TCGA data into data matrices of different sample types (normal, tumor, or recurrent tumor).
}
\usage{
SampleSplit(dat)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{data matrix in \emph{gene} x \emph{sample} format.}
}
\value{
	A list of three elements:
	\item{primary.tumor}{a matrix of tumor samples of dimension \emph{gene} x \emph{sample}.}
	\item{recurrent.tumor}{a matrix of recurrent tumor samples of dimension \emph{gene} x \emph{sample}.}
	\item{normal}{a matrix from normal samples of dimension \emph{gene} x \emph{sample}.}
}
\examples{
\donttest{
library(TCGA2STAT)
lusc.rnaseq2 <- getTCGA(disease="LUSC", data.type="RNASeq2")
lusc.rnaseq2.bytype <- SampleSplit(lusc.rnaseq2$dat)
}
}
