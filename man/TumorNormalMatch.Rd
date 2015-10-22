\name{TumorNormalMatch}
\alias{TumorNormalMatch}
\title{
	Get Matched Tumor and Normal Samples.
}
\description{
Get data matrix of molecular profiles for matching tumor and normal samples.
}
\usage{
TumorNormalMatch(dat)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{data matrix in \emph{gene} x \emph{sample} format.}
}
\details{
This function returns a list of two gene-by-sample matrices. The samples in both matrices are of matching patients and are sorted at the same order.
}
\value{
	A list of two elements:
	\item{primary.tumor}{a matrix containing tumor samples; of dimension of \emph{gene} x \emph{tumor samples}.}
	\item{normal}{a matrix of normal samples; of dimension \emph{gene} x \emph{normal samples}.}
}
\examples{
\donttest{
library(TCGA2STAT)
lusc.rnaseq2 <- getTCGA(disease="LUSC", data.type="RNASeq2")
lusc.rnaseq2.tum.norm <- TumorNormalMatch(lusc.rnaseq2$dat)
}
}
