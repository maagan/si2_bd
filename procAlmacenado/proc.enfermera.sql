
DELIMITER //
CREATE PROCEDURE INSERT_ENFERMERA(_NOMBRE VARCHAR(25),_APELLIDOS VARCHAR(25),
_CI VARCHAR(25),_EMAIL VARCHAR(100),_PASS VARCHAR(25),_DIRECCION VARCHAR(50),
_FOTO VARCHAR(45),_ESPECIALIDAD VARCHAR(50) )
BEGIN
  DECLARE _RES CHAR ;
	 DECLARE _ID_PERS INT;
	DECLARE _CI_AD VARCHAR(25);
    SET _CI_AD=(SELECT P.CI FROM PERSONA P WHERE P.CI=_CI  );
    IF ( _CI_AD = _CI ) THEN
		SET _RES = 0; 
        SELECT _RES AS RESP;
    ELSE
		INSERT INTO PERSONA VALUES(DEFAULT,_NOMBRE,_APELLIDOS,_CI,_EMAIL,_PASS,_DIRECCION,_FOTO, 0,0,1);
		SET _ID_PERS =(SELECT P.ID FROM PERSONA P WHERE P.CI=_CI  );
        INSERT INTO ENFERMERA VALUES( _ESPECIALIDAD, _ID_PERS,1);
        SET _RES = 1;        
        SELECT _RES AS RESP;
   END IF;    
END;
// DELIMITER ;


  CALL xlqhgpsg_DB_RHH.INSERT_ENFERMERA('KATY','QUIR','965874111','ECAT@gmil.com','CONTRA2018','MUTIALISTA','foto/1EDD',1,1,'LIC');
 CALL xlqhgpsg_DB_RHH.INSERT_ENFERMERA('CAMILA','ISSdoc','10124569','iPPsm@gmil.com','CONT554','MUTIALISTA','fot/1233',1,1,'AUX');
  CALL xlqhgpsg_DB_RHH.INSERT_ENFERMERA('ISA','MCCenfe','145876','PPso@gmil.com','CONT44','MUTIALISTA','fottto/1233',1,2,'LIC');
-- DROP PROCEDURE INSERT_ENFERMERA;
 SELECT * FROM ENFERMERA;
  SELECT * FROM PERSONA;