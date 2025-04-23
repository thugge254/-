/* Generated Code (IMPORT) */
/* Source File: energydata_complete.csv */
/* Source Path: /home/u58374793/SAS PROJECT */
/* Code generated on: 5/16/24, 7:22 AM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u58374793/SAS PROJECT/energydata_complete.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

/* Convert character variables to numeric type */
data WORK.IMPORT_NUMERIC;
	set WORK.IMPORT;
	    
	/* Convert the date string to SAS datetime and date values */
    datetime = input(date, anydtdtm19.);
    format datetime datetime20.;
    date_num = datepart(datetime); /* Extract the date part */
    days = DAY(date_num);

    /* Convert character variables to numeric */
    Appliances_num = input(Appliances, best12.);
    lights_num = input(lights, best12.);
    T1_num = input(T1, best12.);
    RH_1_num = input(RH_1, best12.);
    T2_num = input(T2, best12.);
    RH_2_num = input(RH_2, best12.);
    T3_num = input(T3, best12.);
    RH_3_num = input(RH_3, best12.);
    T4_num = input(T4, best12.);
    RH_4_num = input(RH_4, best12.);
    T5_num = input(T5, best12.);
    RH_5_num = input(RH_5, best12.);
    T6_num = input(T6, best12.);
    RH_6_num = input(RH_6, best12.);
    T7_num = input(T7, best12.);
    RH_7_num = input(RH_7, best12.);
    T8_num = input(T8, best12.);
    RH_8_num = input(RH_8, best12.);
    T9_num = input(T9, best12.);
    RH_9_num = input(RH_9, best12.);
    T_out_num = input(T_out, best12.);
    Press_mm_hg_num = input(Press_mm_hg, best12.);
    RH_out_num = input(RH_out, best12.);
    Windspeed_num = input(Windspeed, best12.);
    Visibility_num = input(Visibility, best12.);
    Tdewpoint_num = input(Tdewpoint, best12.);
    rv1_num = input(rv1, best12.);
    rv2_num = input(rv2, best12.);
   
    /* Extract the hour from the datetime */
    hour = hour(datetime);
    
    /* Create a numeric time segment variable */
    if hour < 6 then time_segment = 1; /* Night */
    else if hour < 12 then time_segment = 2; /* Morning */
    else if hour < 18 then time_segment = 3; /* Afternoon */
    else time_segment = 4; /* Evening */
    
    /* Apply appropriate formats */
    format datetime datetime20.;

    /* Create weekday and weekend variables */
    day_of_week = weekday(date_num); /* 1=Sunday, 2=Monday, ..., 7=Saturday */
    weekday = (day_of_week in (2, 3, 4, 5, 6)); /* 1=True if Monday-Friday, 0=False */
    weekend = (day_of_week in (1, 7)); /* 1=True if Sunday or Saturday, 0=False */
    day_of_month = day(date_num);
    
    /* Apply appropriate formats */
    format datetime datetime20.;
    format date_num date9.;
    
    /* Drop original character variables */
    drop T1 RH_1 T2 RH_2 T3 RH_3 T4 RH_4 T5 RH_5 T6 RH_6 T7 RH_7 T8 RH_8 T9 RH_9 T_out Press_mm_hg RH_out Windspeed Visibility Tdewpoint rv1 rv2;
run;

/* Calculate the daily averages*/
proc sql;
    create table daily_averages as
    select date_num, 
           mean(Appliances_num) as daily_avg_Appliance,
           mean(lights_num) as daily_avg_light,
           mean(T1_num) as daily_avg_T1,
           mean(T2_num) as daily_avg_T2,
           mean(T3_num) as daily_avg_T3,
           mean(T4_num) as daily_avg_T4,
           mean(T5_num) as daily_avg_T5,
           mean(T6_num) as daily_avg_T6,
           mean(T7_num) as daily_avg_T7,
           mean(T8_num) as daily_avg_T8,
           mean(T9_num) as daily_avg_T9,
           mean(RH_1_num) as daily_avg_RH_1,
           mean(RH_2_num) as daily_avg_RH_2,
           mean(RH_3_num) as daily_avg_RH_3,
           mean(RH_4_num) as daily_avg_RH_4,
           mean(RH_5_num) as daily_avg_RH_5,
           mean(RH_6_num) as daily_avg_RH_6,
           mean(RH_7_num) as daily_avg_RH_7,
           mean(RH_8_num) as daily_avg_RH_8,
           mean(RH_9_num) as daily_avg_RH_9,
           mean(T_out_num) as daily_avg_T_out,
           mean(Press_mm_hg_num) as daily_avg_Press_mm_hg,
           mean(RH_out_num) as daily_avg_RH_out,
           mean(Windspeed_num) as daily_avg_Windspeed,
           mean(Visibility_num) as daily_avg_Visibility,
           mean(Tdewpoint_num) as daily_avg_Tdewpoint,
           mean(rv1_num) as daily_avg_rv1,
           mean(rv2_num) as daily_avg_rv2,
           min(Appliances_num) as daily_min_usage_Appliances,
           max(Appliances_num) as daily_max_usage_Appliances,
           min(T1_num) as daily_min_usage_T1,
           max(T1_num) as daily_max_usage_T1,
           min(T2_num) as daily_min_usage_T2,
           max(T2_num) as daily_max_usage_T2,
           min(T3_num) as daily_min_usage_T3,
           max(T3_num) as daily_max_usage_T3,
           min(T4_num) as daily_min_usage_T4,
           max(T4_num) as daily_max_usage_T4,
           min(T5_num) as daily_min_usage_T5,
           max(T5_num) as daily_max_usage_T5,
           min(T6_num) as daily_min_usage_T6,
           max(T6_num) as daily_max_usage_T6,
           min(T7_num) as daily_min_usage_T7,
           max(T7_num) as daily_max_usage_T7,
           min(T8_num) as daily_min_usage_T8,
           max(T8_num) as daily_max_usage_T8,
           min(T9_num) as daily_min_usage_T9,
           min(T9_num) as daily_max_usage_T9


    from WORK.IMPORT_NUMERIC

    group by date_num;
quit;

PROC CONTENTS DATA=daily_averages; RUN;

/* Merge the daily average energy use back with the original data */
data WORK.IMPORT_NUMERIC;
    merge WORK.IMPORT_NUMERIC(in=a) daily_averages(in=b);
    by date_num;
    if a;
run;

/* check if the conversion has taken place*/
proc contents data=WORK.IMPORT_NUMERIC; 
run;

PROC UNIVARIATE DATA = WORK.IMPORT_NUMERIC; 
VAR days datetime weekday day_of_week day_of_month T3_num; 
RUN;
PROC UNIVARIATE DATA = WORK.IMPORT_NUMERIC; 
VAR T2_num T3_num  T4_num T5_num ; 
RUN;

PROC UNIVARIATE DATA = WORK.IMPORT_NUMERIC; 
VAR time_segment; 
RUN;


/* Create a dataset containing only indoor variables */
data indoor_data;
    set WORK.IMPORT_NUMERIC;
    keep date Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num T4_num RH_4_num T5_num RH_5_num T7_num RH_7_num T8_num RH_8_num T9_num RH_9_num;
run;

/* Create a dataset containing only outdoor variables */
data outdoor_data;
    set WORK.IMPORT_NUMERIC;
    keep date T6_num Press_mm_hg_num RH_6_num T_out_num RH_out_num RH_out_num Windspeed_num Visibility_num  Tdewpoint_num rv1_num rv2_num time_segment;
run;

/* check if the conversion has taken place*/
proc contents data=WORK.indoor_data; 
run;

/* check if the conversion has taken place*/
proc contents data=WORK.outdoor_data; 
run;

/* Merge indoor and outdoor datasets by date */
data merged_data;
    merge indoor_data (in=a) outdoor_data (in=b);
    by date;
    /* Check for missing values */
    if a and b;
run;

PROC CONTENTS DATA=merged_data; RUN;


/*Principal Components Analysis (PCA) and its visualization*/

/* Standardize the dataset */
proc standard data=WORK.IMPORT_NUMERIC mean=0 std=1 out=energy_standardized;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num
    T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num
    T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num Visibility_num 
    Tdewpoint_num rv1_num rv2_num;
run;

/*Eigenvalues*/

/* Perform PCA */
proc princomp data=energy_standardized out=pca_output outstat=pca_stats plots=all;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num
    T3_num RH_3_num T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num
    T7_num RH_7_num T8_num RH_8_num T9_num RH_9_num T_out_num
    Press_mm_hg_num RH_out_num Windspeed_num Visibility_num Tdewpoint_num rv1_num rv2_num;
run;

/* Perform Factor Analysis with nfactor=2 */
proc factor data=energy_standardized method=principal rotate=varimax scree nfactor=2 out=factor_scores;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num
        T3_num RH_3_num T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num
        T7_num RH_7_num T8_num RH_8_num T9_num RH_9_num T_out_num
        Press_mm_hg_num RH_out_num Windspeed_num Visibility_num Tdewpoint_num rv1_num rv2_num;
run;

/* Print the factor loadings for interpretation */
proc print data=factor_scores(obs=10);
run;


/* Computing MDS*/
/* Step 1: Compute the Distance Matrix */
proc distance data=energy_standardized method=euclid out=distance_matrix;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num
        T3_num RH_3_num T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num
        T7_num RH_7_num T8_num RH_8_num T9_num RH_9_num T_out_num
        Press_mm_hg_num RH_out_num Windspeed_num Visibility_num Tdewpoint_num rv1_num rv2_num;
run;

/* Step 2: Transpose the Distance Matrix to a long format */
proc transpose data=distance_matrix out=distance_long(drop=_NAME_);
    var Dist1-Dist28; 
run;

/* Step 3: Create unique identifiers for each observation */
data distance_long;
    set distance_long;
    length Subject $50; 
    
/* Define an array of variable names */
array var_names[28] $50 _temporary_ ('Appliances_num' 'lights_num' 'T1_num' 'RH_1_num' 'T2_num' 'RH_2_num'
                                          'T3_num' 'RH_3_num' 'T4_num' 'RH_4_num' 'T5_num' 'RH_5_num' 'T6_num' 'RH_6_num'
                                          'T7_num' 'RH_7_num' 'T8_num' 'RH_8_num' 'T9_num' 'RH_9_num' 'T_out_num'
                                          'Press_mm_hg_num' 'RH_out_num' 'Windspeed_num' 'Visibility_num' 'Tdewpoint_num' 'rv1_num' 'rv2_num');
/* Assign Subject based on observation number */
if _N_ <= dim(var_names) then Subject = var_names[_N_];
run;

/* Step 4: Perform MDS using the reshaped distance matrix */
proc mds data=distance_long out=mds_out level=ordinal;
    id Subject;
    var COL1-COL28; 
run;

/* Step 5: Scatter Plot of MDS results */
proc sgplot data=mds_out;
    scatter x=Dim1 y=Dim2 / datalabel=Subject;
    xaxis label='Dimension 1';
    yaxis label='Dimension 2';
    title 'MDS Plot';
run;


/* Scatter Plot of First Two Principal Components */
proc sgplot data=pca_output;
    scatter x=Prin1 y=Prin2;
    xaxis label='Principal Component 1';
    yaxis label='Principal Component 2';
run;

/* Prepare data for biplot */
/* Extract the principal component loadings */
data loadings;
    set pca_stats(where=(_TYPE_='SCORE'));
    keep _NAME_ Prin1 Prin2;
run;

/* Create the combined dataset for biplot */
data biplot_data;
    set pca_output(in=a) loadings(in=b);
    if a then type='score';
    if b then type='loading';
run;

/* Biplot */
proc sgplot data=biplot_data;
    vector x=Prin1 y=Prin2 / group=type name='Variable Contributions';
    scatter x=Prin1 y=Prin2 / group=type;
    xaxis label='Principal Component 1';
    yaxis label='Principal Component 2';
    title 'Biplot of Principal Components';
run;

/* Print the first 20 observations to verify the merge */
proc print data=WORK.IMPORT_NUMERIC(obs=20);
    var date weekend weekday Appliances daily_avg_Appliance daily_avg_light;
run;

title "Daily average energy use data by appliances";
proc sgplot data=WORK.IMPORT_NUMERIC;
   series x=date_num y=daily_avg_appliance / markers;
    xaxis label="Date";
   yaxis label="Energy Use (Applinces)";
run;

title "Daily average energy use data by lights";
proc sgplot data=WORK.IMPORT_NUMERIC;
   series x=date_num y=daily_avg_light / markers;
    xaxis label="Date";
   yaxis label="Energy Use (Lights)";
run;


/*  Correspondence Analysis Method */

/* Check summary statistics */
proc means data=energy_standardized;
    var Appliances_num lights_num T1_num T2_num RH_1_num RH_2_num;
run;

/* Define formats for categorizing continuous variables */
proc format;
    value energy_fmt
        low - 0 = 'Low'
        0.01 - 3 = 'Medium'
        3.01 - high = 'High';
    value temp_fmt
        low - 0 = 'Low'
        0.01 - 3 = 'Medium'
        3.01 - high = 'High';
    value humidity_fmt
        low - 0 = 'Low'
        0.01 - 3 = 'Medium'
        3.01 - high = 'High';
run;

/* Apply the formats to categorize the continuous variables */
data categorized_data;
    set energy_standardized;
    Appliances_cat = put(Appliances_num, energy_fmt.);
    Lights_cat = put(lights_num, energy_fmt.);
    T1_cat = put(T1_num, temp_fmt.);
    T2_cat = put(T2_num, temp_fmt.);
    RH_1_cat = put(RH_1_num, humidity_fmt.);
    RH_2_cat = put(RH_2_num, humidity_fmt.);
run;

/* Create a contingency table for Correspondence Analysis */
proc freq data=categorized_data;
    tables (Appliances_cat Lights_cat) * (T1_cat T2_cat RH_1_cat RH_2_cat) / out=contingency_table;
run;

/* Print the contingency table to verify */
proc print data=contingency_table (obs=20);
run;

/* Perform Correspondence Analysis */
proc corresp data=contingency_table outc=coord;
    tables Lights_cat, RH_2_cat;
    weight COUNT;
run;

/* Plot the results */
proc sgplot data=coord;
    scatter x=dim1 y=dim2 / group=_type_ markerattrs=(symbol=circlefilled);
    text x=dim1 y=dim2 text=_name_ / position=right;
    xaxis label="Dimension 1";
    yaxis label="Dimension 2";
    title "Correspondence Analysis Plot";
run;



/*Canonical Correlation Analysis with PROC CANCORR*/

/* Step 1: Define the variable sets */
%let environmental_vars = T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num T4_num RH_4_num 
                          T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num 
                          T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num 
                          Visibility_num Tdewpoint_num rv1_num rv2_num;

%let energy_vars = Appliances_num lights_num;
run;

/* Step 2: Perform Canonical Correlation Analysis */
proc cancorr data=WORK.IMPORT_NUMERIC
             vprefix=Env vname="Environmental Factors"
             wprefix=Energy wname="Energy Usage";
    var &environmental_vars;
    with &energy_vars;
run;


/*Canonical Discriminant Analysis*/

/* Check the structure of the merged_data */
proc contents data=WORK.merged_data;
run;

/* Ensure merged_data has the time_segment variable and is ready for discriminant analysis */
data discriminant_data;
    set WORK.merged_data;
    /* Ensure necessary variables are included */
    keep date Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num T4_num RH_4_num 
         T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num T9_num RH_9_num T_out_num 
         Press_mm_hg_num RH_out_num Windspeed_num Visibility_num Tdewpoint_num rv1_num rv2_num time_segment;
run;

/* Check the structure and contents of the prepared data */
proc print data=discriminant_data(obs=10);
run;
/* Perform discriminant analysis */
proc discrim data=discriminant_data out=discrim_out canonical;
    class time_segment;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num T4_num RH_4_num 
        T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num T9_num RH_9_num T_out_num 
        Press_mm_hg_num RH_out_num Windspeed_num Visibility_num Tdewpoint_num rv1_num rv2_num;
run;

/* Step 3: Prepare data for visualization */
/* Sort the discrim_out dataset by time_segment */
proc sort data=discrim_out;
    by time_segment;
run;

/* Merge the sorted dataset for visualization */
data plotclass;
    set discrim_out;
run;

/* Step 4: Define a template for plotting the discriminant analysis results */
proc template;
    define statgraph classify;
        begingraph;
            layout overlay;
                contourplotparm x=Can1 y=Can2 z=_into_ / contourtype=fill nhint=30 gridded=false;
                scatterplot x=Can1 y=Can2 / group=time_segment includemissinggroup=false markercharactergroup=time_segment;
            endlayout;
        endgraph;
    end;
run;

/* Step 5: Render the plot */
proc sgrender data=plotclass template=classify;
run;

/*Clustering for using daily averages */

/* Step 1: Standardize the dataset for clustering */
proc standard data=daily_averages mean=0 std=1 out=clustering_standardized;
    var daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_avg_rv1 daily_avg_rv2;
run;

/* Step 2: Perform Clustering using K-means (PROC FASTCLUS) */
proc fastclus data=clustering_standardized maxclusters=3 out=clus_output;
    var daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_avg_rv1 daily_avg_rv2;
run;

/* Step 3: Evaluate Clustering Results */
proc print data=clus_output(obs=10);
    var cluster daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_avg_rv1 daily_avg_rv2;
run;

/* Step 3: Summarize Cluster Characteristics */
proc means data=clus_output n mean std min max;
    class cluster;
    var daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_avg_rv1 daily_avg_rv2;
run;


/* Step 4: Visualize the Clusters */
proc sgplot data=clus_output;
    scatter x=daily_avg_Appliance y=daily_avg_light / group=cluster markerattrs=(symbol=circlefilled) transparency=0.5;
    title 'Clustering Results: daily_avg_Appliance VS daily_avg_light ';
run;


/* Step 5: Hierarchical Clustering (PROC CLUSTER) */
proc cluster data=clustering_standardized method=ward outtree=clus_tree;
    var daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_avg_rv1 daily_avg_rv2;
run;

/* Step 6: Create Clusters from the Hierarchical Tree using PROC TREE */
proc tree data=clus_tree out=tree_clusters nclusters=3;
    id _NAME_; /* Use _NAME_ to identify observations */
run;

/* Step 7: Print the Clusters Created by PROC TREE */
proc print data=tree_clusters;
run;


/*Clustering*/

/* Step 1: Standardize the dataset for clustering */
proc standard data=WORK.IMPORT_NUMERIC mean=0 std=1 out=clustering_standardized;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num
        T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num
        T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num Visibility_num 
        Tdewpoint_num rv1_num rv2_num;
run;

/* Step 2: Perform Clustering using K-means (PROC FASTCLUS) */
proc fastclus data=clustering_standardized maxclusters=3 out=clus_output;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num
        T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num
        T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num Visibility_num 
        Tdewpoint_num rv1_num rv2_num;
run;

/* Step 3: Evaluate Clustering Results */
proc print data=clus_output(obs=10);
    var cluster Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num
        T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num
        T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num Visibility_num 
        Tdewpoint_num rv1_num rv2_num;
run;


/* Step 3: Summarize Cluster Characteristics */
proc means data=clus_output n mean std min max;
    class cluster;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num
        T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num
        T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num Visibility_num 
        Tdewpoint_num rv1_num rv2_num;
run;


/* Step 4: Visualize the Clusters */
proc sgplot data=clus_output;
    scatter x=T1_num y=T2_num / group=cluster markerattrs=(symbol=circlefilled) transparency=0.5;
    title 'Clustering Results: T1_num vs T2_num';
run;

/* Additional scatter plots for other variable pairs */
proc sgplot data=clus_output;
    scatter x=Appliances_num y=lights_num / group=cluster markerattrs=(symbol=circlefilled) transparency=0.5;
    title 'Clustering Results: Appliances_num vs lights_num';
run;


/* Step 5: Hierarchical Clustering (PROC CLUSTER) */
proc cluster data=clustering_standardized method=ward outtree=clus_tree;
    var Appliances_num lights_num T1_num RH_1_num T2_num RH_2_num T3_num RH_3_num
        T4_num RH_4_num T5_num RH_5_num T6_num RH_6_num T7_num RH_7_num T8_num RH_8_num
        T9_num RH_9_num T_out_num Press_mm_hg_num RH_out_num Windspeed_num Visibility_num 
        Tdewpoint_num rv1_num rv2_num;
run;

/* Step 6: Create Clusters from the Hierarchical Tree using PROC TREE */
proc tree data=clus_tree out=tree_clusters nclusters=3;
    id _NAME_; /* Use _NAME_ to identify observations */
run;

/* Step 7: Print the Clusters Created by PROC TREE */
proc print data=tree_clusters;
run;


/*PLS TRY*/
/* Step 1: Standardize the dataset */
proc standard data= daily_averages mean=0 std=1 out=daily_averages_standardized;
    var daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_min_usage_T1 daily_max_usage_T1 daily_min_usage_T2 daily_max_usage_T2
    daily_min_usage_T3 daily_max_usage_T3 daily_min_usage_T4 daily_max_usage_T4
    daily_min_usage_T5 daily_max_usage_T5 daily_min_usage_T6 daily_max_usage_T6
    daily_min_usage_T7 daily_max_usage_T7 daily_min_usage_T8 daily_max_usage_T8
    daily_min_usage_T9 daily_max_usage_T9 ;
run;

proc pls data=daily_averages_standardized;
       model daily_avg_Appliance = daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out
    daily_avg_Press_mm_hg daily_avg_RH_out daily_avg_Windspeed
    daily_avg_Visibility daily_avg_Tdewpoint daily_min_usage_T1 daily_max_usage_T1
    daily_min_usage_T2 daily_max_usage_T2 daily_min_usage_T3 daily_max_usage_T3 daily_min_usage_T4 daily_max_usage_T4
    daily_min_usage_T5 daily_max_usage_T5 daily_min_usage_T6 daily_max_usage_T6
    daily_min_usage_T7 daily_max_usage_T7 daily_min_usage_T8 daily_max_usage_T8
    daily_min_usage_T9 daily_max_usage_T9;
run;
    

/* Step 2: Perform PLS Regression */
proc pls data=daily_averages_standardized nfac=10 cv=split(5) method=pls;
    model daily_avg_Appliance = /*daily_avg_light*/ daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 
                                 daily_avg_T3 daily_avg_RH_3 /*daily_avg_T4*/ daily_avg_RH_4 daily_avg_T5 
                                 daily_avg_RH_5 daily_avg_T6 daily_avg_RH_6 daily_avg_T7 /*daily_avg_RH_7*/
                                 daily_avg_T8 daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 /*daily_avg_T_out*/
                                 /*daily_avg_Tdewpoint*/ daily_min_usage_T1 daily_max_usage_T1
    daily_min_usage_T2 daily_max_usage_T2 daily_min_usage_T3 daily_max_usage_T3 daily_min_usage_T4 daily_max_usage_T4
    daily_min_usage_T5 daily_max_usage_T5 daily_min_usage_T6 daily_max_usage_T6
    daily_min_usage_T7 daily_max_usage_T7 daily_min_usage_T8 daily_max_usage_T8
    daily_min_usage_T9 daily_max_usage_T9;
    output out=pls_pred p=y_pred;
run;

/* Step 3: Generate PLS Scores */
proc score data=daily_averages_standardized score=pls_pred out=pls_scores(rename=(y_pred=_SCORE_));
run;

/* Step 3: Generate PLS Scores */
proc score data=daily_averages_standardized score=pls_pred type=parms out=pls_scores(rename=(y_pred=_SCORE_));
run;



/* Step 3: Generate PLS Scores */
proc score data=daily_averages_standardized score=pls_pred type=parms out=pls_scores;
    var daily_avg_light daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 
        daily_avg_T3 daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 
        daily_avg_RH_5 daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 
        daily_avg_T8 daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out 
        daily_avg_Press_mm_hg daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility 
        daily_avg_Tdewpoint daily_avg_rv1 daily_avg_rv2;
run;


/* Step 3: Generate PLS Scores */
proc score data=daily_averages_standardized score=pls_pred out=pls_pred;
run;



/* Step 3: Assess Variable Importance */
proc sgplot data=pls_scores;
    vbar _NAME_ / response=_VIP_ datalabel;
    xaxis label="Predictor Variables";
    yaxis label="Variable Importance in Projection (VIP)";
    title "PLS Regression: VIP Scores";
run;

/* Step 4: Identify and Filter Non-Predictive Variables */
/* Example: Print VIP Scores to Identify Non-Predictive Variables */
proc print data=pls_scores(where=(_VIP_ < 0.8));
    var _NAME_ _VIP_;
    title "Variables with VIP Scores Less Than 0.8";
run;

/* Step 5: Assess the Model */
proc print data=pls_out(obs=10);
run;

proc sgplot data=pls_pred;
    scatter x=Appliances_num y=y_pred;
    lineparm x=0 y=0 slope=1 / lineattrs=(color=red);
    xaxis label="Actual Appliance Energy Use";
    yaxis label="Predicted Appliance Energy Use";
    title "PLS Regression: Actual vs Predicted Appliance Energy Use";
run;

proc sgplot data=pls_out;
    series x=_CV_ y=_PRESS_ / markers;
    xaxis label="Number of Components";
    yaxis label="Predictive Residual Sum of Squares (PRESS)";
    title "PLS Regression: Model Selection using PRESS";
run;

















/*PLS Regression*/

/* Step 1: Standardize the dataset */
proc standard data= daily_averages mean=0 std=1 out=daily_averages_standardized;
    var daily_avg_Appliance daily_avg_light 
    daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
    daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
    daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
    daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
    daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint 
    daily_min_usage_T1 daily_max_usage_T1 daily_min_usage_T2 daily_max_usage_T2
    daily_min_usage_T3 daily_max_usage_T3 daily_min_usage_T4 daily_max_usage_T4
    daily_min_usage_T5 daily_max_usage_T5 daily_min_usage_T6 daily_max_usage_T6
    daily_min_usage_T7 daily_max_usage_T7 daily_min_usage_T8 daily_max_usage_T8
    daily_min_usage_T9 daily_max_usage_T9 ;
run;


/* Partial Least Squares (PLS) Regression */
proc pls data=daily_averages_standardized method=pls nfac=5;
    model daily_avg_Appliance = daily_avg_light 
        daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
        daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
        daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
        daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
        daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint
        daily_min_usage_T1 daily_max_usage_T1 daily_min_usage_T2 daily_max_usage_T2
        daily_min_usage_T3 daily_max_usage_T3 daily_min_usage_T4 daily_max_usage_T4
        daily_min_usage_T5 daily_max_usage_T5 daily_min_usage_T6 daily_max_usage_T6
        daily_min_usage_T7 daily_max_usage_T7 daily_min_usage_T8 daily_max_usage_T8
        daily_min_usage_T9 daily_max_usage_T9 daily_avg_rv1 daily_avg_rv2;
    output out=pls_output predicted=Predicted_Appliances_num;
run;

/* Step 2: Use PROC REG to obtain coefficients */
proc reg data=pls_output;
    model daily_avg_Appliance = daily_avg_light 
        daily_avg_T1 daily_avg_RH_1 daily_avg_T2 daily_avg_RH_2 daily_avg_T3
        daily_avg_RH_3 daily_avg_T4 daily_avg_RH_4 daily_avg_T5 daily_avg_RH_5 
        daily_avg_T6 daily_avg_RH_6 daily_avg_T7 daily_avg_RH_7 daily_avg_T8 
        daily_avg_RH_8 daily_avg_T9 daily_avg_RH_9 daily_avg_T_out daily_avg_Press_mm_hg 
        daily_avg_RH_out daily_avg_Windspeed daily_avg_Visibility daily_avg_Tdewpoint
        daily_min_usage_T1 daily_max_usage_T1 daily_min_usage_T2 daily_max_usage_T2
        daily_min_usage_T3 daily_max_usage_T3 daily_min_usage_T4 daily_max_usage_T4
        daily_min_usage_T5 daily_max_usage_T5 daily_min_usage_T6 daily_max_usage_T6
        daily_min_usage_T7 daily_max_usage_T7 daily_min_usage_T8 daily_max_usage_T8
        daily_min_usage_T9 daily_max_usage_T9 daily_avg_rv1 daily_avg_rv2;
    output out=reg_output p=predicted;
run;


/* Print the first 20 observations to verify the PLS output */
proc print data=pls_output(obs=20);
    var daily_avg_Appliance Predicted_Appliances_num;
run;

/* Scatter plot of Actual vs. Predicted Values */
proc sgplot data=pls_output;
    scatter x=daily_avg_Appliance y=Predicted_Appliances_num;
    lineparm x=0 y=0 slope=1 / lineattrs=(color=red);
    xaxis label="Actual Appliances Energy Consumption";
    yaxis label="Predicted Appliances Energy Consumption";
    title "Actual vs. Predicted Energy Consumption (PLS)";
run;

/* Print the actual and predicted values for all observations */
proc print data=pls_output noobs label;
    var daily_avg_Appliance Predicted_Appliances_num;
    label daily_avg_Appliance = "Actual Appliances Energy Consumption"
          Predicted_Appliances_num = "Predicted Appliances Energy Consumption";
    title "Table of Actual vs. Predicted Values";
run;





