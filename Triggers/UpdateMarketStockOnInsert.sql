-- Update stock when MarketOrder is inserted
CREATE TRIGGER dbo.TriggerUpdateMarketStockOnInsert
    ON dbo.MarketOrder
    AFTER INSERT AS
    DECLARE
        @Ingredients INT,
        @Quantity    INT
BEGIN
    SELECT TOP 1 @Ingredients = mid.IngredientNo, @Quantity = mid.Quantity
    FROM dbo.MarketOrder AS mo
             INNER JOIN dbo.MarketOrderIngredientDetail AS mid
                        ON mid.OrderNo = mo.OrderNo
    ORDER BY mo.OrderNo DESC;

    UPDATE dbo.Ingredient
    SET Stock = Stock + @Quantity
    WHERE IngredientNo = @Ingredients;
END