-- A tabela character_abilities ja tinha uma coluna "class_track_tier_id" desde o
-- schema original (0001), sem uso ate agora. A 0064 criou "track_tier_id" sem
-- perceber que ja existia -- migra o que foi salvo com o nome errado e remove a
-- coluna duplicada.

update character_abilities set class_track_tier_id = track_tier_id where track_tier_id is not null and class_track_tier_id is null;
alter table character_abilities drop column track_tier_id;
