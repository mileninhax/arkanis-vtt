-- Permite vincular um item de Munição a uma Arma no Inventário — usado ao "Enviar para o
-- combate" pra aplicar automaticamente modificações da munição (ex.: Dum Dum, Explosiva)
-- no ataque gerado.

alter table character_inventory add column linked_ammo_id uuid references character_inventory(id) on delete set null;
