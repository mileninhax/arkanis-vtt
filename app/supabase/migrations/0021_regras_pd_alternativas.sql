-- 5.8: PD (Ponto de Determinação) não é um 4º stat sempre presente — só existe quando
-- "Jogando sem Sanidade" ou "Evolução por Patente" estão ativas, e cada regra usa uma
-- fórmula diferente. classes.pd_initial/pd_per_nex já seeded (4.5) são na verdade a
-- fórmula de "Jogando sem Sanidade" (fonte confirmada). Esta migration adiciona a fórmula
-- separada de "Evolução por Patente" (por patente, não por NEX) e a tabela de patentes.

alter table classes add column pd_patente_initial int;
alter table classes add column pd_patente_per_patente int;

update classes set pd_patente_initial = 8, pd_patente_per_patente = 4 where slug = 'combatente';
update classes set pd_patente_initial = 12, pd_patente_per_patente = 6 where slug = 'especialista';
update classes set pd_patente_initial = 16, pd_patente_per_patente = 8 where slug = 'ocultista';
-- Sobrevivente: fórmula ainda não confirmada nas fontes processadas.

create table patente_progression (
  patente patente primary key,
  prestigio_minimo int not null,
  pd_limite_turno int not null,
  recuperacao_pv_pd int not null
);

insert into patente_progression (patente, prestigio_minimo, pd_limite_turno, recuperacao_pv_pd) values
  ('recruta', 0, 1, 1),
  ('operador', 20, 3, 2),
  ('agente_especial', 50, 6, 3),
  ('oficial_operacoes', 100, 10, 4),
  ('agente_elite', 200, 15, 5);

alter table patente_progression enable row level security;
create policy "patente_progression: leitura pública" on patente_progression for select using (true);
