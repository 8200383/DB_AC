create table Menu
(
    MenuNo   int identity
        primary key,
    MenuName varchar(50),
    DayNo    int not null
        references WeekDay,
    Active   bit not null
)
go

