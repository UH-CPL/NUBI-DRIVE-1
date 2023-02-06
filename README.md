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

**---------------------Version with Text-----------------------**

**Age**     Age     **Continous**

**Gen**     Gender **Binary** [Female, Male]

**DrExp**   Driving Experience [Years]      **Multinomial** 5 class ["1-2" + "3-4" + "5-9" = <10, "10-20" = <20, ">20" = >20 ] 

**Mil**     Driven Per Week [Miles] **Multinomial** 5 class ["10-20" + "20-30" = 10-30, "30-40" + "40-50" = 30-50, ">50" = >50 ]

**WoMo**	Work Mode   **Binary** ["No" = Office, "Yes" = Home]

**Comm**	Commute To Work     **Multinomial** 3 class ["No" = No, "Some days" = Some Days, "Yes" = Yes]

**CommD**   Commuting Distance [Miles]     **Multinomial** 5 class ["0" = 0, "1-5"+"5-10" = 1, "10-20" + "20-30" = 2, ">30" = 3]

**CommT**	Commuting Time [Minutes]    **Multinomial** 5 class ["0" = 0, "10-20" = 1, "20-30" + "30-40" = 2, "40-60" + ">60" = 3]

**RdTr**    Road Trip       **Binary** ["No" = No, "Yes" = Yes]

**DrLike**	Like Driving	**Binary** ["No" = No, "Yes" = Yes]

**DrMo**	Preferred Driving Mode	**Multinomial** 3 class ["Economy" = Economy, "Normal" = Normal, "Sport" = Sport]

**SAE5**	Will you drive when cars become capable of fully automated driving	**Multinomial** 3 class ["I will let the car always drive" = Car_Drives_Always, "I will drive sometimes" = Drives_Sometimes, "I will always drive" = Will_Drive_Always]

**DrNi**	Uncomfortable driving at night	**Binary** ["No" = No, "Yes" = Yes]

**DrTraf**	Uncomfortable driving in heavy traffic	**Binary** ["No" = No, "Yes" = Yes]

**Park**	Good at parking	**Binary** ["No" = No, "Yes" = Yes]

**Acc**	Relish acceleration	**Binary** ["No" = No, "Yes" = Yes]

**RolCoa**	Relish roller-coaster rides	**Binary** ["No" = No, "Yes" = Yes]

**EnFwy**	Uncomfortable entering freeway	**Binary** ["No" = No, "Yes" = Yes]

**PsgAcc**	Uncomfortable when you are a passenger and the driver 
accelerates	**Binary** ["No" = No, "Yes" = Yes]

**DrRain**	Uncomfortable driving in rainy weather	**Binary** ["No" = No, "Yes" = Yes]

**TiredDr**	Tired after driving	**Binary** ["No" = No, "Yes" = Yes]

**Flyer**	Air Travel	**Multinomial** 3 class ["I am a nervous flyer" = Nervous, "I am a normal flyer" = Normal, "I relish air travel" = Enthused]

**MusicDr**	Listen music while driving	**Binary** ["No" = No, "Yes" = Yes]

**TextDr**	Text while driving	**Multinomial** 4 class ["Never" = Never, "Only at stop lights" = Stop_lights, "Sometimes" = Yes, "Often" = Yes]

**TalkDr**	Talk over the phone while driving	**Multinomial** 3 class ["Never" = Never, "Sometimes and I hold it" = Hands, "Sometimes but hands-free" = Hands-free]

**CoffeeDr**	Drink coffee or another beverage while driving	**Multinomial** 3 class ["Never" = Never, "Sometimes" = Sometimes, "Often" = Often]

**AbsMinDr**	Absent-minded when you drive	**Multinomial** 3 class ["Never" = No, "Sometimes" = Yes, "Often" = Yes]

**UpsetDr**	Upset when you drive	**Multinomial** 3 class ["Never" = 1, "Sometimes" = Yes, "Often" = Yes]

**Tickets**	Traffic tickets during the last three years	**Multinomial** 4 class ["None" = None, "1" + "2-3" + ">3" = One_Or_More]

**Crash**	Crash as a driver	**Multinomial** 4 class ["None" = No_Crash, "1" = One, "2-3" + ">3" = More_Than_One]

**RdRg**	Encountered road rage	**Binary** ["No" = No, "Yes" = Yes]

**ReRdRg**	React to road rage	**Multinomial** 4 class ["I flee" = 1, "I call the police" = 2, "I counter attack" = 3, "Other (specify)" = 4)]

**TA**	Trait_Anxiety	**Continous**

**Ext**	Extraversion	**Continous**

**Agr**	Agreeableness	**Continous**

**Cons**	Conscientiousness	**Continous**

**Neuro**	Neuroticism	**Continous**

**Open**	Openness	**Continous**





**---------------------Version with Number-----------------------**

**Age**     Age **Continous**

**Gen**     Gender ["Female" = 1, "Male" = 2 ]

**DrExp**   Driving Experience [Years]      **Multinomial** 5 class ["1-2" + "3-4" + "5-9" = 1, "10-20" = 2, ">20" = 3 ] 

**Mil**     Driven Per Week [Miles]       **Multinomial** 5 class ["10-20" + "20-30" = 1, "30-40" + "40-50" = 2, ">50" = 3 ]

**WoMo**	Work Mode   **Binary** ["No" =1, "Yes" = 2]

**Comm**	Commute To Work     **Multinomial** 3 class ["No" = 1, "Some days" = 2, "Yes" = 3]

**CommD**   Commuting Distance [Miles]     **Multinomial** 5 class ["0" = 0, "1-5"+"5-10" = 1, "10-20" + "20-30" = 2, ">30" = 3]

**CommT**	Commuting Time [Minutes]    **Multinomial** 5 class ["0" = 0, "10-20" = 1, "20-30" + "30-40" = 2, "40-60" + ">60" = 3]

**RdTr**    Road Trip       **Binary** ["No" = 1, "Yes" = 2]

**DrLike**	Like Driving	**Binary** ["No" = 1, "Yes" = 2]

**DrMo**	Preferred Driving Mode	**Multinomial** 3 class ["Economy" = 1, "Normal" = 2, "Sport" = 3]

**SAE5**	Will you drive when cars become capable of fully automated driving	**Multinomial** 3 class ["I will let the car always drive" = 1, "I will drive sometimes" = 2, "I will always drive" = 3]

**DrNi**	Uncomfortable driving at night	**Binary** ["No" = 1, "Yes" = 2]

**DrTraf**	Uncomfortable driving in heavy traffic	**Binary** ["No" = 1, "Yes" = 2]

**Park**	Good at parking	**Binary** ["No" = 1, "Yes" = 2]

**Acc**	Relish acceleration	**Binary** ["No" = 1, "Yes" = 2]

**RolCoa**	Relish roller-coaster rides	**Binary** ["No" = 1, "Yes" = 2]

**EnFwy**	Uncomfortable entering freeway	**Binary** ["No" = 1, "Yes" = 2]

**PsgAcc**	Uncomfortable when you are a passenger and the driver 
accelerates	**Binary** ["No" = 1, "Yes" = 2]

**DrRain**	Uncomfortable driving in rainy weather	**Binary** ["No" = 1, "Yes" = 2]

**TiredDr**	Tired after driving	**Binary** ["No" = 1, "Yes" = 2]

**Air**	Air Travel	**Multinomial** 3 class ["I am a nervous flyer" = 1, "I am a normal flyer" = 2, "I relish air travel" = 3]

**MusicDr**	Listen music while driving	**Binary** ["No" = 1, "Yes" = 2]

**TextDr**	Text while driving	**Multinomial** 4 class ["Never" = 1, "Only at stop lights" = 2, "Sometimes" = 3, "Often" = 3]

**TalkDr**	Talk over the phone while driving	**Multinomial** 3 class ["Never" = 1, "Sometimes and I hold it" = 2, "Sometimes but hands-free" = 3]

**CoffeeDr**	Drink coffee or another beverage while driving	**Multinomial** 3 class ["Never" = 1, "Sometimes" = 2, "Often" = 3]

**AbsMinDr**	Absent-minded when you drive	**Multinomial** 3 class ["Never" = 1, "Sometimes" = 2, "Often" = 2]

**UpsetDr**	Upset when you drive	**Multinomial** 3 class ["Never" = 1, "Sometimes" = 2, "Often" = 2]

**Tickets**	Traffic tickets during the last three years	**Multinomial** 4 class ["None" = 1, "1" + "2-3" + ">3" = 2]

**Crash**	Crash as a driver	**Multinomial** 4 class ["None" = 1, "1" = 2, "2-3" + ">3" = 3]

**RdRg**	Encountered road rage	**Binary** ["No" = 1, "Yes" = 2]

**ReRdRg**	React to road rage	**Multinomial** 4 class ["I flee" = 1, "I call the police" = 2, "I counter attack" = 3, "Other (specify)" = 4)]

**TA**	Trait_Anxiety	**Continous**

**Ext**	Extraversion	**Continous**

**Agr**	Agreeableness	**Continous**

**Cons**	Conscientiousness	**Continous**

**Neuro**	Neuroticism	**Continous**

**Open**	Openness	**Continous**
