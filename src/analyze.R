# Load the Libraries
library(ez)
library(dplyr)
library(reshape)
library(knitr)

data.dir <- "../data/unzipped"
file.name <- "summarized_data.csv"

file <- paste(data.dir,file.name,sep="/")
data <- read.csv(file)

# Clean the Data
data$X <- NULL
data$ID <- as.integer(data$ID) #TODO" Convert the participants to a numeric value


# Group the data by ID, CONDITION, and BLOCK & summarize by WPM and Total Error Rate
data.grouped <- data %>% 
	group_by(ID, CONDITION, BLOCK) %>% 
	summarise(WPM=mean(WPM),TOTAL_ERROR_RATE=mean(TOTAL_ERROR_RATE))

data.long <- melt(data.grouped, id=c("ID", "CONDITION", "BLOCK", "WPM","TOTAL_ERROR_RATE"))

# Define factors task, technique, block and distance
#data.long$ID <- factor(data.long$ID)
data.long$CONDITION <- factor(data.long$CONDITION)
data.long$BLOCK <- factor(data.long$BLOCK)

anova = ezANOVA(data.long, dv=.(WPM), wid=.(ID), within=.(CONDITION, BLOCK), detailed=TRUE)

# THIS WILL FAIL BECAUSE MISSING DATA FOR SOME CONDITIONS



# argument "x" is missing, with no default


















############### MISC PLOTTING WORK ###############

# Audio Tactile
at <- data[which(data$CONDITION == 1),]

# Tactile
tt <- data[which(data$CONDITION == 2),]



# Plotting Work
at.col <- c(rgb(0,0,1,0.5))
tt.col <- c(rgb(1,0,0,0.5))

# Blue is Audio Tactile
# Red is Tactile
plot(at$WPM,
	main="WPM",
	ylab="WPM",
	pch=19,
	col=at.col
)
points(tt$WPM,pch=19, col=tt.col)
abline(mean(at$WPM), col=at.col, 0)
abline(mean(tt$WPM), col=tt.col, 0)

# Boxplot of Two
boxplot(at$WPM,tt$WPM, col=c(at.col,tt.col),
	names= c("Audio Tactile", "Tactile"),
	main = "WPM Boxplot of Audio Tactile vs Tactile",
	ylab = "WPM"
)


# Check for Normality
# CUBE: sign(VALUE) * abs(VALUE)^(1/3)

shapiro.test( sign(at$WPM) * abs(at$WPM)^(1/3) )
shapiro.test( sign(tt$WPM) * abs(tt$WPM)^(1/3) )


at.ztransform <- (at$WPM - mean(at$WPM)) / sd(at$WPM)
tt.ztransform <- (tt$WPM - mean(tt$WPM)) / sd(tt$WPM)

shapiro.test(at.ztransform)
shapiro.test(tt.ztransform)


shapiro.test(sqrt(at$WPM))
shapiro.test(sqrt(tt$WPM))

shapiro.test(log(at$WPM))
shapiro.test(log(tt$WPM))

shapiro.test(at$WPM)
shapiro.test(tt$WPM)



