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
		p = getOption("mc.cores", 2L), clinical = FALSE, cvars = "OS")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{disease}{acronym for cancer type; default to "\code{GBM}" for glioblastoma multiforme.}
  \item{data.type}{genomic data profiling platform; default to "\code{RNASeq2}" for gene level RNA-Seq data from the second pipeline (RNASeqV2).}
  \item{type}{specific type of measurement produced by certain platforms.}
  \item{filter}{chromosome to be filtered out during data import; only applicable CNA or CNV data.}
  \item{p}{maximum number of processing cores used in parallel processing; default to the value set in "mc.cores" global option or 2.}
  \item{clinical}{logical value to indicate if clinical data is to be imported; default to \code{FALSE}.}
  \item{cvars}{clinical covariates to be merged with genomic data; default to "\code{OS}" for overall survival.}
}
\details{
Values for \code{disease} include \code{"ACC"}, \code{"BLCA"}, \code{"BRCA"}, \code{"CESC"}, \code{"CHOL"}, \code{"COAD"}, \code{"COADREAD"}, \code{"DLBC"}, \code{"ESCA"}, \code{"FPPP"}, \code{"GBM"}, \code{"GBMLGG"}, \code{"HNSC"}, \code{"KICH"}, \code{"KIPAN"}, \code{"KIRC"}, \code{"KIRP"}, \code{"LAML"}, \code{"LGG"}, \code{"LIHC"}, \code{"LUAD"}, \code{"LUSC"}, \code{"MESO"}, \code{"OV"}, \code{"PAAD"}, \code{"PCPG"}, \code{"PRAD"}, \code{"READ"}, \code{"SARC"}, \code{"SKCM"}, \code{"STAD"}, \code{"TGCT"}, \code{"THCA"}, \code{"THYM"}, \code{"UCEC"}, \code{"UCS"}, and \code{"UVM"}. Values for \code{data.type} include \code{"RNASeq2"}, \code{"RNASeq"}, \code{"miRNASeq"}, \code{"CNA_SNP"}, \code{"CNV_SNP"}, \code{"CNA_CGH"}, \code{"Methylation"}, \code{"Mutation"}, \code{"mRNA_Array"}, and \code{"miRNA_Array"}. Note that not all combinations are permitted; Appendix A of the package vignette outlines all values of \code{disease} and \code{data.type} accommodated by \code{TCGA2STAT}.



The \code{type} parameter should only be used along with these \code{data.type} parameters:
	\itemize{
		\item{\code{RNASeq} - "\code{count}" for raw read counts (default); "\code{RPKM}" for normalized read counts (reads per kilobase per million mapped reads).}
		\item{\code{miRNASeq} - "\code{count}" for raw read counts (default); "\code{rpmmm}" for normalized read counts.}
		\item{\code{Mutation} - "\code{somatic}" for non-silent somatic mutations (default); "\code{all}" for all mutations.}
		\item{\code{Methylation} - "\code{27K}" platform (default); "\code{450K}" platform.}
    \item{\code{CNA_CGH} - "\code{415K}" for CGH Custom Microarray 2x415K (default); "\code{244A}" for CGH Microarray.}
    \item{\code{mRNA_Array} - "\code{G450}" for Agilent 244K Custom Gene Expression G4502A (default); "\code{U133}" for Affymetrix Human Genome U133A 2.0 Array; "\code{Huex}" for Affymetrix Human Exon 1.0 ST Array.}
	}


The Level III RNA-Seq, miRNA-Seq, mRNA-array, and miRNA-array data imported are at gene level, but not the mutation, copy number alterations/variation (CNA/CNV), and methylation data. Our package processes and aggregates the mutation and CNA/CNV data at the gene level. The mutation data imported are in MAF files, where each file contains mutations found for the particular patient, and the number of mutations differs across patients. We filter the mutation data based on status and variant classification and then aggregate the filtered data at the gene level. The Level III CNA/CNV data imported are in segments; therefore we employ the \code{CNTools} package to merge the segmented data into gene-level data. The methylation data imported is at probe level where each probe represents a CpG site. As methylation profiles at different CpG sites within the same gene could vary a lot, it would not be biological meaningful to aggregate the probe-level methylation data into gene-level data. We return the methylation data at probe level.

}
\value{
  A list containing:
	\item{dat}{a matrix of dimension \emph{gene} x \emph{sample}.}
	\item{clinical}{a matrix of dimension \emph{sample} x \emph{clinical covariates}; \code{NULL} if \code{clinical=FALSE}}
	\item{merged.dat}{a matrix, which is the merged \code{dat} and clinical data as specified by \code{cvars}. Thus, each matrix of size \emph{sample} x (\emph{cvars} + \emph{gene}); \code{NULL} if \code{clinical=FALSE} or \code{cvars} is not a valid name for clinical covariate.}
  
  and for methylation data, an additional element:
  \item{cpgs}{a matrix of dimension \emph{cpg sites} x \emph{3}. The three columns are gene symbol, chromosome, and genomic coordinate for each CpG site. The order of CpG sites in this matrix is the same as the order in \code{dat}.}
}
\examples{
\donttest{
library(TCGA2STAT)
rsem.ov <- getTCGA(disease="OV", data.type="RNASeq2")
rnaseq.ov <- getTCGA(disease="OV", data.type="RNASeq", type="RPKM")
rnaseq_os.ov <- getTCGA(disease="OV", data.type="RNASeq", type="RPKM", clinical=TRUE)
}
}
