-- Reset de desenvolvimento: limpa qualquer estado parcial antes de reaplicar 0001.
-- Só use isso enquanto o schema ainda está em iteração e não há dados reais no banco.

drop table if exists
  character_modifiers, character_effects, character_abilities, character_attacks,
  character_inventory, character_rituals, character_skills, characters,
  campaign_members, campaigns, profiles,
  effects_catalog, creatures, cursed_items_special, cursed_afflictions, weapon_mods,
  equipment_items, rituals, paranormal_powers, origins,
  class_track_tiers, class_tracks, class_powers, class_progression, classes,
  skills, sources
cascade;

drop type if exists
  effect_category, item_category, equipment_type, patente, nex_mode,
  skill_training, elemento, attribute
cascade;
