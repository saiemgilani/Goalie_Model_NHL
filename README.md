# NHL Goalie Credibility
 We seek to determine an appropriate sample size of data needed for a Buhlmann credibility estimation on complement of NHL Goaltender Save percentage (or Goals Allowed percentage). The goal is to determine at what point in a Goaltender’s career can you establish a 95\% confidence interval that the player’s true mean save percentage will not include the league average (or perhaps at a top 10 level).

### Prerequisites
 - Python 3.7: It is recommended that the latest version of Anaconda is installed as that has many of the necessary libraries such as numpy, pandas, sci-kit learn, etc.
 - Apache Spark (pyspark) must be installed to run pre- and post-processing. Spark can be installed and configured to start in a notebook which is the preferred method. See [this](https://medium.com/@singhpraveen2010/install-apache-spark-and-configure-with-jupyter-notebook-in-10-minutes-ae120ebca597) link for more information on how to do this.
 - Tensorflow 2.0: Initially used to run neural networks, this was scrapped in favor of standard ML tools. Still some of it's features are used, such as logging
 - XGBoost: The XGB classifier is used frequently
 - Talos (no longer used): Talos is a grid search-like library for Keras. It was modified to work with the Tensorflow 2.0 tf.keras layers. Code using it has been disabled after the switch to XGBoost 

### Data
Data was scraped from the Sports Radar API, MoneyPuck and from the hockey-reference web site. Starting with the shots data retrieved from Sports Radar, which contains shots data in the NHL both during the regular season and the playoffs for the years 2007-2018, additional player data and advanced stats from the other data sources were appended to the results where possible. This resulted in a file roughly 1GB in size named *shots_2007-2018_with_stats.csv* that was placed in the *data* directory of this project. This "raw" file served as the input for preprocessing.

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
Training and predicting is performed in one step and can be invoked via the command line. The TL;DR; version is you can run the command below and training/prediction will begin with the defaults, providing the data file is in the proper location (the project folder must be on the python path):

`PYTHONPATH=. python goalcred/train.py`
 
The default config file will be copied over to the model directory (named after the config file) for documentation purposes. Training and prediction will begin and all artifacts will be saved in the model directory.

Read on for more detail...

Training requires two arguments:
 - *data_file*: the full path to the input data file. Default is *./goalcred/data/shots_2007-2018_with_stats_processed.csv*
 - *config_file*: the full path of the configuration file. Default is *./goalcred/config/xgboost.yaml*
 
The proper format of a command to train is:

`PYTHONPATH=. python goalcred/train.py --data_file=<full path to data file> --config_file=<full path to config file>`
 
The configuration file is of particular importance. This file, in YAML format, configures all the parameters required to train the model and predict the results. The default file *xgboost.yaml* was used to produce the results for our visualization. Using this config file performs multiple steps, described henceforth:

#### Training preprocessing
Before the model is run, the input data must be prepared for training. The parameters for this stage are located in the `data` section of the config file. Importantly, the path to the data config file must be specified. This file is a CSV file of all the column names with a *use* column that explains what will be done with that column. It also serves as a **data dictionary** with descriptions of what the columns mean. The possible values are of the *use* column are below, which describes how the column will be handled during training preprocessing:

 - *\<blank\>*: no actions are taken therefore these columns are kept
 - *drop*: drop the column
 - *cat*: keep and one-hot encode
 - *scale*: keep and scale column
 - *stratify*: stratify and remove column
 - *stratify_scale*: stratify and scale column
 - *target*: use as target value for training
 
It is recommended to open up this config in a spreadsheet app, edit as needed and save back to the *config/data* directory, making sure to add the full path to the main config file.

#### Feature selection
The first part of training involves using a small set of the data to select the the best features via an XGBoost model. The parameters for selecting the sample and for the XGBoost model are located in the `feature_selection` section of the config file. Note that the **top** portion of the config file holds parameters that are common across all the training/prediction steps, such as XGBoost parameters that are used in every instantiated XGBoost model.

#### Hyperparameter tuning
The second part of training again uses a sample of the data *with* the best features found in the above step, adds a cluster category feature and uses a grid search with an XGBoost model to find the parameters that yield the best cross validation score. The parameters covering this step are located in the `hyperparameter_tuning` section. Of note, the grid search parameters are located in the `grid` section beneath the `hyperparameter_tuning` section; these and most other parameters match exactly the keyword arguments used in the python objects.

Clustering is used in this step for the first time. Clustering configuration can be found in the `clustering` section of the configuration file.

#### Training and Evaluation
Now with the best features and hyperparameters selected, training can begin on the full dataset (sans the withheld test set). An XGBoost model is again trained using the results from the prior two sections (along with the clustering). 

After the model is trained, log loss is evaluated on on the test set and printed to the console

#### Prediction
With best model trained, predictions are run on the entire dataset using the knowledge gained from the previous steps. After the data is treated, predictions are generated and saved to the model directory and are named after the input data file with a *pred_* prefix.

This concludes the training and prediction run.

### Postprocessing
With the predictions in hand, we are ready to generate the files needed to produce the visualization. Based on the probability of a goal for each shot in our data, which is generated in the Training and Prediction phase, we simulate all the shots faced by a given goalie in a given point (game) in their career. With this simulation, we produce a probability mass function which can be compared with the actual number of goals a goalie has conceded to determine the goalie's efficacy.

The file generated has these columns:
 - *goalie_id*: unique identifier for the goalie
 - *game*: the game number in a goalie's career
 - *actual_goals*: the actual goals goalie has let in at that point (game) in their career
 - *sim_goals*: the goals the sim generated
 - *cdf_score*: the cdf score associated with the simulation goals scored
 
 Each goalie_id and game combo will have multiple rows depending on the span of goals that were generated during the simulation (the PMF). These rows are cumulated over each value to generate the CDF score.
 
 The postprocessing work is performed using Apache Spark (pyspark) and is located in the *notebooks/data.ipynb* notebook. All cells should be run in the *Postprocessing* section. These cells perform the following steps:
  - Generate the simulations
  - Aggregate the simulations by goalie and game
  - Accumulate the goals allowed and the simulation goals allowed for each goalie over the course of his career
  - Calculate the probability mass function
  - Expand the PMF buckets across rows and accumulate the CDF score
  
 The resulting file will be saved to the desired location where it can then be handed off to the visualization team. 
 
### Project Structure
 - *config* (dir): contains the config files used in training and prediction. Also, contains the data config file (data dictionary)
 - *data* (dir): data files should be housed here but **NOT** saved to the repository as they are generally too large
 - *data-fetch* (dir): scripts related to scraping the data from the various sources
 - *doc* (dir): project documentation ex. Proposal, progress report, etc.
 - *notebooks* (dir): notebooks used for this project. Contains the spark-based pre- and post-processing script plus the initial notebook used to prototype our methodology (*model.ipynb*)
 - *sql* (dir): contains SQL scripts to treat and merge the scraped data
 - *vis* (dir): R scripts used to transform the output from the main project into a format useful for the visualizations
 - *training-runs* (dir): directory to house artifacts from training. Nothing contained within should be saved to the repository
 - *config.py*: utility object that allows for easy reading of YAML files
 - *data.py*: contains all data-related functionality, ex. training preprocessing, splitting into train and test sets, sampling, etc.
 - *hidden_layers.py*: copied from Talos project and modified to work with tf.keras layers. No longer used.
 - *ml.py*: contains all the machine learning based calls, ex. clustering, training an XGB model, grid search, etc.
 - *model.py*: contains models that were built in Tensorflow and meant to be explored by Talos. No longer used.
 - *README.md*: this file!
 - *train.py*: entry point that runs all the training and prediction steps described above
 - *util.py*: utility functionality that doesn't have a better place

### Suggested Steps To Run an Experiment

1. Copy the default data config file located at *goalcred/config/data/default.csv* into the same directory and name it something meaningful, preferrably putting your initials on the front (ex. `jf-data1.csv`). Modify as needed.
2. Make sure the shots data file, *shots_2007-2018_with_stats_processed.csv*, is located in the data directory.
3. Copy the default config file located at *goalcred/config/xgboost.yaml* into the same directory and name it something meaningful (ex. `jf-xgboost1.yaml`). Modify as desired and make sure the data config file path just created is property input in the config.
4. Run `PYTHONPATH=. python goalcred/train.py --data_file=goalcred/data/shots_2007-2018_with_stats_processed.csv --config_file=goalcred/config/jf-experiment1.yaml`. This command will run training with the data using the new config and save the results in the model directory under *training-runs* determined by the config file name.
5. If results are satisfactory, feel free to add the data config file and regular config file to the github repository. DO *NOT* add the data file to the repository. It is too big!

For our experiment that generated the data used in the visualization, the described methodology was run on three different datasets:

1. Even team strength (5 on 5, 4 on 4 etc.)
2. Power play (shooting team has the advantage, 5 on 4, 4 on 3, etc.)
3. Short-handed (shooting team is at a disadvantage, 4 on 5, 3 on 5, etc)

This experiment can easily be run by dividing the main processed data file into the three categories and executing the command taking care to change the path to each data file in the command line argument. Predictions will be generated in the model directory that correspond to each data file that can be merged.