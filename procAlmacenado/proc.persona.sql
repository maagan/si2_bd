 
-- :::::::::::::::::::::::    PERSONA -- TABLA PERSONA

DELIMITER //
CREATE PROCEDURE INSERT_PERSONA(_NOMBRE VARCHAR(25),_APELLIDOS VARCHAR(25),
_CI VARCHAR(25),_EMAIL VARCHAR(100),_PASS VARCHAR(25),_DIRECCION VARCHAR(50),
_FOTO VARCHAR(45),_CANT_INTENTO TINYINT,_VISITAS INT)
BEGIN
	DECLARE _ID_PERS INT ;
	DECLARE _CI_AD VARCHAR(25);
    SET _CI_AD=(SELECT P.NOMBRE FROM PERSONA P WHERE P.NOMBRE=_NOMBRE  );
    IF ( _CI_AD = _CI ) THEN
		SET _CI_AD =NULL;
    ELSE
		INSERT INTO PERSONA VALUES(DEFAULT,_NOMBRE,_APELLIDOS,_CI,_EMAIL,_PASS,_DIRECCION,_FOTO,
        _CANT_INTENTO,_VISITAS,1);	
        SET _ID_PERS =(SELECT P.ID FROM PERSONA P WHERE P.CI=_CI  );
        INSERT INTO PACIENTE VALUES(_ID_PERS,1);
        
    END IF;    
END;
// DELIMITER ;

 CALL xlqhgpsg_DB_RHH.INSERT_PERSONA('EFT','Flores','9958631','EFT@gmil.com','CONTRA2018','MUTIALISTA','foto/1233',2,1);
  CALL xlqhgpsg_DB_RHH.INSERT_PERSONA('ISMAEL','SELOCOME','551222','ism@gmil.com','CONT554','MUTIALISTA','fot/1233',3,1);
  CALL xlqhgpsg_DB_RHH.INSERT_PERSONA('MACC','SELOCOME','95000','edso@gmil.com','CONT44','MUTIALISTA','fottto/1233',1,2);
-- DROP PROCEDURE INSERT_PERSONA;
 SELECT * FROM PERSONA;
 
-- ::::::::::: "ELIMINA"  
DELIMITER //
CREATE PROCEDURE ELIMINAR_PERSONA(_ID INT)
BEGIN
    UPDATE PERSONA  SET ESTADO=0  WHERE ID = _ID;
END;
// DELIMITER ;
-- CALL xlqhgpsg_DB_RHH.ELIMINAR_PERSONA(5)
-- DROP PROCEDURE ELIMINAR_PERSONA;
 SELECT * FROM PERSONA;


-- :::::::::::::::: MOSTRAR PERSONAS..
DELIMITER //
CREATE PROCEDURE MOSTRAR_PERSONA()
BEGIN
    SELECT P.NOMBRE, P.APELLIDOS,P.CI,P.EMAIL,P.PASS, P.DIRECCION FROM PERSONA P  ;
END;
// DELIMITER ;
-- CALL xlqhgpsg_DB_RHH.MOSTRAR_PERSONA()
-- DROP PROCEDURE MOSTRAR_PERSONA;
 SELECT * FROM PERSONA;


-- :::::::::::::::: MODIFICA LA TABLA DE PERSONA::::::::::::

DELIMITER //
CREATE PROCEDURE MODIFICAR_PERSONA(_ID INT , _NOMBRE VARCHAR(25),_APELLIDOS VARCHAR(25),
_CI VARCHAR(25),_EMAIL VARCHAR(100),_PASS VARCHAR(25),_DIRECCION VARCHAR(25),_FOTO VARCHAR(45),_CANT_INTENTO TINYINT,_VISITAS INT, _ESTADO BOOLEAN )
BEGIN
    UPDATE PERSONA  SET NOMBRE=_NOMBRE ,APELLIDOS = _APELLIDOS , CI=_CI ,EMAIL =_EMAIL, PASS=_PASS ,DIRECCION=_DIRECCION ,
						FOTO=_FOTO,CANT_INTENTO=_CANT_INTENTO,VISITAS = _VISITAS, ESTADO=_ESTADO 
    WHERE ID = _ID  ;
END;
// DELIMITER ;

-- SELECT * FROM  PERSONA;
--  CALL xlqhgpsg_DB_RHH.MODIFICAR_PERSONA(1 ,'EDSAAN','SELOCOME ENTERA','7788996','edtselacome@gmail.com','CONTRA2018','MUTIALISTA','flottt/sss',1,2, 0 );
-- DROP PROCEDURE MODIFICAR_PERSONA;
-- SELECT * FROM PERSONA ;
-- sdfsfdsdfsf
-- rgfgfgfg
  
  
-- ::::::: BUSCAR 
  --  ENCUENTRA TODOS LOS NOMBRES Q COMIENZAN EN _NOMBRE
DELIMITER //
CREATE PROCEDURE BUSCAR_PERSONA(_NOMBRE VARCHAR(50))
BEGIN
    SELECT * FROM PERSONA P WHERE P.NOMBRE LIKE CONCAT( '%',_NOMBRE,'%');
END;
// DELIMITER ;
-- CALL  xlqhgpsg_DB_RHH.BUSCAR_PERSONA('MAC')
-- DROP PROCEDURE BUSCAR_PERSONA;
-- SELECT * FROM PERSONA


DELIMITER //
CREATE PROCEDURE AAA_LOGIN_USER(_EMAIL VARCHAR(50), _PASS VARCHAR(50))
BEGIN
	DECLARE _ESTADO_USER INT; -- USUARIO ESTA BLOQUEADO O NO LO ESTA
	DECLARE _ID INT;		  -- ID DEL USUARIO
	DECLARE _R INT;			  -- SI ES CORECTO EL LOGIN O NO ES
	DECLARE _NOMB VARCHAR(50);
    DECLARE _PASSW VARCHAR(50);-- CONTRA DEL USUARIO
    DECLARE _CANT INT;			-- CANTIDAF DE INTENTOS
    DECLARE _CANT_VISIT INT;   -- CANTIDAD DE VISITAS QUE TIENE EL USUARIO
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- SHOW COUNT(*) ERRORS;
		-- SELECT @@error_count;
		-- SHOW ERRORS;
		ROLLBACK;
	END;
    START TRANSACTION;
		SET _ESTADO_USER = (SELECT A.ESTADO FROM PERSONA A WHERE A.EMAIL=_EMAIL);-- SI NO ESISTE EMAIL DEVUELVE VACIO
		IF(_ESTADO_USER)THEN
			SET _PASSW = (SELECT A.PASS FROM PERSONA A WHERE A.EMAIL=_EMAIL);
			IF(_PASSW = _PASS) THEN
				SET _ID = (SELECT A.ID FROM PERSONA A WHERE A.EMAIL=_EMAIL AND A.PASS=_PASS);
				SET _CANT_VISIT = (SELECT A.CANT_INTENTO+1 FROM PERSONA A WHERE A.ID=_ID);
				UPDATE PERSONA SET VISITAS = _CANT_VISIT WHERE ID=_ID;
				SET _R=20; -- DATOS CORRECTOS
				SELECT A.ID, A.NOMBRE, A.APELLIDO,A.FOTO, _R AS RESULT FROM PERSONA A WHERE A.ID=_ID;--  OJO AQUI
			ELSE
				SET _ID = (SELECT A.ID FROM PERSONA A WHERE A.EMAIL=_EMAIL);
				SET _CANT = (SELECT A.CANT_INTENTO+1 FROM PERSONA A WHERE A.EMAIL=_EMAIL);
				UPDATE PERSONA SET CANT_INTENTO = _CANT WHERE ID=_ID;
				SET _R=_CANT; -- PASS INCORECTO
				IF(_CANT = 4)THEN
					UPDATE PERSONA SET ESTADO = 0 WHERE ID=_ID; -- USUARIO BLOQUEADO
					SELECT _R AS RESULT;
				ELSE
					SELECT _R AS RESULT; -- NUMERO DE INTENTOS LLEGA AL 4 MESAJE DE USUARIO BLOQUEADO
				END IF;
			END IF;
		ELSE
			SET _R=10; -- USUARIO  INHABILITADO O DATOS INCORRECTOS
			SELECT _R AS RESULT;
		END IF;
    COMMIT;
END;
//DELIMITER ;


