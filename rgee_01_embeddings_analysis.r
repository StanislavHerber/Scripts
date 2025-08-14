# Script to use new Satellite Embedding V1 dataset from Google Earth Engine
# Author: Stanislav Herber
# Date: 2024-08-14

import ee

# Section 1: Set up environment
remotes::install_github("r-spatial/rgee")
# install.packages("rgee")
ee_Initialize()

print("Google Earth Engine initialized successfully.")