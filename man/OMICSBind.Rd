\name{OMICSBind}
\alias{OMICSBind}
\title{
	Merge Data of Two Types of Molecular Profiles.
}
\description{
Combine the data matrix of two types of molecular profiles for the same tumor samples.
}
\usage{
OMICSBind(dat1, dat2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat1}{data matrix in \emph{gene} x \emph{sample} format.}
  \item{dat2}{data matrix in \emph{gene} x \emph{sample} format.}
}
\details{
This function combines data matrices of two types of molecular profiles for the same set of tumor samples in the correct patient order. The number of genes returned is the sum of genes from two input matrices; the number of samples returned will be the tumor samples common to both input matrices. Gene names in the returned data will be suffixed by "d1" or "d2" to indicate if the gene is from the first or the second input matrix.
}
\value{
	A list of three elements:
	\item{merged.data}{a matrix in \emph{sample} x \emph{gene} format}
	\item{X}{a matrix in \emph{sample} x "\emph{gene from dat1}" format with samples in the same order as \code{Y}}
	\item{Y}{a matrix of size \emph{sample} x "\emph{gene from dat2}" format with samples in the same order as \code{X}}
}
\examples{
\donttest{
library(TCGA2STAT)

seq <- getTCGA(disease="OV", data.type="RNASeq2")
mut <- getTCGA(disease="OV", data.type="Mutation", type="all")

seq.mut <- OMICSBind(dat1 = seq$dat, dat2 = mut$dat)
str(seq.mut)
}
}

