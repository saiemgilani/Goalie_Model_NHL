# DESCRIPTION
 We seek to determine an appropriate sample size of data needed for a Buhlmann credibility estimation on complement of NHL Goaltender Save percentage (or Goals Allowed percentage). The goal is to determine at what point in a Goaltender’s career can you establish a 95\% confidence interval that the player’s true mean save percentage will not include the league average (or perhaps at a top 10 level).

 The package is written in Python and uses the Scikit Learn library complemented by pandas and numpy. It runs as a standalone python application from the command line. Upon running the main function, the application will perform feature selection, hyperparameter tuning and ultimately train the model on the entire dataset producing an expected goal prediction for each shot.

# INSTALLATION
### Prerequisites
 - Python 3.7: It is recommended that the latest version of Anaconda is installed as that has many of the necessary libraries such as numpy, pandas, sci-kit learn, etc.
 - Apache Spark (pyspark) must be installed to run pre- and post-processing. Spark can be installed and configured to start in a notebook which is the preferred method. See [this](https://medium.com/@singhpraveen2010/install-apache-spark-and-configure-with-jupyter-notebook-in-10-minutes-ae120ebca597) link for more information on how to do this.
 - Tensorflow 2.0: Initially used to run neural networks, this was scrapped in favor of standard ML tools. Still some of it's features are used, such as logging
 - XGBoost: The XGB classifier is used frequently
 - Talos (no longer used): Talos is a grid search-like library for Keras. It was modified to work with the Tensorflow 2.0 tf.keras layers. Code using it has been disabled after the switch to XGBoost 

### Data
Data was scraped from the Sports Radar API, MoneyPuck and from the hockey-reference web site. Starting with the shots data retrieved from Sports Radar, which contains shots data in the NHL both during the regular season and the playoffs for the years 2007-2018, additional player data and advanced stats from the other data sources were appended to the results where possible. This resulted in a file roughly 1GB in size named *shots_2007-2018_with_stats.csv* that was placed in the *data* directory of this project. This "raw" file served as the input for preprocessing.

# EXECUTION
### Preprocessing
All preprocessing is performed in the *notebooks/data.ipynb* notebook via Apache Spark (pyspark). If Spark is properly installed and configured to launch in a notebook, simply navigating to the *notebooks* directory and typing `pyspark` will allow one to open the *data.ipynb* notebook. The first two cells should be run then every subsequent cell in the preprocessing section. The source data file can be set in the third cell of the notebook. The cells perform the following steps:
 - Drop duplicate records
 - Remove empty net shots
 - Remove shots greater than 70 feet (an attempt to balance the goal/non-goal ratio)
 - Clean up various categorical columns that had Null or nonsensical values
 - Adding features, such as score situation, team strength situation, various stat interactions and advanced stat rates per game
 - Adding the 'shooter talent' and 'shots within' advanced stats
 - Adding the zone category

Upon running the final preprocessing cell, the resulting CSV will be saved in the same directory as the input file with the *_processed* term appended to the end.

### Training and Prediction
Training and predicting is performed in one step and can be invoked via the command line. The repository should be cloned and one should navigate to the root directory of the cloned project. The TL;DR; version is you can run the command below and training/prediction will begin with the defaults, providing the data file is in the proper location (the project folder must be on the python path):

`PYTHONPATH=. python goalcred/train.py`
 
The default config file will be copied over to the model directory (named after the config file) for documentation purposes. Training and prediction will begin and all artifacts will be saved in the model directory.

Read on for more detail...

Training requires two arguments:
 - *data_file*: the full path to the input data file. Default is *./goalcred/data/shots_2007-2018_with_stats_processed.csv*
 - *config_file*: the full path of the configuration file. Default is *./goalcred/config/xgboost.yaml*
 
The proper format of a command to train is:

`PYTHONPATH=. python goalcred/train.py --data_file=<full path to data file> --config_file=<full path to config file>`
 
The configuration file is of particular importance. This file, in YAML format, configures all the parameters required to train the model and predict the results. The default file *xgboost.yaml* was used to produce the results for our visualization. Using this config file performs multiple steps, which are described in detail in the README markdown file at the root of the repository.

### Postprocessing
With the predictions in hand, we are ready to generate the files needed to produce the visualization. Based on the probability of a goal for each shot in our data, which is generated in the Training and Prediction phase, we simulate all the shots faced by a given goalie in a given point (game) in their career. With this simulation, we produce a probability mass function which can be compared with the actual number of goals a goalie has conceded to determine the goalie's efficacy.

The postprocessing work is performed using Apache Spark (pyspark) and is located in the *notebooks/data.ipynb* notebook. All cells should be run in the *Postprocessing* section. These cells perform the following steps:
  - Generate the simulations
  - Aggregate the simulations by goalie and game
  - Accumulate the goals allowed and the simulation goals allowed for each goalie over the course of his career
  - Calculate the probability mass function
  - Expand the PMF buckets across rows and accumulate the CDF score

The resulting file will be saved to the desired location where it can then be handed off to the visualization team.

### Suggested Steps To Run an Experiment

1. Copy the default data config file located at *goalcred/config/data/default.csv* into the same directory and name it something meaningful, preferrably putting your initials on the front (ex. `jf-data1.csv`). Modify as needed.
2. Make sure the shots data file, *shots_2007-2018_with_stats_processed.csv*, is located in the data directory.
3. Copy the default config file located at *goalcred/config/xgboost.yaml* into the same directory and name it something meaningful (ex. `jf-xgboost1.yaml`). Modify as desired and make sure the data config file path just created is property input in the config.
4. Run `PYTHONPATH=. python goalcred/train.py --data_file=goalcred/data/shots_2007-2018_with_stats_processed.csv --config_file=goalcred/config/jf-experiment1.yaml`. This command will run training with the data using the new config and save the results in the model directory under *training-runs* determined by the config file name.
5. If results are satisfactory, feel free to add the data config file and regular config file to the github repository. DO *NOT* add the data file to the repository. It is too big!
