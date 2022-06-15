CREATE DATABASE MichelinStar

USE MichelinStar

CREATE TYPE QuantityType FROM INT
CREATE TYPE PriceType FROM DECIMAL(5, 2)
CREATE TYPE IVAType FROM DECIMAL(3, 2)
CREATE TYPE NIFType FROM NUMERIC(9, 0)

CREATE TABLE Employee
(
    EmployeeNo      INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    EmployeeCode    AS CONCAT('E', FORMAT(EmployeeNo, '00')),
    EmployeeName    VARCHAR(50)                     NOT NULL,
    TotalOrdersMade INT DEFAULT 0                   NOT NULL
)

INSERT INTO Employee (EmployeeName, TotalOrdersMade)
VALUES ('Carla Santos', DEFAULT),
       (N'Pedro Miguel', DEFAULT),
       (N'Andre Silva', DEFAULT)

CREATE TABLE Ingredient
(
    IngredientNo   INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    IngredientName VARCHAR(20)                     NOT NULL,
    Stock          INT DEFAULT 0                   NOT NULL
)

INSERT INTO Ingredient
VALUES ('Cenoura', 5),
       ('Repolho', 2),
       ('Batata', 10),
       ('Alho', 2),
       ('Piri-Piri', 8),
       ('Maionese', 4),
       ('Salsa', 2),
       ('Rissoes', 4),
       (N'Camarão', 4)

CREATE TABLE Market
(
    MarketNo     INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    MarketCode   AS CONCAT(LEFT(MarketName, 1), FORMAT(MarketNo, '00')),
    MarketName   VARCHAR(20)                     NOT NULL,
    AddressLine1 VARCHAR(20),
    AddressLine2 VARCHAR(20),
    PostalCode   VARCHAR(9),
    City         VARCHAR(10),
    Phone        INT
)

INSERT INTO Market (MarketName, AddressLine1, PostalCode, City, Phone)
VALUES (N'Talho São Jorge', 'Rua da Junqueira', '4610-812', 'Felgueiras', 936258147),
       (N'Mercado dos Leões', 'Campo 24 Agosto', '4610-814', 'Felgueiras', 963852741),
       ('Mercadinhos Adriano', 'Senhor da Liberdade', '4650-116', 'Felgueiras', 963214587),
       ('Enchidos da Terra', 'Rua da Nora', '4650-360', 'Felgueiras', 963784512)

CREATE TABLE MarketOrder
(
    OrderNo   INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    OrderCode AS CONCAT('O', FORMAT(MarketNo, '00'), OrderNo),
    MarketNo  INT NOT NULL FOREIGN KEY REFERENCES Market (MarketNo),
)

INSERT INTO MarketOrder (MarketNo)
VALUES (1),
       (2),
       (1)

CREATE TABLE MarketOrderIngredientDetail
(
    OrderNo      INT          NOT NULL FOREIGN KEY REFERENCES MarketOrder (OrderNo),
    IngredientNo INT          NOT NULL FOREIGN KEY REFERENCES Ingredient (IngredientNo),
    Quantity     QuantityType NOT NULL
)

INSERT INTO MarketOrderIngredientDetail (OrderNo, IngredientNo, Quantity)
VALUES (1, 4, 22),
       (2, 5, 13),
       (3, 3, 5)

CREATE TABLE ProductType
(
    ProductTypeNo INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    ProductType   VARCHAR(50)                     NOT NULL
)

INSERT INTO ProductType
VALUES ('Entradas'),
       ('Sopas'),
       ('Pratos de Carne'),
       ('Pratos de Peixe'),
       ('Sobremesas'),
       ('Bebidas')

CREATE TABLE WeekDay
(
    DayNo INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    Day   VARCHAR(50)                     NOT NULL
)

INSERT INTO WeekDay
VALUES ('Monday'),
       ('Sunday'),
       ('Tuesday'),
       ('Wednesday'),
       ('Thursday'),
       ('Friday'),
       ('Saturday')

CREATE TABLE Product
(
    ProductNo   INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    ProductType INT                             NOT NULL FOREIGN KEY REFERENCES ProductType (ProductTypeNo),
    ProductCode AS CONCAT(LEFT(ProductName, 1), ProductType, FORMAT(ProductNo, '00')),
    ProductName VARCHAR(50)                     NOT NULL,
    IVA         IVAType                         NOT NULL,
    UnitPrice   PriceType                       NOT NULL,
)

INSERT INTO Product (ProductType, ProductName, IVA, UnitPrice)
VALUES (1, N'Rissoes de Camarão', 0.13, 4.99),
       (1, N'Presunto com melão', 0.13, 6.70),
       (2, 'Sopa de Pedra', 0.13, 8),
       (2, 'Canja', 0.13, 7.70),
       (3, 'Picanha', 0.13, 12),
       (3, 'Lombinho', 0.13, 10),
       (6, 'Coca-Cola', 0.23, 1.20),
       (4, 'Lagosta', 0.23, 15),
       (4, 'Arroz de Marisco', 0.23, 12)

CREATE TABLE Menu
(
    MenuNo   INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    MenuName VARCHAR(50),
    DayNo    INT                             NOT NULL FOREIGN KEY REFERENCES WeekDay (DayNo),
    Active   BIT                             NOT NULL,
)

INSERT INTO Menu (DayNo, MenuName, Active)
VALUES (1, N'Segunda há Bife à Cova', 1),
       (2, NULL, 1),
       (3, NULL, 1),
       (4, NULL, 1),
       (5, 'De Sexta pra Sabado', 1),
       (6, N'Ao sábado é dia de marisco', 1),
       (7, 'Jantares Especiais', 1)

CREATE TABLE MenuProductDetail
(
    MenuNo    INT NOT NULL FOREIGN KEY REFERENCES Menu (MenuNo),
    ProductNo INT NOT NULL FOREIGN KEY REFERENCES Product (ProductNo),
)

INSERT INTO MenuProductDetail
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6)

CREATE TABLE ProductIngredientDetail
(
    ProductNo    INT          NOT NULL FOREIGN KEY REFERENCES Product (ProductNo),
    IngredientNo INT          NOT NULL FOREIGN KEY REFERENCES Ingredient (IngredientNo),
    Quantity     QuantityType NOT NULL
)

INSERT INTO ProductIngredientDetail
VALUES (1, 2, 4),
       (1, 4, 4)

CREATE TABLE PaymentMethod
(
    PaymentMethodNo INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    Method          VARCHAR(20)                     NOT NULL,
)

INSERT INTO PaymentMethod
VALUES ('Cash'),
       ('Master Card'),
       ('Visa'),
       ('MbWay')

CREATE TABLE TableOrder
(
    OrderNo       INT PRIMARY KEY IDENTITY (1, 1) NOT NULL,
    OrderCode     AS CONCAT([OrderTable], [EmployeeNo], [OrderNo]),
    OrderTable    INT                             NOT NULL,
    EmployeeNo    INT                             NOT NULL
        REFERENCES Employee,
    NIF           NIFType   DEFAULT 999999999     NOT NULL,
    Observation   VARCHAR(100),
    PaymentMethod INT       DEFAULT 1             NOT NULL
        REFERENCES PaymentMethod,
    CreatedAt     DATETIME  DEFAULT getdate()     NOT NULL,
    Total         PriceType DEFAULT 0,
    TotalWithIva  PriceType DEFAULT 0
)

INSERT INTO TableOrder (OrderTable, EmployeeNo, NIF, Observation, PaymentMethod, CreatedAt)
VALUES (4, 2, DEFAULT, 'Bife Bem Passado', DEFAULT, DEFAULT),
       (3, 2, DEFAULT, '+ Ovo Cozido', DEFAULT, DEFAULT),
       (5, 1, DEFAULT, NULL, DEFAULT, DEFAULT),
       (8, 1, DEFAULT, NULL, DEFAULT, DEFAULT),
       (10, 2, DEFAULT, NULL, DEFAULT, DEFAULT),
       (9, 1, DEFAULT, NULL, DEFAULT, DEFAULT)

CREATE TABLE TableOrderProductDetail
(
    OrderNo   INT          NOT NULL FOREIGN KEY REFERENCES TableOrder (OrderNo),
    ProductNo INT          NOT NULL FOREIGN KEY REFERENCES Product (ProductNo),
    Quantity  QuantityType NOT NULL
)

INSERT INTO TableOrderProductDetail
VALUES (1, 5, 1.5),
       (2, 4, 1),
       (3, 1, 1),
       (3, 2, 1),
       (4, 5, 1),
       (4, 5, 0.5),
       (5, 6, 1),
       (5, 8, 1),
       (6, 5, 1),
       (6, 7, 0.5)




