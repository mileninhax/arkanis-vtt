-- As "habilidades base" de NEX 5% (Ataque Especial, Eclético/Perito, Escolhido pelo Outro Lado)
-- são concedidas automaticamente ao criar a ficha, diferente dos poderes de classe escolhidos
-- em NEX 15/30/45... (ver 11.5). Adiciona uma flag pra distingui-las na tabela de poderes.

alter table class_powers add column is_base_ability boolean not null default false;

insert into class_powers (class_id, name, description, sort_order, is_base_ability)
select (select id from classes where slug = 'combatente'),
  'Ataque Especial', 'Quando faz um ataque, você pode gastar 2 PE para receber +5 no teste de ataque ou na rolagem de dano. Conforme avança de NEX, pode gastar +1 PE para receber mais um bônus de +5 (cada bônus pode ir pra ataque ou dano, livremente).', 0, true;

insert into class_powers (class_id, name, description, sort_order, is_base_ability)
select (select id from classes where slug = 'especialista'),
  'Eclético', 'Teste de qualquer perícia, gasta 2 PE pra receber os benefícios de ser treinado nela.', 0, true;

insert into class_powers (class_id, name, description, sort_order, is_base_ability)
select (select id from classes where slug = 'especialista'),
  'Perito', 'Escolhe 2 perícias treinadas (exceto Luta/Pontaria); teste nelas, gasta 2 PE pra +1d6 no resultado, escalando o dado com o NEX (+1d8 em 25%, +1d10 em 55%, +1d12 em 85%).', 0, true;

insert into class_powers (class_id, name, description, sort_order, is_base_ability)
select (select id from classes where slug = 'ocultista'),
  'Escolhido pelo Outro Lado', 'Conjura rituais de 1º círculo, ganhando acesso a círculos maiores conforme o NEX (2º em 25%, 3º em 55%, 4º em 85%). Começa com 3 rituais de 1º círculo conhecidos; a cada aumento de NEX, aprende um ritual de qualquer círculo que possa lançar (não conta no limite de rituais conhecidos).', 0, true;

insert into class_powers (class_id, name, description, sort_order, is_base_ability)
select (select id from classes where slug = 'mundano'),
  'Empenho', 'Teste de perícia, gasta 1 PE pra +2 nesse teste.', 0, true;
