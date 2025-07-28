# Analysis of Public Concern About Global Warming

This repository contains the data and code for a statistical analysis project on the factors influencing public concern about global warming. The analysis, conducted in R, explores the differences in concern levels between genders and the correlation between age and concern.

This project was completed by Liwia Gajowniczek, Mateusz Van der Linden, and Ignacy Zegar for a statistics course at SWPS University in Warsaw.

## 📂 Files in this Repository

* `analysis.R`: The R script used for data cleaning, performing statistical tests (Mann-Whitney U test, Spearman's correlation), and generating results.
* `dataset.sav`: The raw dataset in SPSS format, containing survey responses.
* `abstract.pdf`: The final project report in Polish, detailing the methodology, findings, and conclusions.

## 🚀 How to Run the Analysis

To reproduce the analysis, you will need R and RStudio.

1.  Clone this repository or download the files.
2.  Open the `analysis.R` script in RStudio.
3.  Install the required R packages by running the following command in the R console:

    ```r
    install.packages(c("haven", "tidyverse", "rstatix", "ggpubr", "janitor"))
    ```
4.  Set the working directory to the folder containing the files and run the script.

## 📈 Key Findings

The analysis found no statistically significant difference in the level of concern about global warming between men and women. However, a weak, negative correlation was found between age and concern, suggesting that older respondents tend to be slightly less worried about global warming.

## 📄 Data Source

The data is from the "Climate Change in the American Mind" survey.

> Yale Program on Climate Change Communication (YPCCC) & George Mason University Center for Climate Change Communication (Mason 4C). (2022). *Climate Change in the American Mind: National survey data on public opinion (2008-2022)*. doi: 10.17605/OSF.IO/JW79P
