USE [master]
GO
/****** Object:  Database [SistemaCompras]    Script Date: 11/12/2024 0:57:10 ******/
CREATE DATABASE [SistemaCompras]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SistemaCompras', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaCompras.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SistemaCompras_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SistemaCompras_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SistemaCompras] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SistemaCompras].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SistemaCompras] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SistemaCompras] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SistemaCompras] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SistemaCompras] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SistemaCompras] SET ARITHABORT OFF 
GO
ALTER DATABASE [SistemaCompras] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SistemaCompras] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SistemaCompras] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SistemaCompras] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SistemaCompras] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SistemaCompras] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SistemaCompras] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SistemaCompras] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SistemaCompras] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SistemaCompras] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SistemaCompras] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SistemaCompras] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SistemaCompras] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SistemaCompras] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SistemaCompras] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SistemaCompras] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SistemaCompras] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SistemaCompras] SET RECOVERY FULL 
GO
ALTER DATABASE [SistemaCompras] SET  MULTI_USER 
GO
ALTER DATABASE [SistemaCompras] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SistemaCompras] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SistemaCompras] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SistemaCompras] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SistemaCompras] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SistemaCompras] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SistemaCompras', N'ON'
GO
ALTER DATABASE [SistemaCompras] SET QUERY_STORE = ON
GO
ALTER DATABASE [SistemaCompras] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SistemaCompras]
GO
/****** Object:  User [User]    Script Date: 11/12/2024 0:57:10 ******/
CREATE USER [User] FOR LOGIN [User] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [User]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [User]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [User]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [User]
GO
ALTER ROLE [db_datareader] ADD MEMBER [User]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [User]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 11/12/2024 0:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[correo] [varchar](100) NOT NULL,
	[contrasena] [varchar](100) NOT NULL,
	[direccion_envio] [varchar](255) NULL,
	[telefono] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historial_Compras]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historial_Compras](
	[id_historial] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[id_orden] [int] NULL,
	[fecha_compra] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_historial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Órdenes]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Órdenes](
	[id_orden] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[fecha_orden] [datetime] NULL,
	[total] [decimal](10, 2) NOT NULL,
	[estado] [varchar](50) NOT NULL,
	[detalles_envio] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_orden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_HistorialCompras]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_HistorialCompras] AS
SELECT 
    hc.id_historial,
    u.nombre AS nombre_usuario,
    o.fecha_orden,
    o.total,
    o.estado
FROM Historial_Compras hc
JOIN Usuarios u ON hc.id_usuario = u.id_usuario
JOIN Órdenes o ON hc.id_orden = o.id_orden;
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[id_carrito] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[fecha_creacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_carrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre_categoria] [varchar](100) NOT NULL,
	[descripcion] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Descuentos]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Descuentos](
	[id_descuento] [int] IDENTITY(1,1) NOT NULL,
	[codigo_descuento] [varchar](50) NULL,
	[porcentaje] [decimal](5, 2) NULL,
	[valor_fijo] [decimal](10, 2) NULL,
	[fecha_inicio] [datetime] NULL,
	[fecha_fin] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_descuento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalles_Carrito]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Carrito](
	[id_detalle] [int] IDENTITY(1,1) NOT NULL,
	[id_carrito] [int] NULL,
	[id_producto] [int] NULL,
	[cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalles_Cliente]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Cliente](
	[id_detalle_cliente] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[direccion_completa] [varchar](255) NULL,
	[tipo_direccion] [varchar](50) NULL,
	[estado] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalles_Productos]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Productos](
	[id_detalle_producto] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NULL,
	[descripcion] [varchar](255) NULL,
	[caracteristicas] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_detalle_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favoritos]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favoritos](
	[id_favorito] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[id_producto] [int] NULL,
	[fecha_anadido] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_favorito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Metodos_Envio]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Metodos_Envio](
	[id_metodo_envio] [int] IDENTITY(1,1) NOT NULL,
	[nombre_metodo] [varchar](100) NOT NULL,
	[costo] [decimal](10, 2) NULL,
	[tiempo_estimado] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_metodo_envio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Metodos_Pago]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Metodos_Pago](
	[id_pago] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[monto] [decimal](10, 2) NOT NULL,
	[fecha_pago] [datetime] NULL,
	[metodo_pago] [varchar](50) NULL,
	[estado_pago] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificaciones](
	[id_notificacion] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[mensaje] [text] NULL,
	[fecha_creacion] [datetime] NULL,
	[leido] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_notificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[nombre_producto] [varchar](100) NOT NULL,
	[descripcion] [text] NULL,
	[precio] [decimal](10, 2) NOT NULL,
	[stock] [int] NOT NULL,
	[categoria] [varchar](100) NULL,
	[imagen] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carrito] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Favoritos] ADD  DEFAULT (getdate()) FOR [fecha_anadido]
GO
ALTER TABLE [dbo].[Historial_Compras] ADD  DEFAULT (getdate()) FOR [fecha_compra]
GO
ALTER TABLE [dbo].[Metodos_Pago] ADD  DEFAULT (getdate()) FOR [fecha_pago]
GO
ALTER TABLE [dbo].[Notificaciones] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Notificaciones] ADD  DEFAULT ((0)) FOR [leido]
GO
ALTER TABLE [dbo].[Órdenes] ADD  DEFAULT (getdate()) FOR [fecha_orden]
GO
ALTER TABLE [dbo].[Carrito]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Detalles_Carrito]  WITH NOCHECK ADD FOREIGN KEY([id_carrito])
REFERENCES [dbo].[Carrito] ([id_carrito])
GO
ALTER TABLE [dbo].[Detalles_Carrito]  WITH NOCHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
GO
ALTER TABLE [dbo].[Detalles_Cliente]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Detalles_Productos]  WITH NOCHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
GO
ALTER TABLE [dbo].[Favoritos]  WITH NOCHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Productos] ([id_producto])
GO
ALTER TABLE [dbo].[Favoritos]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Historial_Compras]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Metodos_Pago]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Notificaciones]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Órdenes]  WITH NOCHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[Usuarios] ([id_usuario])
GO
ALTER TABLE [dbo].[Órdenes]  WITH CHECK ADD  CONSTRAINT [chk_estado_valores] CHECK  (([estado]='cancelada' OR [estado]='completada' OR [estado]='pendiente'))
GO
ALTER TABLE [dbo].[Órdenes] CHECK CONSTRAINT [chk_estado_valores]
GO
/****** Object:  StoredProcedure [dbo].[RegistrarCompra]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RegistrarCompra]
    @id_usuario INT
AS
BEGIN
    -- Iniciar una transacción
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Declarar variables
        DECLARE @total DECIMAL(10, 2) = 0;
        DECLARE @id_carrito INT;
        DECLARE @id_orden INT;

        -- Obtener el carrito del usuario
        SELECT @id_carrito = id_carrito
        FROM Carrito
        WHERE id_usuario = @id_usuario;

        -- Verificar que el carrito exista
        IF @id_carrito IS NULL
        BEGIN
            THROW 50001, 'El usuario no tiene un carrito asociado.', 1;
        END;

        -- Calcular el total de la orden
        SELECT @total = SUM(p.precio * dc.cantidad)
        FROM Detalles_Carrito dc
        INNER JOIN Productos p ON dc.id_producto = p.id_producto
        WHERE dc.id_carrito = @id_carrito;

        -- Verificar que el carrito no esté vacío
        IF @total IS NULL OR @total = 0
        BEGIN
            THROW 50002, 'El carrito está vacío.', 1;
        END;

        -- Verificar stock suficiente para cada producto
        IF EXISTS (
            SELECT 1
            FROM Detalles_Carrito dc
            INNER JOIN Productos p ON dc.id_producto = p.id_producto
            WHERE dc.id_carrito = @id_carrito AND dc.cantidad > p.stock
        )
        BEGIN
            THROW 50003, 'Stock insuficiente para uno o más productos.', 1;
        END;

        -- Insertar datos en la tabla Órdenes
        INSERT INTO Órdenes (id_usuario, fecha_orden, total, estado, detalles_envio)
        VALUES (@id_usuario, GETDATE(), @total, 'Pendiente', NULL);

        -- Obtener el ID de la orden recién creada
        SET @id_orden = SCOPE_IDENTITY();

        -- Insertar datos en la tabla Historial_Compras
        INSERT INTO Historial_Compras (id_usuario, id_orden, fecha_compra)
        VALUES (@id_usuario, @id_orden, GETDATE());


        -- Limpiar el carrito después de la compra
        DELETE FROM Detalles_Carrito
        WHERE id_carrito = @id_carrito;

        -- Confirmar la transacción
        COMMIT TRANSACTION;
        PRINT 'La compra se ha registrado exitosamente.';
    END TRY
    BEGIN CATCH
        -- Deshacer la transacción en caso de error
        ROLLBACK TRANSACTION;

        -- Manejar el error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Re-lanzar el error para que el cliente pueda gestionarlo
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AutenticarUsuario]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AutenticarUsuario]
    @Correo NVARCHAR(100),
    @Contrasena NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id_usuario, 
        nombre, 
        correo, 
        contrasena 
    FROM 
        Usuarios 
    WHERE 
        correo = @Correo 
        AND contrasena = @Contrasena; -- Asegúrate de que la contraseña esté encriptada y se compare correctamente.
END
GO
/****** Object:  StoredProcedure [dbo].[topconsultas]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[topconsultas]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT TOP 10
    qs.execution_count AS VecesEjecutado,
    qs.total_elapsed_time / qs.execution_count AS AvgTiempoEspera,
    SUBSTRING(st.text, (qs.statement_start_offset / 2) + 1,
              ((CASE qs.statement_end_offset
                  WHEN -1 THEN DATALENGTH(st.text)
                  ELSE qs.statement_end_offset
              END - qs.statement_start_offset) / 2) + 1) AS QueryText
FROM 
    sys.dm_exec_query_stats AS qs
CROSS APPLY 
    sys.dm_exec_sql_text(qs.sql_handle) AS st
ORDER BY 
    qs.execution_count DESC;

END
GO
/****** Object:  StoredProcedure [dbo].[usp_actualizarCantidadProducto]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_actualizarCantidadProducto]
    @id_producto INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN
        UPDATE Productos
        SET stock = stock - 1
        WHERE id_producto = @id_producto;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_agregarProductoAlCarrito]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_agregarProductoAlCarrito]
    @Idusuario INT,
    @Idproducto INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_carrito INT;
    DECLARE @precio DECIMAL(10, 2);
    DECLARE @nombre_producto VARCHAR(100);
    DECLARE @stock INT;

    -- Verificar si el producto existe y obtener sus datos (nombre y precio)
    SELECT 
        @nombre_producto = nombre_producto,
        @precio = precio,
        @stock = stock
    FROM Productos
    WHERE id_producto = @Idproducto;

    -- Validar si el producto existe en la base de datos
    IF @nombre_producto IS NULL
    BEGIN
        RAISERROR('El producto no existe.', 16, 1);
        RETURN;
    END

    -- Verificar si hay suficiente stock del producto
    IF @stock <= 0
    BEGIN
        RAISERROR('El producto no tiene stock disponible.', 16, 1);
        RETURN;
    END

    -- Obtener o crear un carrito activo para el usuario
    SELECT @id_carrito = id_carrito 
    FROM Carrito 
    WHERE id_usuario = @Idusuario;

    IF @id_carrito IS NULL
    BEGIN
        INSERT INTO Carrito (id_usuario, fecha_creacion)
        VALUES (@Idusuario, GETDATE());

        SET @id_carrito = SCOPE_IDENTITY();
    END

    -- Insertar el producto al carrito o actualizar su cantidad si ya existe en el carrito
    IF EXISTS (
        SELECT 1
        FROM Detalles_Carrito
        WHERE id_carrito = @id_carrito AND id_producto = @Idproducto
    )
    BEGIN
        UPDATE Detalles_Carrito
        SET cantidad = cantidad + 1
        WHERE id_carrito = @id_carrito AND id_producto = @Idproducto;

        UPDATE Productos
        SET stock = stock - 1
        WHERE id_producto = @Idproducto;
    END
    ELSE
    BEGIN
        -- Insertar producto en el carrito con el precio
        INSERT INTO Detalles_Carrito (id_carrito, id_producto, cantidad)
        VALUES (@id_carrito, @Idproducto, 1);

		UPDATE Productos
        SET stock = stock - 1
        WHERE id_producto = @Idproducto
    END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_eliminarProductoDelCarrito]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_eliminarProductoDelCarrito]
    @Idusuario INT,
    @id_producto INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Declarar variables
        DECLARE @id_carrito INT;
        DECLARE @cantidad_actual INT;

        -- Obtener el id_carrito activo del usuario
        SELECT @id_carrito = id_carrito
        FROM Carrito
        WHERE id_usuario = @Idusuario;

        -- Verificar si el carrito existe
        IF @id_carrito IS NULL
        BEGIN
            -- Usar un número de error válido en el rango 50000-2147483647
            THROW 50000, 'El usuario no tiene un carrito asociado.', 1;
        END;

        -- Verificar si el producto está en el carrito y obtener la cantidad actual
        SELECT @cantidad_actual = cantidad
        FROM Detalles_Carrito
        WHERE id_carrito = @id_carrito AND id_producto = @id_producto;

        IF @cantidad_actual IS NULL
        BEGIN
            -- Usar un número de error válido
            THROW 50001, 'El producto no está en el carrito.', 1;
        END;

        -- Verificar que la cantidad sea mayor a 0 antes de restar
        IF @cantidad_actual <= 1
        BEGIN
            -- Si la cantidad es 1 o menos, eliminamos el producto del carrito
            DELETE FROM Detalles_Carrito
            WHERE id_carrito = @id_carrito AND id_producto = @id_producto;
        END
        ELSE
        BEGIN
            -- Si la cantidad es mayor a 1, restamos 1
            UPDATE Detalles_Carrito
            SET cantidad = cantidad - 1
            WHERE id_carrito = @id_carrito AND id_producto = @id_producto;
        END

        -- Actualizar el stock del producto
        UPDATE Productos
        SET stock = stock + 1
        WHERE id_producto = @id_producto;

        -- Confirmación
        PRINT 'El producto se actualizó en el carrito correctamente.';
    END TRY
    BEGIN CATCH
        -- Manejar errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Re-lanzar el error
        THROW 50002, @ErrorMessage, @ErrorState;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_RegistrarCompra]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RegistrarCompra]
    @id_usuario INT
AS
BEGIN
    -- Iniciar una transacción
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Declarar variables
        DECLARE @total DECIMAL(10, 2) = 0;
        DECLARE @id_orden INT;
		DECLARE @id_carrito INT;
		-- Obtener el carrito del usuario
        SELECT @id_carrito = id_carrito
        FROM Carrito
        WHERE id_usuario = @id_usuario;

        -- Verificar que el carrito exista
        IF @id_carrito IS NULL
        BEGIN
            THROW 50001, 'El usuario no tiene un carrito asociado.', 1;
        END;

        -- Calcular el total de la orden
        SELECT @total = SUM(p.precio * dc.cantidad)
        FROM Detalles_Carrito dc
        INNER JOIN Productos p ON dc.id_producto = p.id_producto
        WHERE dc.id_carrito = @id_carrito	;

        -- Verificar que el carrito no esté vacío o no exista
        IF @total IS NULL OR @total = 0
        BEGIN
            THROW 50001, 'El carrito está vacío o no existe.', 1;
        END;

        -- Verificar stock suficiente para cada producto
        IF EXISTS (
            SELECT 1
            FROM Detalles_Carrito dc
            INNER JOIN Productos p ON dc.id_producto = p.id_producto
            WHERE dc.id_carrito = @id_carrito AND dc.cantidad > p.stock
        )
        BEGIN
            THROW 50002, 'Stock insuficiente para uno o más productos.', 1;
        END;

        -- Insertar datos en la tabla Órdenes
        INSERT INTO Órdenes (id_usuario, fecha_orden, total, estado, detalles_envio)
        VALUES (@id_usuario, GETDATE(), @total, 'Pendiente', NULL);

        -- Obtener el ID de la orden recién creada
        SET @id_orden = SCOPE_IDENTITY();

        -- Insertar datos en la tabla Historial_Compras
        INSERT INTO Historial_Compras (id_usuario, id_orden, fecha_compra)
        VALUES (@id_usuario, @id_orden, GETDATE());

        -- Reducir el stock de los productos en el carrito
        UPDATE Productos
        SET stock = stock - dc.cantidad
        FROM Productos p
        INNER JOIN Detalles_Carrito dc ON p.id_producto = dc.id_producto
        WHERE dc.id_carrito = @id_carrito;

        -- Limpiar el carrito después de la compra
        DELETE FROM Detalles_Carrito
        WHERE id_carrito = @id_carrito;

        -- Confirmar la transacción
        COMMIT TRANSACTION;
        PRINT 'La compra se ha registrado exitosamente.';
    END TRY
    BEGIN CATCH
        -- Deshacer la transacción en caso de error
        ROLLBACK TRANSACTION;

        -- Manejar el error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Re-lanzar el error para que el cliente pueda gestionarlo
        THROW @ErrorSeverity, @ErrorMessage, @ErrorState;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_verCarritoDetalles]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_verCarritoDetalles] 
    @Idusuario INT
AS
BEGIN
    -- SET NOCOUNT ON agregado para evitar conjuntos de resultados adicionales que interfieran con las declaraciones SELECT.
    SET NOCOUNT ON;

    -- Seleccionar información del carrito y detalles de los productos
    SELECT 
        c.id_carrito,
		p.id_producto,
        c.fecha_creacion,
        dc.id_detalle,
        dc.id_producto,
        dc.cantidad,
        p.nombre_producto,
        p.precio,
        dp.descripcion AS descripcion_producto
    FROM 
        Carrito c
    INNER JOIN 
        Detalles_Carrito dc ON c.id_carrito = dc.id_carrito
    INNER JOIN 
        Productos p ON dc.id_producto = p.id_producto
    LEFT JOIN 
        Detalles_Productos dp ON p.id_producto = dp.id_producto
    WHERE 
        c.id_usuario = @Idusuario;

END
GO
/****** Object:  StoredProcedure [dbo].[usp_verproductos]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: RONAY		<Author,,Name>
-- Create date: 4/12/24 <Create Date,,>
-- Description:Select productos	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_verproductos] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT [id_producto]
      ,[nombre_producto]
      ,[descripcion]
      ,[precio]
      ,[stock]
      ,[categoria]
  FROM [dbo].[Productos]


END
GO
/****** Object:  StoredProcedure [dbo].[usp_verproductosfiltrados]    Script Date: 11/12/2024 0:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_verproductosfiltrados] 
    @filtro NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verifica si el filtro es un campo válido para evitar inyecciones SQL
    IF @filtro NOT IN ('id_producto', 'nombre_producto', 'descripcion', 'precio', 'stock', 'categoria')
    BEGIN
        set @filtro = 'id_producto'
		RAISERROR ('El campo para ordenar no es válido.', 16, 1);
    END

    -- Construcción de la consulta dinámica
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'SELECT id_producto, nombre_producto, descripcion, precio, stock, categoria
                 FROM dbo.Productos
                 ORDER BY ' + QUOTENAME(@filtro);

    EXEC sp_executesql @sql;
END
GO
USE [master]
GO
ALTER DATABASE [SistemaCompras] SET  READ_WRITE 
GO
