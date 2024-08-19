# 📊 Projeto de Análise de Dados de Criminalidade em São Paulo

## 🔗 Links Importantes

- Acesse o dashboard interativo 📈 [aqui](https://lookerstudio.google.com/s/l64WWBY7tQM).
- Consulte os códigos SQL 🎲 [aqui](https://github.com/hianaracamilla/Analise_Base_Crimes_SP/blob/main/Consultas_SQL.sql).

## 📸 Visão Geral do Dashboard

![Print do Dashboard](https://github.com/user-attachments/assets/61bb6c20-45fd-41a5-894b-f0c29c1ff2a2)

## 📝 Descrição do Projeto

Este projeto foi desenvolvido utilizando **BigQuery**, **SQL Avançado** e **Looker Studio** para analisar dados de crimes ocorridos na cidade de São Paulo. O objetivo foi criar um painel interativo que apresenta insights relevantes sobre a criminalidade na cidade.

## 🔍 Análise Exploratória

Durante a análise exploratória, foram respondidas as seguintes perguntas através de consultas SQL:

### 🕵️‍♂️ Quais crimes existem na base de dados?
Os crimes identificados incluem:
- Furtos na região
- Roubo de carga
- Roubos
- Roubo de veículos
- Roubo a banco
- Furto de veículo
- Latrocínios
- Homicídio doloso por acidente de trânsito
- Homicídio culposo por acidente de trânsito
- Homicídio culposo
- Tentativa de homicídio
- Lesão corporal seguida de morte
- Lesão corporal dolosa
- Lesão corporal culposa por acidente de trânsito
- Lesão corporal culposa
- Estupro
- Estupro de vulnerável

### 🗂️ Como os crimes foram categorizados?
Os crimes foram classificados em:

- **Categorias de Crimes**:
  - **Contra o Patrimônio**: Furtos na região, Roubo de carga, Roubos, Roubo de veículos, Furto de veículo, Roubo a banco
  - **Contra a Integridade Física**: Lesão corporal seguida de morte, Lesão corporal dolosa, Lesão corporal culposa
  - **Crimes de Trânsito**: Lesão corporal culposa por acidente de trânsito, Homicídio doloso por acidente de trânsito, Homicídio culposo por acidente de trânsito
  - **Crimes Sexuais**: Estupro, Estupro de vulnerável
  - **Contra a Vida**: Homicídio culposo, Tentativa de homicídio, Latrocínio

- **Tipos de Crimes**:
  - Contra o Patrimônio (Patrimônio)
  - Contra a Pessoa (Integridade Física, Trânsito, Sexuais, Vida)

### 📈 Quantos crimes foram cometidos por ano? E no total?
- **2019**: 453.331 crimes
- **2020**: 361.377 crimes
- **Total**: 814.708 crimes

### 🏢 Quantas delegacias existem?
Há um total de 119 delegacias na base de dados.

### 🚨 Alguma delegacia não registrou crimes?
Sim, algumas delegacias não registraram crimes nos anos analisados:
- 2019: 20 delegacias
- 2020: 21 delegacias

### ⚖️ Há homicídios dolosos?
Identificamos a fonte de dados no site da SSP. Esta informação pode ser cruzada em análises futuras.

### 📊 Houve crimes que aumentaram de um ano para o outro?
Sim, alguns crimes aumentaram de 2019 para 2020, incluindo:
- Latrocínio
- Lesão corporal seguida de morte
- Roubo a banco
- Homicídio doloso por acidente de trânsito

## 🎯 Conclusão

Houve uma redução de **20,28%** no registro de ocorrências entre os anos 2019 e 2020:
![image](https://github.com/user-attachments/assets/b439365e-4b79-4bdb-960f-43129779608a)

- Redução de **20,54%** em crimes contra o patrimônio
  ![image](https://github.com/user-attachments/assets/43a3cc12-4b61-4db8-9928-85f494becc6b)

- Redução de **18,25%** em crimes contra a pessoa
  ![image](https://github.com/user-attachments/assets/3171d42d-34f9-48eb-a994-23a873117881)

Essa redução pode ter sido influenciada pelo início da pandemia e as políticas de isolamento social, mas é necessário mais dados para confirmar essa hipótese.

### Estatísticas Gerais dos Crimes Registrados:
- **88,88%** são crimes contra o patrimônio
- **7,12%** são crimes contra a integridade física
- **3,06%** são crimes no trânsito
- **0,61%** são crimes sexuais
- **0,33%** são crimes contra a vida

### Crimes Mais Registrados:
- Furtos na região
- Roubos
- Furto de veículo
- Lesão corporal dolosa
- Roubo de veículos

  ![image](https://github.com/user-attachments/assets/7628d2da-37bc-489d-b5c9-0ea23442e59c)


## ✍️ Autor

**Hianara Camilla**
