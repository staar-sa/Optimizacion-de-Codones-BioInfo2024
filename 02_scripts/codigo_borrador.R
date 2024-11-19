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

codones_aminoacidos
 print (codones_aminoacidos)
 