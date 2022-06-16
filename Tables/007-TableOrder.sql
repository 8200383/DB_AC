create table TableOrder
(
    OrderNo       int identity
        primary key,
    OrderCode     as concat([OrderTable], [EmployeeNo], [OrderNo]),
    OrderTable    int                        not null,
    EmployeeNo    int                        not null
        references Employee,
    NIF           NIFType  default 999999999 not null,
    Observation   varchar(100),
    PaymentMethod int      default 1         not null
        references PaymentMethod,
    CreatedAt     datetime default getdate() not null,
    Total           PriceType default NULL,
    TotalWithoutIVA PriceType default NULL
)
go

