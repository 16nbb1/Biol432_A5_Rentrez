# Loading in package
library(rentrez)

# NCBI 
ncbi_ids_covid <- c("NC_045512.2")

# Rentrez "fetches" these IDs using the nuccore *nucleotide" option
# It uses the ids provided
# Presents the file as a fasta

(covid<-entrez_fetch(db = "nuccore", id = ncbi_ids_covid, rettype = "fasta"))

# Note: 1 long string of sequence:
  # Each sequence is separated by >
  # Each line within the sequences are separated by \n

# We split out long sequence by finding the > character
Sequences_covid = unlist(strsplit(covid, split = "(?<=[^>])(?=>)", perl = TRUE))

# We only need the sequence this time, this time we're excluding the words AFTER 'genome"
seq<-gsub("^>.*genome\\n([ATCG].*)","\\1",Sequences_covid)

# Remove the newline characters from the Sequences data frame using regular expressions
seq=gsub("[\r\n]", "", seq)

# We can index select from our sequence
(spike = substr(seq, 21563 , 25384)) # should be the length 3821

# We can double check we've selected the right string with the following
  # Logically testing if our substring can find the provided beginning and end
grepl('^ATGTTTGTTTTTCTTGTTT', spike)
grepl('GTCAAATTACATTACACATAA$', spike)


# Using Blast, I searched the sequences provided by "spike" using the default parameters
# Upon inspecting the Description, Graphics and Alignment
  # I found this sequence had ~100% identity among all the sequences shown, even when the sequences provided are from the USA and China
  # I found that all 100 sequences selected report to be from the same lineage. If this protein sequence was rapidly evolving, we would expect "branching" from different strains for example 




