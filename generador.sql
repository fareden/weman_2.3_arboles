-- Funciones que generan nombres aleatorios:
-- Esta función genera CANTIDAD nombres de personas y los inserta en la base de datos
DELIMITER $$
CREATE PROCEDURE `generaNombres`(cantidad int)
BEGIN
	declare i integer default 0;
	genera: LOOP	  -- Este es el ciclo, se ejecuta mientras i < cantidad
		insert into persona (nombre) values(creanombre());	   -- Genera un nombre y lo inserta
        set i = i + 1;		-- Es importante que i vaya aumentando. Aquí no existe la sintaxis de i++
		if i < cantidad then
			iterate genera;	-- Por alguna rareza, necesita esta línea para dar vueltas
		end if;
        leave genera;	-- Sale del ciclo
	end loop genera;
END$$
DELIMITER ;

-- Esta función genera el nombre aleatorio. Podría escribirse en menos líneas
DELIMITER $$
CREATE FUNCTION `creanombre`() RETURNS varchar(300) CHARSET utf8
    READS SQL DATA
BEGIN
	-- Variables para traer los datos que voy a generar en el nombre
	declare nom varchar(80) default '';
    declare ap1 varchar(100) default '';
    declare ap2 varchar(100) default '';
    declare retval varchar(300) default null;
    select nombre into nom from nombre order by rand() limit 1;		-- trae un nombre aleatorio
    select apellido into ap1 from apellido order by rand() limit 1;	-- luego un apellido
    select apellido into ap2 from apellido order by rand() limit 1;	-- ... y luego otro
    set retval = concat_ws(' ', nom, ap1, ap2);	 -- Asigna el resultado a la variable
RETURN retval;
END$$
DELIMITER ;


-- Se alimentan de dos tablas, que se definen como sigue:
-- Tabla de apellidos de personas... los campos "frec" pertenecen al dataset original pero no se usan
CREATE TABLE `apellido` (
  `apellido` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frec_pri` int(11) DEFAULT NULL,
  `frec_seg` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla de nombres. Igual, solamente se toma el campo 'nombre'
CREATE TABLE `nombre` (
  `nombre` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `frec` int(11) DEFAULT NULL,
  `edad_media` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla de destino, donde se ponen los nombres de las personas
CREATE TABLE `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100011 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Con la siguiente instrucción hace la generación de 100,000 nombres
call generaNombres(100000);
