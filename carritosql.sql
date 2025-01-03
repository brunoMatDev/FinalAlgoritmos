USE [master]
GO
/****** Object:  Database [carrito_de_bruno]    Script Date: 02/01/2025 10:10:53 p. m. ******/
CREATE DATABASE [carrito_de_bruno]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'carrito_de_bruno', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\carrito_de_bruno.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'carrito_de_bruno_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\carrito_de_bruno_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [carrito_de_bruno] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [carrito_de_bruno].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [carrito_de_bruno] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET ARITHABORT OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [carrito_de_bruno] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [carrito_de_bruno] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET  DISABLE_BROKER 
GO
ALTER DATABASE [carrito_de_bruno] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [carrito_de_bruno] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [carrito_de_bruno] SET  MULTI_USER 
GO
ALTER DATABASE [carrito_de_bruno] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [carrito_de_bruno] SET DB_CHAINING OFF 
GO
ALTER DATABASE [carrito_de_bruno] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [carrito_de_bruno] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [carrito_de_bruno] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [carrito_de_bruno] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [carrito_de_bruno] SET QUERY_STORE = ON
GO
ALTER DATABASE [carrito_de_bruno] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [carrito_de_bruno]
GO
/****** Object:  Table [dbo].[products]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(0,1) NOT NULL,
	[product_name] [varchar](30) NOT NULL,
	[price] [int] NOT NULL,
	[image_path] [varchar](100) NULL,
	[description] [varchar](256) NOT NULL,
	[stock] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products_x_purchases]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products_x_purchases](
	[id] [int] IDENTITY(0,1) NOT NULL,
	[producto] [int] NOT NULL,
	[compra] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchases]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchases](
	[id] [int] IDENTITY(0,1) NOT NULL,
	[usuario] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[total] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_logs]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ip] [varchar](45) NOT NULL,
	[endpoint] [varchar](60) NOT NULL,
	[date_and_time] [datetime] NOT NULL,
	[user_agent] [varchar](max) NOT NULL,
	[id_user] [int] NULL,
	[status_code] [smallint] NOT NULL,
	[message] [varchar](max) NOT NULL,
 CONSTRAINT [RequestLogs_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rols]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rols](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rol_name] [varchar](50) NOT NULL,
 CONSTRAINT [NewTable_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(0,1) NOT NULL,
	[username] [varchar](30) NOT NULL,
	[password] [varchar](30) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[last_name] [varchar](30) NOT NULL,
	[rol] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users_x_products]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_x_products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[amount] [int] NOT NULL,
 CONSTRAINT [users_x_products_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (4, N'coca de muestra, coca de muest', 1200, N'coca', N'rica y refrescante', 128)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (8, N'PRODUCTO DE PRUEBA', 1200, N'productodeprueba', N'PRODUCTO DE PRUEBA', 20)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (9, N'naranja', 3500, N'naranja', N'rica y jugosa naranja con mucho jugo de naranja para exprimir y hacer jugo de naranja', 22)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (10, N'chevrolet corsa 0km', 30000000, N'chevroletcorsa0km', N'nuevo nuevo sin usar vendo impecable', 1)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (11, N'zapatillas nike', 40000, N'zapatillasnike', N'hermosas marca nike originales', 4)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (12, N'computadora gamer', 800000, N'computadoragamer', N'rx 580, i5-10400, 16GB de ram, SSD M2 1TB. Un año de uso sigue como nueva le cambie la pasta termica 16 veces y la limpio 3 veces al dia', 1)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (13, N'termo stanley', 150000, N'termostanley', N'El verdadero termo argentino', 5)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (15, N'Pepsi', 1100, N'pepsi', N'Pepsi, sabor único y refrescante', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (16, N'Sprite', 950, N'sprite', N'Sprite, refrescante sabor a limón', 100)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (17, N'Fanta', 900, N'fanta', N'Fanta, sabor naranja inconfundible', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (18, N'7 Up', 1050, N'7up', N'7 Up, refrescante sabor de lima', 110)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (19, N'Red Bull', 2500, N'redbull', N'Red Bull, energía en cada sorbo', 200)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (20, N'Monster', 2200, N'monster', N'Monster, bebida energética', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (21, N'Schweppes', 1000, N'schweppes', N'Schweppes, agua tónica con sabor', 90)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (22, N'Gin & tonic', 800, N'gin&tonic', N'Tonic, agua tónica refrescante', 120)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (23, N'Gatorade', 1500, N'gatorade', N'Gatorade, bebida isotónica', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (24, N'Aquarius', 1200, N'aquarius', N'Aquarius, refresco de naranja', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (25, N'Lipton Ice Tea', 1100, N'lipton', N'Lipton, té helado refrescante', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (26, N'Coca Cola Zero', 1250, N'coca_zero', N'Coca Cola Zero, sin azúcar', 90)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (27, N'Pepsi Max', 1150, N'pepsi_max', N'Pepsi Max, sin azúcar y más sabor', 100)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (28, N'Monster Energy', 2300, N'monster_energy', N'Monster Energy, bebida energética', 170)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (29, N'Fanta Uva', 1000, N'fanta_uva', N'Fanta Uva, sabor único a uva', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (30, N'Coca Cola Light', 1100, N'coca_light', N'Coca Cola Light, menos calorías', 120)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (31, N'Heineken', 2500, N'heineken', N'Heineken, cerveza premium', 80)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (32, N'Corona', 2400, N'corona', N'Corona, cerveza con sabor suave', 60)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (33, N'Budweiser', 2200, N'budweiser', N'Budweiser, cerveza de calidad', 100)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (34, N'Miller', 2100, N'miller', N'Miller, cerveza ligera y refrescante', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (35, N'Amstel', 2000, N'amstel', N'Amstel, cerveza de sabor auténtico', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (36, N'Desperados', 2300, N'desperados', N'Desperados, cerveza con un toque de tequila', 110)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (37, N'Kilkenny', 2500, N'kilkenny', N'Kilkenny, cerveza irlandesa', 90)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (38, N'Guinness', 2700, N'guinness', N'Guinness, cerveza oscura y espesa', 70)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (39, N'Cerveza Negra', 1800, N'cerveza_negra', N'Cerveza Negra, sabor intenso', 110)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (40, N'Sangría', 1800, N'sangria', N'Sangría, bebida dulce con vino', 120)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (41, N'Cerveza Clara', 1600, N'cerveza_clara', N'Cerveza Clara, refrescante y ligera', 100)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (42, N'Tonic Water', 850, N'tonic_water', N'Tonic Water, agua con gas con sabor', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (43, N'Ginger Ale', 950, N'ginger_ale', N'Ginger Ale, bebida suave con jengibre', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (44, N'Vino Tinto', 3500, N'vino_tinto', N'Vino Tinto, excelente para acompañar carnes', 80)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (45, N'Vino Blanco', 3200, N'vino_blanco', N'Vino Blanco, refrescante y afrutado', 90)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (46, N'Vino Rosado', 3300, N'vino_rosado', N'Vino Rosado, delicado y afrutado', 100)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (47, N'Champagne', 5000, N'champagne', N'Champagne, burbujeas de lujo', 60)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (48, N'Agua Mineral', 800, N'agua_mineral', N'Agua Mineral, pureza natural', 200)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (49, N'Cerveza IPA', 2400, N'ipa_beer', N'Cerveza IPA, sabor fuerte y amargo', 70)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (50, N'Agua con Gas', 850, N'agua_gas', N'Agua con Gas, refrescante y burbujeante', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (51, N'Refresco Naranja', 900, N'refresco_naranja', N'Refresco de Naranja, dulce y refrescante', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (52, N'Limonada', 850, N'limonada', N'Limonada, fresca y natural', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (53, N'Café Helado', 1500, N'cafe_helado', N'Café Helado, frío y delicioso', 120)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (54, N'Jugo de Naranja', 950, N'jugo_naranja', N'Jugo de Naranja natural', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (55, N'Jugo de Manzana', 1000, N'jugo_manzana', N'Jugo de Manzana, fresco y saludable', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (56, N'Jugo de Piña', 1100, N'jugo_pina', N'Jugo de Piña, tropical y refrescante', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (57, N'Jugo de Uva', 950, N'jugo_uva', N'Jugo de Uva, sabor dulce y fresco', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (58, N'Papas Fritas Lays', 500, N'lays', N'Papas fritas Lays, crujientes y deliciosas', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (59, N'Pringles', 600, N'pringles', N'Pringles, el snack crujiente con sabor inconfundible', 200)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (60, N'Doritos', 550, N'doritos', N'Doritos, nachos con sabor a queso', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (61, N'Cheetos', 450, N'cheetos', N'Cheetos, el snack de siempre con sabor a queso', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (62, N'Ruffles', 520, N'ruffles', N'Ruffles, papas con ondas y sabor extra', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (63, N'Lays Papas Asadas', 550, N'lays_asadas', N'Lays, papas asadas con un toque único', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (64, N'Nachos', 480, N'nachos', N'Nachos, ideal para acompañar con salsa', 170)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (65, N'Alitas de Pollo', 2000, N'alitas_pollo', N'Alitas de Pollo, jugosas y sabrosas', 80)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (66, N'Galletas Oreo', 450, N'oreo', N'Galletas Oreo, sabor irresistible con crema en el medio', 220)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (67, N'Galletas Chips Ahoy', 500, N'chips_ahoy', N'Chips Ahoy, galletas con trozos de chocolate', 210)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (68, N'Galletas Digestive', 350, N'digestive', N'Galletas Digestive, perfectas para el desayuno', 190)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (69, N'Galletas María', 300, N'maria', N'Galletas María, clásicas y crujientes', 250)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (70, N'Galletas Choco Chips', 400, N'choco_chips', N'Galletas con trozos de chocolate', 200)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (71, N'Galletas Fudge', 500, N'fudge', N'Galletas Fudge, dulces y suaves con sabor a chocolate', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (72, N'Frutos Secos Mixtos', 700, N'frutos_secos', N'Frutos secos mixtos, energía natural para todo el día', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (73, N'Almendras Tostadas', 800, N'almendras', N'Almendras tostadas, perfectas para picar', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (74, N'Cacahuates Japoneses', 350, N'cacahuates_japoneses', N'Cacahuates japoneses, crujientes y sabrosos', 210)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (75, N'Pistachos', 900, N'pistachos', N'Pistachos, el snack ideal para picar entre horas', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (76, N'Nueces', 850, N'nueces', N'Nueces, perfectas para disfrutar en cualquier momento', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (77, N'Mix de Frutos Secos', 750, N'mix_frutos_secos', N'Mix de frutos secos, la combinación perfecta para energizarte', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (78, N'Pasas', 300, N'pasas', N'Pasas, el snack dulce y saludable', 200)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (79, N'Chicles Orbit', 200, N'orbit', N'Chicles Orbit, el sabor refrescante que dura más', 250)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (80, N'Chicles Trident', 180, N'trident', N'Chicles Trident, sabor intenso y duradero', 240)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (81, N'Caramelos M&Ms', 500, N'mms', N'M&Ms, los caramelos de chocolate con maní', 220)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (82, N'Caramelos Skittles', 400, N'skittles', N'Skittles, caramelos de colores con sabor a frutas', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (83, N'Caramelos Haribo', 350, N'haribo', N'Haribo, gomitas frutales para todos', 210)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (84, N'Chocolates Milka', 800, N'milka', N'Chocolates Milka, el sabor suave y delicioso', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (85, N'Chocolate Ferrero Rocher', 1200, N'ferrero_rocher', N'Ferrero Rocher, el chocolate premium con avellanas', 90)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (86, N'Chocolate Lindt', 1500, N'lindt', N'Lindt, chocolate suizo de alta calidad', 100)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (87, N'Chocolate Snickers', 500, N'snickers', N'Snickers, el chocolate con cacahuates y caramelo', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (88, N'Chocolate KitKat', 400, N'kitkat', N'KitKat, chocolate con obleas crujientes', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (89, N'Chocolate Twix', 450, N'twix', N'Twix, el chocolate con galleta y caramelo', 170)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (90, N'Chocolate Mars', 500, N'mars', N'Mars, delicioso chocolate con relleno de caramelo', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (91, N'Chicles Wrigley’s', 150, N'wrigleys', N'Chicles Wrigley’s, frescura en cada mordida', 250)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (92, N'Fruta Deshidratada', 600, N'fruta_deshidratada', N'Fruta deshidratada, natural y sin aditivos', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (93, N'Tortillas de Maíz', 300, N'tortillas_maiz', N'Tortillas de maíz, frescas y deliciosas', 200)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (94, N'Chocolinas', 500, N'chocolinas', N'Galletas Chocolinas, ideales para postres', 160)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (95, N'Tostadas de Maíz', 400, N'tostadas_maiz', N'Tostadas de maíz, ideales para acompañar tus comidas', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (96, N'Papas Lay’s BBQ', 550, N'lays_bbq', N'Papas Lay’s BBQ, con sabor ahumado', 150)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (97, N'Papas Lay’s Sal y Pimienta', 600, N'lays_salt_pepper', N'Papas Lay’s con sal y pimienta', 140)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (98, N'Fruta Confitada', 650, N'fruta_confitada', N'Fruta confitada, dulce y deliciosa', 130)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (99, N'Barritas de Cereal', 700, N'barritas_cereal', N'Barritas de cereal, ideales para el desayuno', 180)
INSERT [dbo].[products] ([id], [product_name], [price], [image_path], [description], [stock]) VALUES (100, N'Palomitas de Maíz', 400, N'palomitas_maiz', N'Palomitas de maíz, ligeras y saladas', 150)
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[request_logs] ON 

INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:06:37.940' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: admin')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (2, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:12:53.540' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (3, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:16:37.793' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (4, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:17:31.823' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (5, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:25:47.223' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (6, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:50:20.457' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: asfdsaf')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (7, N'::1', N'/Auth/Login', CAST(N'2024-11-16T10:50:33.860' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (8, N'::1', N'/Auth/Login', CAST(N'2024-11-16T11:55:18.083' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (9, N'::1', N'/Auth/Login', CAST(N'2024-11-16T11:57:09.633' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (10, N'::1', N'/Auth/Login', CAST(N'2024-11-16T11:58:44.783' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (11, N'::1', N'/Auth/Login', CAST(N'2024-11-16T12:03:45.303' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (12, N'::1', N'/Auth/Login', CAST(N'2024-11-16T12:05:40.627' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (13, N'::1', N'/Auth/Login', CAST(N'2024-11-16T12:07:31.413' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (14, N'::1', N'/Auth/Login', CAST(N'2024-11-16T12:39:44.720' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (15, N'::1', N'/Auth/Login', CAST(N'2024-11-16T21:08:38.803' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (16, N'::1', N'/Auth/Login', CAST(N'2024-11-17T00:58:01.900' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (17, N'::1', N'/Auth/Login', CAST(N'2024-11-17T01:23:08.507' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (18, N'::1', N'/Auth/Login', CAST(N'2024-11-21T18:17:11.413' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1001, N'::1', N'/Auth/Login', CAST(N'2024-11-25T21:00:10.317' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1002, N'::1', N'/Auth/Login', CAST(N'2024-11-26T08:04:40.287' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1003, N'::1', N'/Auth/Login', CAST(N'2024-11-26T08:11:36.863' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1004, N'::1', N'/Auth/Login', CAST(N'2024-11-26T10:20:04.697' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1005, N'::1', N'/Auth/Login', CAST(N'2024-11-26T10:30:19.313' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1006, N'::1', N'/Auth/Login', CAST(N'2024-11-26T11:18:10.377' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1007, N'::1', N'/Auth/Login', CAST(N'2024-11-26T11:53:59.910' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1008, N'::1', N'/Auth/Login', CAST(N'2024-11-26T12:45:01.253' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1009, N'::1', N'/Auth/Login', CAST(N'2024-11-26T12:46:04.053' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1010, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-11-26T13:04:12.593' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: string')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1011, N'192.168.0.225', N'/Auth/Login', CAST(N'2024-11-26T13:10:03.613' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: string')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1012, N'192.168.0.225', N'/Auth/Login', CAST(N'2024-11-26T13:18:01.943' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: string')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1013, N'192.168.0.130', N'/Auth/Login', CAST(N'2024-11-26T13:20:37.913' AS DateTime), N'Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0', NULL, 401, N'Se intento iniciar sesion con el username: string')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1014, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:05:37.900' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1015, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:06:45.550' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1016, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:07:11.200' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1017, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:10:05.443' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1018, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:10:59.730' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1019, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:31:49.370' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1020, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:32:56.707' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1021, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:33:23.993' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1022, N'::1', N'/Auth/Login', CAST(N'2024-11-26T17:49:26.483' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1023, N'::1', N'/Auth/Login', CAST(N'2024-11-26T18:46:50.667' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1024, N'::1', N'/Auth/Login', CAST(N'2024-11-26T19:28:10.157' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1025, N'::1', N'/Auth/Login', CAST(N'2024-11-26T20:35:15.617' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1026, N'::1', N'/Auth/Login', CAST(N'2024-11-26T21:05:20.237' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1027, N'::1', N'/Auth/Login', CAST(N'2024-11-26T21:05:29.140' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1028, N'::1', N'/Auth/Login', CAST(N'2024-11-26T21:05:44.727' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1029, N'::1', N'/Auth/Login', CAST(N'2024-11-26T21:05:53.737' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1030, N'::1', N'/Auth/Login', CAST(N'2024-11-26T21:18:49.367' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1031, N'::1', N'/Auth/Login', CAST(N'2024-11-26T23:54:29.290' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1032, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:10:21.790' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1033, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:10:46.817' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1034, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:12:18.860' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1035, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:14:23.147' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1036, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:15:26.883' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1037, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:16:27.903' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1038, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:17:17.930' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1039, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:17:45.797' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1040, N'::1', N'/Auth/Login', CAST(N'2024-11-27T00:18:07.870' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1041, N'::1', N'/Auth/Login', CAST(N'2024-11-28T22:43:20.883' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1042, N'::1', N'/Auth/Login', CAST(N'2024-11-28T22:44:01.733' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1043, N'::1', N'/Auth/Login', CAST(N'2024-11-28T22:50:38.290' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1044, N'::1', N'/Auth/Login', CAST(N'2024-11-28T22:50:47.827' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1045, N'::1', N'/Auth/Login', CAST(N'2024-11-28T22:55:29.503' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1046, N'::1', N'/Auth/Login', CAST(N'2024-11-28T23:05:44.783' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1047, N'::1', N'/Auth/register', CAST(N'2024-11-29T00:47:56.327' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 500, N'Could not find stored procedure ''register_new_user''.')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1048, N'::1', N'/Auth/register', CAST(N'2024-11-29T00:48:48.423' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: assgromo exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1049, N'::1', N'/Auth/register', CAST(N'2024-11-29T00:53:40.900' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asfsaffsaasf exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1050, N'::1', N'/Auth/register', CAST(N'2024-11-29T00:56:23.797' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsda exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1051, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:02:49.953' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 500, N'Violation of UNIQUE KEY constraint ''users_unique''. Cannot insert duplicate key in object ''dbo.users''. The duplicate key value is (asdsadsda).
The statement has been terminated.')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1052, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:02:57.580' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsdaa exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1053, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:03:11.973' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsdaaa exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1054, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:03:27.337' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 500, N'Violation of UNIQUE KEY constraint ''users_unique''. Cannot insert duplicate key in object ''dbo.users''. The duplicate key value is (asdsadsdaaa).
The statement has been terminated.')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1055, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:03:30.313' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsdaaaa exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1056, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:04:41.320' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsdaaaaa exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1057, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:04:48.977' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsdaaaaaa exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1058, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:05:00.803' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 500, N'Violation of UNIQUE KEY constraint ''users_unique''. Cannot insert duplicate key in object ''dbo.users''. The duplicate key value is (asdsadsdaaaaaa).
The statement has been terminated.')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1059, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:05:08.383' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdsadsdaaaaaaa exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1060, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:12:18.827' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdfasdf exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1061, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:12:36.490' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdfasdf exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1062, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:14:38.827' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdfasdf exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1063, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:15:52.713' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'No se pudo registrar el usuario: asdfasdf, podria ya estar en uso')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1064, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:18:36.960' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'No se pudo registrar el usuario: asdfasdf, podria ya estar en uso')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1065, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:20:03.537' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'No se pudo registrar el usuario: asdfasdf, podria ya estar en uso')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1066, N'::1', N'/Auth/register', CAST(N'2024-11-29T01:20:15.710' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: asdfasdfER exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1067, N'::1', N'/Auth/Login', CAST(N'2024-11-29T01:21:08.633' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1068, N'::1', N'/Auth/Login', CAST(N'2024-11-29T01:21:36.953' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1069, N'::1', N'/Auth/Login', CAST(N'2024-11-29T01:21:45.967' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1070, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:36:54.417' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1071, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:39:06.283' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1072, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:39:15.593' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: prueba')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1073, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:39:19.907' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: assgromo')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1074, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:39:23.760' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1075, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:39:39.770' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1076, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:39:55.203' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1077, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:40:11.030' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1078, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:40:24.030' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1079, N'::1', N'/Auth/Login', CAST(N'2024-11-30T07:40:31.470' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1080, N'::1', N'/Auth/Login', CAST(N'2024-11-30T08:07:14.457' AS DateTime), N'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', NULL, 200, N'El usuario: assgromo, id: 1000, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1081, N'::1', N'/Auth/Login', CAST(N'2024-11-30T08:10:10.097' AS DateTime), N'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
GO
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1082, N'::1', N'/Auth/register', CAST(N'2024-11-30T08:13:21.447' AS DateTime), N'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', NULL, 200, N'Se registro el usuario: marcelo1 exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1083, N'::1', N'/Auth/Login', CAST(N'2024-11-30T08:13:57.003' AS DateTime), N'Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1', NULL, 200, N'El usuario: marcelo1, id: 1014, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1084, N'::1', N'/Auth/Login', CAST(N'2024-11-30T08:45:38.847' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1085, N'::1', N'/Auth/Login', CAST(N'2024-11-30T09:16:50.750' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1086, N'::1', N'/Auth/Login', CAST(N'2024-11-30T17:04:04.327' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1087, N'::1', N'/Auth/Login', CAST(N'2024-12-01T12:49:23.823' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1088, N'::1', N'/Auth/register', CAST(N'2024-12-01T13:18:55.580' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'Se registro el usuario: canderamirez exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1089, N'::1', N'/Auth/Login', CAST(N'2024-12-01T13:19:11.690' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: canderamirez, id: 1015, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1090, N'::ffff:192.168.0.51', N'/Auth/register', CAST(N'2024-12-01T19:58:09.763' AS DateTime), N'Mozilla/5.0 (Linux; Android 13; SM-A325M Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.6723.108 Mobile Safari/537.36 OPX/2.6', NULL, 200, N'Se registro el usuario: Agusgromo exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1091, N'::ffff:192.168.0.51', N'/Auth/Login', CAST(N'2024-12-01T19:58:26.603' AS DateTime), N'Mozilla/5.0 (Linux; Android 13; SM-A325M Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.6723.108 Mobile Safari/537.36 OPX/2.6', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1092, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:03:34.257' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1093, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:04:20.627' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1094, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:37:23.123' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1095, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:50:08.083' AS DateTime), N'Mozilla/5.0 (Linux; Android 11.0; Surface Duo) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1096, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:50:21.573' AS DateTime), N'Mozilla/5.0 (Linux; Android 11.0; Surface Duo) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1097, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:50:57.010' AS DateTime), N'Mozilla/5.0 (Linux; Android 11.0; Surface Duo) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1098, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:51:07.960' AS DateTime), N'Mozilla/5.0 (Linux; Android 11.0; Surface Duo) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1099, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T20:51:22.810' AS DateTime), N'Mozilla/5.0 (Linux; Android 11.0; Surface Duo) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Agusgromo, id: 1016, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1100, N'::ffff:192.168.0.51', N'/Auth/register', CAST(N'2024-12-01T21:00:22.193' AS DateTime), N'Mozilla/5.0 (Linux; Android 13; SM-A325M Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.6723.108 Mobile Safari/537.36 OPX/2.6', NULL, 200, N'Se registro el usuario: Jorgejorge exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1101, N'::ffff:192.168.0.51', N'/Auth/Login', CAST(N'2024-12-01T21:00:37.927' AS DateTime), N'Mozilla/5.0 (Linux; Android 13; SM-A325M Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.6723.108 Mobile Safari/537.36 OPX/2.6', NULL, 200, N'El usuario: Jorgejorge, id: 1017, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1102, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T21:05:12.983' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1103, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T21:11:41.763' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1104, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T21:12:36.303' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1105, N'::ffff:192.168.0.242', N'/Auth/Login', CAST(N'2024-12-01T21:20:36.723' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1106, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-12-01T22:41:45.107' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1107, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-12-01T22:42:03.630' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1108, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-12-01T22:42:22.667' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: prueba')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1109, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-12-01T22:42:35.090' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 401, N'Se intento iniciar sesion con el username: prueba')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1110, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-12-01T22:42:52.910' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1111, N'::ffff:192.168.0.225', N'/Auth/Login', CAST(N'2024-12-01T22:52:02.417' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1112, N'::ffff:192.168.135.15', N'/Auth/Login', CAST(N'2024-12-02T08:44:02.953' AS DateTime), N'Mozilla/5.0 (Linux; Android 13; SM-A325M Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.6723.108 Mobile Safari/537.36 OPX/2.6', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1113, N'::ffff:192.168.135.253', N'/Auth/Login', CAST(N'2024-12-02T08:45:36.550' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1114, N'::ffff:192.168.135.15', N'/Auth/Login', CAST(N'2024-12-02T09:13:29.587' AS DateTime), N'Mozilla/5.0 (Linux; Android 13; SM-A325M Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.6723.108 Mobile Safari/537.36 OPX/2.6', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1115, N'::ffff:192.168.135.1', N'/Auth/register', CAST(N'2024-12-02T09:52:18.077' AS DateTime), N'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36', NULL, 200, N'Se registro el usuario: Ramarama exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1116, N'::ffff:192.168.135.1', N'/Auth/Login', CAST(N'2024-12-02T09:52:34.727' AS DateTime), N'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Ramarama, id: 1018, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1117, N'::ffff:192.168.135.1', N'/Auth/Login', CAST(N'2024-12-02T09:53:22.333' AS DateTime), N'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36', NULL, 200, N'El usuario: Ramarama, id: 1018, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1118, N'::ffff:192.168.100.25', N'/Auth/Login', CAST(N'2024-12-06T12:55:40.850' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1119, N'::ffff:192.168.100.25', N'/Auth/Login', CAST(N'2024-12-06T12:56:35.670' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1120, N'::ffff:192.168.100.25', N'/Auth/Login', CAST(N'2024-12-06T16:43:54.133' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (1121, N'::1', N'/Auth/Login', CAST(N'2024-12-13T19:08:53.440' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 OPR/114.0.0.0', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (2121, N'::1', N'/Auth/Login', CAST(N'2025-01-02T22:03:22.067' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', NULL, 401, N'Se intento iniciar sesion con el username: agustin')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (2122, N'::1', N'/Auth/Login', CAST(N'2025-01-02T22:03:27.547' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', NULL, 401, N'Se intento iniciar sesion con el username: agustin')
INSERT [dbo].[request_logs] ([id], [ip], [endpoint], [date_and_time], [user_agent], [id_user], [status_code], [message]) VALUES (2123, N'::1', N'/Auth/Login', CAST(N'2025-01-02T22:05:09.870' AS DateTime), N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', NULL, 200, N'El usuario: prueba, id: 0, inicio sesion exitosamente')
SET IDENTITY_INSERT [dbo].[request_logs] OFF
GO
SET IDENTITY_INSERT [dbo].[rols] ON 

INSERT [dbo].[rols] ([id], [rol_name]) VALUES (2, N'admin')
INSERT [dbo].[rols] ([id], [rol_name]) VALUES (3, N'operador')
INSERT [dbo].[rols] ([id], [rol_name]) VALUES (1, N'super')
INSERT [dbo].[rols] ([id], [rol_name]) VALUES (4, N'usuario')
SET IDENTITY_INSERT [dbo].[rols] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [password], [name], [last_name], [rol]) VALUES (0, N'prueba', N'test', N'prueba', N'test', 1)
INSERT [dbo].[users] ([id], [username], [password], [name], [last_name], [rol]) VALUES (1000, N'assgromo', N'12345678', N'agustin', N'sgromo', 4)
INSERT [dbo].[users] ([id], [username], [password], [name], [last_name], [rol]) VALUES (1014, N'marcelo1', N'marcelo1', N'marcelo', N'audisio', 4)
INSERT [dbo].[users] ([id], [username], [password], [name], [last_name], [rol]) VALUES (1016, N'Agusgromo', N'12345678', N'Agustin', N'Sgromo', 4)
INSERT [dbo].[users] ([id], [username], [password], [name], [last_name], [rol]) VALUES (1017, N'Jorgejorge', N'jorgejorge', N'Jorge', N'Jorge', 4)
INSERT [dbo].[users] ([id], [username], [password], [name], [last_name], [rol]) VALUES (1018, N'Ramarama', N'ramarama', N'Rama', N'San', 4)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[users_x_products] ON 

INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (48, 1016, 4, 6)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (49, 1016, 12, 1)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (50, 1016, 18, 1)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (63, 1017, 9, 4)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (76, 1018, 9, 1)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (81, 0, 9, 2)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (82, 0, 33, 1)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (83, 0, 8, 1)
INSERT [dbo].[users_x_products] ([id], [user_id], [product_id], [amount]) VALUES (1083, 0, 10, 1)
SET IDENTITY_INSERT [dbo].[users_x_products] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NewTable_UNIQUE]    Script Date: 02/01/2025 10:10:54 p. m. ******/
ALTER TABLE [dbo].[rols] ADD  CONSTRAINT [NewTable_UNIQUE] UNIQUE NONCLUSTERED 
(
	[rol_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [users_unique]    Script Date: 02/01/2025 10:10:54 p. m. ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [users_unique] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((4)) FOR [rol]
GO
ALTER TABLE [dbo].[users_x_products] ADD  DEFAULT ((1)) FOR [amount]
GO
ALTER TABLE [dbo].[users_x_products]  WITH CHECK ADD  CONSTRAINT [users_x_products_products_FK] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[users_x_products] CHECK CONSTRAINT [users_x_products_products_FK]
GO
ALTER TABLE [dbo].[users_x_products]  WITH CHECK ADD  CONSTRAINT [users_x_products_users_FK] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[users_x_products] CHECK CONSTRAINT [users_x_products_users_FK]
GO
ALTER TABLE [dbo].[users_x_products]  WITH CHECK ADD  CONSTRAINT [CHK_ValorPositivo] CHECK  (([amount]>(0)))
GO
ALTER TABLE [dbo].[users_x_products] CHECK CONSTRAINT [CHK_ValorPositivo]
GO
/****** Object:  StoredProcedure [dbo].[add_to_cart]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_to_cart]
	@id_item int,
	@id_user int
AS 
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM users_x_products WHERE product_id = @id_item AND user_id = @id_user)
			BEGIN
				UPDATE users_x_products SET amount = amount+1 WHERE product_id = @id_item AND user_id = @id_user;
			END
		ELSE
			BEGIN
				INSERT INTO users_x_products (user_id, product_id) VALUES (@id_user, @id_item)
			END
		SELECT prod.id, prod.product_name, prod.price, prod.stock, us_x_prod.amount
		FROM products prod
		INNER JOIN users_x_products us_x_prod ON us_x_prod.product_id = prod.id
		WHERE us_x_prod.user_id = @id_user
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[delete_item]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_item]
	@id_item int,
	@id_user int
AS 
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM users_x_products WHERE product_id = @id_item AND user_id = @id_user)
			BEGIN
				DELETE FROM users_x_products WHERE product_id = @id_item AND user_id = @id_user;
			END
		SELECT prod.id, prod.product_name, prod.price, prod.stock, us_x_prod.amount
		FROM products prod
		INNER JOIN users_x_products us_x_prod ON us_x_prod.product_id = prod.id
		WHERE us_x_prod.user_id = @id_user
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[get_products]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_products]
	@page smallint = 1
AS 
BEGIN
	IF @page < 1
	    BEGIN
	        SET @page = 1;
	    END
	SELECT id, product_name, price, image_path, description, stock
	FROM products
	ORDER BY id
	OFFSET ((@page-1) * 32) ROWS FETCH NEXT 32 ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[list_users]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[list_users]
AS 
BEGIN
	SELECT u.id, username, name, last_name, rol FROM users u 
	INNER JOIN rols r ON u.rol = r.id 
	ORDER BY username ASC;
END
GO
/****** Object:  StoredProcedure [dbo].[recover_cart]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[recover_cart]
	@id_user int
AS 
BEGIN
	SELECT prod.id, prod.product_name, prod.price, prod.stock, us_x_prod.amount
	FROM products prod
	INNER JOIN users_x_products us_x_prod ON us_x_prod.product_id = prod.id
	WHERE us_x_prod.user_id = @id_user
END
GO
/****** Object:  StoredProcedure [dbo].[register_new_user]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[register_new_user]
	@username varchar(30),
	@password varchar(30),
	@name varchar(30),
	@last_name varchar(30)
AS 
BEGIN
	IF NOT EXISTS (SELECT 1 FROM users WHERE username = @username)
		BEGIN
			INSERT INTO users (username, password, name, last_name) VALUES (@username, @password, @name, @last_name)		
		END
END
GO
/****** Object:  StoredProcedure [dbo].[remove_from_cart]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remove_from_cart]
	@id_item int,
	@id_user int
AS 
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		IF EXISTS (SELECT 1 FROM users_x_products WHERE product_id = @id_item AND user_id = @id_user)
			BEGIN
				UPDATE users_x_products SET amount = amount-1 WHERE product_id = @id_item AND user_id = @id_user;
			END
		SELECT prod.id, prod.product_name, prod.price, prod.stock, us_x_prod.amount
		FROM products prod
		INNER JOIN users_x_products us_x_prod ON us_x_prod.product_id = prod.id
		WHERE us_x_prod.user_id = @id_user
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[save_request_logs]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[save_request_logs]
	@ip varchar(45),
	@endpoint varchar(60),
	@date_and_time datetime,
	@user_agent varchar(MAX),
	@id_user int = NULL,
	@status_code smallint,
	@message varchar(MAX)
AS
BEGIN 
	INSERT INTO request_logs 
		(ip, endpoint, date_and_time, user_agent, id_user, status_code, message) 
	VALUES 
		(@ip, @endpoint, @date_and_time, @user_agent, @id_user, @status_code, @message);
END;
	
	
GO
/****** Object:  StoredProcedure [dbo].[search_product_by_name]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[search_product_by_name]
	@product_name varchar(30),
	@page smallint = 1
AS 
BEGIN
	IF @page < 1
	    BEGIN
	        SET @page = 1;
	    END
	SELECT id, product_name, price, image_path, description, stock
	FROM products
	WHERE product_name LIKE '%' + @product_name + '%'
	ORDER BY id
	OFFSET ((@page-1) * 32) ROWS FETCH NEXT 32 ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[validate_user]    Script Date: 02/01/2025 10:10:54 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[validate_user]
	@user varchar(30),
	@password varchar(20)
AS 
BEGIN
	SELECT u.id, username, name, last_name, rol_name AS rol FROM users u
	INNER JOIN rols r ON u.rol = r.id
	WHERE u.username = @user AND u.password = @password;
END

GO
USE [master]
GO
ALTER DATABASE [carrito_de_bruno] SET  READ_WRITE 
GO
