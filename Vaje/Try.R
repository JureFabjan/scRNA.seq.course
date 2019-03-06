# library(GEOquery)
# gse <- getGEO("GSE93374", GSEMatrix=TRUE)
# show(gse)
# filePaths <- getGEOSuppFiles("GSE93374")
# filePaths
#####################################################
# Imports
library(SingleCellExperiment, quietly = TRUE)


#####################################################
# Data import:
#   - data is already presliced with Preprocess.py
#   - selected are POMC neurons of animals of Chow diet group (same batch!)
df <- read.delim("Vaje/GSE93374/GSE93374_sliced.txt", sep="\t")
head(df)
dim(df)
# Moving gene names to row names => creating numeric matrix
rownames(df) <- df[,1]
df <- df[,-1]
head(df)
# Checking for spike-ins
rownames(df)[grep("^ERCC-", rownames(df))]
# Extracting metadata
cellIDs <- colnames(df)
head(cellIDs)
# Importing metadata from the file
meta <- read.delim("Vaje/GSE93374/GSE93374_metadata.txt", sep="\t")
head(meta)
rownames(meta) <- meta[,1]
meta <- meta[,-1]
head(meta)
meta <- meta[cellIDs,]
head(meta)
sceset <- SingleCellExperiment(assays = list(logcounts = as.matrix(df)), metadata = meta)
sceset
# Tell sceset where to look for spike-ins
isSpike(sceset, "ERCC") <- grepl("ERCC", rownames(sceset))
sceset
