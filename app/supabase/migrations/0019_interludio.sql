-- Bônus temporários de "Exercitar-se"/"Ler" (ação de interlúdio): pilhas de +1d6
-- consumíveis num teste futuro, lembradas na aba Habilidades até serem gastas.

create table character_temp_bonuses (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  source text not null, -- 'Exercitar-se' | 'Ler'
  attribute_group text not null, -- 'fisico' (Agilidade/Força/Vigor) | 'mental' (Intelecto/Presença)
  dice text not null default '1d6',
  remaining int not null,
  created_at timestamptz not null default now()
);

alter table character_temp_bonuses enable row level security;
create policy "character_temp_bonuses: segue o personagem" on character_temp_bonuses for all using (
  exists (select 1 from characters c where c.id = character_temp_bonuses.character_id and c.user_id = auth.uid())
);
