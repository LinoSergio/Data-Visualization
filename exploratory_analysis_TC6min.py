import pandas as pd
import numpy as np

df = pd.read_excel("TC6min.xlsx")
df.head(10)

# Summary description of the dataset

df.info()
df.describe()

# Summary statistics using Profile report

from ydata_profiling import ProfileReport

ProfileReport(df, title = 'TC6min Profle Report')

# Data Visualization

import seaborn as sns
import matplotlib.pyplot as plt

sns.kdeplot(data=df, x='Distancia', hue='Sexo', fill=True, alpha=.5)
plt.title('Densidade da distância percorrida por sexo')
plt.ylabel('Densidade')
plt.xlabel('Distância (m)')

ax = sns.barplot(df, x='Regiao', y='Distancia', ci=False, palette= "GnBu")

sns.scatterplot(x = 'Distancia', y = 'Delta', hue = 'Sexo', data = df)
plt.title('Distância percorrida vs. Freqência Cardíaca Final')
plt.ylabel('Freqência cardíaca Final (bpm)')
plt.xlabel('Distância (m)')

sns.lmplot(data=df, x='Distancia', y='Delta', hue='Sexo', palette='deep')
plt.title('Distância percorrida vs. Freqência Cardíaca de Reserva')
plt.ylabel('Freqência cardíaca de reserva (bpm)')
plt.xlabel('Distância (m)')

# Gráficos em boxplot

sns.boxplot(data=df, x='Regiao', y='Distancia', palette='GnBu')
sns.set_style('ticks')
plt.title('Distância percorrida por região brasileira')
plt.ylabel('Distância (m)')
plt.xlabel('Região brasileira')

sns.boxplot(data=df, x='Idade', y='Distancia', palette='GnBu')
sns.set_style('ticks')
plt.title('Distância percorrida por região Idade')
plt.ylabel('Distância (m)')
plt.xlabel('Idade (anos)')

# Gráfico em barra
sns.catplot(data=df, x='Regiao', y='Distancia', hue='Sexo', kind='bar',
            errorbar= 'sd', palette='Paired')
plt.title('Distância percorrida por região brasileira por sexo')
plt.ylabel('Distância (m)')
plt.xlabel('Região brasileira')

# heatmap

corr = df[['Distancia', 'Altura','IMC', 'Peso', 'Delta', 'FC_Final']].corr()

sns.heatmap(data=corr, cmap='Blues', annot= True)
plt.title('Gráfico de correlação entre varáveis do TC6min', weight='bold')

# Plotnine Grammar of graphics

from plotnine import *

(
ggplot(df, aes(x='Distancia', y='Delta', color = 'Sexo'))
+ geom_point()
+ geom_smooth()
+ theme_bw()
+ labs(title='Distancia Percorrida vs. Variação da Frequência Cardíaca por Sexo',
       x = 'Distancia (m)',
       y = 'Variação da Frequencia cardíaca (bpm)')
)