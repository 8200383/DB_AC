create table MenuProductDetail
(
    MenuNo    int not null
        references Menu,
    ProductNo int not null
        references Product
)
go

