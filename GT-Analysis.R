library(tidyverse)
library(meta)
library(gt)
library(gtsummary)
library(rio)
library(ggthemes)
library(plotly)
library(ggalt)
library(jmv)
library(ggpubr)

# ----- Settings

options(digits = 2)

data <- readxl::read_xlsx(file.choose())

# ---- Creating different data frames for table creations -------

df1 <- data |> group_by(Idade, Sexo)  |> 
  summarise(mean = mean(FC_Rep), sd = sd(FC_Rep), n = n())

df2 <- data |>  group_by(Idade, Sexo) |> 
  summarise(mean = mean(FC_Final), sd = sd(FC_Final), n = n())

df3 <- data |>  group_by(Idade, Sexo) |>  
  summarise(mean = mean(Delta), sd = sd(Delta), n = n())

df4 <- data |>  group_by(Idade, Sexo) |>  
  summarise(mean = mean(FC_1), sd = sd(FC_1), n = n())

df5 <- data |>  group_by(Idade, Sexo) |>  
  summarise(mean = mean(FC_2), sd = sd(FC_2), n = n())

df6 <- df6 <- data |> group_by(Idade, Sexo) |> 
  summarise(mean = mean(FC1), sd = sd(FC1), n = n())

df7 <- df7 <- data |>  group_by(Idade, Sexo)  |>
  summarise(mean = mean(FC2), sd = sd(FC2), n = n())

# ---- gt table ------------------

tb1 <- gt(df1, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Caracterização da frequência cardíaca de repouso por idade**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb1

tb2 <- gt(df2, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Caracterização da frequência cardíaca final por idade**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb2

tb3 <- gt(df3, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Caracterização do aumento da frequencia cardíaca por idade**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb3

tb4 <- gt(df4, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Caracterização da frequência cardíaca de recuperação no primeiro minuto por idade**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb4

tb5 <- gt(df5, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Caracterização da frequência cardíaca de recuperação no segundo minuto por idade**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb5

tb6 <- gt(df6, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Diferença entre a frequência cardíaca final e de recuperação no primeiro minuto**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb6

tb7 <- gt(df7, auto_align = F, groupname_col = "Idade (anos)") |>  
  tab_header(title = md("**Diferença entre a frequência cardíaca final e de recuperação no segundo minuto**")) %>% 
  cols_label(
    Idade = md("**Idade**"),
    Sexo = md("**Sexo**"),
    mean = md("**Média (bpm)**"),
    sd = md("**DP**"),
    n = md("**N**")
  ) |>  
  tab_footnote(
    footnote = "F: Feminino; M: Masculino; DP: Desvio-Padrão; N: Número de participantes"
  )

tb7