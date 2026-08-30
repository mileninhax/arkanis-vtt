-- Planejamento por nível de NEX na aba Progressão: pra cada nível, a pessoa pode
-- escrever uma nota livre e/ou registrar escolhas estruturadas (poder de classe,
-- habilidade de trilha, aumento de atributo etc.) preparadas com antecedência.

create table character_progression_picks (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  nex_percent int not null,
  note text not null default '',
  picks jsonb not null default '[]', -- [{"kind":"poder_classe"|"poder_paranormal"|"trilha"|"atributo"|"outro","label":text,"ref_id":uuid|null}]
  unique (character_id, nex_percent)
);

alter table character_progression_picks enable row level security;
create policy "character_progression_picks: segue o personagem" on character_progression_picks for all using (
  exists (select 1 from characters c where c.id = character_progression_picks.character_id and c.user_id = auth.uid())
);
