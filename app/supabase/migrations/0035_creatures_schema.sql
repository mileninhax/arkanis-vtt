-- Schema definitivo de criaturas (bestiário) — substitui a tabela provisória por uma que
-- reflete a estrutura real da ficha de ameaça (Livro Base, Cap. 7, p.177-182): descritores,
-- sentidos, defesa/resistências de teste, PV, atributos, perícias, deslocamento, habilidades
-- (passivas) e ações (ativas, com teste/dano). `stats` continua como overflow pra qualquer
-- coisa que não caiba nos campos abaixo.

alter table creatures add column flavor_text text;
alter table creatures add column descritores text[] not null default '{}';
alter table creatures add column tamanho text; -- Minúsculo/Pequeno/Médio/Grande/Enorme/Colossal
alter table creatures add column presenca_dt int;
alter table creatures add column presenca_dano text;
alter table creatures add column presenca_nex_imune int;
alter table creatures add column percepcao text;
alter table creatures add column iniciativa text;
alter table creatures add column defesa int;
alter table creatures add column fortitude text;
alter table creatures add column reflexos text;
alter table creatures add column vontade text;
alter table creatures add column pv_maximo int;
alter table creatures add column pv_machucado int;
alter table creatures add column resistencias text;
alter table creatures add column vulnerabilidades text;
alter table creatures add column atributos jsonb not null default '{}'; -- {"agi":1,"for":3,"int":0,"pre":1,"vig":3}
alter table creatures add column pericias text;
alter table creatures add column deslocamento text;
alter table creatures add column habilidades jsonb not null default '[]'; -- [{"nome":text,"descricao":text}]
alter table creatures add column acoes jsonb not null default '[]'; -- [{"tipo":text,"nome":text,"teste":text,"dano":text,"descricao":text}]
alter table creatures add column enigma_medo text;
alter table creatures add column sort_order int not null default 0;
