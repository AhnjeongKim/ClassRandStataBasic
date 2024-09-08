* title: "Introduction in Stata"
* author: "Ahnjeong Kim"
* date: "05-04-2023"

# Motivation
> Professor Z, from one of these departments, asked students to work in STATA for their final project.

For final project, we will learn how to use Stata.

### Detailed situation of Student B, Bob
* Bob also wants to use **GNP Data** of 86 countries.
* Bob’s research question is what factors affect **the population growth** of countries.
* Bob needs to use **Stata** for his research.

### Goal of this lecture

* Learn basic skills for Stata,including:
  - Load and save dataset
  - Generate and manage variables
  - Obtain Statistics and conduct graphical analysis
  - Run a linear regression and interpret the results.
*Learn how to use Stata in data-driven research

# Introduction in Stata

### What is Stata

* Stata is a general-purpose integrated statistical software package developed by StataCorp for data management, visualization, statistics, analysis, and automated reporting. 
* It is used in many fields, including biomedicine, economics, epidemiology, political science, and sociology.
* The dataset can be viewed or edited in spreadsheet format. 
* It has both a command line and graphical user interface making the use of the software more intuitive. 
* Basically, Stata is a software that allows you to store and manage data (large and small data sets), undertake statistical analysis on your data, and create some really nice graphs.
* You need to buy the licence of Stata every year at student price and most of colleges also provide Stata.

# Before Getting Started

### Open Stata

**Bob opens Stata and finds windows.** 

* Stata consists of several windows: the History window, Result Window, Command Window, and properties window.
 * *The History window* keeps a record of all commands Stata has run. This window helps you to review the commands you have done, you can simply click on one of the commands to re-run it in Stata.
 * *The Results window* shows you the results of your commands.
 * *The Command window* is where you enter your Stata commands.
 * *The Variables window* shows all the variables in your current dataset. It includes the variable's name and label.
 * *The Properties window* displays variables' and dataset's properties. It shows the variable's name, label, type and format etc. You can also change your variable's properties in this window. 
 
 <!-- https://www.techtips.surveydesign.com.au/post/change-your-stata-interface-for-both-windows-and-mac -->
 
### 1. Command Window

* You can type a command and press the Enter Key to see the results on the result window. For example:

```{stata}
  display "Hello World!"
```

### 2. Create do file

**Bob open the Do-file Editor and creates a new do-file.** 

* A do-file is a standard text file with a `*.do` file extension that is executed by Stata when you type `do filename`. 
* You can use any text editor or the built-in Do-file Editor to create do-files.

**Bob writes down code on the do-file and executes selected code.** 

* To excecute code, type your command on the `do-file-editor` and press the **Execute(do)** icon or **Control+D**. Results are shown on the result window.
* The `/* */`, `//`, and `///` comment indicators can be used in do-files only. Comments do not work in the Command window.

For example:
```{stata}
// does not run on the Command window
/*  are shown on the Result window*/
```

* A log is a file containing what you type and Stata’s output. A log allows you to make a full record of your Stata session. To create a log, type the following code: 

```{stata}
log using "logfile",replace
  set more off
  cd "/your/directory"	
log close
```

### 3. Set working directory

**Bob wants to set working directory (single folder) to manage his codes(do files),data, and results.** 

To set the working directory, type the following code:
```{stata, collectcode=TRUE}
  set more off
  cd "D:/hamilton/presentation"	//set working directory
  pwd
```

* The `cd` command changes a working directory.
* The `clear` command removes the dataset in memory.
* The `pwd` shows the current working directory.
* The `set more off` command tells Stata not to pause or display a "–more–" message when your log file is displayed.

### 4. Install packages
* The most of the commands in Stata work without requiring the installation of additional packages.
* Once a package is installed, you can use its commands without having to load them each time you start Stata. 
* For example, the `estout` package contains useful commands to create formatted regression tables and transform them to Excel or LaTeX format.
  
```{stata}
 ssc install estout
```


# Data Management

**Bob loads the dataset 'lifeexp_sample.csv' in Stata.** 

### Load dataset

* Stata works based on the dataset. You can load the dataset in Stata using two methods:

1. Using command line and command `import`:
```{stata, echo=TRUE, collectcode=TRUE}
  import delimited "lifeexp_sample.csv",clear
```
* If your memory still has previous work or dataset, you need to add ,clear.


2. Using the menu 
* Click on *file > import > Text data(delimited, .csv)* and set the options.

**Exercise** Open an Excel file in Stata.

* If your data is already Stata format(`*.dta`), you can use the `use` command on the command window:

```{stata}
  use "lifeexp_sample.dta",clear
```

### Save data

* To save the changes you have made to the data, you can use the command or the menu.

1. Using command:
```{stata, echo=TRUE, collectcode=TRUE}
  save "lifeexp_sample.dta",replace	
```

2. Using the menu:
* Select *file>save*

# Statistics

**Bob is using this dataset for the first time, so he needs to understand the structure of the dataset.** 

### Data-Editor

**Bob opens Data-Editor to view the dataset.** 

* The Data-Editor window displays the overall dataset and properties of the variables.
* 
### Summary statistics

```{stata}
  describe
  summarize
```

* `describe` command produces a summary of the dataset.
* `summarize` or `su` command provides summary statistics of all variables. 

* **Question** Why do *region* and *country* variables have no information in the result of `summarize`?
  * `summarize` command shows the result of numeric variables only. 
  * *region* and *country* are string variable.
* In Stata, numberic variables are stored as *int*, *long*, *float*, or *double*,depending on the range of numbers. 

* You can see the detail of certain variables. 

```{stata}
  su gnppc lexp,detail
```

* Use the menu to obtain the same result.
  * Click on *Statistics> summary,tables,and tests>Summary and descriptive statistics > Summary statistics* in the Menu. Then, select the variables.

* However, using a **command** is highly recommended for further analysis.

### Tabulate

* `tabulate` or `tab` command provides a one-way table of frequencies, which is useful when analyzing a factor or string variable. 

For example, running "tabulate region" in the command window will provide the following table:
```{stata}
  tabulate region
```

### Table

* `table` command creates a table of frequencies, summaries, and command results.

```{stata}
  encode region,generate(rcode)
  table rcode,stat(mean lexp) stat(sd lexp) stat(total lexp) stat(min lexp) stat(max lexp)
  drop rcode
```
* `region` variable is a categorical variable that has three categories: Europe & C. Asia, North America, and South America. 

# Variables

### Categorical variable

* **A categorical variable** identifies the group to which a thing belongs. For example, you could categorize people according to their race or ethnicity, cities according to their geographic location, or companies according to their industry.
* Sometimes, categorical variables are stored as strings.
* Stata can convert these categorical string variables to numerical variables with labels, which are much easier to analyze the dataset.
* `encode` command can be used to convert **categorical string variables** to labeled **numeric variables**.

```{stata}
  encode region,generate(code_region)
  tab code_region
  su code_region
```
* *code_region* variable is a labeled numeric variable. Its label is shown in blue color, but its true value consists of numbers: 1,2, and 3. 

* `decode` command converts labeled numeric variables to string variables. 

```{stata, echo=TRUE,collectcode=TRUE}
decode code_region,generate(region2)
```

### Converting between String and Numeric Variables

* Sometimes numeric variables are stored as string variables or vice versa.
* `tostring` converts a numeric variable to a string variable.
* `destring` converts a string variable with non-numeric characters to a numeric variable. 

```{stata}
  tostring(safewater),replace
  destring(safewater),replace
```

### Creating a new variable

* In Stata, you can create a new variable using existing variables.
* `generate` or `gen` command allows you to create a new variable or modify the contents of existing variable.

```{stata, echo=TRUE, collectcode=TRUE}
  gen ones=1
  su ones
```

```{stata, collectcode=TRUE}
  su ones
```

* The variable *ones* has a value of 1. The length of the new variable depends on the number of observation in the dataset.
* `generate` command can also create string variables.

```{stata}
  gen string="Hi"
  list string in 1/10
```

* You can copy existing variables using `=` sign.

```{stata}
  gen y=popgrowth
  gen x=gnppc
```

* The variable *y* has the same value as the variable *popgrowth*.

**Exercise** Create a new variable named *x* with a value equivalent to *gnppc*.
* New variables can be viewed in **the Variable window.**
* Open a data editor and compare the values of **x** and **gnppc**.

* You can add additional labels with more detailed explanations about variables using `label variable` command. 

```{stata, echo=TRUE, collectcode=TRUE}
  label variable x "GNP"
  label variable y "Population Growth"
```

### Replace and Rename

* You can change existing variables using `replace` command.

```{stata}
  replace x=log(gnppc)
  list gnppc x in 1/10
```

* `rename` is used to change the variable name. 

```{stata}
  rename lexp life_expectancy
```

### Drop and Keep 
* you can remove unnecessary variables using `drop` command.

```{stata, echo=TRUE}
  drop safewater life_expectancy
```

* You can also remove certain observations.

```{stata, echo=TRUE}
  drop if x==.
```

```{stata, echo=TRUE}
  drop if x>10
```

* `keep` command is used to select only the required variables. 
```{stata, echo=TRUE}
  keep x y
```

```{stata, echo=TRUE}
  keep if x!=.
```

### Missing Value

* Stata represents a missing value as a very large number and displays it as a dot ("."). 

```{stata}
  count if gnppc==.
  count if safewater==.
```
 
# Graphics

 **Bob decides to use the variable ‘popgrowth’ to represent the population growth of each country and ‘gnppc’ to represent the GNP per capita of each country.**

* **Population Growth** is the annual average rate of change of population size for a given country during a specified period.(accoring to WHO)

* **GNP per capita** is the Gross National Product Per capita, which is used as an indicator of economic growth or wealth of a country.

**Bob wants to know how population growth and GNP per captia are distributed. He uses a histogram and a plot graph.**

### Histogram

```{stata, echo=TRUE, eval=FALSE}
  histogram(gnppc)
```

**Bob wants to change the design of the histogram graph.**

* You can change the options of the graph using a command.

```{stata}
  histogram(gnppc),graphregion(color(white)) fcolor(ebblue) lstyle(none) fraction	xtitle("GNP per capita") title("Distribution of GNP per Capita")  
  graph save hist1.gph,replace
  histogram(popgrowth),graphregion(color(white)) fcolor(maroon) lstyle(none) fraction	xtitle("Population Growth") title("Distribution ofPopulation Growth")
  graph save hist2.gph, replace
  graph combine  hist1.gph hist2.gph,graphregion(color(white)) 
  graph export hist_combine.png,replace
```

* `maroon` and `ebblue` are color names used in Stata. [See more color options](https://www.stata.com/manuals13/g-4colorstyle.pdf)
* `lstyle` sets the style of line of the bar, `fcolor` defines the color of the histogram bar.
* `graphregion(color(white))` sets the background color.
* `xtitle` writes the title of x-axis, and `title` writes the title of entire graph.
* `graph save` saves the graph as `*.gph` format (Stata graph format) only.
* `graph combine` combines several saved stata format graphs.
* `graph export` saves the graph as other graphic formats such as `*.png`,`*.pdf` or `*.eps`.

**Exercise** Change to the title of y-axis to "Frac." and create a new combined graph.

* You can also use **Graph-Editor** instead of using commands.
* You can use `scheme` command to apply pre-determined designs in Stata, such as `s2color`, `s1mono`,`economist`,`sj`, and more.

```{stata}
  set scheme s1mono
  histogram(gnppc)
```

* To customize the graph, You can use the menu.
* Click on *Graphics>Histogram* in the Menu and select variables and options.

### Draw plot graph

* Draw the twoway scatter plot to see the relationship between two variables.

```{stata}
  scatter popgrowth gnppc,graphregion(color(white)) 
  graph save plot1.gph,replace

  scatter popgrowth log_gnppc,graphregion(color(white)) mcolor(dkorange) msymbol(D)
  graph save plot2.gph, replace

  graph combine plot1.gph plot2.gph,graphregion(color(white)) 
```
**Question** What relationship can you see the variables between population growth and GNP per capita in the two plots?

# Regression Analysis
 Bob hypothesizes that the population growth is higher when GNP per capita is lower. It appears that the logarithm of GNP per capita and population growth of a country has a negative linear relationship.

 Bob sets a linear regression equation as  $y=\alpha+\beta log(x)+\varepsilon$ where $y$ is the population growth and $x$ is GNP per capita. Bob expects the coefficient $\beta$ to be negative.

 Now, Bob wants to test his hypothesis by running a regression in Stata.

* Run a simple linear regression using $y=\alpha+\beta x+\varepsilon$.

```{stata}
  regress y x 

  qui: regress y x
  eststo
  esttab
```
* `quitely` or `qui` command makes Stata perform command but suppresses terminal output. On the other hand, `noisely` makes Stata perform a command and ensures terminal output.
* `eststo` command stores the formatted regression result. 
* `esttab` command displays formatted regression table.
* Both `eststo` and `esttab` are part of the `estout` package.

```{stata}
  twoway (scatter y x,graphregion(color(white)) mcolor(dkorange) msymbol(D))(lfit y x,lcolor(dkgreen)),legend(off) ytitle("Population Growth")
```
* `twoway` command provides the overlay of two graphs. 
* `msymbol` command indicates the shape of symbol in scatter plot.
* `lfit` command provides the linear relationship on the scatter plot.


* How to interpret this result?
  * The p-value of 0.001 suggests that the coefficient of -0.2764704 is statistically significant at the 5% level. 
  * A one percent increase in the logarithm of x is associated with a decrease of 0.276 in y. 
  * The intercept (3.258665) represents the average value of $y$ when all other variables are equal to zero.
  * The R-squared value of 0.1666 indicates that the model explains 16.60% of the variance in $y$.
  * The coefficients are statistically significant at the 0.01 level, so  we can reject the null hypothesis that their true values are zero.

**Bob concludes that there is an evidence that there is a negative relationship between population growth and log GNP per capita.**

* Note that it is important to note that statistical significance does not necessarily imply practical significance or causality. 

# Advanced: Create Dummy Variables

**For further research, Bob wants to see the regional difference of the relationship between the population growth and GNP per capita.**

### Create dummy variable

* Convert categorical variable to a dummy variables using `xi command.`

```{stata}
  xi i.code_region
  su _Icode_*
```

* `xi` converts categorical variables into indicator (also called dummy) variable sets by creating new variables.  
* Indicator variable (dummy variable) is a binary variable that takes a value of 0 or 1. 
* Dummies variable is used to indicate which one of a set of categorical values a data point belongs to.

* For example, categorical variable **code_region** consists of 1,2 and 3. 


| region      | Code_region |
| ----------- | ----------- |
| Europe & C. Asia      | 1       |
| North America   | 2        |
| North America   | 3        |


If the region of country is in Europe & C. Asia, the value of code_region is 1. If the region of country is in North America, the value of code_region is 2. If the region of country is in South America, the value of code_region is 3. Based on this category, Stata `xi` command creates dummy variables. 

* **_Icode_region2** is 1 if the region of country is North Americal and 0 otherwise. **_Icode_region3** is 1 if the region of country is South America and 0 otherwise. The variable **_Icode_region1** does not exist because it is implied when both **_Icode_region2** and **_Icode_region3** are 0. 

* In general, the number of dummy variables is $n-1$ when the number of catogory is $n$.

* Dummy variable is useful in empirical research when researcher need to identify Yes/no property, Categorical value, Seasonal period, Fixed effects, or Treatment effect.

```{stata}
  regress y x i.code_region
```

* The coefficient for $x$ is -0.2036198, indicating that a one percent increase in the logarithm of $x$ is associated with a decrease in $y$ by 0.2036198, holding other variables constant.

* The coefficient for code_region North America is 1.235598, indicating that, holding other variables constant, the average value of $y$ is 1.235598 higher for countries in North America compared to countries in other regions.

# Additional Tips

* `help(command)` provides more information about commands.
* To install a new package, type `ssc install package`  on the command line.
* Practice using do file and command instead of menus for further coding and research. Once you get used to typing in command, it makes you more convenient and faster. 

### Statacons

* Statacons is a set of tools for the SCons build-system to allow running Stata projects. It does not require changes to existing code, is correct (no unnecessary rebuilds), extensible via Python, and git-friendly.

[Install and Instruction](https://github.com/bquistorff/statacons)

[Web tutorial](https://bquistorff.github.io/statacons/swc.html)
