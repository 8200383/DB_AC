-- View: Dias dos meses em que foi servido um prato de peixe e de carne
CREATE VIEW MeatFishDishesByMonth AS
SELECT PEIXE.OrderNo, PEIXE.OrderTable, PEIXE.CreatedAt
FROM (SELECT o.OrderNo, o.OrderTable, o.CreatedAt
      FROM dbo.TableOrder AS o
               INNER JOIN TableOrderProductDetail AS op
                          ON op.OrderNo = o.OrderNo
               INNER JOIN Product AS p
                          ON op.ProductNo = p.ProductNo
      WHERE p.ProductType = 3) AS CARNE,
     (SELECT o.OrderNo, o.OrderTable, o.CreatedAt
      FROM dbo.TableOrder AS o
               INNER JOIN TableOrderProductDetail AS op
                          ON op.OrderNo = o.OrderNo
               INNER JOIN Product AS p
                          ON op.ProductNo = p.ProductNo
      WHERE p.ProductType = 4) AS PEIXE
WHERE PEIXE.OrderTable = CARNE.OrderTable
  AND PEIXE.OrderNo = CARNE.OrderNo