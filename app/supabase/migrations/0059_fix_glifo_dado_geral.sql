-- Continuação da 0058: o mesmo glifo residual (◯ — a imagem de um d20 do material
-- original, extraída como um círculo sem sentido) aparece em várias outras tabelas de
-- conteúdo (poderes, rituais, equipamentos, itens amaldiçoados, regras extras, perigos
-- e o bestiário). Mesma lógica de troca: "-◯" -> "-1d20", "2◯"/"◯◯" -> "2d20" etc.

update class_powers set
  description   = replace(replace(replace(regexp_replace(description,   '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  prerequisites = replace(replace(replace(regexp_replace(prerequisites, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%' or prerequisites like '%◯%';

update class_progression set
  gain_text = replace(replace(replace(regexp_replace(gain_text, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where gain_text like '%◯%';

update class_track_tiers set
  description = replace(replace(replace(regexp_replace(description, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%';

update class_tracks set
  description = replace(replace(replace(regexp_replace(description, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%';

update general_powers set
  description   = replace(replace(replace(regexp_replace(description,   '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  prerequisites = replace(replace(replace(regexp_replace(prerequisites, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%' or prerequisites like '%◯%';

update paranormal_powers set
  description           = replace(replace(replace(regexp_replace(description,           '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  affinity_description   = replace(replace(replace(regexp_replace(affinity_description,   '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  prerequisites          = replace(replace(replace(regexp_replace(prerequisites,          '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%' or affinity_description like '%◯%' or prerequisites like '%◯%';

update rituals set
  effect            = replace(replace(replace(regexp_replace(effect,            '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  discente_effect    = replace(replace(replace(regexp_replace(discente_effect,   '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  verdadeiro_effect  = replace(replace(replace(regexp_replace(verdadeiro_effect, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  resistance         = replace(replace(replace(regexp_replace(resistance,        '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where effect like '%◯%' or discente_effect like '%◯%' or verdadeiro_effect like '%◯%' or resistance like '%◯%';

update equipment_items set
  description = replace(replace(replace(regexp_replace(description, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  stats       = (replace(replace(replace(regexp_replace(stats::text, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'))::jsonb
where description like '%◯%' or stats::text like '%◯%';

update weapon_mods set
  effect = replace(replace(replace(regexp_replace(effect, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where effect like '%◯%';

update cursed_afflictions set
  effect = replace(replace(replace(regexp_replace(effect, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where effect like '%◯%';

update cursed_items_special set
  description = replace(replace(replace(regexp_replace(description, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%';

update extra_rules set
  content = replace(replace(replace(regexp_replace(content, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where content like '%◯%';

update hazards set
  description = replace(replace(replace(regexp_replace(description, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20')
where description like '%◯%';

update creatures set
  flavor_text     = replace(replace(replace(regexp_replace(flavor_text,     '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  presenca_dano   = replace(replace(replace(regexp_replace(presenca_dano,   '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  percepcao       = replace(replace(replace(regexp_replace(percepcao,       '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  iniciativa      = replace(replace(replace(regexp_replace(iniciativa,      '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  fortitude       = replace(replace(replace(regexp_replace(fortitude,       '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  reflexos        = replace(replace(replace(regexp_replace(reflexos,        '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  vontade         = replace(replace(replace(regexp_replace(vontade,         '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  resistencias    = replace(replace(replace(regexp_replace(resistencias,    '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  vulnerabilidades= replace(replace(replace(regexp_replace(vulnerabilidades,'(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  pericias        = replace(replace(replace(regexp_replace(pericias,        '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  deslocamento    = replace(replace(replace(regexp_replace(deslocamento,    '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  enigma_medo     = replace(replace(replace(regexp_replace(enigma_medo,     '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  description     = replace(replace(replace(regexp_replace(description,     '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'),
  habilidades     = (replace(replace(replace(regexp_replace(habilidades::text, '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'))::jsonb,
  acoes           = (replace(replace(replace(regexp_replace(acoes::text,       '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'))::jsonb,
  stats           = (replace(replace(replace(regexp_replace(stats::text,       '(\d+)◯+', '\1d20', 'g'), '◯◯◯', '3d20'), '◯◯', '2d20'), '◯', '1d20'))::jsonb
where flavor_text like '%◯%' or presenca_dano like '%◯%' or percepcao like '%◯%' or iniciativa like '%◯%'
   or fortitude like '%◯%' or reflexos like '%◯%' or vontade like '%◯%' or resistencias like '%◯%'
   or vulnerabilidades like '%◯%' or pericias like '%◯%' or deslocamento like '%◯%' or enigma_medo like '%◯%'
   or description like '%◯%' or habilidades::text like '%◯%' or acoes::text like '%◯%' or stats::text like '%◯%';
