-- Bônus editáveis manualmente do card de Defesa na aba de Combate: "Outros"
-- (bônus de defesa fora do equipamento), e os valores de Bloqueio e Esquiva.

alter table characters add column defense_other_bonus int not null default 0;
alter table characters add column bloqueio_bonus int not null default 0;
alter table characters add column esquiva_bonus int not null default 0;
