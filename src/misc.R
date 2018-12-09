

data.dir <- "../data"
part.dir <- "pilot"
tac.file <- "1542579290534-iju9_jia_tactile_1_1_1_metrics.tsv"
aud.file <- "1542579450269-0emq_jia_audio_tactile_2_1_1_metrics.tsv"

tac.file.path <- paste(data.dir,part.dir,tac.file, sep="/")
aud.file.path <- paste(data.dir,part.dir,aud.file, sep="/")


tac.data <- read.table(tac.file.path, sep="\t", fileEncoding="UTF-16LE", stringsAsFactors=FALSE)
aud.data <- read.table(aud.file.path, sep="\t", fileEncoding="UTF-16LE", stringsAsFactors=FALSE)

# Format the Data
colnames(tac.data) <- tac.data[1,]
cnames <- unique(as.matrix(unlist(tac.data[1,])))
colnames(tac.data) <- cnames
tac.data <- tac.data[-1,]
for (i in 1:nrow(tac.data))
{
	tac.data[i,] <- as.character(unlist(tac.data[i,]))
}

colnames(aud.data) <- aud.data[1,]
cnames <- unique(as.matrix(unlist(aud.data[1,])))
colnames(aud.data) <- cnames
aud.data <- aud.data[-1,]
for (i in 1:nrow(aud.data))
{
	aud.data[i,] <- as.character(unlist(aud.data[i,]))
}




plot(seq(1,length(tac.data$WPM)), as.numeric(tac.data$WPM),
	main="WPM vs Trial",
	ylab="WPM",
	xlab="Trial",
	ylim=c(0,max(as.numeric(tac.data$WPM))),
	pch=19,
	col=c(rgb(0,0,1,0.5))
)
points(seq(1,length(aud.data$WPM)), as.numeric(aud.data$WPM),pch=19,col=c(rgb(1,0,0,0.5)))
abline(mean(as.numeric(tac.data$WPM)), col=c(rgb(0,0,1,0.5)),0)
abline(mean(as.numeric(aud.data$WPM)), col=c(rgb(1,0,0,0.5)),0)


#hist(as.numeric(tac.data$WPM),breaks=5)

# Plot the densities of Each
plot(density(as.numeric(tac.data$WPM)),col="blue") # Density Plot
lines(density(as.numeric(aud.data$WPM)),col="red") # Density Plot
