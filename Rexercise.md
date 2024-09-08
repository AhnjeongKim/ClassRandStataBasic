* title: "Introduction in R"
* author: "Ahnjeong Kim"
* date: 05-04-2023

# Motivation
> Professor X, from one of these departments, ask students to work in R for their final project.
For our final project, we will learn how to use R.

### Detailed Situation of  Student A, Alice 

*  Alice wants to use **GNP Data** from 86 countries.
*  Alice's research question is what factors affect **life expectancy** in different countries? 
*   Alice needs to use **R** for her research.

### Goal of this lecture

* Learn basic technical skills for R, including:
  - Create and use matrices in R.
  - Input and save data 
  - Obtain Statistics and Graphical analysis
  - Run a linear regression and interpret the result
* Learn how to use R in data-driven research

# Introduction in R
### What is R
  * R is one of the most commonly used programming languages for statistical computing and graphics.
  * A wide variety of statistical (linear and nonlinear modelling, classical statistical tests, time-series analysis, classification, clustering, etc) and graphical techniques are available.
  * User-created packages offer Highly extensible statistical techniques, graphical devices, import/export, reporting, and easy installation
  * Well-designed plots and graphics 
  * It is free Software!
      - (source: The R Foundation https://www.r-project.org/about.html)

### R Studio
  * R Studio integrates with R as an IDE(Integrated Development Environment) to provide further functionality. 
  * R Studio combines a source code editor, build automation tools and a debugger.
  * Install both R and RStudio on your personal computer.
 
### R Studio Cloud 
  * R Studio Cloud offers a cloud-based version of R Studio Desktop. 
  * R Studio Cloud allows you to use R studio without installing software; you only need a web browser.
  * R Studio Cloud also makes it easy to share projects with colleagues.
  * The working environment is fully reproducible every time the project is accessed. 

# Before Getting Started 
### Open R Studio 
 **Alice opens R Studio and finds four windows.**
  * R studio consists of four windows: Console window, Editor window, Project window (with Environment and History), and Files(Directory,package,help,and viewer) window.

### 1. Console Window
  * This is where R evaluates all the code you write. You can type R code directly into the Console at the command line prompt, `>`.    
  * For example, if you type `2 + 2` into the Console you should obtain the answer `4`.

**Exercise** Try following code on your console window.

```{r}
  print("Hello world!")
```  
  
### 2.Editor Window: Creating a New R Script File

 **Alice creates R script on the editor window.**

* Creating an R script is a better approach than typing R code directly into the Console. 
* Writing code on a script improves the reproducibility and replicability of your code and research project.  
    - **Reproducibility** refers to instances in which the original researcher's data and computer codes are used to regenerate the results.
    - **replicability** refers to instances in which a researcher collects new data to arrive at the same scientific findings as a previous study.
* An R script is just a plain text file with a * .R* file extension which contains lines of R code. 
* These lines of code are then sourced into the R Console line by line. 
* To create an R script, you can select *File > New File > R Script* from the menu.
* Alternatively, you can click on the "New File" icon in the menu bar.

 **Alice writes down code on R script and executes selected code.**

* To execute code on console window, you select targeted code and click **Run** icon or press **Control+Enter** key.
* The comment indicator of R is `#`. The comment is useful when you write memo with your code for later and share your project with others.  

### 3.File Window: Set working directory

 **Alice wants to set a working directory (a single folder) to manage her codes(script files), data, and results.**
  * Set the working directory and save the script file in the same directory.
  * The working directory is the default location where R will look for files you want to load and where it will put any files you save. 
  * You can check the file path of your working directory by looking at the bar at the top of the Console window or use `getwd()` function in the Console window. 

```{r}
  setwd(/your/directory)
  getwd()      
```

### 4. Install packages

 **Alice wants to create graph and use various data files, so they install two packages on their desktop.** 

* R packages are the collection of functions, data and help files which you can download and install in R. 
* Many R users have developed useful codes and shared them as installable packages. 
* These packages can be downloaded from a variety of sources but the most popular are CRAN, Bioconductor and GitHub. 
  * `foreign` provides functions that help you load data files from other programs such as SAS, Stata into R.
  * `ggplot2` is R's a widely used package for making beautiful graphics. ggplot2 lets you use the grammar of graphics to build layered, customization plots.
  
```{r,eval=FALSE}
  install.packages("foreign")
  install.packages("ggplot2")
```
  * [See more information about Packages](https://support.posit.co/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages)

* You can see the installed packages on Package window.


 **After installing the packages, Alice needs to load them in her script.** 

* Installing a package onto your computer doesn't immediately make it available to use in R.
* You need to load the package using the `library()` function, which also load any additional packages required and may print out additional package information. 
* Remember to load the packages you need in each R session.

```{r}
  library(foreign)
  library(ggplot2)
```

# Vectors and Matrix

 **Before loading data, Alice needs to learn how to manage various types of variables in a matrix, data frame, and vectors.** 

```{r}
  mat1<-c(1,2,3)
  mat1
  mat2<-c(4,5,6)
  mat2
```

* Using `cbind` and `rbind` functions, we can combine matrices by columns or rows, respectively. 
```{r}
  mat3<-cbind(mat1,mat2)
  mat3
  mat4<-rbind(mat1,mat2)
  mat4
```
  * `dim` function shows the dimension of the matrix.
```{r,results='hold'}
  dim(mat3)
  dim(mat4)
```
  * We can name the rows and columns of the matrix using `dimnames` argument.
```{r}
  rnames<-c("Row1","Row2")
  cnames<-c("Col1","Col2","Col3")
  mat.name<-matrix(mat4,nrow=2,byrow=TRUE,dimnames=list(rnames,cnames))
  mat.name
```
**Exercise** Change the name of rows of `mat.name` matrix to 'R1' and 'R2'.

### Matrix Calculation
* Product two matrices.
```{r}
  mat.result1=mat1 %*% mat2
  mat.result1
```

* Change the value of matrix component
```{r}
  mat.name[2,2]<-10
  mat.name
```

* Transpose matrix using `t()` function
```{r,results='hide'}
  t(mat.name)
```
```{r}
  mat.name2<-cbind(t(mat.name),mat1)
  mat.name2
```

* See the diagonal elements of matrix using `diag` function
```{r}
  diag(mat.name2)
```

# Other Basic Sintax 
* Create a sequence matrix using `seq` and `rep`
```{r}
  v1<-seq(1,200,by=2)
  v1
  v2<-rep(1,100)
  v2
```
```{r}
  repeat1 <- rep(c(1,2,3), times = 3)
  repeat1
  repeat2 <- rep(c(1,2,3), times = c(5,2,1))
  repeat2
```

* `length` function shows the length of a matrix.
* `range` function shows the range of numbers in a matrix.
* `sum` function calculates the sum of numbers in a matrix.

```{r}
  length(repeat2)
  sum(repeat2)
  range(repeat2)
```

### Vector of Strings and Logics
* Matrix can consist of text or logic as well as numbers.
```{r}
  fruits <- c("banana", "apple", "orange")
  log_values <- c(TRUE, FALSE, TRUE, FALSE)
```
* `sort` function sort a vector into ascending or descending order.
```{r, results='hide'}
  sort(fruits)
  fruits
```

# Data Input

 **Alice loaded data to R from file named "lifeexp_sample" in csv format.** 
* Use the `read.csv` function to load data in CSV format.
```{r}
  data <- read.csv("lifeexp_sample.csv")
  head(data)
```
* The `head` function returns the first or last parts of a vector, matrix, table, data frame or function.
* A CSV (comma-separated values) format is a text file that has a specific format which allows data to be saved in a table structured format.

**Exercise** How can you load data in Excel format in R? 

* The loaded data will be displayed in the environmental window and the editor window.

### Data frames
* Data Frames are data displayed in a format as a table.
* Data Frames can have different types of data inside them. 
* Each column should have the same type of data.
```{r}
  class(data) #check the type of `data`
```
```{r}
  class(data$region)
  class(data$popgrowth)
```

# Statistics

 **Data frames consists of a plenty of number and characters. Alice wants to understand the structure of data and obtain summary statistics.** 

* Use brackets `[]` or `$` to access columns and rows from a data frame.
```{r}
  data[1:2,]
  data[1:2,2]
  data[["gnppc"]]
  data$gnppc
```
* Access only certain columns from a data frame.
```{r}
  data[1:2, c("region","country")]
  data[c(1,2), c(2,3)]
```
* See the list of countries where the life expectancy is greater than 75.
```{r}
  data[data$lexp > 75,c("country") ]
```

**Exercise** What is the value of data from column "lexp" and row 51?
**Exercise** What are countries that gnppc is lower than 10000?

```{r}
  dim(data)
  ncol(data)
  nrow(data)
```
* `ncol` returns the number of columns, and `nrow` returns the number of rows. 

### See basic statistics 
```{r}
  summary(data)
  mean(data$lexp)
  median(data$lexp)
  var(data$lexp)
  sd(data$lexp)
```

* The `summary` function returns overall summary statistics.
* The `mean` function returns the arithmetic mean of rows or columns.
* The `median` function returns the value of given vectors.
* The `var` function returns the variances of given vectors.
* The `sd` function returns the standard deviation of given vectors. 

### How to reduce command of data frame?

 **Alice does not want to write data path repeatedly in her code. Alice finds a way to reduce this.** 

* `attach` function makes it available to refer to the variables by their names alone.
```{r, message = FALSE}
  summary(data$gnppc)
```
```{r, message = FALSE}
  attach(data)
  summary(gnppc)
```

# Missing Values

 **Alice finds "NA" in the vector of 'gnppc'. NA means a missing value in the data.** 

### How to manage missing values?

* Missing values are common in real-world data and can have a significant impact on statistical analysis if not properly handled.

```{r}
  list(gnppc)
```
* NA(Not Available) is a logical constant of length 1 which contains a missing value indicator.
```{r}
is.na(gnppc)
```
* is.na function returns a logical vector of the same length as the input vector, with TRUE for any missing values.
* na.omit function removes rows with missing values.

```{r,message = FALSE}
  x<-na.omit(gnppc)
  list(x)
```

* `mean` function can be used to replace missing values with the mean value of non-missing values in the same column.
```{r}
  mean_gnppc <- mean(gnppc, na.rm = TRUE)
  gnppc[is.na(gnppc)] <- mean_gnppc
```

### Other types of missing values
* `NULL` represents that the value simply doesn't exist, rather than being existent but unknown.
* `inf` represents infinite numbers. 
* `NaN`: not a number

Example 1
```{r,results='hold'}
  mat.num<-c(1,NaN,NA,NULL,Inf,0/0)
  is.nan(mat.num)
  is.na(mat.num)
  is.null(mat.num)
  is.infinite(mat.num)
  is.numeric(mat.num)
```

Example 2
```{r,results='hold'}
  mat.null<-c()
  is.nan(mat.null)
  is.na(mat.null)
  is.null(mat.null)
  is.infinite(mat.null)
  is.numeric(mat.null)
```

# Data Analysis
 **Alice had decided to analyze 'life expectancy' and 'GNP per capita' variables for each country.** 
* **Life Expectancy** reflects the overall mortality level of a population. It summarizes the mortality pattern that prevails across all age groups.(Source: WHO)
* **GNP per capita** is Gross National Product Per Capita, which is used for the indicator of economic growth or wealth of the country. 
 **Alice wants to explore the distribution of the life expectancy and GNP per captia using histogram and a plot.** 

### Histogram
```{r, echo = FALSE,out.width="60%"}
  hist(gnppc)
```

 **Alice wants to customize the colors and title of her graph.** 

```{r,out.width="80%",fig.align="center"}
  par(mfrow=c(1,2),pty="s")
  hist(gnppc,main="Distribution of GNP per captia",xlab="GNP per capita",col="darkgreen",breaks=50)
  hist(lexp,main="Distribution of Life Expectancy",xlab="Life Expectancy",col="orange",breaks=50)
```

* To see more options in the 'help' document, type `?hist` or `help(hist)` on console window to obtain more information.
* See more options for color names  [link](https://r-graph-gallery.com/42-colors-names.html)

 **Alice sees that the distribution of GNP per capita is skewed.(far from symmetric). It would be better to take logarithms on GNP per capita would be better.** 

```{r,out.width="80%",fig.align="center"}
  par(mfrow=c(1,2),pty="s")
  hist(log(gnppc),main="Distribution of log GNP per captia",xlab="log GNP per capita",col="darkgreen",breaks=50)
  hist(lexp,main="Distribution of Life Expectancy",xlab="Life Expectancy",col="orange",breaks=50)
```

### Draw plot graph
```{r,out.width="80%",fig.align='center'}
  par(mfrow=c(1,2),pty="s")
  plot(gnppc, lexp,col="darkgreen",pch=19,ylab="Life Expectancy",xlab="GNP per capita")
  plot(log(gnppc), lexp,col="slateblue",pch=17,ylab="Life Expectancy",xlab="log GNP per captia")
```

* What relationship can you find between life expectancy and GNP per capita? Are they positively or negatively correlated? Is the correlation strong or weak?
* How does taking the logarithm of GNP per capita affect the relationship between life expectancy and GNP per capita?

### Taking logarithms

Taking logarithms of economic variables is a common practice in economics for several reasons:

1. Linearity: Logarithms can help transform a variable with a multiplicative relationship into an additive one. This transformation can make the relationship between variables more linear, which simplifies analysis and facilitates the interpretation of coefficients in econometric models. 
2. Relative changes: Logarithms capture relative changes in variables rather than absolute changes.
3. Interpretation and comparability: Taking logarithms can make variables more easily interpretable and comparable across different scales. 
4. Symmetry and variance stabilization: Logarithms can help achieve symmetry and stabilize the variance of variables that exhibit heteroscedasticity (varying levels of dispersion) in their raw form.

# Regression Analysis

 Alice hypothesizes that life expectancy is higher as GNP per capita is higher. It seems that the log of GNP per capita and life expectancy of the country has a positive linear relationship. 

 Alice run a simple linear regression that equation is equation $y=\alpha+\beta log(x)+\varepsilon$ where $y$ is life expectancy and $x$ is GNP per capita. Alice expects that the coefficient of $\beta$ would be positive. 

 Now, Alice wants to test her hypothesis by running regression in R.
  
```{r}
  x<-log(gnppc)
  y<-lexp
  fit <- lm(y ~ x)  
  summary(fit) 
```
  * The `lm` function runs linear regression models. 
  * `fit<-lm' means save the regression result in the `fit` variable.
  * `summary(fit)` shows the result of regression on the console window.

### The regression results in a graph

```{r,fig.align='center'}
  x_axis<-seq(5,11,0.001)
  plot(x,y,col="darkblue",xlab="Log GNP per capita",ylab="Life Expectancy",main="Life expectancy and Wealth",pch=20)
  lines(x_axis,predict(fit,data.frame(x=x_axis)),col="red")
```

 Alice interprets this results to mean that the coefficient of $\beta$ is 2.768 with a significant level of 0.001, indicating a positive relationship between life expectancy and the log of GNP per capita. 

**Exercise** Can we say this result is statistically significant? What about the coefficient, $R^2$, and p-value?  If yes, can you explain the reason?
**Exercise** Can we say the log of GNP per capita has a  **positive impact** on life expectancy of the country? If yes, can you explain the reason?

# Advanced: Quadratic Linear Regression

 **Alice decides to test the quadratic model with squared $x$ as $y=\alpha+\beta_1 x+\beta_2 x^2 + \varepsilon$ because she is worried that the true relationship between life expectancy and the log of GNP may not linear.** 

```{r}
x2<-x**2
fit2<-lm(y~x+x2)
summary(fit2)
```

* Alternatively, you can use `poly` function.
```{r,eval=FALSE} 
fit22<-lm(y~poly(x,2,raw=TRUE))
```

### Compare two models
```{r,out.width="80%",fig.align='center'}
plot(x,y,col="darkblue",xlab="Log GNP per capita",ylab="Life Expectancy",main="Life expectancy and Wealth",pch=20)
lines(x_axis,predict(fit,data.frame(x=x_axis)),col="red")
lines(x_axis,predict(fit2,data.frame(x=x_axis)),col="darkgreen")
legend(9,65,legend=c("Reg 1","Reg 2"),col=c("red","darkgreen"),lty=1:3)
```
