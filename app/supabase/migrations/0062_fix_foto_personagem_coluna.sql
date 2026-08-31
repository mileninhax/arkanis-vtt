-- A 0061 criou uma coluna nova "photo_url", mas a tabela characters já tinha uma coluna
-- "avatar_url" (desde a 0001) que é a que o resto do app usa pra mostrar a foto do
-- personagem (MeusPersonagens, EntrarCampanha, AgenteTab). Migra o que já foi salvo e
-- remove a coluna duplicada.

update characters set avatar_url = photo_url where photo_url is not null and avatar_url is null;
alter table characters drop column photo_url;
