-- Marcas de "Morrendo"/"Enlouquecendo" (condição Morrendo: 3 marcas na mesma cena = morte;
-- condição Enlouquecendo: 3 marcas = vira NPC). 0 a 3 marcas cada, independentes por barra.

alter table characters add column pv_death_marks int not null default 0;
alter table characters add column sanity_death_marks int not null default 0;
