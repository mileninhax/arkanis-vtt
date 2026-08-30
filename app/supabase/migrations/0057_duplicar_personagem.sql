-- Duplicar Personagem (Jogar, menu de três pontinhos): copia a ficha inteira
-- (todas as colunas de characters + tabelas filhas) pra um novo personagem do
-- mesmo dono. Usa colunas dinâmicas (information_schema) pra não depender de
-- manter uma lista de colunas manual conforme o schema evolui.
--
-- character_inventory.linked_ammo_id e character_attacks.from_inventory_item_id
-- apontam pra outras linhas de character_inventory do mesmo personagem, então
-- precisam de remapeamento de id (tabela temporária _inv_map).

create or replace function duplicate_character(p_source_id uuid)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_new_id uuid;
  v_owner uuid;
  v_cols text;
  t text;
  v_simple_tables text[] := array[
    'character_rituals',
    'character_abilities',
    'character_effects',
    'character_temp_bonuses',
    'character_investigation_pages',
    'character_modifiers',
    'character_progression_picks'
  ];
begin
  select user_id into v_owner from characters where id = p_source_id;
  if v_owner is null or v_owner <> auth.uid() then
    raise exception 'not allowed';
  end if;

  select string_agg(quote_ident(column_name), ', ' order by ordinal_position)
    into v_cols
    from information_schema.columns
   where table_schema = 'public' and table_name = 'characters'
     and column_name not in ('id', 'created_at');

  execute format(
    'insert into characters (%1$s) select %1$s from characters where id = $1 returning id',
    v_cols
  ) using p_source_id into v_new_id;

  update characters set name = coalesce(name, 'Personagem') || ' (Cópia)' where id = v_new_id;

  foreach t in array v_simple_tables loop
    select string_agg(quote_ident(column_name), ', ' order by ordinal_position)
      into v_cols
      from information_schema.columns
     where table_schema = 'public' and table_name = t
       and column_name not in ('id', 'character_id');

    execute format(
      'insert into %1$I (character_id, %2$s) select $1, %2$s from %1$I where character_id = $2',
      t, v_cols
    ) using v_new_id, p_source_id;
  end loop;

  insert into character_skills (character_id, skill_id, training, attribute_override, extra_bonus)
  select v_new_id, skill_id, training, attribute_override, extra_bonus
  from character_skills where character_id = p_source_id;

  create temporary table _inv_map (old_id uuid primary key, new_id uuid not null) on commit drop;

  insert into _inv_map (old_id, new_id)
  select id, gen_random_uuid() from character_inventory where character_id = p_source_id;

  select string_agg(quote_ident(column_name), ', ' order by ordinal_position)
    into v_cols
    from information_schema.columns
   where table_schema = 'public' and table_name = 'character_inventory'
     and column_name not in ('id', 'character_id', 'linked_ammo_id');

  execute format(
    'insert into character_inventory (id, character_id, linked_ammo_id, %1$s)
     select m.new_id, $1, lm.new_id, %1$s
     from character_inventory ci
     join _inv_map m on m.old_id = ci.id
     left join _inv_map lm on lm.old_id = ci.linked_ammo_id
     where ci.character_id = $2',
    v_cols
  ) using v_new_id, p_source_id;

  select string_agg(quote_ident(column_name), ', ' order by ordinal_position)
    into v_cols
    from information_schema.columns
   where table_schema = 'public' and table_name = 'character_attacks'
     and column_name not in ('id', 'character_id', 'from_inventory_item_id');

  execute format(
    'insert into character_attacks (character_id, from_inventory_item_id, %1$s)
     select $1, m.new_id, %1$s
     from character_attacks ca
     left join _inv_map m on m.old_id = ca.from_inventory_item_id
     where ca.character_id = $2',
    v_cols
  ) using v_new_id, p_source_id;

  return v_new_id;
end;
$$;

grant execute on function duplicate_character(uuid) to authenticated;
