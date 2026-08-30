-- Preenche o mapeamento perícia -> atributo-base (Tabela 2.1 do Livro Base) e as flags
-- de regra associadas a cada perícia (só pode ser usada se treinada / sofre penalidade
-- de carga / exige kit de perícia sem o qual leva -5).

alter table skills add column only_trained boolean not null default false;
alter table skills add column carga_penalty boolean not null default false;
alter table skills add column requires_kit boolean not null default false;

update skills set default_attribute = v.attr::attribute, only_trained = v.only_trained, carga_penalty = v.carga, requires_kit = v.kit
from (values
  ('Acrobacia', 'agilidade', false, true, false),
  ('Adestramento', 'presenca', false, false, false),
  ('Artes', 'presenca', false, false, false),
  ('Atletismo', 'forca', false, false, false),
  ('Atualidades', 'intelecto', false, false, false),
  ('Ciências', 'intelecto', false, false, false),
  ('Crime', 'agilidade', true, true, true),
  ('Diplomacia', 'presenca', false, false, false),
  ('Enganação', 'presenca', false, false, true),
  ('Fortitude', 'vigor', false, false, false),
  ('Furtividade', 'agilidade', false, true, false),
  ('Iniciativa', 'agilidade', false, false, false),
  ('Intimidação', 'presenca', false, false, false),
  ('Intuição', 'presenca', false, false, false),
  ('Investigação', 'intelecto', false, false, false),
  ('Luta', 'forca', false, false, false),
  ('Medicina', 'intelecto', false, false, true),
  ('Ocultismo', 'intelecto', true, false, true),
  ('Percepção', 'presenca', false, false, false),
  ('Pilotagem', 'agilidade', true, false, false),
  ('Pontaria', 'agilidade', false, false, false),
  ('Profissão', 'intelecto', false, false, true),
  ('Reflexos', 'agilidade', false, false, false),
  ('Religião', 'presenca', false, false, false),
  ('Sobrevivência', 'intelecto', false, false, false),
  ('Tática', 'intelecto', false, false, false),
  ('Tecnologia', 'intelecto', true, false, true),
  ('Vontade', 'presenca', false, false, false)
) as v(name, attr, only_trained, carga, kit)
where skills.name = v.name;
