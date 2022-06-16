create table Ingredient
(
    IngredientNo   int identity
        primary key,
    IngredientName varchar(20)   not null,
    Stock          int default 0 not null
)
go

