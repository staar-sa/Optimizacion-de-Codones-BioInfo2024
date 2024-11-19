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


# Crear un vector de tamaño igual al número de codones, inicializado en 0
frecuencia_codones <- numeric(length(codones_aminoacidos$Codon))
# Asignar nombres a cada posición del vector, basados en los codones del data frame
names(frecuencia_codones) <- codones_aminoacidos$Codon

for (codon in codones_e.coli) {
  indice <- which(codones_aminoacidos$Codon == codon)
  if (length(indice) > 0) { # Asegurarse de que hay un índice válido
    frecuencia_codones[codon] <- frecuencia_codones[codon] + 1
  }
}

############################################################################33

# Convertir el vector de frecuencias a dataframe
df_frecuencia_codones <- data.frame(
  Codon = names(frecuencia_codones),
  frecuencia_codones = as.numeric(frecuencia_codones)
)


# Combinar con la tabla de aminoácidos
df_codones_aa <- merge(codones_aminoacidos, df_frecuencia_codones, by = "Codon")

# Crear un dataframe vacío para almacenar los resultados
codones_mas_frecuentes <- data.frame()

# Obtener lista única de aminoácidos
aminoacidos_unicos <- unique(df_codones_aa$Aminoacido)

# Para cada aminoácido, encontrar el codón más frecuente
for(aa in aminoacidos_unicos) {
  # Filtrar solo las filas del aminoácido actual
  datos_aa <- df_codones_aa[df_codones_aa$Aminoacido == aa, ]
  
  # Encontrar la fila con la frecuencia más alta
  fila_max <- datos_aa[which.max(datos_aa$frecuencia_codones), ]
  
  # Añadir esta fila al dataframe de resultados
  codones_mas_frecuentes <- rbind(codones_mas_frecuentes, fila_max)
}

print(codones_mas_frecuentes)
 
 
 ###########################################################################
 
 
 #volver las frecuencias a un dataframe 
 df_frecuencia_codones <- as.data.frame(frecuencia_codones)
 df_frecuencia_codones
#combinar ambos data frame, el de aminoacidos y de frecuencias por columnas
 df_codones_aa <- cbind(codones_aminoacidos, df_frecuencia_codones)
 df_codones_aa

 #Cargar la siguiente libreria para los resultados
 library(ggplot2)
 #Si solo queremos un aminoacido hay que seleccionarlo: Alanina
 ala_data <- df_codones_aa[df_codones_aa$Aminoacido == "Ala", ]
 #Gráfico de barras solo de la comparacion de alanina
 ala_plot <- ggplot(ala_data, aes(x = Codon, y = frecuencia_codones, fill = Aminoacido)) +
   geom_bar(stat="identity") +
   theme_minimal() +
   labs(
     title = "Frecuencia de Codones de Alanina en E. coli",
     x = "Codón",
     y = "Frecuencia",
     fill = "Aminoácido"
   ) + 
   theme(axis.text.x = element_text(angle = 90, hjust = 1))
 ala_plot
 
 #Grafica de todos los aminoacidos
 df_codones_aa_plot <- ggplot(df_codones_aa, aes(x = Codon, y = frecuencia_codones, fill = Aminoacido)) +
   geom_bar(stat = "identity") +
   theme_minimal() +
   labs(
     title = "Frecuencia de Codones en E. coli",
     x = "Codón",
     y = "Frecuencia",
     fill = "Aminoácido"
   ) + 
   theme(axis.text.x = element_text(angle = 90, hjust = 1))
 df_codones_aa_plot
 