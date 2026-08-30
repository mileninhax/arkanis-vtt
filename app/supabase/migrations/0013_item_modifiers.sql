-- Modificadores e Maldições aplicados a um item do inventário (5.1). Guarda tanto
-- referências ao catálogo (weapon_mods/cursed_afflictions) quanto entradas totalmente
-- customizadas ("Criar Nova Modificação/Maldição") no mesmo array, já resolvidas em texto,
-- pra não precisar de join toda vez que a ficha renderiza o item.

alter table character_inventory add column applied_modifiers jsonb not null default '[]';
-- formato de cada entrada: {"kind":"modificacao"|"maldicao","name":text,"effect":text,"elemento":text|null}
