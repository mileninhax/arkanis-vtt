-- Painel de Configurações da ficha (5.8): campos pra Aparência (banner/bandeja de
-- dados escolhidos) e Preferências (privacidade compartilhada com a mesa). A aba
-- Mecânicas reutiliza a coluna optional_rules que já existe, só edita a qualquer
-- momento em vez de só na criação. Som é preferência local de dispositivo (localStorage).

alter table characters add column sheet_banner text not null default 'padrao';
alter table characters add column dice_tray text not null default 'padrao';
alter table characters add column editable_by_others boolean not null default false;
alter table characters add column hidden_from_others boolean not null default false;
