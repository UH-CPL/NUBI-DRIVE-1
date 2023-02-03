# **Investigating Cardiovascular Activation in Routine Driving**
This repository contains the R scripts to curate, validate, and generate the final model and visualization from the naturalistic driving study NUBI-Drive.

## Getting Started

#### Prerequisites
- R and RStudio
- Required packages

#### Installing R Packages
Packages are available on CRAN and can be installed using a simple call to `install.packages()`:

    install.packages('PackageName')
	
	
## Script Set
##### Please run the following scripts sequentially

**Validation Scripts (vs)**
 - vs-descriptive-plots.rmd
 	- Generates the descriptive statistics plot from the data
 - vs-correlation-matrix.rmd
 	- Produce the correlation matrix and checks the colenearity of the features
 - vs-driving-NASA-models.Rmd
  	- Creates the driving and the NASA models
  	- Visualizes the model figures
- vs-non-driving-model.rmd
    - Generates the non driveng model and the model figure

