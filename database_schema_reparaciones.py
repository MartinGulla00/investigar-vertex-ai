context = """
    This are the tables in the database and their columns:
    
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
    )

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
    )

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
    )

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
    )
    
    CREATE TABLE [dbo].[DetalleReparacion]( -- esta tabla guarda los repuestos y los relaciona a una reparacion
	[Id] [bigint] IDENTITY(1,1) NOT NULL, 
	[ReparacionId] [bigint] NULL, -- id de la reparacion
	[RepuestoId] [bigint] NULL, -- id del repuesto
	[Costo] [decimal](10, 2) NULL, -- cuanto cuesta el repuesto
    CONSTRAINT [PK_DetalleServicio] PRIMARY KEY CLUSTERED
    )

    CREATE TABLE [dbo].[ReparacionesEventos]( --guarda los eventos relacionados a una reparacion
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Accion] [varchar](50) NOT NULL, -- accion realizada
	[Usuario] [nvarchar](100) NULL, -- usuario que realizo la accion
	[ReparacionId] [bigint] NOT NULL, -- id de la reparacion
	[Detalle] [nvarchar](4000) NULL, -- detalle de la accion
	[FechaEvento] [datetime] NOT NULL, -- fecha del evento
    CONSTRAINT [PK_SReparacionesEventos] PRIMARY KEY CLUSTERED
    )

    CREATE TABLE [dbo].[Repuestos](s
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PN] [varchar](255) NOT NULL, -- otro identificador
	[Descripcion] [varchar](250) NOT NULL, -- descripcion del repuesto
	[Margen] [decimal](10, 2) NULL, -- precio
    CONSTRAINT [PK_Repuestos] PRIMARY KEY CLUSTERED
    )

    CREATE TABLE [dbo].[ResponsablePagoReparacion](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Responsable] [nvarchar](255) NOT NULL, -- responsable de pagar la reparacion
    PRIMARY KEY CLUSTERED 
    )

    CREATE TABLE [dbo].[ESTADOS_STR]( -- esta tabla es la que se utiliza para los estados del resto de tablas, se asocia tabla e id con un string
	[TABLA] [varchar](50) NOT NULL, -- nombre de la tabla
	[ESTADO] [int] NOT NULL, -- id del estado
	[VALOR] [varchar](50) NOT NULL, -- valor del estado
    CONSTRAINT [PK_ESTADOS_STR] PRIMARY KEY CLUSTERED
    )
    """