-- :::::::::::::::::::::::  DOCTOR -- TABLA DOCTOR

DELIMITER //
CREATE PROCEDURE INSERT_DOCTOR(_NOMBRE VARCHAR(25),_APELLIDOS VARCHAR(25),
_CI VARCHAR(25),_EMAIL VARCHAR(100),_PASS VARCHAR(25),_DIRECCION VARCHAR(50),
_FOTO VARCHAR(45),_CANT_INTENTO TINYINT,_VISITAS INT,_ESPECIALIDAD VARCHAR(50) )
BEGIN
    DECLARE _RES CHAR ;
	DECLARE _ID_PERS INT;
	DECLARE _CI_AD VARCHAR(25);
    SET _CI_AD=(SELECT P.CI FROM PERSONA P WHERE P.CI=_CI  );
    IF ( _CI_AD = _CI ) THEN
        SET _RES = 0;
        SELECT _RES AS RESP;
    ELSE
		INSERT INTO PERSONA VALUES(DEFAULT,_NOMBRE,_APELLIDOS,_CI,_EMAIL,_PASS,_DIRECCION,
        _FOTO, _CANT_INTENTO,_VISITAS,1);
		SET _ID_PERS =(SELECT P.ID FROM PERSONA P WHERE P.CI=_CI );
        INSERT INTO DOCTOR VALUES( _ESPECIALIDAD, _ID_PERS,1);
        SET _RES = 1;
        SELECT _RES AS RESP;

   END IF;    
END;
// DELIMITER ;

  CALL xlqhgpsg_DB_RHH.INSERT_DOCTOR('CAMILA','DOM','887744455','ECAMLA@gmil.com','CONTRA2018','MUTIALISTA','foto/12SSS3',1,1,'DOCTOR');
-- CALL xlqhgpsg_DB_RHH.INSERT_PERSONA('ISMAEL','ISSdoc','551222','ism@gmil.com','CONT554','MUTIALISTA','fot/1233',3,1,'DOCTOR');
-- CALL xlqhgpsg_DB_RHH.INSERT_PERSONA('MACC','MCCenfe','95000','edso@gmil.com','CONT44','MUTIALISTA','fottto/1233',1,2,'ENFERMERA');
-- DROP PROCEDURE INSERT_DOCTOR;
 SELECT * FROM PERSONA;
 SELECT * FROM DOCTOR;
 
  