create table MarketOrderIngredientDetail
(
    OrderNo      int          not null
        references MarketOrder,
    IngredientNo int          not null
        references Ingredient,
    Quantity     QuantityType not null
)
go

