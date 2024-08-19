-- ANALISE EXPORATÓRIA

-- QUAIS CRIMES EXITEM NA BASE DE DADOS? 
---- RESPOSTA (Delegacia, Furtos na região, Roubo de carga, Roubos, Roubo de Veiculo,Furto de veiculo,Latrocinios,Homicídio doloso por acidente de trânsito,
---- Homicídio Culposo por Acidente de Trânsito,Homicídio Culposo,Tentativa de Homicídio,Lesão Corporal seguida de morte,Lesão Corporal Dolosa,
---- Lesão Corporal Culposa por acidente de trânsito,Lesão Corporal Culposa, Estupro,Estupro de vulnerável,Roubo de veiculos,Roubo a Banco,Ano)

-- É POSSIVEL CATEGORIZÁ-LOS? 
---- RESPOSTA Sim, categorizei em Categorias de Crimes, e Tipos de Crimes

-- QUANTOS CRIMES FORAM COMETIDOS POR ANO? E NO TOTAL? 
---- RESPOSTA (2019 - 453331, 2020 - 361377 - TOTAL 814708)

-- TEMOS QUANTAS DELEGACIAS? 
---- RESPOSTA 219

-- ALGUMA DELEGACIA NÃO REGISTROU CRIMES? 
---- RESPOSTA: SIM (20, 21)

-- HÁ HOMICIDIOS DOLOSOS?
----- RESPOSTA: LOCALIZEI A FONTE DE DADOS SITE SSP, POSSO CRUZAR EM OUTRO MOMENTO

-- HA CRIMES QUE AUMENTARAM DE UM ANO PARA O OUTRO? 
---- RESPOSTA SIM (latrocinio, lesao_coporal_seg_morte,roubo_banco, homicidio_doloso_transito)







-- VISUALIZAR OS DADOS
SELECT *
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`;
-- RESULTDOS: ALGUNS ESTÃO COM O FORMATO INCORRETO.


-- TRATAMENTO DOS DADOS
CREATE OR REPLACE TABLE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP` AS
SELECT 
    CAST(`Ano` AS STRING) AS ano
    , Delegacia AS delegacia
    , CAST(REPLACE(CAST(`Furtos na região` AS STRING), ".", "") AS INT64) AS furtos_na_regiao
    , `Roubo de carga` AS roubo_de_carga
    , CAST(REPLACE(CAST(`Roubos` AS STRING), ".", "")  AS INT64) AS roubos
    , (CAST(REPLACE(CAST(`Roubo de veiculos` AS STRING), ".", "")  AS INT64) + `Roubo de Veiculo`) AS roubo_de_veiculos
    , CAST(REPLACE(CAST(`Furto de veiculo` AS STRING), ".", "")  AS INT64) AS furto_de_veiculo
    , Latrocinios AS latrocinio
    , `Homicídio doloso por acidente de trânsito` AS homicidio_doloso_transito
    , `Homicídio Culposo por acidente de Trânsito` AS homicidio_culposo_transito
    , `Homicídio Culposo` AS homicidio_culposo
    , `Tentativa de Homicídio` AS tentativa_de_homicidio
    , `Lesão Corporal seguida de morte` AS lesao_coporal_seg_morte
    , `Lesão Corporal Dolosa` AS lesao_corporal_dolosa
    , `Lesão Corporal Culposa por acidente de trânsito` AS lesao_corporal_culposa_transito
    , `Lesão Corporal Culposa` AS lesao_corporal_culposa
    , `Estupro` AS estupro
    , `Estupro de vulnerável` AS estupro_de_vulneravel
    , `Roubo a Banco ` AS roubo_banco
FROM 
    `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
ORDER BY delegacia;


-- INCLUIR UMA COLUNA COM O TOTAL DE CRIMES
CREATE OR REPLACE TABLE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP` AS
SELECT 
    ano
    , delegacia
    , SUM(furtos_na_regiao +
    roubo_de_carga +
    roubos +
    furto_de_veiculo +
    latrocinio +
    homicidio_doloso_transito +
    homicidio_culposo_transito +
    homicidio_culposo +
    tentativa_de_homicidio +
    lesao_coporal_seg_morte +
    lesao_corporal_dolosa +
    lesao_corporal_culposa_transito +
    lesao_corporal_culposa +
    estupro +
    estupro_de_vulneravel + 
    roubo_de_veiculos +
    roubo_banco) AS total_crimes
    , furtos_na_regiao
    , roubo_de_carga
    , roubos
    , furto_de_veiculo
    , latrocinio
    , homicidio_doloso_transito
    , homicidio_culposo_transito
    , homicidio_culposo
    , tentativa_de_homicidio
    , lesao_coporal_seg_morte
    , lesao_corporal_dolosa
    , lesao_corporal_culposa_transito
    , lesao_corporal_culposa
    , estupro
    , estupro_de_vulneravel 
    , roubo_de_veiculos
    , roubo_banco
FROM 
    `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano, delegacia, furtos_na_regiao,roubo_de_carga,roubos
,furto_de_veiculo,latrocinio,homicidio_doloso_transito,homicidio_culposo_transito
,homicidio_culposo,tentativa_de_homicidio,lesao_coporal_seg_morte,lesao_corporal_dolosa
,lesao_corporal_culposa_transito,lesao_corporal_culposa,estupro,estupro_de_vulneravel 
,roubo_de_veiculos,roubo_banco
ORDER BY delegacia;


-- CONTAR QUANTOS OCORRENCIAS HOUVERAM POR ANO
SELECT ano, SUM(total_crimes)
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano;
-- CONTAR QUANTOS OCORRENCIAS HOUVERAM NO TOTAL
SELECT SUM(total_crimes)
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`;
-- CONTAR QUANTAS DELEGACIAS EXISTEM E SE ALGUMA NÃO POSSUI CRIME
SELECT ano, COUNT(delegacia) AS `total de delegacias`,
COUNT(CASE WHEN total_crimes = 0 THEN 1 END) AS `delegacias inativas`
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano;


-- CRIAR ENDEREÇO SÃO PAULO PARA CRIAR GRAFICOS GEOGRAFICOS
CREATE OR REPLACE TABLE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP` AS
WITH tabela_criminalidade AS (
    SELECT * 
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`)
SELECT
    CASE
        WHEN REGEXP_CONTAINS(delegacia, r'DP - ') THEN
            CONCAT(SUBSTR(delegacia, INSTR(delegacia, 'DP - ') + 5), ', São Paulo, SP, Brasil')
        ELSE
            NULL
    END AS endereco,
    *
FROM tabela_criminalidade

-- AJUSTAR ENDEREÇOS INCORRETOS
UPDATE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
SET endereco = CASE
    WHEN delegacia = '102 DP - Socorro' THEN 'Av. Atlântica, 1171 - Socorro, São Paulo - SP, 04768-200'
    WHEN delegacia = '096 DP - Monções' THEN 'Av. Engenheiro Luís Carlos Berrini, 900 - Itaim Bibi, São Paulo - SP, 04571-000'
    WHEN delegacia = '4ª DDM - 4ª Seccional - Norte'THEN 'Av. Itaberaba, 731 - fundos, São Paulo - SP, 02734-000'
    ELSE endereco
END
WHERE delegacia IN ('102 DP - Socorro', '096 DP - Monções');


--- CRIAR NOVA TABELA COM CRIMES POR LINHA PARA FACILITAR A VISUALIZAÇÃO DE DADOS
CREATE OR REPLACE TABLE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO` AS
WITH Crimes_Resumidos AS (
    SELECT
        ano,
        'furtos_na_regiao' AS crime,
        SUM(furtos_na_regiao) AS total_crime,
        MAX(furtos_na_regiao) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY furtos_na_regiao DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY furtos_na_regiao DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
    GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'roubo_de_carga' AS crime,
        SUM(roubo_de_carga) AS total_crime,
        MAX(roubo_de_carga) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubo_de_carga DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubo_de_carga DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'roubos' AS crime,
        SUM(roubos) AS total_crime,
        MAX(roubos) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubos DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubos DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'furto_de_veiculo' AS crime,
        SUM(furto_de_veiculo) AS total_crime,
        MAX(furto_de_veiculo) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY furto_de_veiculo DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY furto_de_veiculo DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'latrocinio' AS crime,
        SUM(latrocinio) AS total_crime,
        MAX(latrocinio) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY latrocinio DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY latrocinio DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'homicidio_doloso_transito' AS crime,
        SUM(homicidio_doloso_transito) AS total_crime,
        MAX(homicidio_doloso_transito) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY homicidio_doloso_transito DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY homicidio_doloso_transito DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'homicidio_culposo_transito' AS crime,
        SUM(homicidio_culposo_transito) AS total_crime,
        MAX(homicidio_culposo_transito) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY homicidio_culposo_transito DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY homicidio_culposo_transito DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'homicidio_culposo' AS crime,
        SUM(homicidio_culposo) AS total_crime,
        MAX(homicidio_culposo) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY homicidio_culposo DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY homicidio_culposo DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'tentativa_de_homicidio' AS crime,
        SUM(tentativa_de_homicidio) AS total_crime,
        MAX(tentativa_de_homicidio) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY tentativa_de_homicidio DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY tentativa_de_homicidio DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'lesao_coporal_seg_morte' AS crime,
        SUM(lesao_coporal_seg_morte) AS total_crime,
        MAX(lesao_coporal_seg_morte) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_coporal_seg_morte DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_coporal_seg_morte DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'lesao_corporal_dolosa' AS crime,
        SUM(lesao_corporal_dolosa) AS total_crime,
        MAX(lesao_corporal_dolosa) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_corporal_dolosa DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_corporal_dolosa DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'lesao_corporal_culposa_transito' AS crime,
        SUM(lesao_corporal_culposa_transito) AS total_crime,
        MAX(lesao_corporal_culposa_transito) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_corporal_culposa_transito DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_corporal_culposa_transito DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'lesao_corporal_culposa' AS crime,
        SUM(lesao_corporal_culposa) AS total_crime,
        MAX(lesao_corporal_culposa) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_corporal_culposa DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY lesao_corporal_culposa DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'estupro' AS crime,
        SUM(estupro) AS total_crime,
        MAX(estupro) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY estupro DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY estupro DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'estupro_de_vulneravel' AS crime,
        SUM(estupro_de_vulneravel) AS total_crime,
        MAX(estupro_de_vulneravel) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY estupro_de_vulneravel DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY estupro_de_vulneravel DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'roubo_de_veiculos' AS crime,
        SUM(roubo_de_veiculos) AS total_crime,
        MAX(roubo_de_veiculos) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubo_de_veiculos DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubo_de_veiculos DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano

    UNION ALL

    SELECT
        ano,
        'roubo_banco' AS crime,
        SUM(roubo_banco) AS total_crime,
        MAX(roubo_banco) AS maximo,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubo_banco DESC LIMIT 1)[SAFE_OFFSET(0)].delegacia AS delegacia,
        ARRAY_AGG(STRUCT(delegacia, endereco) ORDER BY roubo_banco DESC LIMIT 1)[SAFE_OFFSET(0)].endereco AS endereco
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP`
GROUP BY ano
)

SELECT
    ano,
    crime,
    total_crime,
    maximo,
    delegacia,
    endereco
FROM Crimes_Resumidos
ORDER BY total_crime DESC;

-- CATEGORIZANDO CRIMES DA TABELA

CREATE OR REPLACE TABLE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO` AS
SELECT
    ano
    , crime
    , CASE
            WHEN crime IN ('furtos_na_regiao', 'roubo_de_carga', 'furto_de_veiculo', 'roubo_banco','roubos', 'roubo_de_veiculos') THEN 'Patrimonio'
            WHEN crime IN ('homicidio_doloso_transito', 'homicidio_culposo_transito', 'lesao_corporal_culposa_transito') THEN 'Transito'
            WHEN crime IN ('lesao_coporal_seg_morte', 'lesao_corporal_dolosa', 'lesao_corporal_culposa') THEN 'Integridade_Fisica'
            WHEN crime IN ('latrocinio', 'homicidio_doloso_transito', 'homicidio_culposo', 'tentativa_de_homicidio') THEN 'Vida'
            WHEN crime IN ('estupro', 'estupro_de_vulneravel') THEN 'Sexual'
            ELSE 'Outros'
        END AS categoria
    , total_crime
    , maximo
    , delegacia
    , endereco
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO`
ORDER BY total_crime DESC ;


-- DIVIDINDO CATEGORIAS DE CRIMES POR "CONTRA O PATRIMONIO" E "CONTRA A PESSOA"
CREATE OR REPLACE TABLE `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO` AS
SELECT
    ano
    , crime
    , categoria
    , CASE
            WHEN categoria IN ('Patrimonio') THEN 'Patrimonio'
            WHEN categoria IN ('Transito', 'Integridade_Fisica', 'Vida', 'Sexual') THEN 'Pessoa'
            ELSE 'Outros'
        END AS contra
    , total_crime
    , maximo
    , delegacia
    , endereco
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO`
ORDER BY total_crime DESC ;


--- HA CRIMES QUEM EM 2020 HOUVERAM MAIS OCORRENCIAS QUE EM 2019?
SELECT crime
FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO` AS t1
WHERE ano = "2020" AND total_crime > (
    SELECT total_crime
    FROM `projeto-pratico-desenvolve.projeto_pratico_desenvolve_3.CRIMINALIDADE_SP_VISUALIZACAO` AS t2
    WHERE ano = "2019" AND t1.crime = t2.crime
);







