USE museo;

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
SELECT AVG(ob_costo) FROM obra;


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
