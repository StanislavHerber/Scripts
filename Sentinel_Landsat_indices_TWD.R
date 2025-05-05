# Load necessary packages
library(ggplot2)
library(ggcorrplot)
library(readr)
library(readxl)
library(ggpubr)
library(dplyr)
library(tidyr)
library(corrplot)
library(Hmisc)

# Input data - combined table of TWD and vegetation indices from Sentinel and Landsat
Indices_TWD <- read_xlsx("E:/Mendelu/Finland_2025/Czechglobe_TWD/Indices_TWD_combined.xlsx", sheet = "Data")

# remove NA values from the data - make the calculations faster - for now not necessary
complete_rows <- complete.cases(Indices_TWD)
complete_data_frame <- Indices_TWD[complete_rows, , drop = FALSE]
print(complete_data_frame)

#----------------------------------------------------------------------------
# Lets try to plot only Sentinel indices
# filter dataset to be only plot_ID 13 - NDVI index
#----------------------------------------------------------------------------

# filter dataset to be only plot_ID 13
data_13 <- complete_data_frame %>%
  filter(plot_ID == 13)

data_13_sentinel <- data_13 %>%
  filter(sensor == 'Sentinel')

data_13_sentinel <- data_13_sentinel %>%
  mutate(NDVI = as.numeric(NDVI),
         NDWI = as.numeric(NDWI),
         MSI = as.numeric(MSI),
         NDRE = as.numeric(NDRE),
         EVI = as.numeric(EVI),
         GNDVI = as.numeric(GNDVI),
         SAVI = as.numeric(SAVI),
         OSAVI = as.numeric(OSAVI),
         TWD = as.numeric(TWD))

#----------------------------------------------------------------------------
# plot_ID 13 - NDVI index plot
#----------------------------------------------------------------------------

data_13_sentinel_ndvi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = NDVI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("NDVI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only NDVI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - NDWI index plot
#----------------------------------------------------------------------------

data_13_sentinel_ndwi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = NDWI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("NDWI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only NDWI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - NSI index plot
#----------------------------------------------------------------------------

data_13_sentinel_msi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = MSI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("MSI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of MSI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - NDRE index plot
#----------------------------------------------------------------------------

data_13_sentinel_ndre <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = NDRE, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("NDRE" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only NDRE and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - EVI index plot
#----------------------------------------------------------------------------

data_13_sentinel_evi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = EVI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("EVI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only EVI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - GNDVI index plot
#----------------------------------------------------------------------------

data_13_sentinel_gndvi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = GNDVI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("GNDVI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only GNDVI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - SAVI index plot
#----------------------------------------------------------------------------

data_13_sentinel_savi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = SAVI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("SAVI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only SAVI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# plot_ID 13 - OSAVI index plot
#----------------------------------------------------------------------------

data_13_sentinel_osavi <- ggplot(data = data_13_sentinel, aes(x = date)) +
  geom_line(aes(y = OSAVI, color = sensor, group = sensor),
            alpha = 0.8, linewidth = 0.8) +
  geom_line(aes(y = TWD, color = "TWD"),
            linewidth = 0.8) +
  scale_color_manual(name = "Sensor",
                     values = c("Sentinel" = "red",
                                "Landsat" = "dodgerblue",
                                "TWD" = "#1e8714")) +
  scale_linetype_manual(name = "Variable",
                        values = c("OSAVI" = "solid",
                                   "TWD" = "dashed")) +
  labs(title = "Time Series of Sentinel-only OSAVI and TWD - Plot ID 13",
       x = "Date",
       y = "Value") +
  theme_light() +
  theme(legend.position = "bottom",
        legend.box = "vertical",
        legend.margin = margin(),
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10, face = "bold"))

#----------------------------------------------------------------------------
# compare all indices
#----------------------------------------------------------------------------

print(data_13_sentinel_ndvi)
print(data_13_sentinel_ndwi)
print(data_13_sentinel_msi)
print(data_13_sentinel_ndre)
print(data_13_sentinel_evi)
print(data_13_sentinel_gndvi)
print(data_13_sentinel_savi)
print(data_13_sentinel_osavi)

# display them all together (Arrange in a 2x2 grid)
ggarrange(data_13_sentinel_ndvi, data_13_sentinel_ndwi, data_13_sentinel_msi, data_13_sentinel_evi, nrow = 2, ncol = 2)
ggarrange(data_13_sentinel_ndre, data_13_sentinel_gndvi, data_13_sentinel_savi, data_13_sentinel_osavi, nrow = 2, ncol = 2)

#----------------------------------------------------------------------------
# Statistics of indices and TWD
#----------------------------------------------------------------------------

data_13_numeric <- data_13 %>%
  mutate(NDVI = as.numeric(NDVI),
         NDWI = as.numeric(NDWI),
         MSI = as.numeric(MSI),
         NDRE = as.numeric(NDRE),
         EVI = as.numeric(EVI),
         GNDVI = as.numeric(GNDVI),
         SAVI = as.numeric(SAVI),
         OSAVI = as.numeric(OSAVI),
         TWD = as.numeric(TWD))

# Calculate Pearson's correlation coefficient between NDVI13 and TWD_13
correlation_ndvi_13 <- cor(data_13_numeric$NDVI, data_13_numeric$TWD, method = "pearson")
correlation_ndwi_13 <- cor(data_13_numeric$NDWI, data_13_numeric$TWD, method = "pearson")
correlation_msi_13 <- cor(data_13_numeric$MSI, data_13_numeric$TWD, method = "pearson")
correlation_ndvi_13 <- cor(data_13_numeric$NDRE, data_13_numeric$TWD, method = "pearson")
correlation_ndvi_13 <- cor(data_13_numeric$EVI, data_13_numeric$TWD, method = "pearson")
correlation_ndvi_13 <- cor(data_13_numeric$GNDVI, data_13_numeric$TWD, method = "pearson")
correlation_ndvi_13 <- cor(data_13_numeric$SAVI, data_13_numeric$TWD, method = "pearson")
correlation_ndvi_13 <- cor(data_13_numeric$OSAVI, data_13_numeric$TWD, method = "pearson")

cat("Pearson's Correlation Coefficient of NDVI and TWD in plot 13:", correlation_ndvi_13, "\n")
cat("Pearson's Correlation Coefficient of NDWI and TWD in plot 13:", correlation_ndwi_13, "\n")
cat("Pearson's Correlation Coefficient of MSI and TWD in plot 13:", correlation_msi_13, "\n")
cat("Pearson's Correlation Coefficient of NDRE and TWD in plot 13:", correlation_ndre_13, "\n")
cat("Pearson's Correlation Coefficient of EVI and TWD in plot 13:", correlation_evi_13, "\n")
cat("Pearson's Correlation Coefficient of GNDVI and TWD in plot 13:", correlation_gndvi_13, "\n")
cat("Pearson's Correlation Coefficient of SAVI and TWD in plot 13:", correlation_savi_13, "\n")
cat("Pearson's Correlation Coefficient of OSAVI and TWD in plot 13:", correlation_osavi_13, "\n")


#----------------------------------------------------------------------------
# Perform linear regression of TWD_13 on NDVI13
#----------------------------------------------------------------------------

linear_model13 <- lm(TWD ~ NDVI, data = data_13)

# Print the summary of the linear regression model
print(summary(linear_model13))

# Calculate the correlation coefficient
correlation_coefficient <- cor(data_13$NDVI, data_13$TWD, use = "complete.obs") # important to handle NAs
correlation_text <- paste("Correlation = ", round(correlation_coefficient, 4))

#----------------------------------------------------------------------------
# Create the scatterplot with regression line and correlation coefficient
#----------------------------------------------------------------------------

scatter13_ndvi = ggplot(data_13, aes(x = NDVI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between NDVI and TWD - plot 13",
    x = "NDVI",
    y = "TWD"
  ) +
  theme_minimal() +
  # Add the correlation coefficient as text on the plot
  annotate(
    "text",
    x = max(data_13$NDVI), # Position the text.  Adjust as needed.
    y = max(data_13$TWD), # Position the text. Adjust as needed
    label = correlation_text,
    hjust = 1, #right justification
    vjust = 1, #top justification
    color = "black",
    size = 4
  )

scatter13_ndwi = ggplot(data_13, aes(x = NDVI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between NDWI and TWD - plot 13",
    x = "NDWI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$NDWI), 
    y = max(data_13$TWD), 
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

scatter13_msi = ggplot(data_13, aes(x = MSI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between MSI and TWD - plot 13",
    x = "MSI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$MSI), 
    y = max(data_13$TWD), 
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

scatter13_ndre = ggplot(data_13, aes(x = NDRE, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between NDRE and TWD - plot 13",
    x = "NDVI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$NDRE), 
    y = max(data_13$TWD), 
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

scatter13_evi = ggplot(data_13, aes(x = EVI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between EVI and TWD - plot 13",
    x = "NDVI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$EVI), 
    y = max(data_13$TWD), 
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

scatter13_gndvi = ggplot(data_13, aes(x = GNDVI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between GNDVI and TWD - plot 13",
    x = "NDVI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$GNDVI), 
    y = max(data_13$TWD),
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

scatter13_savi = ggplot(data_13, aes(x = SAVI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between SAVI and TWD - plot 13",
    x = "SAVI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$SAVI), 
    y = max(data_13$TWD), 
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

scatter13_osavi = ggplot(data_13, aes(x = OSAVI, y = TWD)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Relationship between OSAVI and TWD - plot 13",
    x = "OSAVI",
    y = "TWD"
  ) +
  theme_minimal() +
  annotate(
    "text",
    x = max(data_13$OSAVI), 
    y = max(data_13$TWD), 
    label = correlation_text,
    hjust = 1, 
    vjust = 1, 
    color = "black",
    size = 4
  )

ggarrange(data_13_sentinel_ndvi, data_13_sentinel_ndwi, data_13_sentinel_msi, data_13_sentinel_ndre, nrow = 2, ncol = 2)
ggarrange(data_13_sentinel_evi, data_13_sentinel_gndvi, data_13_sentinel_savi, data_13_sentinel_osavi, nrow = 2, ncol = 2)

#----------------------------------------------------------------------------
# to easily evalute index usability - ggcorrplot
#----------------------------------------------------------------------------

# Calculate the correlation matrix and the p-value matrix
corr_matrix <- rcorr(as.matrix(data_13_numeric[, c("NDVI", "NDWI", "MSI", "NDRE", "EVI", "GNDVI", "SAVI", "OSAVI", "TWD")]))

# Extract the correlation coefficients
corr <- round(corr_matrix$r, 2)

# Extract the p-values
p_mat <- corr_matrix$P

ggcorrplot(corr,
           hc.order = TRUE,
           type = "lower",
           lab = TRUE)
