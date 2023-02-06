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

## Data Descriptor
- Model_Data.csv
	- **P_ID**: Participant's ID
	- **Day_Num**: Observation day of the study Day1 = Monday, Day7 = Sunday
	- **Trips**: Trip number of a particular day
	- **Trip_Time**: Time of the trip [Morning, Afternoon]
	- **Weather_Info**: Weather information while driving [clear, clouds, Rain, OT(Other)]
	- **Mean_Raw_HR**: Mean heart-rate of participants while driving
	- **Mean_Speed**: Mean speed of the car
	- **Mean_ATP**: Mean throttle of the car
	- **Mean_JF**: Mean jam factor of the road while driving
	- **mean_acc_energy**: Mean hand acceleration
	- **mean_rot_energy**: Mean hand rotaion
	- **Gender**: [Male/Female]
	- **TA**: Trait Anxiety	of the participants
	- **Ext**: Extraversion	
	- **Agr**: Agreeableness	
	- **Cons**: Conscientiousness	
	- **Neuro**: Neuroticism	
	- **Open**: Openness
	- **State_Anxiety**: 
	- **MD** : NASA mental demand
	- **PD** : NASA physical demand
	- **TD** : NASA temporal demand
	- **P** : NASA performance
	- **E** : NASA effort
	- **F** : NASA frustration
	
- Non_Driving_Data.csv
	- **P_ID**: Participant's ID
	- **Days**: Observation day of the study Day1 = Monday, Day7 = Sunday
	- **Day_Indicator**: Indication of weekdays or weekend [weekdays, weekend]
	- **TIME_Of_Day**: Time of the trip [Morning, Afternoon]
	- **HR_Drive**: Mean heart rate of driving
	- **HR_NON_DRIVE**: Mean heart rate of non-driving
	- **Gender**: [Male/Female]
	- **TA**: Trait Anxiety	of the participants
	- **Ext**: Extraversion	
	- **Agr**: Agreeableness	
	- **Cons**: Conscientiousness	
	- **Neuro**: Neuroticism	
	- **Open**: Openness
	- **State_Anxiety**: 
	
- Trait_Data.csv
	- **P_ID**: Participant's ID
	- **TA**: Trait_Anxiety	
	- **Ext**: Extraversion	
	- **Agr**: Agreeableness	
	- **Cons**: Conscientiousness	
	- **Neuro**: Neuroticism	
	- **Open**: Openness
