\name{TCGA2STAT-package}
\alias{TCGA2STAT-package}
\alias{TCGA2STAT-package}
\docType{package}
\title{
TCGA2STAT: TCGA to Statistical Analysis
}
\description{
This widget automatically downloads and processes TCGA genomics and clinical data into a format convenient for statistical analyses in the R environment.
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
integrated into statistical analysis pipelines in the R environment. The data imported by this package is the version-stamped standardized data sets hosted and maintained by the Broad GDAC Firehose (http://gdac.broadinstitute.org/). 

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
	
	#-- Default: Get only the omics-profiles, for example RNA-SeqV2
	\donttest{ACC.ov <- getTCGA(disease="ACC", data.type="RNASeq2")}
	\donttest{str(ACC.ov)}

	#-- Get the RNA-SeqV2, all clinical data, and expression merged with 
	#   overall-survival for tumor samples
	\donttest{ACC.ov.os <- getTCGA(disease = "ACC", data.type = "RNASeq2", clinical=TRUE)}

	#-- Get expression and merged with specific clinical covariate 
	\donttest{ACC.ov.eth <- getTCGA(disease = "ACC", data.type = "RNASeq2", clinical=TRUE, 
	                        cvars="ethnicity")}
	\donttest{head(ACC.ov.eth$merged.dat[,1:5])}
}
