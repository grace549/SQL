#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory).
USE AdventureWorksDW;
SELECT
    p.ProductKey,
    p.EnglishProductName AS ProdName,
    p.Color,
    p.Size,
    p.ListPrice,
    ps.EnglishProductSubcategoryName AS ProdSubName
FROM dimproduct p
INNER JOIN dimproductsubcategory ps
    ON p.productsubcategorykey = ps.productsubcategorykey;
    
    #Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory).
    SELECT
    p.ProductKey AS ProdKey,
    p.EnglishProductName AS ProdName,
    p.Color,
    p.Size,
    p.ListPrice,
    ps.EnglishProductSubcategoryName AS SubcategoryName,
    pc.EnglishProductCategoryName AS CategoryName
FROM dimproduct p
INNER JOIN dimproductsubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN dimproductcategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey;

#Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales). 

SELECT DISTINCT
    p.ProductKey,
    p.EnglishProductName,
	p.ListPrice
FROM dimproduct p
INNER JOIN factresellersales frs
    ON p.ProductKey = frs.ProductKey;

    #Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1.
    SELECT
    p.ProductKey,
    p.EnglishProductName,
    p.Color,
    p.Size,
    p.ListPrice
FROM dimproduct p
LEFT JOIN factresellersales frs
    ON p.ProductKey = frs.ProductKey
WHERE p.FinishedGoodsFlag = 1
  AND frs.ProductKey IS NULL;
#Esponi lʼelenco delle transazioni di vendita FactResellerSales) indicando anche il nome del prodotto venduto DimProduct)
SELECT
    frs.SalesOrderNumber,
    p.EnglishProductName,
    frs.OrderQuantity,
    frs.SalesAmount
FROM factresellersales frs
INNER JOIN dimproduct p
    ON frs.ProductKey = p.ProductKey;
    # Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
    SELECT
    frs.SalesOrderNumber,
    p.EnglishProductName,
    frs.OrderQuantity,
    frs.SalesAmount,
    pc.EnglishProductCategoryName AS CategoryName
FROM factresellersales frs
INNER JOIN dimproduct p
    ON frs.ProductKey = p.ProductKey
INNER JOIN dimproductsubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN dimproductcategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey;

#Esplora la tabella DimReseller
DESCRIBE dimreseller;
#Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 
SELECT
    r.ResellerKey,
    r.ResellerName,
    g.City,
    g.StateProvinceName
FROM dimreseller r
LEFT JOIN dimgeography g
    ON r.GeographyKey = g.GeographyKey;
    
 #   Esponi l'elenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrder Number, SalesOrderLineNumber, OrderDate, UnitPrice,Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e l'area geografica.
 SELECT
    frs.SalesOrderNumber,
    frs.SalesOrderLineNumber,
    d.DateKey AS Orderdate,
    frs.UnitPrice,
    frs.OrderQuantity AS Quantity,
    frs.TotalProductCost,
    p.EnglishProductName AS ProductName,
    pc.EnglishProductCategoryName AS CategoryName,
    r.ResellerName,
    g.City,
    g.StateProvinceName
FROM factresellersales frs
INNER JOIN dimproduct p
    ON frs.ProductKey = p.ProductKey
INNER JOIN dimproductsubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
INNER JOIN dimproductcategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
INNER JOIN dimreseller r
    ON frs.ResellerKey = r.ResellerKey
INNER JOIN dimgeography g
    ON r.GeographyKey = g.GeographyKey
INNER JOIN dimdate d
    ON d.DateKey = d.DateKey;

 
