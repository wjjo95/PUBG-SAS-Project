# PUBG-SAS-Project
SAS Project - PUBG

**/* Introduction */ **

PlayerUnknown’s Battlegrounds (PUBG) from KRAFTON Inc. is a popular online multiplayer game released in 2016 that can be played on select consoles and PC. Players populate one of four maps and must fight to be the last one standing using a multitude of weapons and equipment. Players can choose solo, duo, and team modes as well as first or third person.  
Game statistics available to players include damage dealt, the number of boosts used, weapons acquired, and distance by swimming, riding in vehicles, and walking, among others. The analysis conducted examines non-combat, individual-based game statistics which are given for each player in solo matches in an effort to predict and maximize the number of kills a player will achieve in any given match. 
A player’s ability to destroy opponents is not only an indicator of game expertise but can enable new and seasoned players alike to get the most from each match.  Further, through improving a player’s skills while competing against other talented players, matches retain player interests while prolonging game enjoyment.  


**/* Data Description */**

The match type of “solo-fpp” was chosen for the analysis. To prepare the data to reflect this, all variables that related solely to group matches or overall ranking were removed from the data set. Group and rank predictors removed included assists, revives, teamKills, DBNOs, groupId, numGroups, rankPoints, killPlace, winPoints, maxPlace, matchTypes. A filter was also applied to include only matches of type “solo-fpp”, removing group matches, duo matches, and solo matches played in third person perspective. Once other match types were removed, the categorical matchType variable was eliminated from the dataset. Additionally, the predictor variable ‘kills’ was transformed to ‘log_kills’ so the data better matches the assumptions of the model applied.  
**Original Data:** https://www.kaggle.com/c/pubg-finish-placement-prediction/data

**/* Why Multiple Regression? */**

A multiple linear regression model was the most appropriate in this scenario. This is primarily because both the input variables and the response variable were continuous. In addition, there were no categorical variables to consider in the model. 


**/* Assumptions of the Multiple Regression Model */**
 
**Before creating our multiple regression model, we tested the following assumptions in order to make sure that such a model can be used.**    
(1) Observations are Independent: Each of the matches are played by a different person, which can be verified using the ID. Given this type of collection method, we can be confident that the observations are independent.

(2) Error terms (residuals) are normally distributed, as it can be seen from the below illustrations.  
On the q-q plot, plot the error terms (residual values) are almost spot on the line which tells us that the error terms are normally distributed. We can derive the same insight from the graph on the right. The error terms are almost exactly in line with a normal distribution plot. 
 
(3) From the below illustration, we can clearly see that the error terms (residuals) have a mean of zero. There are an equal number of points, with similar magnitude above and below the 0 line. This implies that the residual values cancel each other out.   
 
(4) The above residual plot also shows there is the same variance at each predicted value. The error terms are randomly scattered throughout and no clearly visible pattern can be found. Hence, we can be confident that the constant variance assumption is also satisfied.    
 
 
**/* Findings */ **

Our correlation analysis for the data set revealed that all the 14 predictor variables chosen had a p-value that was statistically significant at a 5% significance level, with 5 out of the 14 having strong linear relationships to the number of kills a player had. Among these the predictor variable that had the highest Pearson Correlation Coefficient was damageDealt with a coefficient of 0.88863 and the lowest Pearson Correlation Coefficient was weaponsAcquired with a coefficient of 0.38036. What this correlation told us was that on average players with the highest number of kills usually had very good strike effectiveness against their opponents and that strikes and weapons that lead to high damageDealt scores should be prioritized above other game strategies. We however did not consider this in our regression models as we sought to find novel non-combat related predictor variables to give players a unique advantage. 
For the model itself, a stepwise variable selection method was used to determine the best multiple regression model for predicting number of kills. This produced a 10-variable model with an F-value of 13106.3 and an R-squared and adjusted R-squared of 0.5488 and 0.5487 respectively.  The 10-variable multiple regression model obtained proved to be the best model irrespective of the information criteria used (AIC, AICC and SBC) to compare the models. Generally, after the 4-varible multiple regression model the information criteria scores leveled out and the changes in criteria score were minimal. Based on the information criteria scores and the standardized coefficient progression chart a 4-variable multiple regression model could have been a viable option to predict number of kills. However, the objective of our model was to maximize kills and so the effects of the other predictor variables were considered our model. 
 
**/* Limitations */**

The main limitations to our model were data related. There were lots of zero-values for variables in the data set and as result a lot of the data was skewed. This could’ve been as a result of players not lasting long in the matches or having different strategies that meant that they didn’t engage with certain actions related to our variables, for example it is very likely that a novice player had no kills at all or did not last long enough to have a sizeable swimDistance or walkDistance score. In order to deal with this, we found the natural log of the number of kills instead and predicted for that.  
Secondly, predictor variables like damageDealt and killStreaks were not used in our multiple regression model as they didn’t provide any new insight to players, mainly because they had very high linear correlations to number of kills. An effective strike to an opponent or a weapon that yielded a very high damageDealt score would be as good as a kill recorded. This would’ve explained most of the variability in our response variable if added to the model, but it would not have provided a novel advantage to anyone who went by our model. As a result, our final model could do no better than explain 55% of the variability in logarithmic number of kills. This would go some way to explain why the increase in adjusted R-squared and information criteria values barely changed after the 4-variable regression model. 
 **
/* Conclusion */**

In this modeling regression analysis, we built our predictive model on the training data set and chose the best fit and generalizable model based on our validation data set. From this analysis, we can predict the log_kills with 10 predictor variables by using stepwise selection method. With the high adjusted R-squared, we have evidence to say this is the best model for predicting log_kills. However, there are limitations in this model, such as useless data, null values. To avoid too many 0 values, we take the natural log of number of kills.   


