create table TableOrder
(
    OrderNo         int identity
        primary key,
    OrderCode       as concat([OrderTable], [EmployeeNo], [OrderNo]),
    OrderTable      int                         not null,
    EmployeeNo      int                         not null
        references Employee,
    NIF             NIFType,
    Observation     varchar(100),
    PaymentMethod   int
        references PaymentMethod,
    CreatedAt       datetime  default getdate() not null,
    Total           PriceType default NULL,
    TotalWithoutIVA PriceType default NULL,
    IsPaid          bit       default 0,
    CashReceived    PriceType default NULL,
    CashGiven       PriceType default NULL
)
go

