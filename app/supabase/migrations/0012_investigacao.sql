-- Aba Investigação (5.2): campos da sub-aba Pessoal direto em characters,
-- e uma tabela pra páginas da sub-aba Investigação (múltiplas, criadas livremente).

alter table characters add column aparencia text;
alter table characters add column personalidade text;
alter table characters add column objetivo text;
alter table characters add column historico text;
alter table characters add column lembrete_fechado boolean not null default false;

create table character_investigation_pages (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  title text not null default '',
  objective text not null default '',
  summary text not null default '',
  questions text not null default '',
  clues text not null default '',
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table character_investigation_pages enable row level security;
create policy "character_investigation_pages: segue o personagem" on character_investigation_pages for all using (
  exists (select 1 from characters c where c.id = character_investigation_pages.character_id and c.user_id = auth.uid())
);
