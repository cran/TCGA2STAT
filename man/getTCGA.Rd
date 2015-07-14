\name{getTCGA}
\alias{getTCGA}
\title{
	Get TCGA Data.
}
\description{
Obtain TCGA data from the Broad GDAC Firehose and process the data into a format ready for statistical analysis.
}
\usage{
getTCGA(disease = "GBM", data.type = "RNASeq2", type = "", filter = "Y",  
		p = getOption("mc.cores", 2L), clinical = TRUE, cvars = "OS")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{disease}{abbreviation for cancer type; default to "\code{GBM}" for glioblastoma multiforme .}
  \item{data.type}{genomic data profiling platform; default to "\code{RNASeq2}" for gene level RNA-Seq data from the second pipeline (RNASeqV2).}
  \item{type}{specific data type produced by certain platforms.}
  \item{filter}{chromosome to be filtered out during data import; only applicable to \code{data.type="CNV_SNP"}.}
  \item{p}{maximum number of processing cores used in parallel processing; default to the value set in "mc.cores" global option or 2.}
  \item{clinical}{logical value to indicate if clinical data is to be imported; default to \code{TRUE}.}
  \item{cvars}{clinical covariates to be merged with genomic data; default to "\code{OS}" for overall survival.}
}
\details{
Values for \code{disease} include \code{"ACC"}, \code{"BLCA"}, \code{"BRCA"}, \code{"CESC"}, \code{"CHOL"}, \code{"COAD"}, \code{"COADREAD"}, \code{"DLBC"}, \code{"ESCA"}, \code{"FPPP"}, \code{"GBM"}, \code{"GBMLGG"}, \code{"HNSC"}, \code{"KICH"}, \code{"KIPAN"}, \code{"KIRC"}, \code{"KIRP"}, \code{"LAML"}, \code{"LGG"}, \code{"LIHC"}, \code{"LUAD"}, \code{"LUSC"}, \code{"MESO"}, \code{"OV"}, \code{"PAAD"}, \code{"PCPG"}, \code{"PRAD"}, \code{"READ"}, \code{"SARC"}, \code{"SKCM"}, \code{"STAD"}, \code{"TGCT"}, \code{"THCA"}, \code{"THYM"}, \code{"UCEC"}, \code{"UCS"}, and \code{"UVM"}. Values for \code{data.type} include \code{"RNASeq2"}, \code{"RNASeq"}, \code{"miRNASeq"}, \code{"CNA_SNP"}, \code{"CNV_SNP"}, \code{"CNA_CGH"}, \code{"Methylation"}, \code{"Mutation"}, \code{"mRNA_Array"}, and \code{"miRNA_Array"}. Note that not all combinations are permitted; Appendix A of the package vignette outlines all values of \code{disease} and \code{data.type} accommodated by \code{TCGA2STAT}.



The \code{type} parameter should only be used along with these four \code{data.type} parameters:
	\itemize{
		\item{\code{RNASeq} - "\code{raw_counts}" for raw read counts (default); "\code{RPKM}" for normalized read counts (reads per kilobase per million mapped reads).}
		\item{\code{miRNASeq} - "\code{raw_counts}" for raw read counts (default); "\code{reads_per_million_miRNA_mapped}" for normalized read counts.}
		\item{\code{Mutation} - "\code{somatic}" for non-silent somatic mutations (default); "\code{all}" for all mutations.}
		\item{\code{Methylation} - "\code{27K}" platform (default), "\code{450K}" platform, and"\code{all}" for both platforms.}
	}


The Level III RNA-Seq, miRNA-Seq, mRNA-array, and miRNA-array data imported are at gene level, but not the mutation, copy number variation (CNV), and methylation data. Our package processes and aggregates the mutation and CNV data at the gene level. The mutation data imported are in MAF files, where patients are repeated in multiple rows as multiple mutations are found, and the number of mutations differs across patients. We filter the mutation data based on status and variant classification and then aggregate the filtered data at the gene level. The Level III CNV data imported are in segments; therefore we employ the \code{CNTools} package to merge the segmented data into gene-level data. The methylation data imported is at probe level where each probe represents a CpG region. As methylation profiles at different CpG regions within the same gene could vary a lot, it would not be biological meaningful to aggregate the probe-level methylation data into gene-level data. We return the methylation data at probe level.

}
\value{
	If clinical data is imported, a list containing three elements is returned:
	\item{dat}{a matrix or a list of matrices. Each matrix is of dimension \emph{gene} x \emph{sample}.}
	\item{clinical}{a matrix of dimension \emph{sample} x \emph{clinical covariates}.}
	\item{merged.dat}{a matrix or a list of matrices. Each matrix is the merged \code{dat} and clinical data as specified by \code{cvars}. Thus, each matrix of size \emph{sample} x (\emph{cvars} + \emph{gene})}
	
	If clinical data is not imported, only a matrix or list of matrices with genomics data, each of dimension \emph{gene} x \emph{sample} is returned.


	Note: for methylation data, each row in \code{dat} is a probe for CpG island, the first three columns are gene symbol, chromosome, and genome coordinate.

}
\examples{
\donttest{
library(TCGA2STAT)
ov.rnaseq2 <- getTCGA(disease="OV", data.type="RNASeq2")
ov.rnaseq <- getTCGA(disease="OV", data.type="RNASeq", type="RPKM")
}
}
