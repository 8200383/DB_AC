EXEC SearchDishes @DishType = 1, @StartingDate = '2022/05/30', @EndingDate = '2022/06/27';
EXEC InsertMarketOrder @MarketCode = 'T01', @Ingredient = 'Cenoura', @Quantity = 12;
EXEC PayBill @TableOrderCode = '916', @NIF = NULL, @PaymentMethod = 1, @ReceivedAmount = 20


SELECT m.MarketNo
FROM dbo.Market AS m
WHERE m.MarketCode LIKE 'T01'