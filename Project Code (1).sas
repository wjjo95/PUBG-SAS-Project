/* Define library */;
%let project_path=/home/u58561298/MBAN5110Cap;
libname Capstone base "&project_path/Data";

/* importing the data */
PROC IMPORT datafile="/home/u58560613/MBAN5110_JustinC/MBAN5110/train_V2.csv"
	DBMS=CSV OUT = work.pubg_trainV2;
run;

/* DATA step modifications */
data work.pubgtrain;
	set work.pubg_trainV2;
	log_kills = LOG(kills+1);
	Drop assists revives teamKills DBNOs groupId numGroups rankPoints
		killPlace winPoints maxPlace matchType;
	where matchType="solo-fpp";
run;

title1 'Descriptive Statistics Using PROC UNIVARIATE for Kills';
proc univariate data=work.pubgtrain;
    var log_kills;
    histogram log_kills / normal(mu=est sigma=est) kernel;
    inset skewness kurtosis / position=ne;
    probplot log_kills / normal(mu=est sigma=est);
    inset skewness kurtosis;
run;



Proc
/* exploring correlation */
ods graphics / reset=all imagemap;
title1 'Correlation Analysis';

proc corr data=work.pubgtrain rank;
	var WinPlacePerc boosts heals vehicleDestroys  
		 longestKill walkDistance matchDuration rideDistance roadKills 
		swimDistance weaponsAcquired;
	with log_kills;
run;

/* automatic model selection using backwards stepwise selection (including kill-like predictors)*/
ODS graphics / imagemap=ON;
title1 'Backwards Selection';

proc reg data=work.pubgtrain plots(only)=(rsquare adjrsq cp);
	model log_kills = boosts damageDealt headshotKills heals killPoints 
		killStreaks longestKill matchDuration rideDistance roadKills swimDistance 
		vehicleDestroys walkDistance weaponsAcquired / selection=backward;
	run;
quit;

title1;

/* adjusted selection */
ODS graphics / imagemap=ON;
title1 'Backwards Selection';

proc reg data=work.pubgtrain plots(only)=(rsquare adjrsq cp);
	model log_kills = boosts heals longestKill matchDuration 
	rideDistance swimDistance vehicleDestroys walkDistance weaponsAcquired 
		/ selection=backward slstay=0.01;
	run;
quit;

title1;

/* model 1 - using multiple linear regression (backward stepwise model) */
ODS graphics off;

title1 'Multiple Linear Regression Model for Predicting kills';
proc reg data=work.pubgtrain plots(maxpoints=none);
model log_kills = boosts winPlacePerc heals matchDuration longestKill
		rideDistance swimDistance vehicleDestroys walkDistance weaponsAcquired;
run;
quit;