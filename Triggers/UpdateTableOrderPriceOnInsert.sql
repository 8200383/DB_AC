CREATE TRIGGER dbo.UpdateTableOrderPriceOnInsert
    ON dbo.TableOrder
    AFTER INSERT AS
    DECLARE
        @OrderNo INT
    DECLARE
        @Transaction TABLE
                     (
                         Total           PriceType,
                         TotalWithoutIVA PriceType
                     )
BEGIN
    SELECT TOP 1 @OrderNo = t.OrderNo
    FROM dbo.TableOrder AS t
    ORDER BY t.OrderNo DESC;

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