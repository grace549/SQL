#Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
#Quali considerazioni/ragionamenti è necessario che tu faccia? 
#Utilizzando il comando DESCRIBE e dando il lancio mi fornisce tutti i dettagli della tabella e quindi anche della chiave primaria. Con ciò capisco che effettivamente PorductKey è la chiave primaria della tabella DimProduct.

USE AdventureWorksDW; 
DESCRIBE dimproduct;

#Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK

SELECT 
    COLUMN_NAME
FROM 
    information_schema.KEY_COLUMN_USAGE
WHERE 
    TABLE_NAME = 'factresellersales'
    AND TABLE_SCHEMA = 'AdventureWorksDW'
    AND CONSTRAINT_NAME = 'PRIMARY';

SELECT 
    OrderDate,
    COUNT(salesorderlinenumber) AS NumeroTransazioni
FROM 
    factresellersales
WHERE 
    OrderDate >= '2020-01-01'
GROUP BY 
    OrderDate
ORDER BY 
    OrderDate;

SELECT
    p.englishproductname AS NomeProdotto,
    SUM(f.salesamount) AS FatturatoTotale,
    SUM(f.orderquantity) AS QuantitaTotaleVenduta,
    AVG(f.unitprice) AS PrezzoMedioVendita
FROM
   factresellersales AS f
JOIN
    dimproduct AS p
    ON f.productkey = p.productkey
WHERE
    f.orderdate >= '2020-01-01'
GROUP BY
    p.englishproductname
ORDER BY
    p.englishproductname;

SELECT
    c.englishproductcategoryname AS CategoriaProdotto,
    SUM(f.salesamount) AS FatturatoTotale,
    SUM(f.orderquantity) AS QuantitaTotaleVenduta
FROM
    factresellersales AS f
JOIN
    dimproduct AS p ON f.productkey = p.productkey
JOIN
    dimproductsubcategory AS s ON p.productsubcategorykey = s.productsubcategorykey
JOIN
    dimproductcategory AS c ON s.productcategorykey = c.productcategorykey
GROUP BY
    c.englishproductcategoryname
ORDER BY
    CategoriaProdotto;
    
SELECT
    g.city AS Citta,
    SUM(f.SalesAmount) AS FatturatoTotale
FROM
    factresellersales AS f
JOIN
    dimgeography AS g ON f.salesterritorykey = g.salesterritorykey
WHERE
    f.orderdate >= '2020-01-01'
GROUP BY
    g.city
HAVING
    SUM(f.salesamount) > 60000
ORDER BY
    FatturatoTotale DESC;






