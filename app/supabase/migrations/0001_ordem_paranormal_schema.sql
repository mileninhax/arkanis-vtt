-- VTT — schema inicial: conteúdo de sistema (Ordem Paranormal) + personagens + campanhas.
-- Tabelas de conteúdo (origens, classes, rituais, equipamento etc.) guardam dados dos livros
-- como registros, não hardcoded no frontend — populadas por um seed script separado.
-- Este arquivo cria só a estrutura; sem dados ainda (ver seed em supabase/seed/).

-- ============================================================
-- Enums
-- ============================================================

create type attribute as enum ('forca', 'agilidade', 'intelecto', 'vigor', 'presenca');

create type elemento as enum ('conhecimento', 'energia', 'morte', 'sangue', 'medo');

create type skill_training as enum ('nenhum', 'treinado', 'perito');

create type nex_mode as enum ('padrao', 'nex_experiencia');

create type patente as enum ('sem_patente', 'recruta', 'operador', 'agente_especial', 'oficial_operacoes', 'agente_elite');

create type equipment_type as enum ('arma', 'municao', 'protecao', 'geral', 'paranormal');

create type item_category as enum ('0', 'I', 'II', 'III', 'IV');

create type effect_category as enum ('condicao', 'efeito_inimigo', 'ritual', 'habilidade', 'extra', 'personalizado');

-- ============================================================
-- Fontes (livros) — todo conteúdo referencia de onde veio
-- ============================================================

create table sources (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  sort_order int not null default 0
);

insert into sources (slug, name, sort_order) values
  ('ordem_paranormal', 'Ordem Paranormal (Livro Base)', 1),
  ('sobrevivendo_ao_horror', 'Sobrevivendo ao Horror', 2),
  ('arquivos_secretos_01', 'Arquivos Secretos 01', 3),
  ('arquivos_secretos_02', 'Arquivos Secretos 02', 4),
  ('arquivos_secretos_03', 'Arquivos Secretos 03', 5),
  ('arquivos_secretos_04', 'Arquivos Secretos 04', 6),
  ('arquivos_secretos_05', 'Arquivos Secretos 05', 7),
  ('arquivos_secretos_06', 'Arquivos Secretos 06', 8),
  ('arquivos_secretos_07', 'Arquivos Secretos 07', 9);

-- ============================================================
-- Perícias
-- ============================================================

create table skills (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  default_attribute attribute, -- preenchido quando Millie confirmar o mapeamento perícia->atributo do livro
  sort_order int not null default 0
);

-- ============================================================
-- Classes
-- ============================================================

create table classes (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  slug text not null unique,
  name text not null,
  description text,
  is_custom boolean not null default false, -- true só em linhas criadas via "Sua Classe" de um personagem específico (ver character_id em characters)

  pv_initial int,
  pv_initial_attr attribute, -- ex.: Combatente = 'vigor' (20 +VIG)
  pv_per_nex int,
  pv_per_nex_attr attribute,

  pe_initial int,
  pe_initial_attr attribute,
  pe_per_nex int,
  pe_per_nex_attr attribute,

  sanity_initial int,
  sanity_per_nex int,

  pd_initial int,
  pd_initial_attr attribute,
  pd_per_nex int,
  pd_per_nex_attr attribute,

  trained_skills_text text, -- regra de perícias treinadas, ex.: "Luta ou Pontaria... mais 1 + Intelecto"
  proficiencies_text text,

  sort_order int not null default 0
);

create table class_progression (
  id uuid primary key default gen_random_uuid(),
  class_id uuid not null references classes(id) on delete cascade,
  nex_percent int not null,
  gain_text text not null,
  pe_sequential int, -- coluna "PE" da tabela de progressão (1 a 20)
  unique (class_id, nex_percent)
);

create table class_powers (
  id uuid primary key default gen_random_uuid(),
  class_id uuid not null references classes(id) on delete cascade,
  name text not null,
  description text not null,
  prerequisites text,
  sort_order int not null default 0
);

create table class_tracks (
  id uuid primary key default gen_random_uuid(),
  class_id uuid not null references classes(id) on delete cascade,
  slug text not null,
  name text not null,
  description text,
  sort_order int not null default 0,
  unique (class_id, slug)
);

create table class_track_tiers (
  id uuid primary key default gen_random_uuid(),
  track_id uuid not null references class_tracks(id) on delete cascade,
  nex_percent int not null,
  name text not null,
  description text not null,
  unique (track_id, nex_percent)
);

-- ============================================================
-- Origens
-- ============================================================

create table origins (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  roll_range text, -- ex.: "2-8" da tabela de rolagem 2d20 (quando aplicável)
  skill_1_id uuid references skills(id),
  skill_2_id uuid references skills(id),
  skills_text text, -- fallback pra casos como Amnésico ("duas à escolha do mestre")
  power_name text not null,
  power_description text not null,
  description text,
  is_custom boolean not null default false,
  sort_order int not null default 0
);

-- ============================================================
-- Poderes Paranormais
-- ============================================================

create table paranormal_powers (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  elemento elemento, -- null = poder geral (qualquer elemento)
  name text not null,
  description text not null,
  affinity_description text, -- versão com Afinidade, quando existir
  prerequisites text
);

-- ============================================================
-- Rituais
-- ============================================================

create table rituals (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  elemento elemento, -- null = multi-elemento, escolhido ao aprender (ex.: Amaldiçoar Arma)
  circle int not null check (circle between 1 and 4),
  execution text,
  range text,
  target text,
  duration text,
  resistance text,
  effect text not null,
  discente_cost int,
  discente_effect text,
  discente_requires_circle int,
  verdadeiro_cost int,
  verdadeiro_effect text,
  verdadeiro_requires_circle int,
  verdadeiro_requires_affinity boolean not null default false,
  image_url text,
  is_custom boolean not null default false
);

-- ============================================================
-- Equipamento (armas, munições, proteções, itens gerais/paranormais)
-- Campos mecânicos que variam por tipo (dano, crítico, alcance, categoria de munição etc.)
-- ficam em `stats` (jsonb) pra não exigir dezenas de colunas majoritariamente nulas.
-- ============================================================

create table equipment_items (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  type equipment_type not null,
  name text not null,
  category item_category not null default '0',
  spaces int, -- "Espaços" no inventário; null = não ocupa espaço (ex.: mochila militar)
  description text,
  stats jsonb not null default '{}', -- ex. arma: {"dano":"1d8","critico":"19","alcance":"curto","tipo_dano":"C","empunhadura":"uma_mao"}
  is_custom boolean not null default false
);

create table weapon_mods (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  applies_to text not null, -- 'corpo_a_corpo_disparo' | 'armas_fogo' | ...
  effect text not null
);

-- ============================================================
-- Itens Amaldiçoados — maldições (armas/proteções/acessórios) + itens especiais únicos
-- ============================================================

create table cursed_afflictions (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  applies_to text not null, -- 'arma' | 'protecao' | 'acessorio'
  elemento elemento,
  name text not null,
  effect text not null
);

create table cursed_items_special (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  description text not null,
  category item_category,
  spaces int
);

-- ============================================================
-- Ameaças / Bestiário — estrutura provisória, refinada quando VTT_Ameacas_*.md for modelado em detalhe
-- ============================================================

create table creatures (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  vd int, -- valor de desafio
  description text,
  stats jsonb not null default '{}'
);

-- ============================================================
-- Condições e Efeitos (aba "Condições e Efeitos" da ficha, 5.1)
-- ============================================================

create table effects_catalog (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  category effect_category not null,
  name text not null,
  description text not null,
  mechanical_rule jsonb -- regra aplicada automaticamente na ficha (ex.: -1d20 em todos os testes p/ "Abalado")
);

-- ============================================================
-- Perfis de usuário
-- ============================================================

create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  banner_url text,
  accent_color text,
  created_at timestamptz not null default now()
);

-- ============================================================
-- Campanhas (Mesa)
-- ============================================================

create table campaigns (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references profiles(id),
  name text not null,
  description text,
  cover_image_url text,
  accent_color text,
  invite_code text not null unique default substr(md5(random()::text), 1, 10),
  created_at timestamptz not null default now()
);

create table campaign_members (
  campaign_id uuid not null references campaigns(id) on delete cascade,
  user_id uuid not null references profiles(id) on delete cascade,
  role text not null default 'jogador', -- 'mestre' | 'jogador'
  joined_at timestamptz not null default now(),
  primary key (campaign_id, user_id)
);

-- ============================================================
-- Personagens (Ordem Paranormal)
-- ============================================================

create table characters (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  campaign_id uuid references campaigns(id),
  system text not null default 'ordem_paranormal',

  name text,
  avatar_url text,
  doc_number text,

  origin_id uuid references origins(id),
  custom_origin jsonb, -- preenchido quando origin_id é null e o jogador criou a própria origem ("Sua Origem")

  class_id uuid references classes(id),
  custom_class jsonb, -- idem, pra "Sua Classe"

  attributes jsonb not null default '{"forca":1,"agilidade":1,"intelecto":1,"vigor":1,"presenca":1}',

  nex_mode nex_mode not null default 'padrao',
  nex_percent int not null default 0,
  experience int,

  current_pv int,
  temp_pv int not null default 0,
  max_pv_override int, -- dano ao máximo (reduz o teto calculado)
  current_sanity int,
  temp_sanity int not null default 0,
  max_sanity_override int,
  current_pe int,
  current_pd int,

  patente patente not null default 'sem_patente',
  prestigio int not null default 0,

  optional_rules jsonb not null default '{"nex_experiencia":false,"contagem_municao":false,"sem_sanidade":false,"evolucao_patente":false,"ferimentos_debilitantes":false}',

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table character_skills (
  character_id uuid not null references characters(id) on delete cascade,
  skill_id uuid not null references skills(id),
  training skill_training not null default 'nenhum',
  attribute_override attribute,
  extra_bonus int not null default 0,
  primary key (character_id, skill_id)
);

create table character_rituals (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  ritual_id uuid references rituals(id),
  custom_ritual jsonb -- ritual criado do zero pelo jogador, quando ritual_id é null
);

create table character_inventory (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  equipment_item_id uuid references equipment_items(id),
  custom_item jsonb, -- item criado do zero, quando equipment_item_id é null
  category_override item_category,
  is_equipped boolean not null default false,
  is_cursed boolean not null default false,
  cursed_affliction_ids uuid[] not null default '{}',
  ammo_current int,
  ammo_label text, -- "Cenas" | "Usos" | "Missões" quando Contagem de Munição está desativada
  ammo_total int,
  quantity int not null default 1
);

create table character_attacks (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  name text not null,
  skill_id uuid references skills(id),
  attribute attribute,
  d20_bonus int not null default 0,
  attack_bonus text,
  threat_margin int not null default 20,
  multiplier int not null default 2,
  damage_attribute attribute,
  damage jsonb not null default '[]', -- [{"formula":"1d8","tipo":"corte"}]
  general_info jsonb not null default '{}', -- tipo, empunhadura, alcance, tipo_municao
  image_url text,
  modifiers jsonb not null default '[]',
  description text,
  from_inventory_item_id uuid references character_inventory(id)
);

create table character_abilities (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  class_power_id uuid references class_powers(id),
  class_track_tier_id uuid references class_track_tiers(id),
  paranormal_power_id uuid references paranormal_powers(id),
  origin_power_of uuid references origins(id), -- concedida pela própria origem
  custom_ability jsonb -- criada do zero ("Criar Nova Habilidade")
);

create table character_effects (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  effect_id uuid references effects_catalog(id),
  custom_effect jsonb, -- categoria "Personalizado"
  is_active boolean not null default true
);

create table character_modifiers (
  id uuid primary key default gen_random_uuid(),
  character_id uuid not null references characters(id) on delete cascade,
  scope text not null, -- 'teste' | 'ataque' | 'dano'
  name text not null,
  dice_bonus int not null default 0,
  value_bonus int not null default 0,
  threat_margin_bonus int not null default 0,
  multiplier_bonus int not null default 0,
  damage_type text,
  is_active boolean not null default true
);

-- ============================================================
-- Row Level Security — cada pessoa só edita o que é seu; mestre/jogadores da mesma
-- campanha podem ler personagens vinculados a ela.
-- ============================================================

alter table profiles enable row level security;
alter table campaigns enable row level security;
alter table campaign_members enable row level security;
alter table characters enable row level security;
alter table character_skills enable row level security;
alter table character_rituals enable row level security;
alter table character_inventory enable row level security;
alter table character_attacks enable row level security;
alter table character_abilities enable row level security;
alter table character_effects enable row level security;
alter table character_modifiers enable row level security;

create policy "profiles: leitura pública" on profiles for select using (true);
create policy "profiles: dono edita" on profiles for update using (auth.uid() = id);
create policy "profiles: dono insere" on profiles for insert with check (auth.uid() = id);

create policy "campaigns: membros e dono leem" on campaigns for select using (
  auth.uid() = owner_id or exists (
    select 1 from campaign_members m where m.campaign_id = campaigns.id and m.user_id = auth.uid()
  )
);
create policy "campaigns: dono cria" on campaigns for insert with check (auth.uid() = owner_id);
create policy "campaigns: dono edita" on campaigns for update using (auth.uid() = owner_id);
create policy "campaigns: dono deleta" on campaigns for delete using (auth.uid() = owner_id);

create policy "campaign_members: membros leem" on campaign_members for select using (
  auth.uid() = user_id or exists (
    select 1 from campaigns c where c.id = campaign_members.campaign_id and c.owner_id = auth.uid()
  )
);
create policy "campaign_members: usuário entra" on campaign_members for insert with check (auth.uid() = user_id);

create policy "characters: dono ou membros da campanha leem" on characters for select using (
  auth.uid() = user_id or (campaign_id is not null and exists (
    select 1 from campaign_members m where m.campaign_id = characters.campaign_id and m.user_id = auth.uid()
  ))
);
create policy "characters: dono cria" on characters for insert with check (auth.uid() = user_id);
create policy "characters: dono edita" on characters for update using (auth.uid() = user_id);
create policy "characters: dono deleta" on characters for delete using (auth.uid() = user_id);

create policy "character_skills: segue o personagem" on character_skills for all using (
  exists (select 1 from characters c where c.id = character_skills.character_id and c.user_id = auth.uid())
);
create policy "character_rituals: segue o personagem" on character_rituals for all using (
  exists (select 1 from characters c where c.id = character_rituals.character_id and c.user_id = auth.uid())
);
create policy "character_inventory: segue o personagem" on character_inventory for all using (
  exists (select 1 from characters c where c.id = character_inventory.character_id and c.user_id = auth.uid())
);
create policy "character_attacks: segue o personagem" on character_attacks for all using (
  exists (select 1 from characters c where c.id = character_attacks.character_id and c.user_id = auth.uid())
);
create policy "character_abilities: segue o personagem" on character_abilities for all using (
  exists (select 1 from characters c where c.id = character_abilities.character_id and c.user_id = auth.uid())
);
create policy "character_effects: segue o personagem" on character_effects for all using (
  exists (select 1 from characters c where c.id = character_effects.character_id and c.user_id = auth.uid())
);
create policy "character_modifiers: segue o personagem" on character_modifiers for all using (
  exists (select 1 from characters c where c.id = character_modifiers.character_id and c.user_id = auth.uid())
);

-- Tabelas de conteúdo (skills, classes, origins, rituals, equipment_items etc.) são
-- dados de regras do sistema, iguais pra todo mundo — RLS habilitado com leitura
-- pública liberada, mas sem policy de escrita (só service_role, que ignora RLS,
-- escreve nelas — ex.: o seed script).

alter table sources enable row level security;
alter table skills enable row level security;
alter table classes enable row level security;
alter table class_progression enable row level security;
alter table class_powers enable row level security;
alter table class_tracks enable row level security;
alter table class_track_tiers enable row level security;
alter table origins enable row level security;
alter table paranormal_powers enable row level security;
alter table rituals enable row level security;
alter table equipment_items enable row level security;
alter table weapon_mods enable row level security;
alter table cursed_afflictions enable row level security;
alter table cursed_items_special enable row level security;
alter table creatures enable row level security;
alter table effects_catalog enable row level security;

create policy "sources: leitura pública" on sources for select using (true);
create policy "skills: leitura pública" on skills for select using (true);
create policy "classes: leitura pública" on classes for select using (true);
create policy "class_progression: leitura pública" on class_progression for select using (true);
create policy "class_powers: leitura pública" on class_powers for select using (true);
create policy "class_tracks: leitura pública" on class_tracks for select using (true);
create policy "class_track_tiers: leitura pública" on class_track_tiers for select using (true);
create policy "origins: leitura pública" on origins for select using (true);
create policy "paranormal_powers: leitura pública" on paranormal_powers for select using (true);
create policy "rituals: leitura pública" on rituals for select using (true);
create policy "equipment_items: leitura pública" on equipment_items for select using (true);
create policy "weapon_mods: leitura pública" on weapon_mods for select using (true);
create policy "cursed_afflictions: leitura pública" on cursed_afflictions for select using (true);
create policy "cursed_items_special: leitura pública" on cursed_items_special for select using (true);
create policy "creatures: leitura pública" on creatures for select using (true);
create policy "effects_catalog: leitura pública" on effects_catalog for select using (true);
