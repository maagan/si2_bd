 

delimiter //
create procedure insert_persona(_ci int ,_nombre varchar(50),_apellidos varchar(50),
_direccion text,_usuario varchar(50),_pass varchar(50),
_tipo varchar(1), _foto varchar(45)  )
begin
  declare _res char ;
	 declare _ci_pers int;
	declare _ci_ad varchar(25);
    set _ci_ad=(select p.ci from persona p where p.ci=_ci  );
    if ( _ci_ad = _ci ) then
		set _res = 0; 
        select _res as resp;
    else
		insert into persona values(_ci,_nombre,_apellidos,_direccion, _usuario,_pass,default,default,_tipo,default
		,default,default,default,"0",_foto);
		set _ci_pers =(select p.ci from persona p where p.ci=_ci  );
		if (_tipo = 'p') then
			insert into paciente values(_ci_pers,default);
		else
			if(_tipo = 'e') then
        		insert into enfermera values(_ci_pers,especialidad);
			else
				insert into doctor values(_ci_pers,especialidad);
			end if;
		end if;
        set _res = 1;        
        select _res as resp;
   end if;    
end;
// delimiter ;





























-- :::::::::::::::::::::::    PERSONA -- TABLA PERSONA
-- ::::::::::: "ELIMINA"  
DELIMITER //
CREATE PROCEDURE ELIMINAR_PERSONA(_ID INT)
BEGIN
	DECLARE _RES CHAR ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- SHOW COUNT(*) ERRORS;
		-- SELECT @@error_count;
		-- SHOW ERRORS;
        SET _RES = 0;
        SELECT _RES AS RESP;
		ROLLBACK;
	END;
	START TRANSACTION;
    	UPDATE PERSONA  SET ESTADO=0  WHERE ID = _ID;
        SET _RES = 1;
        SELECT _RES AS RESP;
	COMMIT;
END;
// DELIMITER ;
-- CALL xlqhgpsg_DB_RHH.ELIMINAR_PERSONA(5)
-- DROP PROCEDURE ELIMINAR_PERSONA;
 SELECT * FROM PERSONA;


-- :::::::::::::::: MOSTRAR PERSONAS..
DELIMITER //
CREATE PROCEDURE MOSTRAR_PERSONA()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- SHOW COUNT(*) ERRORS;
		-- SELECT @@error_count;
		-- SHOW ERRORS;
		ROLLBACK;
	END;
    START TRANSACTION;
    	SELECT P.ID, P.NOMBRE, P.APELLIDOS,P.CI,P.EMAIL, P.DIRECCION FROM PERSONA P  ;
	COMMIT;
END;
// DELIMITER ;
-- CALL xlqhgpsg_DB_RHH.MOSTRAR_PERSONA()
-- DROP PROCEDURE MOSTRAR_PERSONA;
 SELECT * FROM PERSONA;


-- :::::::::::::::: MODIFICA LA TABLA DE PERSONA::::::::::::

DELIMITER //
CREATE PROCEDURE MODIFICAR_PERSONA(_ID INT , _NOMBRE VARCHAR(25),_APELLIDOS VARCHAR(25),
_CI VARCHAR(25),_EMAIL VARCHAR(100),_DIRECCION VARCHAR(25),_FOTO VARCHAR(45))
BEGIN
	DECLARE _RES CHAR ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- SHOW COUNT(*) ERRORS;
		-- SELECT @@error_count;
		-- SHOW ERRORS;
        SET _RES = 0;
        SELECT _RES AS RESP;
		ROLLBACK;
	END;
    START TRANSACTION;
    	UPDATE PERSONA  SET NOMBRE=_NOMBRE ,APELLIDOS = _APELLIDOS , CI=_CI ,EMAIL =_EMAIL,
			DIRECCION=_DIRECCION , FOTO=_FOTO WHERE ID = _ID;
		SET _RES = 1;
        SELECT _RES AS RESP;
	COMMIT;
END;
// DELIMITER ;

-- SELECT * FROM  PERSONA;
--  call xlqhgpsg_DB_RHH.MODIFICAR_PERSONA('1','melina','flores','963124','melina@gmail.com','mutualista','melina.jpg');
-- DROP PROCEDURE MODIFICAR_PERSONA;
-- SELECT * FROM PERSONA ;

  
  
-- ::::::: BUSCAR 
  --  ENCUENTRA TODOS LOS NOMBRES Q COMIENZAN EN _NOMBRE
DELIMITER //
CREATE PROCEDURE BUSCAR_PERSONA(_NOMBRE VARCHAR(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- SHOW COUNT(*) ERRORS;
		-- SELECT @@error_count;
		-- SHOW ERRORS;
		ROLLBACK;
	END;
    START TRANSACTION;
    	SELECT P.ID,P.NOMBRE,P.APELLIDOS,P.CI,P.EMAIL,P.DIRECCION,CANT_INTENTO,P.VISITAS FROM PERSONA P WHERE P.NOMBRE LIKE CONCAT( '%',_NOMBRE,'%');
	COMMIT;
END;
// DELIMITER ;
-- CALL  xlqhgpsg_DB_RHH.BUSCAR_PERSONA('MAC')
-- DROP PROCEDURE BUSCAR_PERSONA;
-- SELECT * FROM PERSONA


delimiter //
create procedure aaa_login_user(_usuario varchar(50), _pass varchar(50))
begin
	declare _estado_user boolean; -- usuario esta bloqueado o no lo esta
	declare _ci int;		  -- id del usuario
	declare _r int;			  -- si es corecto el login o no es
	declare _nomb varchar(50);
    declare _passw varchar(50);-- contra del usuario
    declare _cant int;			-- cantidaf de intentos
 --   declare _cant_visit int;   -- cantidad de visitas que tiene el usuario
    
	declare exit handler for sqlexception
	begin
		-- show count(*) errors;
		-- select @@error_count;
		-- show errors;
		rollback;
	end;
    start transaction;
		set _estado_user = (select a.estado from persona a where a.usuario=_usuario);-- si no esiste email devuelve vacio
		if(_estado_user)then
			set _passw = (select a.pass from persona a where a.usuario=_usuario);
			if(_passw = _pass) then
				set _ci = (select a.ci from persona a where a.pass=_pass and a.usuario=_usuario);
				set _r=20; -- datos correctos
				select a.ci, a.NOMBRE,a.usuario, a.apellido,a.foto, _r as RESULT from persona a where a.ci=_ci;--  ojo aqui
			else
				set _ci = (select a.ci from persona a where a.usuario=_usuario);
				set _cant = (select a.intento+1 from persona a where a.usuario=_usuario);
				update persona set intento = _cant where ci=_ci;
				set _r=_cant; -- pass incorecto
				if(_cant = 4)then
					update persona set estado = 0 where ci=_ci; -- usuario bloqueado
					select a.intento from persona a where a.usuario=_usuario;
				else
					select a.intento from persona a where a.usuario=_usuario; -- numero de intentos llega al 4 mesaje de usuario bloqueado
				end if;
			end if;
		else
			set _r=10; -- usuario  inhabilitado o datos incorrectos
			select _r as RESULT;
		end if;
    commit;
end;
//delimiter ;


