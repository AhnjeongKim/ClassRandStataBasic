################################################################################
###### Sample code for lecture: Introduction in R ##############################
###### Author: Ahn Kim #########################################################
###### Date: 05-04-2023 ########################################################
################################################################################
###### Run this before you start ###############################################
rm(list=ls()) # clear memory
cat("\014") #or Ctrl+L : clear console
setwd("C:") # change the path
################################################################################

# Before getting started 

print("Hello world!")
setwd("C:") # change the path
getwd()      
# install.packages("foreign")
# install.packages("ggplot2")

library(foreign)
library(ggplot2)

# Vectors and Matrix

mat1<-c(1,2,3)
mat1
mat2<-c(4,5,6)
mat2
mat3<-cbind(mat1,mat2)
mat3
mat4<-rbind(mat1,mat2)
mat4
dim(mat3)
dim(mat4)
rnames<-c("Row1","Row2")
cnames<-c("Col1","Col2","Col3")
mat.name<-matrix(mat4,nrow=2,byrow=TRUE,dimnames=list(rnames,cnames))
mat.name

# Matrix Calculation
mat.result1=mat1 %*% mat2
mat.result1
mat.name[2,2]<-10
mat.name

t(mat.name)

mat.name2<-cbind(t(mat.name),mat1)
mat.name2
diag(mat.name2)

# Other Basic Sintax 
v1<-seq(1,200,by=2)
v1
v2<-rep(1,100)
v2
repeat1 <- rep(c(1,2,3), times = 3)
repeat1
repeat2 <- rep(c(1,2,3), times = c(5,2,1))
repeat2

length(repeat2)
sum(repeat2)
range(repeat2)

fruits <- c("banana", "apple", "orange")
log_values <- c(TRUE, FALSE, TRUE, FALSE)

# Data Input

rm(list=ls()) # clear memory
cat("\014") #or Ctrl+L : clear console

data <- read.csv("lifeexp_sample.csv")
head(data)

# Exercise
# install.packages("readxl")
# library(readxl)
# data <- read_excel("data.xlsx")

class(data) #check the type of `data`
class(data$region)
class(data$popgrowth)

# Statistics

data[1:2,]
data[1:2,2]
data[["gnppc"]]
data$gnppc

data[1:2, c("region","country")]
data[c(1,2), c(2,3)]
data[data$lexp > 75,c("country") ]

dim(data)
ncol(data)
nrow(data)

summary(data)
mean(data$lexp)
median(data$lexp)
var(data$lexp)
sd(data$lexp)

summary(data$gnppc)
attach(data)
summary(gnppc)

# Missing Values
list(gnppc)
is.na(gnppc)
x<-na.omit(gnppc)
list(x)
mean_gnppc <- mean(gnppc, na.rm = TRUE)
gnppc[is.na(gnppc)] <- mean_gnppc

mat.num<-c(1,NaN,NA,NULL,Inf,0/0)
is.nan(mat.num)
is.na(mat.num)
is.null(mat.num)
is.infinite(mat.num)
is.numeric(mat.num)

mat.null<-c()
is.nan(mat.null)
is.na(mat.null)
is.null(mat.null)
is.infinite(mat.null)
is.numeric(mat.null)

# Data Analysis
  hist(gnppc)

par(mfrow=c(1,2),pty="s")
hist(gnppc,main="Distribution of GNP per captia",xlab="GNP per capita",col="darkgreen",breaks=50)
hist(lexp,main="Distribution of Life Expectancy",xlab="Life Expectancy",col="orange",breaks=50)

par(mfrow=c(1,2),pty="s")
hist(log(gnppc),main="Distribution of log GNP per captia",xlab="log GNP per capita",col="darkgreen",breaks=50)
hist(lexp,main="Distribution of Life Expectancy",xlab="Life Expectancy",col="orange",breaks=50)

par(mfrow=c(1,2),pty="s")
plot(gnppc, lexp,col="darkgreen",pch=19,ylab="Life Expectancy",xlab="GNP per capita")
plot(log(gnppc), lexp,col="slateblue",pch=17,ylab="Life Expectancy",xlab="log GNP per captia")

# Regression Analysis

x<-log(gnppc)
y<-lexp
fit <- lm(y ~ x)  
summary(fit) 

x_axis<-seq(5,11,0.001)
plot(x,y,col="darkblue",xlab="Log GNP per capita",ylab="Life Expectancy",main="Life expectancy and Wealth",pch=20)
lines(x_axis,predict(fit,data.frame(x=x_axis)),col="red")

# Advanced: Quadratic Linear Regression
x2<-x**2
fit2<-lm(y~x+x2)
summary(fit2)

fit22<-lm(y~poly(x,2,raw=TRUE))
fit2<-lm(y~poly(x,2,raw=TRUE))

plot(x,y,col="darkblue",xlab="Log GNP per capita",ylab="Life Expectancy",main="Life expectancy and Wealth",pch=20)
lines(x_axis,predict(fit,data.frame(x=x_axis)),col="red")
lines(x_axis,predict(fit2,data.frame(x=x_axis)),col="darkgreen")
legend(9,65,legend=c("Reg 1","Reg 2"),col=c("red","darkgreen"),lty=1:3)

