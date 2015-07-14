\name{GeneMerge}
\alias{GeneMerge}
\title{
	Merge Data of Two Types of Molecular Profiles.
}
\description{
Combine the data matrix of two types of molecular profiles for the same tumor samples.
}
\usage{
GeneMerge(dat1, dat2)
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
	\item{Y}{a matrix of size \emph{sample} x "\emph{gene from dat2}" format with sampels in the same order as \code{X}}
}
\examples{
#	Here is a brief example of how to merge methylation and gene expression (RNASeq) data
#	and use the data for CCA analysis

\donttest{
library(TCGA2STAT)

lusc.methyl <- getTCGA(disease="LUSC", data.type="Methylation", clinical=FALSE)
lusc.rnaseq2 <- getTCGA(disease="LUSC", data.type="RNASeq2")

met.var <- apply(lusc.methyl[,-c(1,2,3)], 1, var)
met.data <- subset(lusc.methyl[,-c(1,2,3)], met.var >= quantile(met.var, 0.99, na.rm=TRUE) 
                & !is.na(met.var))

rnaseq2.var <- apply(log10(1+lusc.rnaseq2$dat), 1, var)
rnaseq.data <- subset(log10(1+lusc.rnaseq2$dat), 
                rnaseq2.var >= quantile(rnaseq2.var, 0.99, na.rm=TRUE) 
                & !is.na(rnaseq2.var))

met.rnaseq2 <- GeneMerge(dat1 = rnaseq.data, dat2= met.data)
}
\dontrun{library(CCA)}
\dontrun{estl <- estim.regul(met.rnaseq2$X, met.rnaseq2$Y)}
\dontrun{lusc.cc <- rcc(met.rnaseq2$X, met.rnaseq2$Y, estl$lambda1, estl$lambda1)}
\dontrun{plt.cc(lusc.cc, d1=1, d2=2, type="b", var.label=TRUE)}
}

