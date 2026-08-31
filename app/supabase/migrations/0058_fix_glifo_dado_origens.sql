-- Corrige um glifo residual (◯ — a imagem de um d20 do material original, que virou
-- um circulo sem sentido na transcricao) nas descricoes de origem, trocando pelo
-- texto real do dado de bonus/penalidade (ex.: "-◯" -> "-1d20", "2◯" -> "2d20",
-- "◯◯" -> "2d20").

update origins set
  power_description = replace(replace(replace(regexp_replace(power_description, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  description        = replace(replace(replace(regexp_replace(description,        '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  skills_text         = replace(replace(replace(regexp_replace(skills_text,        '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where power_description like '%◯%' or description like '%◯%' or skills_text like '%◯%';
