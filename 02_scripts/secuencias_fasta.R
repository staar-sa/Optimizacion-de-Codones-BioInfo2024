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


## Data frame para asignar el aminoacido a los codones 

codones_aminoacidos <- data.frame(
  Codon = c(
    # Alanina
    "GCT", "GCC", "GCA", "GCG",
    
    # Cisteína
    "TGT", "TGC",
    
    # Ácido aspártico
    "GAT", "GAC",
    
    # Ácido glutámico
    "GAA", "GAG",
    
    # Fenilalanina
    "TTT", "TTC",
    
    # Glicina
    "GGT", "GGC", "GGA", "GGG",
    
    # Histidina
    "CAT", "CAC",
    
    # Isoleucina
    "ATT", "ATC", "ATA",
    
    # Lisina
    "AAA", "AAG",
    
    # Leucina
    "TTA", "TTG", "CTT", "CTC", "CTA", "CTG",
    
    # Metionina
    "ATG",
    
    # Asparagina
    "AAT", "AAC",
    
    # Prolina
    "CCT", "CCC", "CCA", "CCG",
    
    # Glutamina
    "CAA", "CAG",
    
    # Arginina
    "CGT", "CGC", "CGA", "CGG", "AGA", "AGG",
    
    # Serina
    "TCT", "TCC", "TCA", "TCG", "AGT", "AGC",
    
    # Treonina
    "ACT", "ACC", "ACA", "ACG",
    
    # Valina
    "GTT", "GTC", "GTA", "GTG",
    
    # Triptófano
    "TGG",
    
    # Tirosina
    "TAT", "TAC",
    
    # Codones de parada
    "TAA", "TAG", "TGA"
  ),
  
  Aminoacido = c(
    # 4 Alanina
    "Ala", "Ala", "Ala", "Ala",
    
    # 2 Cisteína
    "Cys", "Cys",
    
    # 2 Ácido aspártico
    "Asp", "Asp",
    
    # 2 Ácido glutámico
    "Glu", "Glu",
    
    # 2 Fenilalanina
    "Phe", "Phe",
    
    # 4 Glicina
    "Gly", "Gly", "Gly", "Gly",
    
    # 2 Histidina
    "His", "His",
    
    # 3 Isoleucina
    "Ile", "Ile", "Ile",
    
    # 2 Lisina
    "Lys", "Lys",
    
    # 6 Leucina
    "Leu", "Leu", "Leu", "Leu", "Leu", "Leu",
    
    # 1 Metionina
    "Met",
    
    # 2 Asparagina
    "Asn", "Asn",
    
    # 4 Prolina
    "Pro", "Pro", "Pro", "Pro",
    
    # 2 Glutamina
    "Gln", "Gln",
    
    # 6 Arginina
    "Arg", "Arg", "Arg", "Arg", "Arg", "Arg",
    
    # 6 Serina
    "Ser", "Ser", "Ser", "Ser", "Ser", "Ser",
    
    # 4 Treonina
    "Thr", "Thr", "Thr", "Thr",
    
    # 4 Valina
    "Val", "Val", "Val", "Val",
    
    # 1 Triptófano
    "Trp",
    
    # 2 Tirosina
    "Tyr", "Tyr",
    
    # 3 Codones de parada
    "Stop", "Stop", "Stop"
  )
)  


# Crear un vector de tamaño igual al número de codones, inicializado en 0
frecuencia_codones <- numeric(length(codones_aminoacidos$Codon))


# Asignar nombres a cada posición del vector, basados en los codones del data frame
names(frecuencia_codones) <- codones_aminoacidos$Codon

frecuencia_codones

for (codon in codones_e.coli) {
  indice <- which(codones_aminoacidos$Codon == codon)
  if (length(indice) > 0) { # Asegurarse de que hay un índice válido
    frecuencia_codones[codon] <- frecuencia_codones[codon] + 1
  }
}

frecuencia_codones

 