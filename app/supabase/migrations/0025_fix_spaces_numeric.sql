-- Sobrevivendo ao Horror introduz itens de meio-espaço (0,5) — "Espaços" precisa
-- aceitar valor fracionário, não só inteiro.

alter table equipment_items alter column spaces type numeric using spaces::numeric;
alter table cursed_items_special alter column spaces type numeric using spaces::numeric;
