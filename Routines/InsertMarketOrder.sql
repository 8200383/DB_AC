CREATE PROCEDURE InsertMarketOrder @MarketCode VARCHAR(10), @Ingredient VARCHAR(10), @Quantity QuantityType AS

DECLARE @MarketNo INT

SELECT @MarketNo = m.MarketNo
FROM dbo.Market AS m
WHERE m.MarketCode LIKE @MarketCode

INSERT INTO dbo.MarketOrder (MarketNo)
VALUES (@MarketNo)

DECLARE @OrderNo INT;

SELECT TOP 1 @OrderNo = m.OrderNo
FROM dbo.MarketOrder AS m
ORDER BY m.MarketNo DESC;

DECLARE @IngredientNo INT;

SELECT @IngredientNo = i.IngredientNo
FROM dbo.Ingredient AS i
WHERE i.IngredientName LIKE '%' + @Ingredient + '%'

INSERT INTO dbo.MarketOrderIngredientDetail (OrderNo, IngredientNo, Quantity)
VALUES (@OrderNo, @IngredientNo, @Quantity)