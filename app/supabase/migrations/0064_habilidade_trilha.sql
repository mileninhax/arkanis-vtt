-- As habilidades de trilha (class_track_tiers) nunca apareciam na aba Habilidades
-- porque essa aba so le da tabela character_abilities, e essa tabela nao tinha uma
-- coluna pra referenciar um tier de trilha.

alter table character_abilities add column track_tier_id uuid references class_track_tiers(id);
