CREATE TRIGGER dbo.CanUpdateTableOrderProductsOnInsertOrUpdate
    ON dbo.TableOrderProductDetail
    INSTEAD OF INSERT, UPDATE AS
    DECLARE
        @IsPaid BIT
BEGIN
    SELECT @IsPaid = t.IsPaid
    FROM inserted
             INNER JOIN dbo.TableOrder AS t
                        ON t.OrderNo = inserted.OrderNo;

    IF (@IsPaid = 1)
        BEGIN
            RAISERROR (N'Não podes alterar a fatura depois de estar paga!', 16, 1)
            ROLLBACK TRANSACTION
        END
END;
GO;

CREATE TRIGGER dbo.CanUpdateTableOrderOnUpdate
    ON dbo.TableOrder
    INSTEAD OF UPDATE AS
    DECLARE
        @IsPaid BIT
BEGIN
    SELECT @IsPaid = inserted.IsPaid FROM inserted;

    IF (@IsPaid = 1)
        BEGIN
            RAISERROR (N'Não podes alterar a fatura depois de estar paga!', 16, 1)
            ROLLBACK TRANSACTION
        END
END;