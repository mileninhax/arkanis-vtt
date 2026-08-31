-- Esforço tambem tem "Temp." igual Vida e Sanidade, mas so existia temp_pv/temp_sanity.

alter table characters add column temp_pe int not null default 0;
