-- A trilha so aparecia depois que a pessoa ja tivesse uma habilidade de trilha
-- registrada (via character_progression_picks), o que nao acontece se o NEX ainda
-- for baixo demais pra ter desbloqueado alguma. Agora a trilha escolhida fica
-- guardada direto no personagem, independente do NEX atual.

alter table characters add column chosen_track_id uuid references class_tracks(id);
