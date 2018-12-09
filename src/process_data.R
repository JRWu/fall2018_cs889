#!/usr/bin/Rscript
# This script processes all data and formats the values into 1 large CSV

# For all the zipped files
# Unzip the files

data.dir <- "../data/"
unzipped.data.dir <- "../data/unzipped"
zipped.files <- list.files(data.dir) 

# Iterate through all the zipped files
for (i in 1:length(zipped.files)){
	file <- paste(data.dir,zipped.files[i],sep="")
	#print(file) # Print Filename
	unzip(file,exdir=unzipped.data.dir)
}

all.files <- list.files(unzipped.data.dir)
metrics.indices <- grep("*metrics.tsv$", all.files)

# List of files containing all metrics
metrics.filenames <- all.files[metrics.indices]

# For each of these files, 
# READ THEM IN FORMAT THE CONDITION, FORMAT THE BLOCK
# OUTPUT TO FINAL FILE

final.data <- data.frame(matrix(NA, nrow=0, ncol=33))

for (i in 1:length(metrics.filenames)){
	# Format the Filename
	file <- paste(unzipped.data.dir,metrics.filenames[i],sep="/")	

	# Read the file
	data <- read.table(file, sep="\t", fileEncoding="UTF-16LE", stringsAsFactors=FALSE)

	colnames(data) <- data[1,]
	cnames <- unique(as.matrix(unlist(data[1,])))
	colnames(data) <- cnames
	data <- data[-1,]

	id <- unique(data$ID)
	tokens <- strsplit(id,"_")

	# Format the ID, CONDITION and BLOCK

	# Add special exception for mlakier
	if (tokens[[1]][1] == "matthewlakier"){
		data$ID <- "mlakier"
	} else {
		data$ID <- tokens[[1]][1]
	}

	data$CONDITION <- tokens[[1]][2]
	data$BLOCK <- tokens[[1]][3]

	# Correct for data anomaly, reduce length of asalrefa, condition 1 block 2 to 19 rows instead of 20
	if(tokens[[1]][1] == "asalrefa"){
		if(tokens[[1]][2] == "1"){
			if(tokens[[1]][3] == "2"){
				print("YESSSSS")
				data <- data[-nrow(data),]
			}
		}
	}



	# Strip the LAST row from dataframe (DONT CARE ABOUT SUMMARY STATISTICS PER USER)
	data <- data[-nrow(data),]

	# DELETE RANDOM ROW
	data$CURRENT_SETTING <- NULL

	# Convert all data to characters
	for (j in 1:nrow(data)){
		data[j,] <- as.character(unlist(data[j,]))
	}

	print(tokens[[1]][1])
	print(tokens[[1]][2])
	print(tokens[[1]][3])
	print(nrow(data))

	final.data <- rbind(final.data,data)
}

write.csv(final.data, file=paste(unzipped.data.dir,"summarized_data.csv",sep="/"))



# NOTES:
# Need to change matthew's name so his data is classed as the same
