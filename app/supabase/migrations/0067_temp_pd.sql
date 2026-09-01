-- Determinacao tambem tem "Temp." igual Vida/Sanidade/Esforco, mas faltava a coluna.

alter table characters add column temp_pd int not null default 0;
