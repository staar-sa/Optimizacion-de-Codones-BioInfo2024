###Script secuencias fasta


##Cargar libraría siempre

library(Biostrings)

ecoli <- "01_raw_data/e.coli.fna"
ecoli_fasta <- readAAStringSet(ecoli)

bsubtilis <- "01_raw_data/b. subtilis.fna"
bsubtilis_fasta <- readAAStringSet (bsubtilis)

pflour <- "01_raw_data/b. subtilis.fna"
flouresce_fasta <- readAAStringSet (pflour)

cereviseae <- "01_raw_data/s.cereviseae.fna"
cereviseae_fasta <- readAAStringSet (cereviseae)
