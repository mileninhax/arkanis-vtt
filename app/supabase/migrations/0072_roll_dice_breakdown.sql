-- Guarda a lista estruturada de dados (lados/valor/descartado) e o bonus de
-- cada rolagem, pra o Histórico de Rolagens conseguir mostrar o mesmo card
-- clicável com a formula colorida e o flip de detalhes (igual o RollCard).

alter table character_rolls add column dice jsonb;
alter table character_rolls add column bonus int not null default 0;
