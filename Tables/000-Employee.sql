use MichelinStar
go

create table Employee
(
    EmployeeNo      int identity
        primary key,
    EmployeeCode    as concat('E', format([EmployeeNo], '00')),
    EmployeeName    varchar(50)   not null,
    TotalOrdersMade int default 0 not null
)
go

