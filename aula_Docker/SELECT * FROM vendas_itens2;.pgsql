SELECT * FROM vendas_itens2;


----------------      Vendas Totais   --------------------------------------------------------
SELECT  
    venda_id,                                       --numeric converter um valor ou string para o tipo NUMERIC
    ROUND(SUM(quantidade * valor_unitario)::numeric,2 ) AS total_vendas,      -- round conversao para duas casas decimais
    data_venda
FROM
    vendas_itens2
GROUP BY 
    venda_id,
    data_venda
ORDER BY
    venda_id;

---------------- Media total das vendas ----------------------------------------------------------

SELECT 
   ROUND(AVG(total_vendas)::numeric, 3) AS media_total_vendas
FROM
   (
    SELECT
       venda_id,
       ROUND(SUM(quantidade * valor_unitario)::numeric,2 ) AS total_vendas -- A AVG() função retorna o valor médio de uma coluna numérica.
    FROM 
        vendas_itens2
    GROUP BY
        venda_id
    ) AS vendas_totais;


-------------------  Venda com valor Mínimo e Venda com valor Máximo --------------------------------------

SELECT 
    venda_id,
    total_vendas
FROM
    (
    SELECT
       venda_id,
       ROUND(SUM(quantidade * valor_unitario)::numeric,2 ) AS total_vendas -- A AVG() função retorna o valor médio de uma coluna numérica.
    FROM 
        vendas_itens2
    GROUP BY
        venda_id
    ) AS vendas_totais
WHERE 
    total_vendas = (
        SELECT 
            MIN(total_vendas)
        FROM 
            (
            SELECT
                venda_id,
                SUM(quantidade * valor_unitario) AS total_vendas
            FROM
                vendas_itens2
            GROUP BY
                 venda_id
            ) AS menor_venda
    );



---------------- CTE _ Compra mínima ----------------------------------------

WITH vendasTotais AS (
    ------  Calcular total de cada venda, por id
    SELECT
       venda_id,
       ROUND(SUM(quantidade * valor_unitario)::numeric,2 ) AS total_vendas -- A AVG() função retorna o valor médio de uma coluna numérica.
    FROM 
        vendas_itens2
    GROUP BY
        venda_id
)

SELECT 
    venda_id,
    total_vendas
FROM
    vendasTotais
WHERE 
    total_vendas = (
        SELECT 
            MIN(total_vendas)
        FROM 
            vendasTotais
    ); 