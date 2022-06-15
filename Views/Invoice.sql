CREATE VIEW Invoices AS
SELECT tb.OrderNo
FROM dbo.TableOrderProductDetail AS tb
    INNER JOIN dbo.Product AS p
    ON tb.ProductNo = p.ProductNo
group by tb.OrderNo