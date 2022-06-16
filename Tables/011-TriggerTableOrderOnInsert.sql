CREATE TRIGGER dbo.TriggerTableOrderOnInsert
    ON dbo.TableOrder
    AFTER INSERT AS
    DECLARE
        @EmployeeNo INT
BEGIN
    SELECT TOP 1 @EmployeeNo = t.EmployeeNo
    FROM dbo.TableOrder AS t
    ORDER BY t.OrderNo DESC;

    UPDATE dbo.Employee
    SET TotalOrdersMade = TotalOrdersMade + 1
    WHERE EmployeeNo = @EmployeeNo;
END
go

