--1.Visualizar todos los registros de la tabla productos.
SELECT * FROM Production.Product
go
--2. Ver la estructura de la tabla productos
EXEC sp_help '[Production].[Product]'
GO
--3. Cuantos productos no pertenecen a una subcategoría.
SELECT * FROM Production.Product
WHERE ProductSubcategoryID IS NULL
go
--4. Ver listado de subcategorías de productos
select * from Production.Product where ProductSubcategoryID is not null
go
--5. Visualizar listado de subcategorías con sus respectivas categorías
select ps.Name,pc.Name from Production.ProductSubcategory ps,Production.ProductCategory pc
where ps.ProductCategoryID = pc.ProductCategoryID
go
--6. Visualizar cantidad de productos por cada subcategoría
select count(*) as products,p.ProductSubcategoryID from Production.Product p,Production.ProductSubcategory psc
where psc.ProductSubcategoryID = p.ProductSubcategoryID
group by p.ProductSubcategoryID
go
--7. Ver precio promedio por cada categoría de producto
select pc.Name,AVG(p.ListPrice) from Production.Product p
inner join Production.ProductSubcategory ps on 
ps.ProductSubcategoryID = p.ProductSubcategoryID
inner join Production.ProductCategory pc on 
ps.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
go 
--8. Ver cantidad de productos por categoría
select count(*) as products,psc.ProductCategoryID from Production.Product p,Production.ProductSubcategory psc
where psc.ProductSubcategoryID = p.ProductSubcategoryID
group by psc.ProductCategoryID
go
--9. Ver cantidad de productos sólo de la categoría components
SELECT C.Name AS Categoria,COUNT(P.ProductID) AS CANTIDAD FROM Production.Product P
INNER JOIN Production.ProductSubcategory S 
on S.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN Production.ProductCategory C 
on C.ProductCategoryID = S.ProductCategoryID
WHERE C.Name = 'Components'
GROUP BY C.Name
go
--10. Visualizar el total de ventas por cada categoría de producto
SELECT C.Name, SUM(SA.LineTotal * SA.UnitPrice) as TOTAL FROM Production.Product P
INNER JOIN Sales.SalesOrderDetail SA 
on P.ProductID = SA.ProductID
INNER JOIN Production.ProductSubcategory S 
on S.ProductSubcategoryID = P.ProductSubcategoryID
INNER JOIN Production.ProductCategory C 
on C.ProductCategoryID = S.ProductCategoryID
GROUP BY C.Name
go
--11. Ver la cantidad total de empleados
SELECT COUNT(H.BusinessEntityID) AS TOTAL_EMPLEADOS FROM HumanResources.Employee H
go
--12. Ver la cantidad total de empleados de acuerdo a su estado civil.
SELECT MaritalStatus, COUNT(H.BusinessEntityID) AS ESTADO_CIVIL from HumanResources.Employee H 
GROUP BY MaritalStatus 
go
--13. Ver cantidad de empleados por género
SELECT Gender, COUNT(H.BusinessEntityID) AS Genero from HumanResources.Employee H 
GROUP BY Gender
go
--14. Ver listado de Departamentos
SELECT * from HumanResources.Department
--15. Ver cantidad de empleados por cada departamento
SELECT D.Name AS Departamento,COUNT(E.BusinessEntityID) as Empleados from HumanResources.Employee E
INNER JOIN HumanResources.EmployeeDepartmentHistory H 
on E.BusinessEntityID = H.BusinessEntityID
INNER JOIN HumanResources.Department D 
on D.DepartmentID = H.DepartmentID
GROUP BY D.Name