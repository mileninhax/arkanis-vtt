-- Permite upsert por (character_id, scope, name) — usado pra aplicar/remover
-- automaticamente o modificador de teste/ataque de uma condição (ex.: Abalado
-- = -1d20 em testes) sem duplicar a linha toda vez que a condição é adicionada.

alter table character_modifiers
  add constraint character_modifiers_char_scope_name_key unique (character_id, scope, name);
