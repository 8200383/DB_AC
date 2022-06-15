-- View: Ementa
CREATE VIEW MenuOfTheDay AS
SELECT w.Day, m.MenuName, p.ProductCode, t.ProductType, p.ProductName, p.UnitPrice
FROM dbo.MenuProductDetail AS mp
         INNER JOIN dbo.Menu AS m
                    ON mp.MenuNo = m.MenuNo
         INNER JOIN dbo.Product AS p
                    ON p.ProductNo = mp.ProductNo
         INNER JOIN dbo.ProductType AS t
                    ON p.ProductType = t.ProductTypeNo
         INNER JOIN dbo.WeekDay as w
                    ON w.DayNo = m.DayNo
WHERE m.Active = 1
  AND w.Day = DATENAME(weekday, GETDATE())