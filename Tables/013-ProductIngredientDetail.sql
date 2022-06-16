create table ProductIngredientDetail
(
    ProductNo    int          not null
        references Product,
    IngredientNo int          not null
        references Ingredient,
    Quantity     QuantityType not null
)
go

