# Loading required packages

pacman::p_load(tidyverse, rio, gt, gtsummary, ggthemes, ggalt, ggpubr, readxl)

# Importing the data frame

df <- read_excel("TC6_df.xlsx")

#----gt summary------

df |>  
  select(Idade, Sexo, Altura, Peso, IMC, Borg_Final, SpO2_Rep, Delta, Distancia) |>  
  tbl_summary(by= Sexo, 
              statistic = all_continuous() ~ "{mean} ({sd})",
              missing = "no",
              label = list(Idade ~ "Age",
                           Altura ~ "Height",
                           Peso ~ "Weight",
                           IMC ~ "BMC",
                           Borg_Final ~ "Borg - RPE (Final)",
                           SpO2_Rep ~ "SpO2 (Rest)",
                           Delta ~ "HR (Difference)",
                           Distancia ~ "Distance (m)")) |> 
  modify_footnote(label = "F: Female; M: Male; BMC: Body mass index; RPE: Rate of percieved exercion, HR: Heart Rate") %>% 
  modify_header(label = "**Variables**")

df |>  
  select(Sexo, Altura, Peso, IMC, Distancia, FC_Final, Delta, FC1, FC2, Regiao) |>  
  tbl_summary(by = Regiao,
              statistic = all_continuous() ~ "{mean} ({sd})",
              missing = "no",
              label = list(
                Sexo ~ "Sex",
                Altura ~ "Heigth",
                Peso ~ "Weight",
                IMC ~ "BMC",
                Distancia ~ "Distance (m)",
                FC_Final ~ "Final HR",
                Delta ~ "HR (Difference)",
                FC1 ~ "HR recovery (first minute)",
                FC2 ~ "HR recovery (second minute)"
              )) |>  
  modify_footnote(label = "MW: Midwest; N: North, NE: North East; S: South; SE: Southest; BMC: Body mass index; HR: Heart Rate") %>% 
  modify_header(label = "**Variables**", stat_1 = "**MW**, N = 111") |>  
  add_p(all_continuous() ~ "aov")

df |> 
  select(Sexo, Idade, Regiao, FC1r) |> 
  tbl_summary(by = Regiao,
              statistic = all_continuous() ~ "{mean} ({sd})",
              missing = "no",
              label = list(
                Sexo ~ "Sex",
                Regiao ~ "Region",
                Idade ~ "Age",
                FC1r ~ "HR Drop (first minute)"
              )) |>  
  modify_footnote(label = "MW: Midwest; N: North, NE: North East; S: South; SE: Southest; HR: Heart Rate. HR drop values are presented in %.") %>% 
  modify_header(label = "**Variables**", stat_1 = "**MW**, N = 111") |>  
  add_p(all_continuous() ~ "aov")
