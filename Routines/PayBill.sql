CREATE PROCEDURE PayBill @TableOrderCode VARCHAR(36), @NIF NIFType, @PaymentMethod INT, @ReceivedAmount PriceType AS

DECLARE @UnpaidAmount PriceType;

SELECT @UnpaidAmount = T.Total
FROM TableOrder AS t
WHERE t.OrderCode = @TableOrderCode;

    IF ((SELECT COUNT(*)
         FROM PaymentMethod AS m
         WHERE m.PaymentMethodNo = @PaymentMethod) = 0)
        BEGIN
            RAISERROR (N'O metodo de pagamento é inexistente!', 16, 1)
        END;

DECLARE @Change PriceType;
    SET @Change = null;

    IF (@PaymentMethod = 1 OR @PaymentMethod = 4) AND (@ReceivedAmount < @UnpaidAmount)
        BEGIN
            RAISERROR (N'O valor é inferior ao valor da conta!', 16, 1)
        END;
    ELSE
        BEGIN
            SELECT @Change = @ReceivedAmount - t.Total
            FROM dbo.TableOrder AS t
            WHERE t.OrderCode = @TableOrderCode
        END;

    IF (ISNULL(@NIF, 0) = 0)
        BEGIN
            SET @NIF = 999999999
        END;

UPDATE dbo.TableOrder
SET IsPaid        = 1,
    NIF           = @NIF,
    PaymentMethod = @PaymentMethod,
    CashReceived  = @ReceivedAmount,
    CashGiven     = @Change
WHERE OrderCode = @TableOrderCode