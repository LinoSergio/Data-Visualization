# graphical analysis for six-minute walk test brazil (TC6minBrasil)

## Loading required packages

pacman::p_load(tidyverse, gt, gtsummary, ggalt, ggpubr, readxl)
options(digits = 2)

## Importing the dataset

data <- read_excel('TC6_df.xlsx')

# ---- gtsummary tables ----------------

data |>  
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

data |> 
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
  modify_footnote(label = "MW: Midwest; N: North, NE: North East; S: South; SE: Southest; BMC: Body mass index; HR: Heart Rate") |> 
  modify_header(label = "**Variables**", stat_1 = "**MW** \n N = 111") |>
  modify_column_alignment( align = 'center') |> 
  add_p(all_continuous() ~ "aov")

## Graphs with statistical analysis

### Creating the comparisons among brazilian regions
my_comparisons <- list(c("MW", "N"), c("MW","NE"), c("MW","S"), c("MW", "SE"),
                       c("N", "NE"), c("N", "S"), c( "N", "SE"),
                       c("NE", "S"), c("NE", "SE"),
                       c("S", "SE"))

### Recoding the dataset

data2 <- data |> 
  mutate(Region = recode(Regiao, "CE" = "MW"))

### Creating Boxplot graphs

ggplot(data2, aes(x= Region, y = FC1, fill = Region)) +
  geom_point(alpha = .5) +
  geom_boxplot() +
  stat_compare_means(method = "anova", label.y = 300, aes(label = paste0("p", after_stat(p.format)))) +
  stat_compare_means(label = "p.signif", comparisons = my_comparisons, show.legend = TRUE) +
  theme_classic() +
  scale_fill_brewer(palette = "Greys") +
  labs(
    title = "First minute heart rate recovery through brazilian regions",
    x = "Brazilian region",
    y = "First minute heart rate (bpm)",
    fill = "Region") +
  theme(plot.title = element_text(face = "bold"),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"))

ggplot(data2, aes(x= Region, y = FC2, fill = Region)) +
  geom_point(alpha = .5) +
  geom_boxplot() +
  stat_compare_means(method = "anova", label.y = 300, aes(label = paste0("p", after_stat(p.format)))) +
  stat_compare_means(label = "p.signif", comparisons = my_comparisons, show.legend = ) +
  theme_classic() +
  scale_fill_brewer(palette = "Greys") +
  labs(
    title = "Second minute heart rate recovery through brazilian regions",
    x = "Brazilian region",
    y = "Second minute heart rate recovery (bpm)",
    fill = "Region") +
  theme(plot.title = element_text(face = "bold"),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"))

### Scaterplot with regression line showing the association among different heart rate domains

ggplot(data = data, aes(x = Distancia, y = FC_Final)) +
  geom_point(alpha = .5) +
  stat_smooth(method = "lm", formula = y ~ x, geom = "smooth", color = "black") +
  labs(
    title = "Final heart rate vs. Distance covered in six minute walk test distance",
    x = "Distance (m)",
    y = "Final Heart Rate (bpm)") +
  theme_bw() + theme(plot.title = element_text(face = "bold"),
                     axis.title.x = element_text(face = "bold"),
                     axis.title.y = element_text(face = "bold"))


ggplot(data = data, aes(x = Distancia, y = FC1)) +
  geom_point(alpha = .5) +
  stat_smooth(method = "lm", formula = y ~ x, geom = "smooth", color = "black") +
  labs(
    title = "Final heart rate vs. Distance covered in six minute walk test distance",
    x = "Distance (m)",
    y = "Final Heart Rate (bpm)") +
  theme_bw() + theme(plot.title = element_text(face = "bold"),
                     axis.title.x = element_text(face = "bold"),
                     axis.title.y = element_text(face = "bold"))


ggplot(data = data, aes(x = Distancia, y = FC2)) +
  geom_point(alpha = .5) +
  stat_smooth(method = "lm", formula = y ~ x, geom = "smooth", color = "black") +
  labs(
    title = "Final heart rate vs. Distance covered in six minute walk test distance",
    x = "Distance (m)",
    y = "Final Heart Rate (bpm)") +
  theme_bw() + theme(plot.title = element_text(face = "bold"),
                     axis.title.x = element_text(face = "bold"),
                     axis.title.y = element_text(face = "bold"))
