-- Registra qual munição cada arma de disparo/fogo usa (Tabela 3.3/3.4 do Livro Base),
-- pra filtrar o seletor de munição no Inventário só pelo tipo compatível.

update equipment_items set stats = stats || jsonb_build_object('tipo_municao', v.municao)
from (values
  ('Arco', 'Flechas'),
  ('Besta', 'Flechas'),
  ('Pistola', 'Balas curtas'),
  ('Revólver', 'Balas curtas'),
  ('Fuzil de caça', 'Balas longas'),
  ('Submetralhadora', 'Balas curtas'),
  ('Espingarda', 'Cartuchos'),
  ('Fuzil de assalto', 'Balas longas'),
  ('Fuzil de precisão', 'Balas longas'),
  ('Arco composto', 'Flechas'),
  ('Balestra', 'Flechas'),
  ('Bazuca', 'Foguete'),
  ('Lança-chamas', 'Combustível'),
  ('Metralhadora', 'Balas longas')
) as v(name, municao)
where equipment_items.type = 'arma' and equipment_items.name = v.name;
