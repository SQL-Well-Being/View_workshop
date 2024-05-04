USE museo;

-- Punto 6 --
DROP VIEW IF EXISTS vw_museos_fecha_especifica;
CREATE VIEW vw_museos_fecha_especifica AS
	(SELECT DISTINCT mu_id, mu_nombre FROM museo
    INNER JOIN presentacion ON mu_id = pre_mu_id
    WHERE pre_fechaincial = 'May-sept-2013');
SELECT * FROM vw_museos_fecha_especifica;

-- Punto 7 --
DROP VIEW IF EXISTS vw_museos_ninguna_exposicion;
CREATE VIEW vw_museos_ninguna_exposicion AS
	(SELECT mu_id, mu_nombre FROM museo
    LEFT JOIN presentacion ON mu_id = pre_mu_id
    WHERE pre_mu_id IS NULL);
SELECT * FROM vw_museos_ninguna_exposicion;

-- Punto 8 --
DROP VIEW IF EXISTS vw_obras_presentadas_mas_de_una_vez;
CREATE VIEW vw_obras_presentadas_mas_de_una_vez AS
	(SELECT ob_id, ob_nombre FROM obra
    INNER JOIN presentacion ON ob_id = pre_ob_id
    GROUP BY pre_ob_id
    HAVING COUNT(pre_ob_id) > 1);
SELECT * FROM vw_obras_presentadas_mas_de_una_vez;

-- Punto 9 --
	DROP VIEW IF EXISTS vw_obras_presentadas_en_mas_de_un_museo;
	CREATE VIEW vw_obras_presentadas_en_mas_de_un_museo AS
		(SELECT ob_id, ob_nombre FROM obra
		INNER JOIN presentacion ON ob_id = pre_ob_id
		GROUP BY pre_ob_id
		HAVING COUNT(DISTINCT pre_mu_id) > 1);
	SELECT * FROM vw_obras_presentadas_en_mas_de_un_museo;

-- Punto 10 --
DROP VIEW IF EXISTS vw_exposciones_pintura_shangai;
CREATE VIEW vw_exposciones_pintura_shangai AS 
	(SELECT  DISTINCT ex_id, ex_nombre FROM obra 
	INNER JOIN presentacion ON ob_id = pre_ob_id
    INNER JOIN exposicion ON ob_ex_id = ex_id
    INNER JOIN museo ON pre_mu_id = mu_id
    WHERE LOWER(ob_tipo) = 'pintura' AND LOWER(mu_nombre) = 'shangai');
SELECT * FROM vw_exposciones_pintura_shangai;

-- Punto 11 --
DROP VIEW IF EXISTS vw_obras_costo_superior_al_promedio_exposicion;
CREATE VIEW vw_obras_costo_superior_al_promedio_exposicion AS 
	(SELECT exposicion.ex_id, ex_nombre, ob_id, ob_nombre, ob_tipo, ob_costo FROM exposicion
	INNER JOIN obra ON ex_id = ob_ex_id
    INNER JOIN  (SELECT ex_id, AVG(ob_costo) AS 'ex_costo_promedio' FROM exposicion
		INNER JOIN obra ON ex_id = ob_ex_id
		GROUP BY ex_id) AS tab1 ON exposicion.ex_id = tab1.ex_id
        
	WHERE ob_costo > ex_costo_promedio);
SELECT * FROM vw_obras_costo_superior_al_promedio_exposicion;

-- Punto 12 --
DROP VIEW IF EXISTS vw_museos_al_menos_3_obras_pintura_misma_presentacion;
CREATE VIEW vw_museos_al_menos_3_obras_pintura_misma_presentacion  AS
	(SELECT * FROM museo WHERE mu_id IN 
		(SELECT DISTINCT mu_id FROM presentacion
		INNER JOIN museo ON pre_mu_id = mu_id
		INNER JOIN obra ON pre_ob_id = ob_id
		
		WHERE LOWER(ob_tipo) = 'pintura'
		
		GROUP BY pre_fechaincial, mu_id
		HAVING COUNT(*)>=3)
	);
SELECT * FROM vw_museos_al_menos_3_obras_pintura_misma_presentacion;

-- Punto 13 --
DROP VIEW IF EXISTS vw_costo_promedio_obra_presentacion;
CREATE VIEW vw_costo_promedio_obra_presentacion AS
	(SELECT pre_fechaincial, pre_mu_id, AVG(ob_costo) AS 'costo_promedio_obras' FROM presentacion
	INNER JOIN obra ON pre_ob_id = ob_id
    GROUP BY pre_fechaincial, pre_mu_id);
SELECT * FROM vw_costo_promedio_obra_presentacion;
