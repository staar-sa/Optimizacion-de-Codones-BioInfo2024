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


##############################################################################

##Definir una función, para que esta reciba una secuencia de ADN como entrada
preferencia_de_codones <- function(secuencia) {

# Dividir una secuencia en codones
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



###Generar un ciclo for que recorre todos los codones generados anteriormente y calcular cuantas veces a parece cada uno 

for (codon in codones) {      ##Un ciclo que tome cada codón del vector codones uno por uno 
  indice <- which(codones_aminoacidos$Codon == codon)  ##Aquí buscamos la posición del codón actual en el data frame codones_aminoacidos, usamos which para que devuelva la posición en la que el codoón actual coincide 
  if (length(indice) > 0) { # Aquí verificamos que el codón actual exista, si el codoón no existe which devuelve un vector vacío y el length(índice) sería 0
    frecuencia_codones[codon] <- frecuencia_codones[codon] + 1  ##Si el codón actual existe incrementa en 1 la frecuencia del codón en el vector frecuencia_codones
  }
}





#volver las frecuencias a un dataframe 
df_frecuencia_codones <- as.data.frame(frecuencia_codones)
df_frecuencia_codones

#combinar ambos data frame, el de aminoacidos y de frecuencias por columnas
df_codones_aa <- cbind(codones_aminoacidos, df_frecuencia_codones)
df_codones_aa

# Crear dataframe vacío para los resultados
codones_mas_frecuentes <- data.frame()

# Obtener los aminoácidos únicos
aminoacidos <- unique(df_codones_aa$Aminoacido)

# Encontrar el codón más frecuente para cada aminoácido
for(amino in aminoacidos) {
    # Seleccionar las filas de ese aminoácido
    filas_aa <- df_codones_aa[df_codones_aa$Aminoacido == amino, ]
    # Seleccionar la fila con el valor más alto
    fila_max <- filas_aa[which.max(filas_aa$frecuencia_codones), ]
    # Añadir al dataframe final
    codones_mas_frecuentes <- rbind(codones_mas_frecuentes, fila_max)
}

codones_mas_frecuentes

library(ggplot2)
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
 
 library (plotly)
 df_codones_aa_plot_interactivo <- ggplotly (df_codones_aa_plot)
 print (df_codones_aa_plot_interactivo)
 
 print(list(
   codones_mas_frecuentes = codones_mas_frecuentes,
   grafico = df_codones_aa_plot)
 )
 }

preferencia_de_codones(bsubtilis_fasta)
