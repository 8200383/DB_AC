create table Product
(
    ProductNo   int identity
        primary key,
    ProductType int         not null
        references ProductType,
    ProductCode as concat(left([ProductName], 1), [ProductType], format([ProductNo], '00')),
    ProductName varchar(50) not null,
    IVA         IVAType     not null,
    UnitPrice   PriceType   not null,
    HalfPrice   PriceType
)
go

