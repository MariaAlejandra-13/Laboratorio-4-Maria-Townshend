USE ProductosDB;
GO

INSERT INTO Productos
    (Nombre, Precio, Cantidad, Imagen)
VALUES
    ('Laptop HP', 850.99, 5, NULL),
    ('Mouse Logitech', 35.50, 10, NULL),
    ('Teclado Mecánico', 75.00, 8, NULL);
GO

SELECT *
FROM Productos;
GO