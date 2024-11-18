###Script secuencias fasta


##Cargar libraría siempre

library(Biostrings)

ecoli <- "01_raw_data/e.coli.fna"
ecoli_fasta <- readAAStringSet(ecoli)

bsubtilis <- "01_raw_data/b. subtilis.fna"
bsubtilis_fasta <- readAAStringSet (bsubtilis)

pflour <- "01_raw_data/b. subtilis.fna"
flouresce_fasta <- readAAStringSet (pflour)


# Crear un data frame con las secuencias
secuencias_df <- rbind(    ###Es para unir todos los data frames, porque no se como hacerlo o no me acuerdo jejej 
  data.frame(
    Organismo = "E. coli",
    ID = names(ecoli_fasta),
    Secuencia = as.character(ecoli_fasta),
    Longitud = width(ecoli_fasta)
  ),
  data.frame(
    Organismo = "B. subtilis",
    ID = names(bsubtilis_fasta),
    Secuencia = as.character(bsubtilis_fasta),
    Longitud = width(bsubtilis_fasta)
  ),
  data.frame(
    Organismo = "P. fluorescens",
    ID = names(flouresce_fasta),
    Secuencia = as.character(flouresce_fasta),
    Longitud = width(flouresce_fasta)
    
  )
)



