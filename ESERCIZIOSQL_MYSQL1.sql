USE AdventureWorksDW;
SELECT * FROM dimproduct;
SELECT
ProductKey,
ProductAlternateKey AS AltKey,
EnglishProductName AS ProdName,
Color,
StandardCost,
FinishedGoodsFlag AS FGFlag
FROM dimproduct;
#riscrivo tutta la query di prima aggiungendo l'esercizio numero 4 anche se si potrebbe aggiungere il filtro dopo anche se già effettuata l'esecuzione
SELECT
ProductKey,
ProductAlternateKey AS AltKey,
EnglishProductName AS ProdName,
Color,
StandardCost,
CASE
WHEN FinishedGoodsFlag = 1 THEN 'Sì'
ELSE 'No'
END AS FGFlag
FROM dimproduct
WHERE FinishedGoodsFlag = 1;
SELECT 
    ProductKey,
    ProductAlternateKey AS AltKey,
    EnglishProductName AS ProdName,
    StandardCost,
    ListPrice
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';
SELECT 
    ProductKey,
    ProductAlternateKey AS AltKey,
    EnglishProductName AS ProdName,
    StandardCost,
    ListPrice,
    (ListPrice - StandardCost) AS Markup
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';
SELECT 
    ProductKey,
    ProductAlternateKey AS AltKey,
    EnglishProductName AS ProdName,
    StandardCost,
    ListPrice
FROM dimproduct
WHERE FinishedGoodsFlag = 1
  AND ListPrice BETWEEN 1000 AND 2000;
  
  SELECT * FROM dimemployee;
  SELECT
    EmployeeKey,
    FirstName AS Name,
    LastName AS Surname,
    SalespersonFlag AS Agent
FROM dimemployee
WHERE SalespersonFlag = 1;
SELECT
    SalesOrderNumber,
    ProductKey,
    OrderDate,
    SalesAmount,
    TotalProductCost,
    (SalesAmount - TotalProductCost) AS Profit
FROM FactResellerSales
WHERE OrderDate >= '2020-01-01'
  AND ProductKey IN (597, 598, 477, 214);


  