\name{TCGA2STAT-package}
\alias{TCGA2STAT-package}
\alias{TCGA2STAT-package}
\docType{package}
\title{
A TCGA Data Widget for Statistical Analysis in R
}
\description{
A R package to acquire and preprocess TCGA (genomics and clinical) data for statistical analyses.
}
\details{
\bold{}
\bold{}
\bold{}
\bold{}
\bold{}
\bold{}
\bold{}
\bold{}

\tabular{rl}{
Package: \tab TCGA2STAT\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2015-06-12\cr
License: \tab GPL-2\cr
}
This package contains a set of tools to obtain TCGA data as an object that can be seamlessly 
integrated into statistical analysis pipelines in the R environment. The data obtained is being hosted and maintained by the Broad GDAC Firehose (http://gdac.broadinstitute.org/). 

\bold{}

Both genomics and clinical data of cancer patients can be conveniently imported and merged via one simple interface of the main function in the package: \code{\link{getTCGA}}. Users just have to specify the type of cancer, data profiling platform, and/or clinical covariates, and the specified data will be imported and processed into a gene-by-sample matrix or a list of matrices for downstream statistical analyses in R. The types of diseases and molecular platforms supported by \code{TCGA2STAT} are summarized in Appendix A of the package vignette.

}
\author{
Ying-Wooi Wan, Genevera I. Allen, Matthew L. Anderson, Zhandong Liu

Maintainer: Ying-Wooi Wan<yingwoow@bcm.edu>
}
\keyword{ package }
\seealso{
	\code{\link{getTCGA}}
}
\examples{
	library(TCGA2STAT)
	
	#-- Default: get the expression, all clinical data, and expression merged with 
	#   overall-survival for tumor samples
	\donttest{data <- getTCGA(disease="ACC", data.type="RNASeq2")}
	
	#-- Get only the expression matrix
	\donttest{data <- getTCGA(disease="ACC", data.type="RNASeq", type="RPKM", clinical=FALSE)}

	#-- Get expression and merged with specific clinical covariate 
	\donttest{data <- getTCGA(disease="OV", data.type="RNASeq", type="RPKM", cvars="ethnicity")}
	}
