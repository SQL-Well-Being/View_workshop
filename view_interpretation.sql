USE museo;

-- Punto 7 --
INSERT INTO obra (ob_id, ob_nombre, ob_tipo, ob_costo, ob_ex_id)
VALUES 
    (501, 'Amanecer Sobre las Colinas', 'pintura', 1200, 1003),
    (502, 'Armonía Graciosa', 'escultura', 900, 1004),
    (503, 'Susurros de la Naturaleza', 'dibujo', 500, 1005);

INSERT INTO presentacion (pre_fechaincial, pre_ob_id, pre_mu_id)
VALUES 
    ('May-jul-2024', 501, 101), -- Amanecer Sobre las Colinas en el Louvre
    ('Jun-ago-2024', 502, 102), -- Armonía Graciosa en el Met
    ('Jul-sep-2024', 503, 205), -- Susurros de la Naturaleza en el Museo de Shanghái
    ('Jul-sep-2024', 501, 102), -- Amanecer Sobre las Colinas en el Met
    ('Ago-oct-2024', 502, 101), -- Armonía Graciosa en el Louvre
    ('May-sep-2013', 503, 304), -- Susurros de la Naturaleza en el Museo Británico
    ('Oct-dic-2024', 501, 205); -- Amanecer Sobre las Colinas en el Museo de Shanghái