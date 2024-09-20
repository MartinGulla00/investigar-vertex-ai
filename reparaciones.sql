USE [Orquesta]
GO

/****** Object:  Table [dbo].[Reparaciones]    Script Date: 5/9/2024 18:35:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Reparaciones](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdTaller] [bigint] NOT NULL,
	[Tecnico] [varchar](255) NULL, -- tecnico que hace la reparacion (osea que repara)
	[Cliente] [varchar](50) NULL, -- codigo de cliente
	[Instalacion] [bigint] NULL, --id de la instalacion
	[Pos] [bigint] NULL, -- id del pos
	[Presupuesto] [varchar](255) NULL, --  suma total de los costos
	[Reactivacion] [decimal](10, 2) NULL, -- cuanto le cobran al cliente por reactivar el pos
	[Tcom] [decimal](10, 2) NULL, -- cuanto le cobran al cliente por probar el pos
	[ManoDeObra] [decimal](10, 2) NULL, -- cuanto le cobran al cliente por la mano de obra
	[Total] [decimal](10, 2) NULL, --  valor total de la reparacion (suma de las otras)
	[Comentarios] [varchar](255) NULL, -- comentarios de la reparacion
	[FechaInicio] [date] NULL, -- fecha de inicio de la reparacion
	[FechaFinalizacion] [date] NULL, -- fecha de finalizacion de la reparacion
	[FechaFacturado] [date] NULL, -- fecha en la que se factura la reparacion (despues de finalizacion)
	[DocumentoReferencia] [bigint] NULL, -- id de la factura(no manejamos)
	[ResponsablePago] [varchar](100) NULL, -- responsable de pagar la reparacion (cliente, oca, cliente cpatu)
	[CostoFacturado] [decimal](10, 2) NULL, -- costo facturado de la reparacion (se guarda por casos especiales normalmente es igual a total)
	[Estado] [int] NOT NULL, -- id del estado de la reparacion 
	[Factura] [varchar](250) NULL, -- numero de factura
	[FechaClienteInformado] [datetime] NULL, -- fecha en la que se informa al cliente
 CONSTRAINT [PK_ServiciosTecnicos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Reparaciones]  WITH CHECK ADD FOREIGN KEY([Instalacion])
REFERENCES [dbo].[INSTALACIONES] ([INST_ID])
GO

ALTER TABLE [dbo].[Reparaciones]  WITH CHECK ADD FOREIGN KEY([Pos])
REFERENCES [dbo].[POS] ([POS_ID])
GO

ALTER TABLE [dbo].[Reparaciones]  WITH CHECK ADD  CONSTRAINT [FK_Reparaciones_CABREMITO] FOREIGN KEY([DocumentoReferencia])
REFERENCES [dbo].[CABREMITO] ([REMI_ID])
GO

ALTER TABLE [dbo].[Reparaciones] CHECK CONSTRAINT [FK_Reparaciones_CABREMITO]
GO

ALTER TABLE [dbo].[Reparaciones]  WITH CHECK ADD  CONSTRAINT [FK_Reparaciones_TALLER] FOREIGN KEY([IdTaller])
REFERENCES [dbo].[TALLER] ([TAL_ID])
GO

ALTER TABLE [dbo].[Reparaciones] CHECK CONSTRAINT [FK_Reparaciones_TALLER]
GO


USE [Orquesta]
GO

/****** Object:  Table [dbo].[POS]    Script Date: 5/9/2024 18:35:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[POS](
	[POS_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[POS_SERIAL] [varchar](80) NOT NULL, -- numero de serie del pos
	[POS_SERIALCAJA] [varchar](80) NOT NULL, -- numero de serie de la caja
	[POS_TIPOCONEXION] [varchar](15) NOT NULL, -- tipo de conexion del pos (3G, ETH, WIFI)
	[POS_TIPOHW] [varchar](50) NOT NULL, -- tipo de hardware del pos (pos, pinpad, etc, no usamos)
	[POS_ESTADO] [int] NOT NULL, -- id del estado del pos 
	[POS_DEPOSITO] [int] NULL, -- id del deposito del pos
	[POS_UBICACION] [int] NULL, -- id de la ubicacion del pos
	[POS_PROVEEDOR] [varchar](50) NOT NULL, -- nombre del proveedor OCA, HANDY , VISA, RESONET
	[POS_OC] [varchar](50) NOT NULL, -- numero de orden de compra(no usamos)
	[POS_NROFACTURA] [varchar](50) NOT NULL, -- numero de factura(no usamos)
	[POS_FECHAINGRESO] [datetime] NOT NULL, -- fecha de ingreso del pos
	[POS_USUARIOALTA] [varchar](50) NOT NULL, -- usuario que da de alta el pos
	[POS_USUARIOBAJA] [varchar](50) NULL, -- usuario que da de baja el pos
	[POS_USUARIOACTIVACION] [varchar](50) NULL, -- usuario que activa el pos
	[POS_FECHABAJA] [datetime] NULL, -- fecha de baja del pos
	[POS_FECHAACTIVACION] [datetime] NULL, -- fecha de activacion del pos
	[POS_VERSION_SW] [varchar](50) NOT NULL, -- version de software del pos
	[POS_ESTADO_CFG] [int] NOT NULL, -- id del estado de la configuracion del pos
	[POS_VERSION_KEYS] [varchar](50) NOT NULL, -- version de las keys del pos
	[POS_SIM] [bigint] NULL, -- numero de sim del pos
	[POS_MAC] [varchar](50) NULL, -- mac del pos
	[POS_PROPIETARIO] [varchar](50) NULL, -- propietario del pos OCA, HANDY , VISA, RESONET
	[POS_MODELO] [varchar](50) NOT NULL, -- modelo del pos MOVE5000, MOVE2500, etc
	[POS_MARCA] [varchar](25) NOT NULL, -- marca del pos INGENICO, NEWLAND, etc
	[POS_PRODUCTID] [varchar](50) NOT NULL, -- id del producto del pos(no usamos)
	[POS_PCI] [varchar](80) NOT NULL, -- numero de pci del pos
	[POS_PCI_FECHA] [date] NULL, -- fecha alta pci
	[POS_PCI_VENCIMIENTO] [date] NULL, -- fecha vencimiento pci
	[POS_CARGADOR] [bit] NOT NULL, -- si tiene cargador
	[POS_CAJA] [bit] NOT NULL, -- si tiene caja
	[POS_ROLLO] [bit] NOT NULL, -- si tiene rollo
	[POS_MANUAL] [bit] NOT NULL, -- si tiene manual
	[POS_ESTADO_PRUEBAS] [int] NOT NULL, -- id del estado de pruebas del pos
	[POS_PRUEBAS_NOTAS] [varchar](200) NOT NULL, -- notas de pruebas del pos
	[POS_CASE] [bit] NOT NULL, -- si tiene case
	[POS_ESTADOMIGRACION] [int] NULL, -- id del estado de migracion del pos
	[POS_USUFRUCTO] [varchar](50) NULL, -- usuario que tiene el pos en usufructo
	[POS_ORIGEN] [varchar](50) NULL, -- origen del pos OCA, HANDY, VISA, RESONET
	[POS_PRESTATARIO] [varchar](50) NULL, -- prestatario del pos
	[POS_SERIE_ESPERADA] [varchar](50) NULL, -- serie esperada del pos
	[POS_MODELO_ESPERADO] [varchar](50) NULL, -- modelo esperado del pos
	[POS_VALIDADO] [varchar](50) NULL, -- validacion PCK,TRX, etc -> PCK = esta en la empresa, TRX esta transaccionando
	[POS_PART_NUMBER] [varchar](50) NULL, -- part number del pos (otro identificador)
 CONSTRAINT [PK_POS] PRIMARY KEY CLUSTERED 
(
	[POS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF_POS_POS_CARGADOR]  DEFAULT ((0)) FOR [POS_CARGADOR]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF_POS_POS_CAJA]  DEFAULT ((0)) FOR [POS_CAJA]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF_POS_POS_ROLLO]  DEFAULT ((0)) FOR [POS_ROLLO]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF_POS_POS_CAJA1]  DEFAULT ((0)) FOR [POS_MANUAL]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF_POS_POS_ESTADO_PRUEBAS]  DEFAULT ((0)) FOR [POS_ESTADO_PRUEBAS]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF_POS_POS_ESTADO_PRUEBAS1]  DEFAULT ((0)) FOR [POS_PRUEBAS_NOTAS]
GO

ALTER TABLE [dbo].[POS] ADD  CONSTRAINT [DF__POS__POS_CASE__540C7B00]  DEFAULT ((0)) FOR [POS_CASE]
GO

ALTER TABLE [dbo].[POS]  WITH CHECK ADD  CONSTRAINT [FK_POS_Depositos] FOREIGN KEY([POS_DEPOSITO])
REFERENCES [dbo].[Depositos] ([DEP_ID])
GO

ALTER TABLE [dbo].[POS] CHECK CONSTRAINT [FK_POS_Depositos]
GO

ALTER TABLE [dbo].[POS]  WITH CHECK ADD  CONSTRAINT [FK_POS_POS_MODELOS] FOREIGN KEY([POS_MARCA], [POS_MODELO])
REFERENCES [dbo].[POS_MODELOS] ([MODELO_MARCA], [MODELO_MODELO])
GO

ALTER TABLE [dbo].[POS] CHECK CONSTRAINT [FK_POS_POS_MODELOS]
GO

ALTER TABLE [dbo].[POS]  WITH CHECK ADD  CONSTRAINT [FK_POS_PRESTATARIOS] FOREIGN KEY([POS_PRESTATARIO])
REFERENCES [dbo].[PROPIETARIOS] ([PROP_COD])
GO

ALTER TABLE [dbo].[POS] CHECK CONSTRAINT [FK_POS_PRESTATARIOS]
GO

ALTER TABLE [dbo].[POS]  WITH CHECK ADD  CONSTRAINT [FK_POS_Ubicaciones] FOREIGN KEY([POS_UBICACION])
REFERENCES [dbo].[Ubicaciones] ([UBI_ID])
GO

ALTER TABLE [dbo].[POS] CHECK CONSTRAINT [FK_POS_Ubicaciones]
GO



USE [Orquesta]
GO

/****** Object:  Table [dbo].[TALLER]    Script Date: 5/9/2024 18:34:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TALLER](
	[TAL_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TAL_FECHA] [date] NOT NULL, -- fecha que se agrego el registro
	[TAL_INGRESADO] [datetime] NOT NULL, -- fecha y hora que entro al taller
	[TAL_POSID] [bigint] NOT NULL, -- id del pos
	[TAL_USUARIOENTRADA] [varchar](50) NOT NULL, -- usuario que ingreso el pos
	[TAL_NOTASENTRADA] [varchar](300) NOT NULL,     -- notas de entrada
	[TAL_ESTADO] [int] NOT NULL, -- id del estado del pos en taller
	[TAL_FECHASALIDA] [date] NULL, -- fecha de salida del pos
	[TAL_SALIDA] [datetime] NULL, -- fecha y hora de salida del pos
	[TAL_ESTADOPOSSALIDA] [int] NULL, -- id del estado del pos al salir del taller
	[TAL_NOTASSALIDA] [varchar](300) NULL, -- notas de salida
	[TAL_USUARIOSALIDA] [varchar](50) NULL, -- usuario que saco el pos
	[TAL_ESTADOPOSENTRADA] [int] NOT NULL, -- id del estado del pos al entrar al taller
	[TAL_CLICOD] [varchar](50) NOT NULL, -- codigo de cliente
	[TAL_INSTID] [bigint] NULL, -- id de la instalacion
	[TAL_INSTPOSID] [bigint] NULL, -- id de la instalacion del pos
 CONSTRAINT [PK_TALLER] PRIMARY KEY CLUSTERED 
(
	[TAL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TALLER] ADD  DEFAULT ('') FOR [TAL_CLICOD]
GO

ALTER TABLE [dbo].[TALLER]  WITH CHECK ADD  CONSTRAINT [FK_TALLER_POS] FOREIGN KEY([TAL_POSID])
REFERENCES [dbo].[POS] ([POS_ID])
GO

ALTER TABLE [dbo].[TALLER] CHECK CONSTRAINT [FK_TALLER_POS]
GO



USE [Orquesta]
GO

/****** Object:  Table [dbo].[INSTALACIONES]    Script Date: 5/9/2024 18:34:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[INSTALACIONES](
	[INST_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[INST_CONTRATOID] [bigint] NULL, -- id del contrato
	[INST_NROINSTALACION] [varchar](50) NULL, -- numero de instalacion
	[INST_SUCCOD] [varchar](50) NULL, -- codigo de sucursal
	[INST_FECHAPROMETIDA] [date] NULL, -- fecha prometida de la instalacion (cuando dijimos que la ibamos a entregar)
	[INST_FECHABAJA] [date] NULL, -- fecha de baja de la instalacion
	[INST_FECHAINGRESO] [datetime] NULL, -- fecha de ingreso de la instalacion
	[INST_USUARIOINGRESO] [varchar](50) NULL, -- usuario que ingreso la instalacion
	[INST_FECHA_ENTREGADO] [date] NULL, -- fecha de entrega de la instalacion
	[INST_USU_CONF_ENTREGA] [varchar](50) NULL, -- usuario que confirma la entrega
	[INST_ESTADO_LOGISTICA] [int] NULL, -- id del estado de la logistica
	[INST_ESTADO_POS] [int] NULL, -- id del estado del pos
	[INST_ESTADO_SERVICIO] [int] NULL, -- id del estado del servicio 
	[INST_ESTADO] [int] NULL, -- id del estado de la instalacion
	[INST_INSTALADOR] [varchar](50) NULL, -- nombre del instalador
	[INST_COMENTARIOS] [varchar](300) NULL, -- comentarios de la instalacion
	[INST_TIPOCOMERCIO] [int] NOT NULL, -- id del tipo de comercio
	[INST_TIPOCONEXION] [varchar](15) NOT NULL, -- tipo de conexion de la instalacion (3G, ETH, WIFI)
	[INST_MONEDA] [varchar](10) NULL, -- moneda de la instalacion
	[INST_VOUCHER_COMERCIO] [varchar](50) NULL, -- voucher del comercio
	[INST_VOUCHER_DIRECCION] [varchar](50) NULL, -- direccion del voucher
	[INST_ESTADOMIGRACION] [int] NULL, -- id del estado de migracion de la instalacion
	[INST_NROINSTALACIONANT] [varchar](50) NULL, -- numero de instalacion anterior
	[INST_FECHACOMIENZOFACTURACION] [date] NULL, -- fecha de comienzo de facturacion
	[INST_ULTIMAFECHAFACTGEOCOM] [date] NULL, -- ultima fecha de facturacion geocom
	[INST_MADRE] [varchar](25) NULL, -- madre de la instalacion (nro instalacion de otra instalacion)
	[INST_TIENE_HIJOS] [bit] NOT NULL, -- si tiene hijos
	[INST_CATEGORIAPOS_ID] [bigint] NULL, -- id de la categoria del pos
	[INST_PARAMETERGROUP] [int] NULL, -- id del grupo de parametros
	[INST_PARAMETERVERSION] [int] NULL, -- version de los parametros
	[INST_POSLINK] [bit] NULL, -- si tiene poslink
	[INST_PAQUETE] [varchar](63) NULL, -- paquete de la instalacion
	[INST_PROGRAMVERSION] [int] NULL, -- version del programa
	[INST_APPVERSION] [varchar](150) NULL, -- version de la app
	[INST_PROGRAMID] [int] NULL, -- id del programa
	[INST_CONNECTGROUP] [int] NULL, -- id del grupo de conexion
	[INST_CONTROLGROUP] [int] NULL, -- id del grupo de control
	[INST_POSLINK_PUNTO_VENTA]  
	[bit] NOT NULL, -- si tiene poslink punto de venta
	[INST_POSLINK_POLEO] [int] NOT NULL, -- id del poslink poleo
	[INST_POSLINK_TID] [varchar](50) NULL, -- tid del poslink
 CONSTRAINT [PK_INSTALACIONES] PRIMARY KEY CLUSTERED  
(
	[INST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[INSTALACIONES] ADD  CONSTRAINT [DF_INSTALACIONES_TIPOCOMERCIO]  DEFAULT ((0)) FOR [INST_TIPOCOMERCIO]
GO

ALTER TABLE [dbo].[INSTALACIONES] ADD  DEFAULT ((0)) FOR [INST_TIENE_HIJOS]
GO

ALTER TABLE [dbo].[INSTALACIONES] ADD  DEFAULT ((0)) FOR [INST_POSLINK]
GO

ALTER TABLE [dbo].[INSTALACIONES] ADD  DEFAULT ((0)) FOR [INST_POSLINK_PUNTO_VENTA]
GO

ALTER TABLE [dbo].[INSTALACIONES] ADD  DEFAULT ((0)) FOR [INST_POSLINK_POLEO]
GO

ALTER TABLE [dbo].[INSTALACIONES]  WITH CHECK ADD  CONSTRAINT [FK_INSTALACIONES_CATEGORIA] FOREIGN KEY([INST_CATEGORIAPOS_ID])
REFERENCES [dbo].[CategoriaPos] ([Id])
GO

ALTER TABLE [dbo].[INSTALACIONES] CHECK CONSTRAINT [FK_INSTALACIONES_CATEGORIA]
GO


USE [Orquesta]
GO

/****** Object:  Table [dbo].[DetalleReparacion]    Script Date: 5/9/2024 18:33:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetalleReparacion]( -- esta tabla guarda los repuestos y los relaciona a una reparacion
	[Id] [bigint] IDENTITY(1,1) NOT NULL, 
	[ReparacionId] [bigint] NULL,
	[RepuestoId] [bigint] NULL,
	[Costo] [decimal](10, 2) NULL, -- cuanto cuesta el repuesto
 CONSTRAINT [PK_DetalleServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DetalleReparacion]  WITH CHECK ADD FOREIGN KEY([ReparacionId])
REFERENCES [dbo].[Reparaciones] ([Id])
GO

ALTER TABLE [dbo].[DetalleReparacion]  WITH CHECK ADD FOREIGN KEY([RepuestoId])
REFERENCES [dbo].[Repuestos] ([Id])
GO



USE [Orquesta]
GO

/****** Object:  Table [dbo].[ReparacionesEventos]    Script Date: 5/9/2024 18:37:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ReparacionesEventos]( --guarda los eventos relacionados a una reparacion
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Accion] [varchar](50) NOT NULL,
	[Usuario] [nvarchar](100) NULL,
	[ReparacionId] [bigint] NOT NULL,
	[Detalle] [nvarchar](4000) NULL,
	[FechaEvento] [datetime] NOT NULL,
 CONSTRAINT [PK_SReparacionesEventos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ReparacionesEventos]  WITH CHECK ADD FOREIGN KEY([ReparacionId])
REFERENCES [dbo].[Reparaciones] ([Id])
GO


USE [Orquesta]
GO

/****** Object:  Table [dbo].[Repuestos]    Script Date: 5/9/2024 18:37:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Repuestos](s
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PN] [varchar](255) NOT NULL, -- otro identificador
	[Descripcion] [varchar](250) NOT NULL,
	[Margen] [decimal](10, 2) NULL, -- precio
 CONSTRAINT [PK_Repuestos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Orquesta]
GO

/****** Object:  Table [dbo].[ResponsablePagoReparacion]    Script Date: 5/9/2024 18:37:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ResponsablePagoReparacion](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Responsable] [nvarchar](255) NOT NULL, 
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[ESTADOS_STR](
	[TABLA] [varchar](50) NOT NULL,
	[ESTADO] [int] NOT NULL,
	[VALOR] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ESTADOS_STR] PRIMARY KEY CLUSTERED 
(
	[TABLA] ASC,
	[ESTADO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

------------------------------------

--EJEMPLO ESTADOS:

-- TABLA	ESTADO	VALOR
-- CONTRATO	0	INGRESADO
-- CONTRATO	1	ESPERANDO POS
-- CONTRATO	2	ACTIVO
-- CONTRATO	3	BAJA
-- CONTRATO	4	A DESINSTALAR
-- INSTALACION	0	INGRESADO
-- INSTALACION	1	ESPERANDO POS
-- INSTALACION	2	ACTIVA
-- INSTALACION	3	POS ASIGNADO
-- INSTALACION	4	EN LOGISTICA
-- INSTALACION	5	CAMBIO
-- INSTALACION	6	BAJA
-- INSTALACION	7	EN PROCESO DE BAJA
-- INSTALACION	8	RECHAZADA
-- INSTALACION	9	BLOQUEADA
-- INSTALACION	10	SIN MIGRAR
-- INSTALACION	11	GESTION COMERCIAL
-- INSTALACION	12	STAND BY
-- INSTALACION	13	CONFIGURACIÓN COMERCIAL
-- INSTALACION_POS	0	ASIGNADO
-- INSTALACION_POS	1	SIN ASIGNAR
-- INSTALACION_POS	2	BAJA
-- INSTALACION_POS	3	RECAMBIO DE POS
-- INSTALACION_POS	4	SUSTITUIDO
-- POS	0	EN STOCK
-- POS	1	PRE PRODUCIDO
-- POS	2	EN PREPARACION
-- POS	3	PRODUCIDO
-- POS	4	INSTALADO
-- POS	5	OPERATIVO
-- POS	6	SIN USO
-- POS	8	A DESINSTALAR
-- POS	9	PERDIDO
-- POS	10	PRESTADO
-- POS	11	DESINSTALADO
-- POS	12	EN LABORATORIO
-- POS	14	DESTRUIDO
-- POS	15	SCRAP
-- POS	16	SIN MIGRAR
-- POS	17	EVALUAR TCOM
-- POS	18	A DESTRUIR
-- POS_CFG	0	SIN CONFIGURAR
-- POS_CFG	1	ETAPA DE PRUEBAS
-- POS_CFG	2	PARA CIERRE DE PRODUCCIÓN
-- POS_CFG	3	COMPLETADA
-- POS_LOGISTICA	0	NO REQUERIDO
-- POS_LOGISTICA	1	ESPERANDO GUIA
-- POS_LOGISTICA	2	ENTREGADO
-- POS_LOGISTICA	3	EN TRANSITO
-- POS_LOGISTICA	4	GUÍA EMITIDA
-- POS_LOGISTICA	5	ESPERANDO ACCION
-- POS_LOGISTICA	6	ENVIO RESONANCE
-- POS_LOGISTICA	7	RETORNO POR RECAMBIO PENDIENTE
-- POS_LOGISTICA	8	RETORNADO
-- POS_LOGISTICA	9	RETORNO POR BAJA PENDIENTE
-- POS_LOGISTICA	10	PERDIDO
-- POS_SALIDA_TALLER	0	EN STOCK
-- POS_SALIDA_TALLER	9	PERDIDA
-- POS_SALIDA_TALLER	10	PRESTADO
-- POS_SALIDA_TALLER	14	DESTRUIDO
-- POS_SALIDA_TALLER	15	SCRAP
-- REMITO	0	INGRESADO
-- REMITO	1	PARCIALMENTE ENTREGADO
-- REMITO	2	ENTREGADO
-- REMITO	4	ANULADO
-- REPARACION	0	Pendiente
-- REPARACION	1	En proceso
-- REPARACION	2	Finalizada
-- REPARACION	3	Detenida
-- REPARACION	4	Facturado
-- REPARACION	5	Cliente Informado
-- SIMS	0	INACTVA
-- SIMS	1	ACTIVA
-- SIMS	2	BAJA
-- TALLER	0	INGRESADO
-- TALLER	1	EN PROCESO
-- TALLER	2	FINALIZADO
-- TALLER_FACTURACION	0	CANCELADO
-- TALLER_FACTURACION	1	INGRESADO
-- TALLER_FACTURACION	2	PENDIENTE FACTURAR
-- TALLER_FACTURACION	3	FACTURADO
-- TALLER_FACTURACION	4	ERROR AL FACTURAR
-- TIPOS_RECAMBIOPOS	0	Rotura Fisica
-- TIPOS_RECAMBIOPOS	1	Falla Logica
-- TIPOS_RECAMBIOPOS	2	Cambio de tecnologia
-- TIPOS_RECAMBIOPOS	3	Envio perdido
-- TIPOS_RECAMBIOPOS	4	Baja de POS
-- TIPOS_RECAMBIOPOS	5	Migracion
-- TIPOS_RECAMBIOPOS	6	Equipo reparado
-- TIPOS_RECAMBIOPOS	7	Perdido
-- TIPOS_RECAMBIOPOS	99	Otro
-- TIPOS_RECAMBIOPOS	100	INGRESO DIRECTO A LABORATORIO