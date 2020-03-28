create table Cliente (
    IdCliente INTEGER,
    Nombre VARCHAR2(50),
    Apellido1 VARCHAR2(50),
    Apellido2 VARCHAR2(50),
    Observaciones VARCHAR2(50),
    
    CONSTRAINT PK_Cliente 
        PRIMARY KEY (IdCliente)
);

create table Mesa
(
    IdMesa INTEGER,
    NumMaxComensal INTEGER,
    Ubicacion VARCHAR2(50),
    
    CONSTRAINT PK_Mesa
        PRIMARY KEY (IdMesa)
);

create table Camarero
(
    IdCamarero INTEGER,
    Nombre VARCHAR2(50),
    Apellido1 VARCHAR2(50),
    Apellido2 VARCHAR2(50),
    
    CONSTRAINT PK_Camarero
        PRIMARY KEY (IdCamarero)
    
);

create table Cocinero
(
    IdCocinero INTEGER,
    Nombre  VARCHAR2(50),
    Apellido1  VARCHAR2(50),
    Apellido2  VARCHAR2(50),
    
    CONSTRAINT PK_Cocinero
        PRIMARY KEY (IdCocinero)
);

create table Factura
(
    IdFactura INTEGER,
    IdCliente INTEGER,
    IdCamarero INTEGER,
    IdMesa INTEGER,
    FechaFactura DATE,
    
    CONSTRAINT PK_Factura
        PRIMARY KEY (IdFactura),
        
    CONSTRAINT FK1_Factura
        FOREIGN KEY (IdCliente)
            REFERENCES Cliente(IdCliente) ON DELETE CASCADE,
        
    CONSTRAINT FK2_Factura
        FOREIGN KEY (IdCamarero)
            REFERENCES Camarero(IdCamarero) ON DELETE CASCADE,
    
    CONSTRAINT FK3_Factura
        FOREIGN KEY (IdMesa)
            REFERENCES Mesa(IdMesa) ON DELETE CASCADE
);



create table DetalleFactura
(
    IdFactura INTEGER,
    IdDetalleFactura INTEGER,
    IdCocinero INTEGER,
    Plato VARCHAR2(50),
    Importe INTEGER,
    
    CONSTRAINT PK_DetalleFactura
        PRIMARY KEY (IdFactura, IdDetalleFactura),
    
    CONSTRAINT FK1_DetalleFactura
        FOREIGN KEY (IdFactura)
            REFERENCES Factura(IdFactura) ON DELETE CASCADE,
        
    CONSTRAINT FK2_DetalleFactura
        FOREIGN KEY (IdCocinero)
            REFERENCES Cocinero(IdCocinero) ON DELETE CASCADE
    
);



ALTER TABLE Factura
    ADD CONSTRAINT VALIDAR_FACTURA
        CHECK (IdFactura BETWEEN 3000 AND 8000);
        
ALTER TABLE Factura 
    ADD CONSTRAINT VALIDAR_FECHA_HORA 
        CHECK (
            FechaFactura BETWEEN 
                    TO_DATE('2015-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS') 
                    AND 
                    TO_DATE('2025-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS')
        );


ALTER TABLE DetalleFactura
    ADD CONSTRAINT VALIDAR_LETRA
        CHECK (UPPER(SUBSTR(Plato,1,1)) = 'S');   

ALTER TABLE DetalleFactura
    ADD CONSTRAINT VALIDAR_PLATO
        UNIQUE (Plato);    


ALTER TABLE DetalleFactura
    ADD CONSTRAINT VALIDAR_IMPORTE
        CHECK (Importe > 75);        
