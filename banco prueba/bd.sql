SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE IF NOT EXISTS banco;

USE banco;

DROP TABLE IF EXISTS atm;

CREATE TABLE `atm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ubicacion` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `monto` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS caja;

CREATE TABLE `caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS cliente_cuenta;

CREATE TABLE `cliente_cuenta` (
  `id_cliente` int(11) NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`,`id_cuenta`),
  KEY `FK_cliente_cuenta_cuenta` (`id_cuenta`),
  CONSTRAINT `FK_cliente_cuenta_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `persona` (`id`),
  CONSTRAINT `FK_cliente_cuenta_cuenta` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS cliente_juridico;

CREATE TABLE `cliente_juridico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nit` int(11) NOT NULL,
  `nombre_comercial` varchar(100) NOT NULL,
  `tipo_empresa` varchar(100) NOT NULL,
  `fecha_constitucion` date NOT NULL,
  `vencimiento_poder` date NOT NULL,
  `id_rubro` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cliente_juridico_rubro` (`id_rubro`),
  CONSTRAINT `FK_cliente_juridico_cliente` FOREIGN KEY (`id`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cliente_juridico_rubro` FOREIGN KEY (`id_rubro`) REFERENCES `rubro` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO cliente_juridico VALUES("2","9788381","coca cola","S.A","1974-05-20","2020-05-20","2");



DROP TABLE IF EXISTS cliente_natural;

CREATE TABLE `cliente_natural` (
  `id` int(11) NOT NULL,
  `nom_empleo` varchar(100) NOT NULL,
  `dir_empleo` varchar(100) NOT NULL,
  `id_ocupacion` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cliente_natural_ocupacion` (`id_ocupacion`),
  CONSTRAINT `FK_cliente_natural_cliente` FOREIGN KEY (`id`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cliente_natural_ocupacion` FOREIGN KEY (`id_ocupacion`) REFERENCES `ocupacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO cliente_natural VALUES("1","coca- cola","parque industrial","1");
INSERT INTO cliente_natural VALUES("3","Papel kimberly","parque industrial","2");
INSERT INTO cliente_natural VALUES("4","coca- cola","parque industrial","1");
INSERT INTO cliente_natural VALUES("5","Guabira","4to anillo","1");
INSERT INTO cliente_natural VALUES("6","Casa del camba","2do anillo","1");
INSERT INTO cliente_natural VALUES("7","Embol","Los pozos","2");



DROP TABLE IF EXISTS credito;

CREATE TABLE `credito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monto` float NOT NULL,
  `moneda` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `plazo` int(11) NOT NULL,
  `modalidad_pago` varchar(100) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `id_tipoC` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_credito_tipo_credito` (`id_tipoC`),
  KEY `FK_credito_cliente` (`id_cliente`),
  CONSTRAINT `FK_credito_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `persona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_credito_tipo_credito` FOREIGN KEY (`id_tipoC`) REFERENCES `tipo_credito` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS credito_garante;

CREATE TABLE `credito_garante` (
  `id_credito` int(11) NOT NULL,
  `id_garante` int(11) NOT NULL,
  PRIMARY KEY (`id_credito`,`id_garante`),
  KEY `FK_credito_garante_garante` (`id_garante`),
  CONSTRAINT `FK_credito_garante_credito` FOREIGN KEY (`id_credito`) REFERENCES `credito` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_credito_garante_garante` FOREIGN KEY (`id_garante`) REFERENCES `garante` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS cuenta;

CREATE TABLE `cuenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nro_cuenta` int(11) NOT NULL,
  `fecha_apertura` date NOT NULL,
  `id_tipoC` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cuenta_tipo_cuenta` (`id_tipoC`),
  CONSTRAINT `FK_cuenta_tipo_cuenta` FOREIGN KEY (`id_tipoC`) REFERENCES `tipo_cuenta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS cuota;

CREATE TABLE `cuota` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_plan` int(11) NOT NULL,
  `monto` float NOT NULL,
  `fecha_plazo` date NOT NULL,
  `estado` varchar(100) NOT NULL,
  `fecha_cancelado` date NOT NULL,
  `multa` float NOT NULL,
  PRIMARY KEY (`id`,`id_plan`),
  KEY `FK_cuota_plan_pago` (`id_plan`),
  CONSTRAINT `FK_cuota_plan_pago` FOREIGN KEY (`id_plan`) REFERENCES `plan_pago` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS doc_credito;

CREATE TABLE `doc_credito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `id_credito` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_doc_credito_credito` (`id_credito`),
  CONSTRAINT `FK_doc_credito_credito` FOREIGN KEY (`id_credito`) REFERENCES `credito` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS entidad_financiera;

CREATE TABLE `entidad_financiera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nit` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_entidad` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO entidad_financiera VALUES("1","26744126","Banco sol","Privada","plan 3000","sucursal");



DROP TABLE IF EXISTS favorito;

CREATE TABLE `favorito` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_favoritos_users` (`user_id`),
  CONSTRAINT `FK_favoritos_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

INSERT INTO favorito VALUES("12","personas","2");
INSERT INTO favorito VALUES("13","personas/create","2");
INSERT INTO favorito VALUES("20","users/create","1");
INSERT INTO favorito VALUES("21","roles/create","1");



DROP TABLE IF EXISTS garante;

CREATE TABLE `garante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `fecha_nac` date NOT NULL,
  `ci` bigint(20) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` bigint(20) DEFAULT NULL,
  `genero` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS lista_negra;

CREATE TABLE `lista_negra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO lista_negra VALUES("1","9769321","Bladimir","Perez Toledo");



DROP TABLE IF EXISTS migrations;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO migrations VALUES("1","2014_10_12_000000_create_users_table","1");
INSERT INTO migrations VALUES("2","2014_10_12_100000_create_password_resets_table","1");
INSERT INTO migrations VALUES("3","2018_04_17_145646_entrust_setup_tables","1");



DROP TABLE IF EXISTS ocupacion;

CREATE TABLE `ocupacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO ocupacion VALUES("1","ing. comercial");
INSERT INTO ocupacion VALUES("2","ing. industrial");



DROP TABLE IF EXISTS password_resets;

CREATE TABLE `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS permission_role;

CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO permission_role VALUES("5","1");
INSERT INTO permission_role VALUES("6","1");
INSERT INTO permission_role VALUES("7","1");
INSERT INTO permission_role VALUES("8","1");
INSERT INTO permission_role VALUES("13","1");
INSERT INTO permission_role VALUES("1","2");
INSERT INTO permission_role VALUES("2","2");
INSERT INTO permission_role VALUES("3","2");
INSERT INTO permission_role VALUES("4","2");
INSERT INTO permission_role VALUES("9","2");
INSERT INTO permission_role VALUES("10","2");
INSERT INTO permission_role VALUES("11","2");
INSERT INTO permission_role VALUES("12","2");
INSERT INTO permission_role VALUES("1","3");
INSERT INTO permission_role VALUES("2","3");



DROP TABLE IF EXISTS permissions;

CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO permissions VALUES("1","crear_cliente","crear_cliente","crear_cliente","","");
INSERT INTO permissions VALUES("2","editar_cliente","editar_cliente","editar_cliente","","");
INSERT INTO permissions VALUES("3","verificacion_cliente","verificacion_cliente","verificacion_cliente","2018-05-06 21:30:11","");
INSERT INTO permissions VALUES("4","crear-cuenta","crear-cuenta","crear-cuenta","2018-05-06 21:30:57","");
INSERT INTO permissions VALUES("5","crear_usuario","crear_usuario","crear_usuario","2018-05-09 11:35:23","");
INSERT INTO permissions VALUES("6","editar_usuario","editar_usuario","editar_usuario","2018-05-09 11:35:49","");
INSERT INTO permissions VALUES("7","crear_rol","crear_rol","crear_rol","2018-05-09 11:36:24","");
INSERT INTO permissions VALUES("8","editar_rol","editar_rol","editar_rol","2018-05-09 11:36:42","");
INSERT INTO permissions VALUES("9","crear_credito","crear_credito","crear_credito","2018-05-09 11:40:30","");
INSERT INTO permissions VALUES("10","crear_garante","crear_garante","crear_garante","2018-05-09 11:41:34","");
INSERT INTO permissions VALUES("11","crear_tipo_cuenta","crear_tipo_cuenta","crear_tipo_cuenta","2018-05-09 11:54:50","");
INSERT INTO permissions VALUES("12","modulo-servicios","modulo-servicios","modulo-servicios","2018-05-09 11:58:51","");
INSERT INTO permissions VALUES("13","modulo-seguridad","modulo-seguridad","modulo-seguridad","2018-05-09 11:59:21","");



DROP TABLE IF EXISTS persona;

CREATE TABLE `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `ci` int(11) DEFAULT NULL,
  `sexo` varchar(100) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `firma` varchar(100) DEFAULT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `id_entidad` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cliente_entidad_financiera` (`id_entidad`),
  CONSTRAINT `FK_cliente_entidad_financiera` FOREIGN KEY (`id_entidad`) REFERENCES `entidad_financiera` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

INSERT INTO persona VALUES("1","jesus","vargas moya","3570744","M","1966-05-19","72185300","av. 2 de agosto","jesus@gmail.com","1526760836_foto6.jpg","1526760836_f2.jpg","natural","","2018-05-21 13:49:18");
INSERT INTO persona VALUES("2","Jandira","vargas rojas","9788381","M","1997-05-20","65022467","av. virgen de cotoca","la_best23@hotmail.com","1526779008_foto4.jpg","1526779008_f2.jpg","juridico","","2018-05-03 13:49:20");
INSERT INTO persona VALUES("3","vladimir","vasquez peredo","32568914","M","1997-03-21","65893214","los pozos","vladimir@gmail.com","1526912942_foto2.jpg","1526912942_f8.JPG","natural","","2018-05-03 13:49:21");
INSERT INTO persona VALUES("4","milton","pesoa peres","56234783","M","1992-05-21","34425631","av. beni","milton@gmail.com","1526913205_foto7.jpg","1526913205_f4.JPG","natural","","2018-05-05 13:49:22");
INSERT INTO persona VALUES("5","Marta","roca Leigue","2369231","F","1993-05-21","72112563","av cristo redentor","martha@gmail.com","1526914825_foto3.jpg","1526914825_f9.JPG","natural","","2018-05-13 13:49:23");
INSERT INTO persona VALUES("6","Pedro","Solar Sol","3570789","M","1997-05-01","72186325","av cristo redentor","pedro@gmail.com","1526933103_foto8.jpg","1526933103_f1.jpg","natural","","2018-05-23 13:49:25");
INSERT INTO persona VALUES("7","Carla","Morales Leigue","3570789","F","1991-05-21","72186325","av cristo redentor","carla@gmail.com","1526914062_foto10.jpg","1526914062_f7.JPG","natural","","2018-05-23 13:49:28");



DROP TABLE IF EXISTS plan_pago;

CREATE TABLE `plan_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monto` float NOT NULL,
  `fecha_plazo` date NOT NULL,
  `id_credito` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_plan_pago_credito` (`id_credito`),
  CONSTRAINT `FK_plan_pago_credito` FOREIGN KEY (`id_credito`) REFERENCES `credito` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS referencia;

CREATE TABLE `referencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_referencia_cuenta` (`id_cuenta`),
  CONSTRAINT `FK_referencia_cuenta` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS role_user;

CREATE TABLE `role_user` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO role_user VALUES("1","1");
INSERT INTO role_user VALUES("3","1");
INSERT INTO role_user VALUES("4","1");
INSERT INTO role_user VALUES("6","1");
INSERT INTO role_user VALUES("7","1");
INSERT INTO role_user VALUES("2","2");
INSERT INTO role_user VALUES("5","2");



DROP TABLE IF EXISTS roles;

CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO roles VALUES("1","administrador","administrador","administrador","2018-05-06 19:50:46","");
INSERT INTO roles VALUES("2","oficial de cuenta","oficial de cuenta","oficial de cuenta","2018-05-07 01:09:37","2018-05-07 01:09:37");
INSERT INTO roles VALUES("3","cajero","cajero","cajero","2018-05-23 16:41:03","2018-05-23 16:41:03");



DROP TABLE IF EXISTS rubro;

CREATE TABLE `rubro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO rubro VALUES("1","comercio interior");
INSERT INTO rubro VALUES("2","comercio exterior");



DROP TABLE IF EXISTS tasa_interes;

CREATE TABLE `tasa_interes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tasa` float NOT NULL,
  `plazo` int(11) NOT NULL,
  `monto` float NOT NULL,
  `moneda` float NOT NULL,
  `id_cuenta` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tasa_interes_cuenta` (`id_cuenta`),
  CONSTRAINT `FK_tasa_interes_cuenta` FOREIGN KEY (`id_cuenta`) REFERENCES `cuenta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS tipo_credito;

CREATE TABLE `tipo_credito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tasa_interes` float NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS tipo_cuenta;

CREATE TABLE `tipo_cuenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS titulo;

CREATE TABLE `titulo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS transaccion;

CREATE TABLE `transaccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nro_cuentaA` bigint(20) NOT NULL,
  `nro_cuentaB` bigint(20) NOT NULL,
  `moneda` varchar(100) NOT NULL,
  `monto` float NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `ci` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `id_caja` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_transaccion_caja` (`id_caja`),
  CONSTRAINT `FK_transaccion_caja` FOREIGN KEY (`id_caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




DROP TABLE IF EXISTS users;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fondo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estilo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO users VALUES("1","jandira","jan@gmail.com","$2y$10$c/fho/NJF9BtI.zvVjnvOOIOBm0pakj3cSZjZKwDaaAMf6BNdTPXm","skin-red","1527079037_1526778536_perfilsinfotomujer.jpg","si","BY23K181RHsDlwBBs1zSGGi6GPf5zG1z7KGaZZJTwgpTwWWQwsvXfbkxS6Ff","2018-05-19 18:49:59","2018-05-23 12:37:17");
INSERT INTO users VALUES("2","karla","karla@gmail.com","$2y$10$/C60E51vrs.bxzCmPNVO.e3ZDebvRdcxubBng6ddvuWOhhfVi4TYe","skin-yellow","1527079810_default.jpg","si","pdO4pnF9ZB9XJ0xt9CxQPbzWuSSMw1XduYYxMdHYvZdST4gzyfpC1EsFo5sl","2018-05-19 19:15:39","2018-05-23 16:59:34");
INSERT INTO users VALUES("3","vladimir","vladimir@gmail.com","$2y$10$ZAQio/WhxHSYxVbXGdnGzeXK8/JbU927qdB2XGfs.uoEEa0SHKsgO","skin-blue","default.jpg","si","","2018-05-21 18:54:54","2018-05-21 18:54:54");
INSERT INTO users VALUES("4","alex","alex@gmail.com","$2y$10$QA9/lrfDLenISj5lNhAWneaLKUCTCUv.GYrG3Rz8Yj2hGCQEr9tTq","skin-blue","default.jpg","si","","2018-05-21 18:57:12","2018-05-21 18:57:12");
INSERT INTO users VALUES("5","Gabriela","gabriela@gmail.com","$2y$10$wIU1CJvyo2jRrHfO.zTW0eLghnpJsvdNrW/QUO30ekLKTg8Bk5nt6","skin-blue","default.jpg","si","","2018-05-21 19:11:04","2018-05-21 19:11:04");
INSERT INTO users VALUES("6","milton","milton@gmail.com","$2y$10$QhE90jgC000DMJ5CDKqxt.ZKMT0HkotPF8g/rezvAJN10jQRxOBcW","skin-blue","default.jpg","si","","2018-05-21 19:37:39","2018-05-21 19:37:39");
INSERT INTO users VALUES("7","luis","luis@gmail.com","$2y$10$9vlmW0JpQ2Xubfq7I5KJZOYTXZMkjhiIpP2VmS0jQYl3vKV6CZYWC","skin-blue","default.jpg","si","","2018-05-23 17:22:34","2018-05-23 17:22:34");



DROP TABLE IF EXISTS usuario;

CREATE TABLE `usuario` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `fondo` varchar(100) NOT NULL,
  `estilo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

INSERT INTO usuario VALUES("1","jandira","jan@gmail.com","1527079037_1526778536_perfilsinfotomujer.jpg","skin-red","si");
INSERT INTO usuario VALUES("2","karla","karla@gmail.com","1527079810_default.jpg","skin-yellow","si");
INSERT INTO usuario VALUES("3","vladimir","vladimir@gmail.com","default.jpg","skin-blue","si");
INSERT INTO usuario VALUES("4","alex","alex@gmail.com","default.jpg","skin-blue","si");
INSERT INTO usuario VALUES("5","Gabriela","gabriela@gmail.com","default.jpg","skin-blue","si");
INSERT INTO usuario VALUES("6","milton","milton@gmail.com","default.jpg","skin-blue","si");



DROP TABLE IF EXISTS usuario_caja;

CREATE TABLE `usuario_caja` (
  `id_usuario` int(11) unsigned NOT NULL,
  `id_caja` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(100) NOT NULL,
  `monto` float NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_caja`),
  KEY `FK_usuario_caja_caja` (`id_caja`),
  CONSTRAINT `FK_usuario_caja_caja` FOREIGN KEY (`id_caja`) REFERENCES `caja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_usuario_caja_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




SET FOREIGN_KEY_CHECKS=1;