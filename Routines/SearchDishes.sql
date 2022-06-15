-- Procedure: Pratos Servidos num periodo de tempo
CREATE PROCEDURE SearchDishes @DishType int, @StartingDate datetime, @EndingDate datetime AS
SELECT orderdetail.ProductNo, p.ProductName, SUM(orderdetail.Quantity) as Quantity
FROM dbo.TableOrder tableorder
         INNER JOIN dbo.TableOrderProductDetail orderdetail
                    ON tableorder.OrderNo = orderdetail.OrderNo
         INNER JOIN dbo.Product p
                    ON p.ProductNo = orderdetail.ProductNo
WHERE p.ProductType = @DishType                       -- Tipo
  AND CreatedAt between @StartingDate and @EndingDate -- Periodo de tempo
GROUP BY orderdetail.ProductNo, p.ProductName