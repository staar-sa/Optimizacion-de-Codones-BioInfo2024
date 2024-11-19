###Script secuencias fasta


##Cargar libraría siempre

library(Biostrings)

ecoli <- "01_raw_data/e.coli.fna"
ecoli_fasta <- readDNAStringSet(ecoli)

bsubtilis <- "01_raw_data/b. subtilis.fna"
bsubtilis_fasta <- readDNAStringSet (bsubtilis)

pflour <- "01_raw_data/p. fluorescens.fna"
flouresce_fasta <- readDNAStringSet (pflour)

lividians <- "01_raw_data/s. lividians.fna"
livi_fasta <- readDNAStringSet (lividians)

putida <- "01_raw_data/p. putida.fna"
putida_fasta <- readDNAStringSet (putida)

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
    
  ),
  data.frame(
    Organismo = "S. lividians",
    ID = names(livi_fasta),
    Secuencia = as.character (livi_fasta),
    Longitud = width (livi_fasta)
  ),
  data.frame(
    Organismo = "P. putida",
    ID = names(putida_fasta),
    Secuencia = as.character(putida_fasta),
    Longitud = width (putida_fasta)
  )
)

# Función para dividir una secuencia en codones
dividir_en_codones <- function(secuencia) {
# Convertir DNAString a caracteres
secuencia_en_caracteres <- as.character(secuencia)
  
# Obtener la longitud de la secuencia
numero_caracteres <- nchar( secuencia_en_caracteres)
  
# Verificar si la longitud es múltiplo de 3
if (numero_caracteres %% 3 != 0) {
secuencia_en_caracteres <- substr( secuencia_en_caracteres, 1, numero_caracteres 
                                   - (numero_caracteres %% 3))
}
  
# Dividir en codones
codones <- substring( secuencia_en_caracteres, 
                       seq(1, nchar( secuencia_en_caracteres)-2, by=3),
                       seq(3, nchar( secuencia_en_caracteres), by=3))
  
  return(codones)
}

dividir_en_codones(ecoli_fasta) -> codones_e.coli
codones_e.coli


