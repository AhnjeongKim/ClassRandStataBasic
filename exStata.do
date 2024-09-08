*******************************************************************
**** Sample code for lecture: Introduction in Stata ***************
**** Author: Ahn Kim **********************************************
**** Date: 05-04-2023 *********************************************
*******************************************************************
**** Run this before you start ************************************
cls
clear
cd "C:"	//change the path  
*******************************************************************
// Before Getting Started

display "Hello World!"

log using "logfile",replace
  set more off
  cd "C:" //change the path	
log close

set more off
cd "C:"	//change the path
pwd

// ssc install estout 
//skip this line if estout is alraedy installed.

import delimited "lifeexp_sample.csv",clear
use "lifeexp_sample.dta",clear

save "lifeexp_sample.dta",replace	

// Statistics 

describe
summarize
su gnppc lexp,detail

tabulate region

encode region,generate(rcode)
table rcode,stat(mean lexp) stat(sd lexp) stat(total lexp) stat(min lexp) stat(max lexp)
drop rcode

// Variables

encode region,generate(code_region)
tab code_region
su code_region
decode code_region,generate(region2)

tostring(safewater),replace
destring(safewater),replace

gen ones=1
su ones
gen string="Hi"
list string in 1/10
gen y=popgrowth
gen x=gnppc
label variable x "GNP"
label variable y "Population Growth"
replace x=log(gnppc)
list gnppc x in 1/10
rename lexp life_expectancy

preserve
drop safewater life_expectancy
drop if x==.
drop if x>10
keep x y
keep if x!=.
restore 

count if gnppc==.
count if safewater==.
 
// Graphics

histogram(gnppc)
histogram(gnppc),graphregion(color(white)) fcolor(ebblue) lstyle(none) fraction	xtitle("GNP per capita") title("Distribution of GNP per Capita")
graph save hist1.gph,replace

histogram(popgrowth),graphregion(color(white)) fcolor(maroon) lstyle(none) fraction	xtitle("Population Growth") title("Distribution ofPopulation Growth")
graph save hist2.gph, replace

graph combine hist1.gph hist2.gph,graphregion(color(white)) 

graph export hist_combine.png,replace

set scheme s1mono
histogram(gnppc)

scatter popgrowth gnppc,graphregion(color(white)) 
graph save plot1.gph,replace

gen log_gnppc=log(gnppc)
scatter popgrowth log_gnppc,graphregion(color(white)) mcolor(dkorange) msymbol(D)
graph save plot2.gph, replace

graph combine plot1.gph plot2.gph,graphregion(color(white)) 

// Regression Analysis

regress y x
qui: regress y x
eststo
esttab

twoway (scatter y x,graphregion(color(white)) mcolor(dkorange) msymbol(D))(lfit y x,lcolor(dkgreen)),legend(off) ytitle("Population Growth")

xi i.code_region
su _Icode_*
regress y x i.code_region

graph close
clear
*******************************************************************
// Statacons

* Statacons is a set of tools for the SCons build-system to allow running Stata projects. It does not require changes to existing code, is correct (no unnecessary rebuilds), extensible via Python, and git-friendly.

//[Install and Instruction] (https://github.com/bquistorff/statacons)

//[Web tutorial] (https://bquistorff.github.io/statacons/swc.html)
