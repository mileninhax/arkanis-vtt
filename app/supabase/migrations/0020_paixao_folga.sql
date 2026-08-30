-- Regra da Paixão (Arquivos Secretos 03): vínculo romântico com bônus permanente
-- (até um parceiro morrer). Folga da Ordem (Sobrevivendo ao Horror 12): interlúdio
-- estendido entre missões, com um "problema" que pode travar a ação Relaxar até resolvido.

alter table characters add column vinculo_parceiro text;
alter table characters add column vinculo_pv_pe_bonus int not null default 0;
alter table characters add column problema_folga text;
