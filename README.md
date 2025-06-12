DatSciTrain_bushfire_specific_pm25_for_locations_2019
==============

**Cassandra Yuen and Ivan Hanigan**

This repository contains training material for the CARDAT hackyhour *Bushfire Smoke V1.3 PM2.5 data and coding with generative AI*, introducing the Bushfire Smoke PM2.5 V1.3 dataset with a sample subset and demonstrating the coding with the aid of generative AI.

## Setup

### Install R and RStudio

You will need to install and download R and RStudio to run the code. Instructions are available at https://cardat.github.io/DatSciTrain_set_up_R_and_friends/, as well as a recommended layout for RStudio.

### Download the code and associated data

Download this repository by clicking the green **<> Code** button at the top of [this GitHub repository](https://github.com/cardat/DatSciTrain_GenAI_coding_bushfire_pm25) file listing, then select **Download ZIP**. Extract the contents of the downloaded ZIP to your desired location.

(If you are familiar with Git, you can clone this repository instead.)

Bushfire Smoke PM2.5 data will be made available to hackyhour participants. Please add these files to the `data_provided/` directory.


### Running the code

1. Open the `DatSciTrain_bushfire_specific_pm25_for_locations_2019.Rproj` project file in RStudio, then open `main.R`.
2. If prompted by RStudio, install the required R packages. Alternatively you can install them by running `install.packages("terra")` in the RStudio console.
3. You can step through the code line-by-line with the `Ctrl + Enter` shortcut.


## Data sources

- PM2.5 estimates, STL decomposition and selected flags subset from [Bushfire Smoke PM2.5 V1.3 dataset](https://doi.org/10.17605/OSF.IO/WQK4T)
- Study location coordinates derived from [ABS Urban Centres and Localities, 2016](https://www.abs.gov.au/AUSSTATS/abs@.nsf/productsbyCatalogue/7B4A59ACBBB57DC9CA257A980013D3E9?OpenDocument)
