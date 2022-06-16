create table TableOrderProductDetail
(
    OrderNo   int          not null
        references TableOrder,
    ProductNo int          not null
        references Product,
    Quantity  QuantityType not null
)
go

