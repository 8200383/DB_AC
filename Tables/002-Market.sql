create table Market
(
    MarketNo     int identity
        primary key,
    MarketCode   as concat(left([MarketName], 1), format([MarketNo], '00')),
    MarketName   varchar(20) not null,
    AddressLine1 varchar(20),
    AddressLine2 varchar(20),
    PostalCode   varchar(9),
    City         varchar(10),
    Phone        int
)
go

