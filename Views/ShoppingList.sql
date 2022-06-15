-- View: Lista de Compras para 10 pratos
CREATE VIEW ShoppingList AS
SELECT pid.IngredientNo, i.IngredientName, p.ProductName, (pid.Quantity*10)-i.Stock AS needed
FROM dbo.MenuProductDetail
         INNER JOIN dbo.Menu AS m
                    ON MenuProductDetail.MenuNo = m.MenuNo
         INNER JOIN dbo.Product AS p
                    ON p.ProductNo = MenuProductDetail.ProductNo
         INNER JOIN dbo.ProductIngredientDetail AS pid
                    On p.ProductNo = pid.ProductNo
         INNER JOIN dbo.Ingredient AS i
                    On pid.IngredientNo = i.IngredientNo
         INNER JOIN dbo.WeekDay AS w
                    ON w.DayNo = m.DayNo
WHERE m.Active = 1
  AND w.Day = DATENAME(weekday, GETDATE() + 1) -- dia amanha