# Download.R 

# Loading in package
library(rentrez)

# NCBI Ids
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# Rentrez "fetches" these IDs using the nuccore *nucleotide" option
# It uses the ids provided
# Presents the file as a fasta

(Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta"))

# Note: 1 long string of sequence:
  # Each sequence is separated by >
  # Each line within the sequences are separated by \n

# We split out long sequence by finding the > character
Sequences = unlist(strsplit(Bburg, split = "(?<=[^>])(?=>)", perl = TRUE))

# We find the header, using the characters founnd BEFORE 'sequence"
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
# We find the header, using the characters founnd AFTER 'sequence"
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
# We create a dataframe using the headers and sequences for all 3 ids
Sequences<-data.frame(Name=header,Sequence=seq)

# Remove the newline characters from the Sequences data frame using regular expressions by using the \n character
Sequences$Sequence=gsub("[\r\n]", "", Sequences$Sequence)

# We save the sequences in a .csv
write.csv(Sequences,"./Sequences.csv", row.names=FALSE)



