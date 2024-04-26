USE museo;

/* Los primeros 3 puntos es necesario correrlos haciendo uso del usuario root */

-- Punto 1 --
CREATE USER IF NOT EXISTS 'usuario_1'@'localhost' IDENTIFIED BY 'pass1';

-- Punto 2 --
GRANT SELECT, INSERT, UPDATE ON museo.vw_exposciones_pintura_shangai TO 'usuario_1'@'localhost';
GRANT SELECT, INSERT, UPDATE ON museo.vw_museos_al_menos_3_obras_pintura_misma_presentacion TO 'usuario_1'@'localhost';

-- Punto 3 --
REVOKE IF EXISTS ALL PRIVILEGES ON museo.exposicion FROM 'usuario_1'@'localhost';
REVOKE IF EXISTS ALL PRIVILEGES ON museo.museo FROM 'usuario_1'@'localhost';
REVOKE IF EXISTS ALL PRIVILEGES ON museo.obra FROM 'usuario_1'@'localhost';
REVOKE IF EXISTS ALL PRIVILEGES ON museo.presentacion FROM 'usuario_1'@'localhost';

/* A partir de este punto es necesario salir de la db y volverse a loggear como el usuario_1 */

-- Punto 4 --
SELECT * FROM vw_exposciones_pintura_shangai;
SELECT * FROM vw_museos_al_menos_3_obras_pintura_misma_presentacion;
/* las siguientes consultas aparecen comentadas, pues si se corren desde el usuario_1, habra un error, porque este no tiene permisos para realizarlas*/
-- SELECT * FROM exposicion;
-- SELECT * FROM obra;
-- SELECT * FROM museo;
-- SELECT * FROM presentacion;

-- Punto 5 --

-- INSERT INTO vw_exposciones_pintura_shangai (ex_id, ex_nombre) VALUES  (1007, 'Nueva expo');
-- UPDATE vw_exposciones_pintura_shangai SET ex_nombre = 'IMPRESIONISMO' WHERE ex_id=1006;

-- INSERT INTO vw_museos_al_menos_3_obras_pintura_misma_presentacion (mu_id, mu_nombre) VALUES (999, 'Bogota');
-- UPDATE vw_museos_al_menos_3_obras_pintura_misma_presentacion SET mu_nombre='SHANGAI' WHERE mu_id=205;