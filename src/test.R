#!/usr/bin/Rscript

# Setup the File/Data
data.dir <- "../data"
part.dir <- "pilot"
file.name <- "1542389228020-lvdt_1_1_1_metrics.tsv"
file.path <- paste(data.dir,part.dir,file.name, sep="/")

# Read the Data
data <- read.table(file.path, sep="\t", fileEncoding="UTF-16LE", stringsAsFactors=FALSE)

# Format the Data
colnames(data) <- data[1,]
cnames <- unique(as.matrix(unlist(data[1,])))
colnames(data) <- cnames
data <- data[-1,]


for (i in 1:nrow(data))
{
	data[i,] <- as.character(unlist(data[i,]))
}


par (mfrow=c(2,1))
plot(seq(1,length(data$WPM)), as.numeric(data$WPM),
	main="WPM vs Trial",
	ylab="WPM",
	xlab="Trial",
	ylim=c(0,max(as.numeric(data$WPM)))
)
hist(as.numeric(data$WPM),breaks=5)

sum(as.numeric(data$INPUT_TIME))





xval <- seq(1,length(x$WPM))
yval <- as.character(x$WPM)
plot(xval,yval)

lin <- lm(xval~yval)



for (i in 1:nrow(x))
{
	x[i,] <- as.character(x[i,])
}