#0 - LIBRERIAS REQUERIDAS##

 #En caso de no tenerlas, es necesario instalarlas previamente antes de cargarlas

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Biostrings")

install.packages("ggplot2")

install.packages("plotly")

#Si ya las tienes, solo hay que cargarlas previamente

library(Biostrings)
library(ggplot2)
library(plotly)



## 1 - DESCARGAR SECUENCIAS, ESTAS SERAN USADAS COMO REFERENCIA##

# 1.1 Asignar a un objeto la secuencia fasta 

ecoli <- "04_rmarkdown/01_raw_data/e.coli.fna"

# 1.2 Leer la secuencia con la función readDNAStringSet que vive en Biostrings 
# y asignar a un objeto

ecoli_fasta <- readDNAStringSet(ecoli)


# Repetir los pasos 1.1 y 1.2 con las secuencias que se deseen analizar

bsubtilis <- "04_rmarkdown/01_raw_data/b. subtilis.fna"
bsubtilis_fasta <- readDNAStringSet (bsubtilis)

pflour <- "04_rmarkdown/01_raw_data/p. fluorescens.fna"
flouresce_fasta <- readDNAStringSet (pflour)

lividians <- "04_rmarkdown/01_raw_data/s. lividians.fna"
livi_fasta <- readDNAStringSet (lividians)

putida <- "04_rmarkdown/01_raw_data/p. putida.fna"
putida_fasta <- readDNAStringSet (putida)

# Si queremos observalas:
# Podemos visualizarlas individualmente solo imprimiendolas

print(ecoli_fasta)
print(bsubtilis_fasta)
print(flouresce_fasta)
print(livi_fasta)
print(putida_fasta)

# Preferimos hacer un dataframe para organizar las secuencias a usar en el proyecto

secuencias_df <- rbind(    
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
print(secuencias_df)



## 2 - DEFINIMOS UNA FUNCION PARA DETERMINAR LA PREFERENCIA DE CODONES##

preferencia_de_codones <- function(secuencia) {
  
#2.1 Dividir una secuencia en codones
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
  
#2.2 Creamos un dataframe sobre los codones que le corresponden a cada aminoacido
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
    # Codones de paro
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
  ))  

 #2.3 Crear un vector de tamaño igual al número de codones, inicializado en 0
frecuencia_codones <- numeric(length(codones_aminoacidos[["Codon"]]))
  # Asignar nombres a cada posición del vector, basados en los codones del data frame
names(frecuencia_codones) <- codones_aminoacidos[["Codon"]]

 #2.4 Generar un ciclo for que recorre todos los codones generados anteriormente y calcular cuantas veces a parece cada uno 
for (codon in codones) { #Que tome cada codón del vector codones uno por uno 
  indice <- which(codones_aminoacidos[["Codon"]] == codon) #Aquí buscamos la posición del codón actual en el data frame codones_aminoacidos, usamos which para que devuelva la posición en la que el codon actual coincide 
  if (length(indice) > 0) { #Verificamos que el codón actual exista, si el codón no existe which devuelve un vector vacío y el length(índice) sería 0
    frecuencia_codones[codon] <- frecuencia_codones[codon] + 1 #Si el codón actual existe incrementa en 1 la frecuencia del codón en el vector frecuencia_codones
  }
}
  # Convertir las frecuencias obtenidas a un data frame 
df_frecuencia_codones <- as.data.frame(frecuencia_codones)

  # Combinar ambos data frame, el de aminoacidos y de frecuencias por columnas
df_codones_aa <- cbind(codones_aminoacidos, df_frecuencia_codones)


 #2.5 Para visualizar los aminoacidos mas frecuentes
  # Crear dataframe vacío para los resultados
codones_mas_frecuentes <- data.frame()
  # Obtener los aminoácidos únicos
aminoacidos <- unique(df_codones_aa[["Aminoacido"]])
  # Encontrar el codón más frecuente para cada aminoácido
for(amino in aminoacidos) {
  # Seleccionar las filas de ese aminoácido
  filas_aa <- df_codones_aa[df_codones_aa[["Aminoacido"]] == amino, ]
  # Seleccionar la fila con el valor más alto
  fila_max <- filas_aa[which.max(filas_aa[["frecuencia_codones"]]), ]
  # Añadir al dataframe final
    codones_mas_frecuentes <- rbind(codones_mas_frecuentes, fila_max)
}


 #2.6 Graficar los resultados
library(ggplot2)

 df_codones_aa_plot <- ggplot(df_codones_aa, aes(x = Codon, y = frecuencia_codones, fill = Aminoacido)) +
   geom_bar(stat = "identity") +
   theme_minimal() +
   labs(
     title = "Frecuencia de Codones",
     x = "Codón",
     y = "Frecuencia",
     fill = "Aminoácido"
   ) + 
   theme(axis.text.x = element_text(angle = 90, hjust = 1))
 
  # Como extra, si queremos que la grafica sea interactiva
 df_codones_aa_plot_interactivo <- ggplotly (df_codones_aa_plot)
 print (df_codones_aa_plot_interactivo)

  #2.7 Creamos una lista donde tengamos tanto la grafica como los codones mas frecuentes
 print(list(
   codones_mas_frecuentes = codones_mas_frecuentes,
   grafico = df_codones_aa_plot)
 )
   # Guardar los codones más frecuentes como un archivo CSV
 write.csv(codones_mas_frecuentes, "04_rmarkdown/03_resultados/codones_mas_frecuentes.csv", row.names = FALSE)
   # Guardar la tabla completa de codones y frecuencias como CSV
 write.csv(df_codones_aa, "04_rmarkdown/03_resultados/frecuencia_codones.csv", row.names = FALSE)
   # Guardar la gráfica como imagen PNG
 ggsave("04_rmarkdown/03_resultados/grafico_codones.png", plot = df_codones_aa_plot, width = 10, height = 7, dpi = 300)
 }



## 3 - PODEMOS USAR EL MISMO CODIGO PARA LAS DEMAS SECUENCIAS, POR EJEMPLO:
 # E.coli
preferencia_de_codones(ecoli_fasta)


 # Bacillus subtilis
preferencia_de_codones(bsubtilis_fasta)


 # Pseudomonas fluorscens
preferencia_de_codones(flouresce_fasta)


 # Streptomyces lividans
preferencia_de_codones(livi_fasta)


 # Pseudomonas putida
preferencia_de_codones(putida_fasta)


