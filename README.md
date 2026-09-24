# Universidad Tecnológica de Panamá

# Facultad de Ingeniería de Sistemas Computacionales

## Laboratorio #4 - Aplicación CRUD en C# con SQL Server e Imágenes

### Herramientas de Programación Aplicada III

## Fecha de Ejecución:

15 de septiembre de 2026

---

## Objetivos

- Desarrollar una aplicación de escritorio utilizando C# y Windows Forms.
- Implementar operaciones CRUD para crear, consultar, modificar y eliminar registros.
- Establecer conexión entre una aplicación Windows Forms y una base de datos Microsoft SQL Server.
- Utilizar `SqlConnection`, `SqlCommand` y `SqlDataReader` para acceder a la información almacenada en la base de datos.
- Utilizar programación orientada a objetos mediante una clase `Producto`.
- Implementar un `DataGridView` para mostrar los registros almacenados.
- Permitir la selección y almacenamiento de imágenes asociadas a los productos.
- Utilizar `MemoryStream` para convertir imágenes entre objetos `Image` y arreglos de bytes `byte[]`.
- Implementar búsquedas dinámicas utilizando el evento `TextChanged`.
- Aplicar validaciones mediante `decimal.TryParse()` e `int.TryParse()`.
- Utilizar parámetros SQL para ejecutar operaciones sobre la base de datos.
- Aplicar eventos de Windows Forms como `Load`, `Click`, `CellClick` y `TextChanged`.
- Utilizar estructuras de datos como `List<Producto>` y `Dictionary<string, object>`.

---

## Introducción

En este laboratorio se desarrolló una aplicación de escritorio en C# utilizando Windows Forms y Microsoft SQL Server como sistema de gestión de base de datos.

La aplicación permite administrar productos almacenados en una base de datos. Cada producto contiene un identificador, nombre, precio, cantidad y una imagen asociada.

El sistema implementa las operaciones fundamentales de un CRUD:

- **Create:** agregar nuevos productos.
- **Read:** consultar y visualizar los productos existentes.
- **Update:** modificar la información de un producto.
- **Delete:** eliminar productos almacenados.

Además, la aplicación permite realizar búsquedas dinámicas, seleccionar imágenes desde el equipo, convertirlas a datos binarios para almacenarlas en SQL Server y reconstruir posteriormente esas imágenes para mostrarlas dentro de un `DataGridView`.

Durante el desarrollo también se implementaron validaciones de información, manejo de excepciones, consultas SQL parametrizadas y herramientas de depuración mediante breakpoints.

---

## Requisitos Previos

Para desarrollar y ejecutar este laboratorio se requiere contar con el siguiente entorno:

### Tecnologías utilizadas

- **Lenguaje de programación:** C#
- **Framework:** .NET / Windows Forms
- **Entorno de desarrollo:** Visual Studio Community
- **Base de datos:** Microsoft SQL Server
- **Administrador de base de datos:** SQL Server Management Studio
- **Proveedor de datos:** `Microsoft.Data.SqlClient`
- **Control de versiones:** Git
- **Repositorio:** GitHub

### Sistema Operativo

- Windows 10
- Windows 11

---

# Descripción de los Archivos Principales

## Form1.cs

El archivo `Form1.cs` contiene la lógica principal de la interfaz de usuario.

Entre las funciones implementadas se encuentran:

- Cargar productos desde SQL Server.
- Mostrar productos en el `DataGridView`.
- Seleccionar imágenes.
- Convertir imágenes a arreglos de bytes.
- Validar los datos ingresados.
- Agregar productos.
- Buscar productos.
- Seleccionar registros.
- Modificar productos.
- Eliminar productos.
- Limpiar los controles.
- Cerrar la aplicación.

---

## Conexion.cs

El archivo `Conexion.cs` contiene la lógica relacionada con la comunicación entre la aplicación y SQL Server.

Los principales métodos implementados son:

```text
ObtenerConexion()
GetProductos()
InsertSeguro()
ModificarProducto()
EliminarProducto()
```

La clase utiliza:

```csharp
SqlConnection
SqlCommand
SqlDataReader
```

para realizar las operaciones sobre la base de datos.

---

## Producto.cs

La clase `Producto` representa cada uno de los registros almacenados en la tabla de productos.

La clase contiene las siguientes propiedades:

```csharp
public int Id { get; set; }

public string Nombre { get; set; }

public decimal Precio { get; set; }

public int Cantidad { get; set; }

public byte[] Imagen { get; set; }
```

El campo `Imagen` utiliza un arreglo de bytes `byte[]` porque las imágenes son almacenadas como información binaria dentro de SQL Server.

---

# Base de Datos

Para el desarrollo del laboratorio se utilizó una base de datos denominada:

```text
ProductosDB
```

La tabla utilizada se denomina:

```text
Productos
```

La creación de la tabla puede realizarse mediante:

```sql
CREATE DATABASE ProductosDB;
GO

USE ProductosDB;
GO

CREATE TABLE Productos
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Cantidad INT NOT NULL,
    Imagen VARBINARY(MAX) NULL
);
GO
```

---

# Interfaz de la Aplicación

La aplicación contiene los siguientes controles principales:

- `Label`
- `TextBox`
- `Button`
- `PictureBox`
- `DataGridView`
- `Panel`
- `MessageBox`
- `OpenFileDialog`

Los campos principales del formulario son:

```text
Folio
Nombre
Precio
Cantidad
Imagen
Búsqueda
```

Los botones disponibles son:

```text
Agregar
Modificar
Eliminar
Limpiar
Salir
```

---

# Resultado - Interfaz Principal

A continuación se muestra la interfaz principal desarrollada para la administración de productos.

<img width="506" height="404" alt="image" src="https://github.com/user-attachments/assets/84f41ea5-8dd5-4bd0-b344-6b3390077151" />



---

# Conexión con SQL Server

La aplicación establece comunicación con Microsoft SQL Server mediante la clase:

```csharp
SqlConnection
```

La cadena de conexión utilizada sigue la siguiente estructura:

```csharp
@"Server=SERVIDOR\SQLEXPRESS;
Database=ProductosDB;
Trusted_Connection=True;
TrustServerCertificate=True;";
```

La conexión se abre mediante:

```csharp
conexion.Open();
```

El método utilizado para realizar esta operación es:

```csharp
ObtenerConexion()
```

En caso de producirse un error, la aplicación captura la excepción mediante:

```csharp
catch (SqlException ex)
```

y muestra un mensaje informativo al usuario.

---

# Lectura de Productos

Los productos almacenados en SQL Server son recuperados mediante el método:

```csharp
GetProductos()
```

La consulta principal utilizada es:

```sql
SELECT Id, Nombre, Precio, Cantidad, Imagen
FROM Productos
```

Para leer los registros se utiliza:

```csharp
SqlDataReader
```

Cada registro recuperado se utiliza para crear un objeto de tipo:

```csharp
Producto
```

Los objetos son almacenados dentro de:

```csharp
List<Producto>
```

---

# Carga de Productos en el DataGridView

Cuando se abre la aplicación se ejecuta el evento:

```csharp
Form1_Load
```

Este evento llama al método:

```csharp
cargarProductos();
```

El método realiza las siguientes operaciones:

1. Limpia las filas actuales del `DataGridView`.
2. Obtiene los productos desde SQL Server.
3. Recorre la lista de productos.
4. Reconstruye las imágenes almacenadas.
5. Agrega cada producto al `DataGridView`.

La inserción de cada fila se realiza mediante:

```csharp
dgvProductos.Rows.Add(
    prod.Id,
    prod.Nombre,
    prod.Precio,
    prod.Cantidad,
    img
);
```

---

# Resultado - Productos Cargados

A continuación se muestran dos productos cargados desde SQL Server en el `DataGridView`.

<img width="507" height="427" alt="image" src="https://github.com/user-attachments/assets/b9817c0f-75ec-44e7-b597-966ca9693b95" />



---

# Manejo de Imágenes

La aplicación permite asociar una imagen a cada producto.

Para seleccionar una imagen se utiliza:

```csharp
OpenFileDialog
```

El filtro utilizado permite seleccionar archivos con las siguientes extensiones:

```text
.jpg
.jpeg
.png
.bmp
```

La imagen seleccionada se carga mediante:

```csharp
Image.FromFile()
```

y posteriormente se muestra en:

```csharp
pictureBox1
```

La propiedad:

```csharp
PictureBoxSizeMode.Zoom
```

permite ajustar la imagen manteniendo sus proporciones.

<img width="505" height="388" alt="image" src="https://github.com/user-attachments/assets/c1635bdd-0fe4-4744-839c-9813cb06fd7c" />


---

# Uso de MemoryStream

Para almacenar las imágenes en SQL Server es necesario convertirlas a información binaria.

El objeto original es:

```text
Image
```

y debe convertirse a:

```text
byte[]
```

Para realizar esta conversión se utiliza:

```csharp
MemoryStream
```

El proceso para guardar una imagen es:

```text
Image
   ↓
MemoryStream
   ↓
byte[]
   ↓
VARBINARY(MAX)
   ↓
SQL Server
```

El proceso para recuperar la imagen es:

```text
SQL Server
   ↓
VARBINARY(MAX)
   ↓
byte[]
   ↓
MemoryStream
   ↓
Bitmap
   ↓
Image
```

El método utilizado para guardar la imagen es:

```csharp
private byte[] ImageToByteArray(Image image)
{
    if (image == null)
        return null;

    using (MemoryStream mMemoryStream =
           new MemoryStream())
    {
        image.Save(
            mMemoryStream,
            ImageFormat.Png);

        return mMemoryStream.ToArray();
    }
}
```

---

# Validación de Datos

Antes de insertar o modificar información, la aplicación verifica que los datos sean válidos.

Las principales validaciones son:

- El nombre no puede estar vacío.
- El precio no puede estar vacío.
- El precio debe ser numérico.
- El precio debe ser mayor que cero.
- La cantidad no puede estar vacía.
- La cantidad debe ser numérica.
- La cantidad no puede ser negativa.

Para validar el precio se utiliza:

```csharp
decimal.TryParse()
```

Para validar la cantidad se utiliza:

```csharp
int.TryParse()
```

Estos métodos permiten intentar la conversión sin detener la ejecución del programa si el usuario introduce información incorrecta.

---

<img width="498" height="401" alt="image" src="https://github.com/user-attachments/assets/5af7238e-7a8b-450f-a66e-e12c620bbcf8" />


---

# Resultado - Validación de Datos Numéricos

<img width="499" height="412" alt="image" src="https://github.com/user-attachments/assets/982abd98-7816-429f-90c2-1a0145135b6f" />


---

# Uso de Dictionary

Para preparar la información que será insertada en la base de datos se utilizó:

```csharp
Dictionary<string, object>
```

La estructura almacena temporalmente los valores correspondientes a:

```text
Nombre
Precio
Cantidad
Imagen
```

Por ejemplo:

```csharp
myProducto["Nombre"] =
    txtNombre.Text.Trim();

myProducto["Precio"] =
    decimal.Parse(txtPrecio.Text.Trim());

myProducto["Cantidad"] =
    int.Parse(txtCantidad.Text.Trim());

myProducto["Imagen"] =
    ImageToByteArray(pictureBox1.Image);
```

Posteriormente el diccionario es enviado al método:

```csharp
InsertSeguro()
```

---

# Agregar Productos

El botón:

```text
Agregar
```

permite registrar un nuevo producto.

El proceso realizado es:

```text
Datos ingresados
      ↓
Validación
      ↓
Dictionary
      ↓
InsertSeguro()
      ↓
SQL Server
      ↓
Actualizar DataGridView
```

La inserción utiliza parámetros SQL.

Esto permite separar los valores ingresados de la sentencia SQL.

---

# Resultado - Agregar Producto

<img width="500" height="420" alt="image" src="https://github.com/user-attachments/assets/d5b67394-4c65-4c2a-b87f-61375f0a990d" />


---

# Búsqueda de Productos

La aplicación permite filtrar los productos mientras el usuario escribe dentro de la caja de búsqueda.

Para esto se utiliza el evento:

```csharp
TextChanged
```

El evento ejecuta:

```csharp
cargarProductos(textBox5.Text.Trim());
```

La búsqueda permite filtrar por:

- Id.
- Nombre.
- Precio.
- Cantidad.

La consulta utiliza:

```sql
LIKE @filtro
```

y parámetros SQL.

---

# Resultado - Búsqueda

<img width="501" height="419" alt="image" src="https://github.com/user-attachments/assets/06d1e74a-bfc6-4401-9a2d-8446d525d8fd" />


---

# Selección de Productos

Para seleccionar un producto se utiliza el evento:

```csharp
CellClick
```

del `DataGridView`.

Cuando se selecciona una fila, los datos son enviados nuevamente a los controles del formulario.

Se recuperan:

```text
Folio
Nombre
Precio
Cantidad
Imagen
```

El identificador del producto también se almacena en:

```csharp
idSeleccionado
```

Este valor posteriormente permite modificar o eliminar el registro correcto.

---

# Resultado - Selección de Producto

<img width="503" height="398" alt="image" src="https://github.com/user-attachments/assets/7d5ee16a-adc4-495d-9536-060b8eef2997" />


---

# Modificar Productos

Para modificar un producto se realiza el siguiente procedimiento:

1. Seleccionar el producto desde el `DataGridView`.
2. Modificar la información deseada.
3. Presionar el botón **Modificar**.
4. Ejecutar la sentencia `UPDATE`.
5. Actualizar nuevamente el `DataGridView`.

La consulta utilizada es:

```sql
UPDATE Productos
SET Nombre = @Nombre,
    Precio = @Precio,
    Cantidad = @Cantidad,
    Imagen = @Imagen
WHERE Id = @Id
```

La utilización de:

```sql
WHERE Id = @Id
```

permite modificar únicamente el registro seleccionado.

---

# Resultado - Modificar Producto

<img width="503" height="392" alt="image" src="https://github.com/user-attachments/assets/f54a0500-3e44-43ba-b497-21b9bd8b60f7" />

<img width="501" height="400" alt="image" src="https://github.com/user-attachments/assets/52184483-9b43-403d-b936-2c47f44308c0" />

<img width="502" height="392" alt="image" src="https://github.com/user-attachments/assets/64e3cc39-5d2d-4f57-8075-81dadc4b0b94" />


---

# Eliminar Productos

Para eliminar un producto primero se selecciona una fila del `DataGridView`.

Luego se presiona:

```text
Eliminar
```

Antes de eliminar definitivamente el registro, la aplicación solicita confirmación.

La sentencia SQL utilizada es:

```sql
DELETE FROM Productos
WHERE Id = @Id
```

De esta forma solamente se elimina el registro seleccionado.

---

# Resultado - Confirmación de Eliminación

<img width="501" height="394" alt="image" src="https://github.com/user-attachments/assets/f1d23cb8-7122-440b-a2e5-612109c75033" />


---

# Resultado - Producto Eliminado

<img width="498" height="392" alt="image" src="https://github.com/user-attachments/assets/295d0e4e-8101-42c4-a253-a1f45a66dc01" />



---

# Botón Limpiar

El botón:

```text
Limpiar
```

permite borrar la información presente en los controles del formulario.

Se limpian:

```text
Folio
Nombre
Precio
Cantidad
Imagen
```

También se elimina la selección actual del `DataGridView`.

El método utilizado es:

```csharp
LimpiarCampos()
```

---

# Botón Salir

El botón:

```text
Salir
```

permite cerrar la aplicación de forma controlada.

Primero se muestra una ventana de confirmación:

```text
¿Desea salir de la aplicación?
```

Si el usuario confirma, se muestra:

```text
Cerrando aplicación...
```

y posteriormente se ejecuta:

```csharp
Application.Exit();
```

---

# Resultado - Salir

<img width="500" height="392" alt="image" src="https://github.com/user-attachments/assets/51dbf355-b964-42ca-b7da-1f6cb2564e6b" />

<img width="500" height="394" alt="image" src="https://github.com/user-attachments/assets/485d7306-f55b-4eaa-bebf-1ba4e23187b1" />


---

# Eventos Utilizados

Durante el desarrollo se utilizaron diferentes eventos de Windows Forms.

| Control | Evento | Función |
|---|---|---|
| Formulario | `Load` | Cargar registros al iniciar |
| Botón Agregar | `Click` | Insertar producto |
| Botón Modificar | `Click` | Modificar producto |
| Botón Eliminar | `Click` | Eliminar producto |
| Botón Limpiar | `Click` | Limpiar controles |
| Botón Salir | `Click` | Cerrar aplicación |
| PictureBox | `Click` | Seleccionar imagen |
| TextBox búsqueda | `TextChanged` | Filtrar productos |
| DataGridView | `CellClick` | Seleccionar producto |

---

# Consultas SQL Utilizadas

## SELECT

```sql
SELECT Id, Nombre, Precio, Cantidad, Imagen
FROM Productos
```

---

## INSERT

La sentencia `INSERT` es construida desde el método:

```csharp
InsertSeguro()
```

utilizando:

```csharp
Dictionary<string, object>
```

y parámetros SQL.

---

## UPDATE

```sql
UPDATE Productos
SET Nombre = @Nombre,
    Precio = @Precio,
    Cantidad = @Cantidad,
    Imagen = @Imagen
WHERE Id = @Id
```

---

## DELETE

```sql
DELETE FROM Productos
WHERE Id = @Id
```

---

# Verificación desde SQL Server Management Studio

Los registros almacenados pueden verificarse directamente utilizando SQL Server Management Studio.

La consulta utilizada es:

```sql
USE ProductosDB;
GO

SELECT *
FROM Productos;
```

En la columna:

```text
Imagen
```

la información aparece en formato binario o hexadecimal.

Esto corresponde a los bytes que representan cada archivo gráfico.

---

# Resultado - Registros en SQL Server

<img width="839" height="305" alt="image" src="https://github.com/user-attachments/assets/a4fe3aaa-69dd-419f-88a8-39b2bad6c09f" />

---

# Depuración con Breakpoints

Durante el desarrollo se utilizaron puntos de interrupción o:

```text
breakpoints
```

para comprobar el contenido de las variables durante la ejecución.

Un breakpoint puede colocarse en:

```csharp
foreach (Producto prod in listaProductos)
```

Cuando el programa llega a esta línea, Visual Studio detiene temporalmente la ejecución.

Esto permite inspeccionar:

```csharp
listaProductos
```

y comprobar que los registros recuperados desde SQL Server realmente fueron almacenados dentro de la lista.

---

# Flujo General de la Aplicación

El flujo principal del sistema puede representarse de la siguiente manera:

```text
Usuario
   ↓
Windows Forms
   ↓
Validación de datos
   ↓
Objeto Producto / Dictionary
   ↓
Conexion.cs
   ↓
SqlConnection
   ↓
SqlCommand
   ↓
SQL Server
   ↓
ProductosDB
```

Para la consulta de información:

```text
SQL Server
   ↓
SqlDataReader
   ↓
Producto
   ↓
List<Producto>
   ↓
DataGridView
```

Para el manejo de imágenes:

```text
PictureBox
   ↓
Image
   ↓
MemoryStream
   ↓
byte[]
   ↓
VARBINARY(MAX)
```

---

# Elementos de C# Utilizados

Durante el laboratorio se aplicaron los siguientes elementos:

- Programación orientada a objetos.
- Clases.
- Propiedades.
- Métodos.
- Eventos.
- `List<T>`.
- `Dictionary<string, object>`.
- Estructuras condicionales.
- Manejo de excepciones.
- `try`.
- `catch`.
- `using`.
- `decimal.TryParse()`.
- `int.TryParse()`.
- Parámetro `out`.
- `MemoryStream`.
- `Bitmap`.
- `Image`.
- `byte[]`.
- `OpenFileDialog`.
- `MessageBox`.
- `DataGridView`.
- `PictureBox`.
- `SqlConnection`.
- `SqlCommand`.
- `SqlDataReader`.
- Parámetros SQL.

---

# Resultados Obtenidos

Al finalizar el laboratorio se logró desarrollar una aplicación funcional para administrar productos mediante Windows Forms y Microsoft SQL Server.

La aplicación permite:

- Agregar productos.
- Consultar productos almacenados.
- Mostrar información en un `DataGridView`.
- Buscar productos dinámicamente.
- Seleccionar imágenes desde el sistema de archivos.
- Convertir imágenes a información binaria.
- Guardar imágenes dentro de SQL Server.
- Recuperar las imágenes almacenadas.
- Seleccionar registros.
- Modificar productos.
- Eliminar productos.
- Validar los datos ingresados.
- Limpiar los controles.
- Confirmar operaciones importantes mediante `MessageBox`.
- Verificar los registros desde SQL Server Management Studio.
- Depurar el programa utilizando breakpoints.

La implementación permitió integrar la interfaz gráfica, la programación orientada a objetos y el acceso a bases de datos dentro de una misma aplicación.

---

# Dificultades y Soluciones

Durante el desarrollo del laboratorio se presentaron diferentes situaciones que requirieron análisis y corrección.

---

## Inicialización del Formulario

Se presentó un problema dentro de:

```text
Form1.Designer.cs
```

Los controles se encontraban declarados, pero no estaban siendo correctamente inicializados dentro del método:

```csharp
InitializeComponent()
```

Como consecuencia, algunos controles no existían correctamente durante la ejecución del programa.

Para solucionar el problema se reconstruyó la inicialización del formulario y se verificó nuevamente la creación de los controles.

---

## Eventos de los Botones

Después de recuperar la interfaz gráfica, algunos botones aparecían correctamente pero no ejecutaban ninguna acción.

El problema se encontraba en la asociación de eventos.

Fue necesario relacionar cada control con su método correspondiente.

Por ejemplo:

```text
btnAgregar
      ↓
btnAgregar_Click

btnModificar
      ↓
btnModificar_Click

btnEliminar
      ↓
btnEliminar_Click

btnLimpiar
      ↓
btnLimpiar_Click

btnSalir
      ↓
btnSalir_Click
```

También se verificaron:

```text
pictureBox1 → pictureBox1_Click

textBox5 → textBox5_TextChanged

dgvProductos → dgvProductos_CellClick
```

---

## Conversión de Imágenes

Las imágenes no pueden ser almacenadas directamente como objetos `Image` dentro de SQL Server.

Para solucionar esto se utilizó:

```csharp
MemoryStream
```

La imagen es transformada primero en:

```csharp
byte[]
```

y posteriormente almacenada en:

```text
VARBINARY(MAX)
```

El proceso inverso permite reconstruir nuevamente la imagen al recuperar los registros.

---

## Validación de Datos

Los controles `TextBox` reciben información en formato de texto.

Por esta razón fue necesario comprobar que los valores correspondientes al precio y cantidad pudieran convertirse correctamente.

Se utilizaron:

```csharp
decimal.TryParse()
```

e:

```csharp
int.TryParse()
```

Esto permitió evitar errores durante la ejecución.

---

## Conexión con SQL Server

La aplicación utiliza el paquete:

```text
Microsoft.Data.SqlClient
```

para establecer comunicación con Microsoft SQL Server.

Los principales objetos utilizados fueron:

```csharp
SqlConnection
SqlCommand
SqlDataReader
```

La conexión utiliza autenticación de Windows y permite acceder directamente a:

```text
ProductosDB
```

---

# Conclusión

El desarrollo de este laboratorio permitió integrar diferentes conceptos de C# dentro de una aplicación completa conectada a una base de datos. A través de Windows Forms se construyó una interfaz capaz de recibir información del usuario, mientras que SQL Server permitió almacenar y recuperar los registros de manera permanente.

La implementación de las operaciones de agregar, consultar, modificar y eliminar permitió comprender de forma práctica el funcionamiento de una aplicación CRUD. Además, el manejo de imágenes mediante `MemoryStream`, el uso de clases, listas, diccionarios, consultas parametrizadas y validaciones permitió aplicar diferentes conceptos de programación dentro de un mismo proyecto.

El laboratorio también permitió comprender mejor la importancia de la depuración, la asociación correcta de eventos y la separación entre la lógica de la interfaz y la lógica utilizada para acceder a la base de datos.

---

# Referencias

Material utilizado para el desarrollo del laboratorio:

- Guía del Laboratorio #4 - Herramientas de Programación Aplicada III.
- Material proporcionado por la Ing. Irina Fong.
- Microsoft SQL Server.
- SQL Server Management Studio.
- Microsoft.Data.SqlClient.
- Visual Studio Community.

---

# Información del Estudiante

**Nombre:** Maria Townshend  
**Curso:** Herramientas de Programación Aplicada III  
**Institución:** Universidad Tecnológica de Panamá  
**Facultad:** Facultad de Ingeniería de Sistemas Computacionales  
**Facilitadora:** Ing. Irina Fong
