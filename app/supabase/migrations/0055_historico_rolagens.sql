-- Histórico de Rolagens (5.9): registra toda rolagem feita na ficha (testes,
-- ataques, dados manuais) pra exibir num painel compartilhado com a mesa —
-- as rolagens do próprio jogador e as de todos os colegas de campanha.

create table character_rolls (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  user_id uuid not null references profiles(id) on delete cascade,
  campaign_id uuid references campaigns(id),
  character_name text,
  label text not null,
  total int not null,
  detail text not null,
  created_at timestamptz not null default now()
);

alter table character_rolls enable row level security;

create policy "character_rolls: dono ou membros da campanha leem" on character_rolls for select using (
  auth.uid() = user_id or (campaign_id is not null and is_campaign_member(campaign_id))
);

create policy "character_rolls: dono insere" on character_rolls for insert with check (auth.uid() = user_id);
