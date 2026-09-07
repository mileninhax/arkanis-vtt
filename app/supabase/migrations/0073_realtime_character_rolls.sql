-- Habilita Realtime pra character_rolls, pra o painel de Histórico de
-- Rolagens atualizar sozinho quando alguem rola (sem precisar fechar/abrir).

alter publication supabase_realtime add table character_rolls;
