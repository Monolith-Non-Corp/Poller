CREATE DATABASE poller;
GO
USE poller;
GO

CREATE TABLE Respondiente (
  id_pk INT NOT NULL IDENTITY ,
  firstName VARCHAR(45) NOT NULL ,
  secondName VARCHAR(255) NOT NULL ,
  email VARCHAR(45) NOT NULL UNIQUE ,
  password VARCHAR(45) NOT NULL ,
  PRIMARY KEY (id_pk)
);
GO

CREATE TABLE Encuesta (
  id_pk VARCHAR(8) NOT NULL UNIQUE ,
  titulo VARCHAR(45) NOT NULL ,
  activa BIT NOT NULL ,
  propietario_fk INT NOT NULL ,
  PRIMARY KEY (id_pk) ,
  FOREIGN KEY (propietario_fk) REFERENCES Respondiente(id_pk)
);
GO

CREATE TABLE Aplicacion (
  id_pk VARCHAR(8) NOT NULL UNIQUE ,
  periodo VARCHAR(3) NOT NULL ,
  fecha DATETIME NOT NULL ,
  respondiente_fk INT NOT NULL ,
  encuesta_fk VARCHAR(8) NOT NULL ,
  PRIMARY KEY (id_pk) ,
  FOREIGN KEY (encuesta_fk) REFERENCES Encuesta(id_pk) ,
  FOREIGN KEY (respondiente_fk) REFERENCES Respondiente(id_pk)
);
GO

CREATE TABLE Tipo (
  id_pk INT NOT NULL IDENTITY ,
  tipo VARCHAR(45) NOT NULL ,
  PRIMARY KEY (id_pk)
);
GO

CREATE TABLE Pregunta (
  id_pk INT NOT NULL IDENTITY ,
  texto VARCHAR(255) NOT NULL ,
  encuesta_fk VARCHAR(8) NOT NULL ,
  tipo_fk INT NOT NULL ,
  PRIMARY KEY (id_pk) ,
  FOREIGN KEY (encuesta_fk) REFERENCES Encuesta(id_pk) ,
  FOREIGN KEY (tipo_fk) REFERENCES Tipo(id_pk)
);
GO

CREATE TABLE Pregunta_Respuesta (
  id_pk INT NOT NULL IDENTITY ,
  respuesta VARCHAR(255) NOT NULL ,
  pregunta_fk INT NOT NULL ,
  PRIMARY KEY (id_pk) ,
  FOREIGN KEY (pregunta_fk) REFERENCES Pregunta(id_pk)
);
GO

CREATE TABLE Respuesta_Seleccion (
  id_pk INT NOT NULL IDENTITY ,
  pregunta_respuesta_fk INT NOT NULL ,
  aplicacion_fk VARCHAR(8) NOT NULL ,
  PRIMARY KEY (id_pk) ,
  FOREIGN KEY (pregunta_respuesta_fk) REFERENCES Pregunta_Respuesta(id_pk) ,
  FOREIGN KEY (aplicacion_fk) REFERENCES Aplicacion(id_pk) ,
);
GO

CREATE TABLE Respuesta_Abierta (
  respuesta VARCHAR(255) NOT NULL ,
  pregunta_fk INT NOT NULL ,
  aplicacion_fk VARCHAR(8) NOT NULL ,
  FOREIGN KEY (pregunta_fk) REFERENCES Pregunta(id_pk) ,
  FOREIGN KEY (aplicacion_fk) REFERENCES Aplicacion(id_pk)
);
GO

CREATE PROCEDURE test
  AS
  SELECT 'Hello World' AS hi;
  GO

CREATE PROCEDURE test_in @some VARCHAR(255)
  AS
  SELECT @some as value;
  GO

CREATE PROCEDURE canLogin @email VARCHAR(45), @password VARCHAR(45), @login BIT OUT
  AS
  --Declare variable
  DECLARE @exists INT;
  --Check for match
  SELECT @exists = count(email) FROM Respondiente WHERE email = @email AND password = @password;
  IF @exists = 1
      SET @login = 1;
  ELSE
    SET @login = 0;
  --Send confirmation
  SELECT @login;
  GO