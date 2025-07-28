library(haven)
library(tidyverse)
library(rstatix)
library(ggpubr)
library(datarium)
library(skimr)
library(janitor)
library(coin)
library(jmv)
library(scatr)
library(ggplot2)

# import danych

dataset <- read_sav("dataset.sav")
View(dataset)

# wybranie kolumn danych z datasetu

cc <- dataset |>
  select(id = case_ID,
         gender,
         age,
         worry) |>
  na.omit()

refused_num <- sum(cc$worry == -1, na.rm = TRUE)

# usuwamy respondentów z worry "-1", poniewaz oni odmowili odpowiedzi na pytanie

cc <- cc |>
  filter(worry != -1)

# zmiana kolumny gender na faktor

cc$gender <- factor(cc$gender, labels = c("male", "female"))

# sprawdzamy czy zmienna zalezna "worry" ma rozklad zblizony do normalnego

ggboxplot(cc, x = "gender", y = "worry") # rozklady nie spelniaja tego zalozenia dla testu t, skorzystamy z nieparametrycznego

# test U Manna-Whitneya

test <- wilcox.test(worry ~ gender, data = cc)

# wielkość siły eff

test_eff <- wilcox_effsize(worry ~ gender, data = cc)

# statystyki opisowe

cc |>
  group_by(gender) |>
  get_summary_stats(worry, type = "median_iqr")

# tabelka

jmv::ttestIS(
  formula = worry ~ gender,
  data = cc,
  vars = worry,
  welchs = TRUE,
  mann = TRUE,
  desc = TRUE
  )


# ------------- KORELACJA F/M, DLA WIEKU I GLOBALNEGO OCIEPLENIA ------------------------


# ciecie danych do korelacji

cor_cc <- cc |>
  select(case_ID = id,
         gender,
         age,
         worry) |>
  na.omit()

cor_cc$gender <- factor(cor_cc$gender, labels = c("male", "female"))

# statystyki opisowe 

cor_cc |> 
  get_summary_stats(type = "mean_sd")

# korelacja związku 

women <- filter(cor_cc, gender == "female")
women_cor_results <- cor.test(women$age, women$worry, method = "spearman")


men <- filter(cor_cc, gender == "male")
men_cor_results <- cor.test(men$age, men$worry, method = "spearman")

corrMatrix(women, vars = vars(age, worry), pearson = FALSE, spearman = TRUE,
           kendall = FALSE, sig = TRUE, flag = FALSE, n = FALSE,
           ci = FALSE, ciWidth = 95, plots = FALSE, plotDens = FALSE,
           plotStats = FALSE, hypothesis = "corr")
corrMatrix(men, vars = vars(age, worry), pearson = FALSE, spearman = TRUE,
           kendall = FALSE, sig = TRUE, flag = FALSE, n = FALSE,
           ci = FALSE, ciWidth = 95, plots = FALSE, plotDens = FALSE,
           plotStats = FALSE, hypothesis = "corr")

# tabelka z wynikami testu korelacji

wynik_mal <- data.frame(
  estimate = men_cor_results$estimate,
  p.value = men_cor_results$p.value, 
  statistic = women_cor_results$statistic
  )

wynik_fem <- data.frame(
  estimate = women_cor_results$estimate,
  p.value = women_cor_results$p.value,
  statistic = women_cor_results$statistic
  )


scatr::scat(
  data = women,
  x = "worry",
  y = "age",
  marg = "dens",
  line = "linear")

scatr::scat(
  data = men,
  x = "worry",
  y = "age",
  marg = "dens",
  line = "linear")

