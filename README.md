DatSciTrain_bushfire_specific_pm25_for_locations_2019
==============

**Cassandra Yuen and Ivan Hanigan**

This repository contains training material for the CARDAT hackyhour *Bushfire Smoke V1.3 PM2.5 data and coding with generative AI*, introducing the Bushfire Smoke PM2.5 V1.3 dataset with a sample subset and demonstrating code development with the aid of generative AI.

## Setup

### Install R and RStudio

You will need to install and download R and RStudio to run the code. Instructions are available at https://cardat.github.io/DatSciTrain_set_up_R_and_friends/, as well as a recommended layout for the RStudio interface.

### Download the code and associated data

Download this repository by clicking the green **\<\> Code** button at the top of [this GitHub repository](https://github.com/cardat/DatSciTrain_bushfire_specific_pm25_for_locations_2019) file listing, then select **Download ZIP**. Extract the contents of the downloaded ZIP to your desired location.

(If you are familiar with Git, you can clone this repository instead.)

Bushfire Smoke PM~2.5~ data will be made available to hackyhour participants via Cloud CARDAT. Please add these files to the `data_provided/` directory alongside the `location_crds.csv` file. Note that **the Bushfire Smoke PM~2.5~ data are provided for training purposes only, and may not be on-shared or used for any other purpose*</span>** beyond this hackyhour.

### Installing required `R` packages

1.  Open the `DatSciTrain_bushfire_specific_pm25_for_locations_2019.Rproj` project file in RStudio, then open `main.R`.
2.  If prompted by RStudio, install the required R packages. Alternatively you can install them with the `install.packages` function (e.g. `install.packages("terra")`) in the RStudio console.

### Set up access to a generative AI

For this workshop, code development with generative AI will be demonstrated using Claude. To access Claude, go to the [website](https://claude.ai/) and create an account - a Personal, Free tier account is sufficient. 

Also check if you have institutional access to a generative AI (e.g. Microsoft Copilot). You may use this to compare and contrast responses from different generative AIs.

## Running the code

You can step through the code line-by-line in RStudio by clicking the "Run" button at the top-right of the code (Source) panel, or using the `Ctrl + Enter` shortcut.

## Data sources

**PM2.5 estimates, STL decomposition and selected flags** subset from [Bushfire Smoke PM2.5 V1.3 dataset](https://doi.org/10.17605/OSF.IO/WQK4T). The development and use of this dataset is detailed in the paper:

> Borchers-Arriagada, N., Morgan, G.G., Van Buskirk, J., Gopi, K., Yuen, C., Johnston, F.H., Guo, Y., Cope, M. and Hanigan, I.C. (2024) ‘Daily PM2.5 and Seasonal-Trend Decomposition to Identify Extreme Air Pollution Events from 2001 to 2020 for Continental Australia Using a Random Forest Model’, *Atmosphere*, *15*(1341). Available at: <https://doi.org/10.3390/atmos15111341>.

Access to this dataset may be requested via the [CARDAT](https://cardat.github.io/) access request form.

**Study location coordinates** derived from [ABS Urban Centres and Localities, 2016](https://www.abs.gov.au/AUSSTATS/abs@.nsf/productsbyCatalogue/7B4A59ACBBB57DC9CA257A980013D3E9?OpenDocument)
