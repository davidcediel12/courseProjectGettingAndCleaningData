# Code Book 

## Data:
The data that I work is the data collected from the accelerometers from Samsung Galaxy S, [This is the data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

When the file is unzipped, there is a folder (UCI HAR Dataset) which contains a lot of information:

* Folder **test**: Contains the files X and Y test
* Folder **train**: Contains the files X and Y train
* File **activity_labels**: Contain the mean of the numbers that are in Y test and Y train 
* File **features**: Contain all the variable names for the data stored in *X*
* File **features_info**: Contain details, like abbreviations used, and explanations for the file features. 


## Variables in the script

1. **fileUrl**: Used for save the link to download the zip

2. *test_x*, *train_x*, *test_y* and *train_y*: Dataframes that store the data which was reading from the .txt files in the data folder

3. *bigX* and *bigY*: This variables are the result of merging the test and train data 

4. *features_names*: Used for read *features.txt*, which contain the name of all variables of *X*, with that variable I can change the column names of X

5. function *changeNames*: Used to map number -> activity for made descriptive names 

6. *activities*: Factor for split the dataset and can find the mean for every variable separated by activity

5. *means*: Contain the mean for every variable of *dataset* separated by activity

6. *by_activity*: Contain the dataset grouped by activity

## Tranformations

First, I merge the train X and train Y, and do the same with train Y and test Y.

Then, I give names to all the columns of *bigX*, this change after, but I do that for select the columns which are standard deviation and mean, using the function **contains**.

Later, I change *bigY* that has numeric representation to string representation, for made it more readable. 

Then I create change the variable *features_names*, I left only the names which have "mean()" or "std()", I remove the '-' and the parenthesis, I replace *t* to *time*, *acc* to *acceleration*, and *f* to *frequency* (this information are given in the file **features_info.txt**) and change *std* to *standard deviation* and, last, I change all to lowercase 

With the variable *features_names* I change the column names of *bigX*

Later, I create a factor variable called *activities*, that is useful for group the dataset by activities, with the grouped dataset stored in *by_activity* I calculate the means for all variables. 

I wrote two csv, the big dataset(only with the columns that appear the mean or standard deviation) and the means of that dataset grouped by activities 



