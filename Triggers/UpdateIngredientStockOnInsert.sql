-- Update stock when TableOrder is inserted
CREATE TRIGGER dbo.TriggerUpdateTableStockOnInsert
    ON dbo.TableOrder
    AFTER INSERT AS
    DECLARE
        @OrderNo INT
BEGIN
    SELECT TOP 1 @OrderNo = t.OrderNo FROM dbo.TableOrder AS t ORDER BY t.OrderNo DESC

    UPDATE dbo.Ingredient
    SET Ingredient.Stock = Ingredient.Stock - t.Quantity
    FROM dbo.Ingredient as i
             INNER JOIN dbo.TableOrderProductDetail AS t
                        ON t.OrderNo = @OrderNo
             INNER JOIN dbo.ProductIngredientDetail as p
                        ON p.ProductNo = t.ProductNo
    WHERE p.IngredientNo = i.IngredientNo
END