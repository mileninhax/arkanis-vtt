-- Condições e Efeitos (Fase 9): tags livres de condição/efeito ativo na ficha
-- (ex: "Alterar Destino"), adicionadas/removidas pelo jogador na aba Agente.

alter table characters add column conditions jsonb not null default '[]'::jsonb;
