create table MarketOrder
(
    OrderNo      int identity
        primary key,
    OrderCode    as concat('O', format([MarketNo], '00'), [OrderNo]),
    MarketNo     int not null
        references Market,
    PurchaseDate date default getdate()
)
go

