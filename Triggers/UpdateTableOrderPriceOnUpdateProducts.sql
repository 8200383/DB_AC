CREATE TRIGGER dbo.UpdateTableOrderPriceOnUpdateProducts
    ON dbo.TableOrderProductDetail
    AFTER UPDATE AS
    DECLARE
        @OrderNo INT
    DECLARE
        @Transaction TABLE
                     (
                         Total           PriceType,
                         TotalWithoutIVA PriceType
                     )
BEGIN
    SET NOCOUNT ON

    SELECT @OrderNo = inserted.OrderNo FROM inserted

    INSERT INTO @Transaction
    SELECT ((p.IVA * p.UnitPrice) + p.UnitPrice) * op.Quantity, -- Total com IVA
           p.UnitPrice * op.Quantity                            -- Total sem IVA
    FROM dbo.TableOrderProductDetail AS op
             INNER JOIN Product AS p
                        ON p.ProductNo = op.ProductNo
    WHERE op.OrderNo = @OrderNo

    UPDATE dbo.TableOrder
    SET TotalWithoutIVA = (SELECT SUM(t.TotalWithoutIVA) FROM @Transaction AS t),
        Total           = (SELECT SUM(t.Total) FROM @Transaction AS t)
    WHERE OrderNo = @OrderNo;
END