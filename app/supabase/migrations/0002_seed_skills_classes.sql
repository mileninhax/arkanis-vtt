-- Seed: perícias e classes (Livro Base). Fonte: docs/VTT_Conteudo_Ordem_Paranormal.md (11.1, 11.2, 11.5).

-- Sobrevivente ainda não tem fonte de livro confirmada (ver 11.5) — permite source_id nulo pra esse caso.
alter table classes alter column source_id drop not null;

-- ============================================================
-- Perícias (11.1)
-- ============================================================

insert into skills (name, sort_order) values
  ('Acrobacia', 1), ('Adestramento', 2), ('Artes', 3), ('Atletismo', 4), ('Atualidades', 5),
  ('Ciências', 6), ('Crime', 7), ('Diplomacia', 8), ('Enganação', 9), ('Fortitude', 10),
  ('Furtividade', 11), ('Iniciativa', 12), ('Intimidação', 13), ('Intuição', 14), ('Investigação', 15),
  ('Luta', 16), ('Medicina', 17), ('Ocultismo', 18), ('Percepção', 19), ('Pilotagem', 20),
  ('Pontaria', 21), ('Profissão', 22), ('Reflexos', 23), ('Religião', 24), ('Sobrevivência', 25),
  ('Tática', 26), ('Tecnologia', 27), ('Vontade', 28);

-- ============================================================
-- Classes (4.5 / 11.5)
-- ============================================================

insert into classes (
  source_id, slug, name, description,
  pv_initial, pv_initial_attr, pv_per_nex, pv_per_nex_attr,
  pe_initial, pe_initial_attr, pe_per_nex, pe_per_nex_attr,
  sanity_initial, sanity_per_nex,
  pd_initial, pd_initial_attr, pd_per_nex, pd_per_nex_attr,
  trained_skills_text, proficiencies_text, sort_order
) values
(
  (select id from sources where slug = 'ordem_paranormal'),
  'combatente', 'Combatente',
  'Treinado para lutar com todo tipo de armas, e com a força e a coragem para encarar os perigos de frente. É o tipo de agente que prefere abordagens mais diretas e costuma atirar primeiro e perguntar depois.',
  20, 'vigor', 4, 'vigor',
  2, 'presenca', 2, 'presenca',
  12, 3,
  6, 'presenca', 3, 'presenca',
  'Luta ou Pontaria (uma das duas) e Fortitude ou Reflexos (uma das duas), mais perícias à escolha = 1 + Intelecto',
  'Armas simples, armas táticas e proteções leves', 1
),
(
  (select id from sources where slug = 'ordem_paranormal'),
  'especialista', 'Especialista',
  'Um agente que confia mais em esperteza do que em força bruta. Se vale de conhecimento técnico, raciocínio rápido ou mesmo lábia para resolver mistérios e enfrentar o paranormal.',
  16, 'vigor', 3, 'vigor',
  3, 'presenca', 3, 'presenca',
  16, 4,
  8, 'presenca', 4, 'presenca',
  'Perícias à escolha = 7 + Intelecto',
  'Armas simples e proteções leves', 2
),
(
  (select id from sources where slug = 'ordem_paranormal'),
  'ocultista', 'Ocultista',
  'O Outro Lado é misterioso, perigoso e cativante. Esse tipo de agente não é apenas um conhecedor do oculto, mas também possui talento para se conectar com elementos paranormais em busca de compreendê-los e usá-los para combater o próprio Outro Lado.',
  12, 'vigor', 2, 'vigor',
  4, 'presenca', 4, 'presenca',
  20, 5,
  10, 'presenca', 5, 'presenca',
  'Ocultismo e Vontade, mais perícias à escolha = 3 + Intelecto',
  'Armas simples', 3
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'sobrevivente', 'Sobrevivente',
  'Muito mais fraco que Combatente, Especialista ou Ocultista — de propósito, para oferecer uma experiência de jogo diferente, na pele de uma pessoa comum que precisa fugir ou se esconder diante do terror. Progride por Estágio (1-5), não por NEX% como as demais classes — ver pendência de design.',
  8, 'vigor', 2, null,
  2, 'presenca', 1, null,
  8, 2,
  4, 'presenca', 2, null,
  'Escolha 1 + Intelecto',
  'Armas simples', 4
),
(
  (select id from sources where slug = 'ordem_paranormal'),
  'mundano', 'Mundano',
  'Uma pessoa comum, com ocupação regular e vida normal — que não vai continuar normal por muito tempo. Estado transitório (Livro Base, "Personagens de NEX 0%", p.171): não progride por NEX sozinho, e ao atingir NEX 5% escolhe Combatente, Especialista ou Ocultista.',
  8, 'vigor', null, null,
  1, 'presenca', null, null,
  8, null,
  4, 'presenca', null, null,
  'Escolha 1 + Intelecto',
  'Armas simples', 5
);

-- ============================================================
-- Progressão por NEX — Combatente (Tabela 1.3)
-- ============================================================

insert into class_progression (class_id, nex_percent, gain_text, pe_sequential)
select (select id from classes where slug = 'combatente'), v.nex, v.gain, v.pe from (values
  (5, 'Ataque especial (2 PE, +5)', 1),
  (10, 'Habilidade de trilha', 2),
  (15, 'Poder de combatente', 3),
  (20, 'Aumento de atributo', 4),
  (25, 'Ataque especial (3 PE, +10)', 5),
  (30, 'Poder de combatente', 6),
  (35, 'Grau de treinamento', 7),
  (40, 'Habilidade de trilha', 8),
  (45, 'Poder de combatente', 9),
  (50, 'Aumento de atributo, versatilidade', 10),
  (55, 'Ataque especial (4 PE, +15)', 11),
  (60, 'Poder de combatente', 12),
  (65, 'Habilidade de trilha', 13),
  (70, 'Grau de treinamento', 14),
  (75, 'Poder de combatente', 15),
  (80, 'Aumento de atributo', 16),
  (85, 'Ataque especial (5 PE, +20)', 17),
  (90, 'Poder de combatente', 18),
  (95, 'Aumento de atributo', 19),
  (99, 'Habilidade de trilha', 20)
) as v(nex, gain, pe);

-- ============================================================
-- Progressão por NEX — Especialista (Tabela 1.4)
-- ============================================================

insert into class_progression (class_id, nex_percent, gain_text, pe_sequential)
select (select id from classes where slug = 'especialista'), v.nex, v.gain, v.pe from (values
  (5, 'Eclético, perito (2 PE, +1d6)', 1),
  (10, 'Habilidade de trilha', 2),
  (15, 'Poder de especialista', 3),
  (20, 'Aumento de atributo', 4),
  (25, 'Perito (3 PE, +1d8)', 5),
  (30, 'Poder de especialista', 6),
  (35, 'Grau de treinamento', 7),
  (40, 'Engenhosidade (veterano), habilidade de trilha', 8),
  (45, 'Poder de especialista', 9),
  (50, 'Aumento de atributo, versatilidade', 10),
  (55, 'Perito (4 PE, +1d10)', 11),
  (60, 'Poder de especialista', 12),
  (65, 'Habilidade de trilha', 13),
  (70, 'Grau de treinamento', 14),
  (75, 'Engenhosidade (expert), poder de especialista', 15),
  (80, 'Aumento de atributo', 16),
  (85, 'Perito (5 PE, +1d12)', 17),
  (90, 'Poder de especialista', 18),
  (95, 'Aumento de atributo', 19),
  (99, 'Habilidade de trilha', 20)
) as v(nex, gain, pe);

-- ============================================================
-- Progressão por NEX — Ocultista (Tabela 1.5)
-- ============================================================

insert into class_progression (class_id, nex_percent, gain_text, pe_sequential)
select (select id from classes where slug = 'ocultista'), v.nex, v.gain, v.pe from (values
  (5, 'Escolhido pelo Outro Lado (1º círculo)', 1),
  (10, 'Habilidade de trilha', 2),
  (15, 'Poder de ocultista', 3),
  (20, 'Aumento de atributo', 4),
  (25, 'Escolhido pelo Outro Lado (2º círculo)', 5),
  (30, 'Poder de ocultista', 6),
  (35, 'Grau de treinamento', 7),
  (40, 'Habilidade de trilha', 8),
  (45, 'Poder de ocultista', 9),
  (50, 'Aumento de atributo, versatilidade', 10),
  (55, 'Escolhido pelo Outro Lado (3º círculo)', 11),
  (60, 'Poder de ocultista', 12),
  (65, 'Habilidade de trilha', 13),
  (70, 'Grau de treinamento', 14),
  (75, 'Poder de ocultista', 15),
  (80, 'Aumento de atributo', 16),
  (85, 'Escolhido pelo Outro Lado (4º círculo)', 17),
  (90, 'Poder de ocultista', 18),
  (95, 'Aumento de atributo', 19),
  (99, 'Habilidade de trilha', 20)
) as v(nex, gain, pe);

-- ============================================================
-- Poderes de Combatente
-- ============================================================

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'combatente'), v.name, v.description, v.prereq, v.ord from (values
  ('Armamento Pesado', 'Proficiência com armas pesadas.', 'For 2', 1),
  ('Artista Marcial', 'Ataques desarmados causam 1d6 (1d8 em NEX 35%, 1d10 em NEX 70%), podem causar dano letal e se tornam ágeis.', null, 2),
  ('Ataque de Oportunidade', 'Quando um ser sai voluntariamente de um espaço adjacente ao seu, gasta reação + 1 PE pra ataque corpo a corpo contra ele.', null, 3),
  ('Combater com Duas Armas', 'Empunhando duas armas (uma leve), ao agredir pode atacar com as duas; sofre -1d20 em testes de ataque até o próximo turno.', 'Agi 3, treinado em Luta ou Pontaria', 4),
  ('Combate Defensivo', 'Ao agredir, pode combater defensivamente: -1d20 em testes de ataque até o próximo turno, mas +5 na Defesa.', 'Int 2', 5),
  ('Golpe Demolidor', 'Ao quebrar ou atacar um objeto, gasta 1 PE pra causar +2 dados de dano do mesmo tipo da arma.', 'For 2, treinado em Luta', 6),
  ('Golpe Pesado', 'Empunhando arma corpo a corpo, o dano dela aumenta em +1 dado do mesmo tipo.', null, 7),
  ('Incansável', 'Uma vez por cena, gasta 2 PE pra ação de investigação adicional usando Força ou Agilidade como atributo-base.', null, 8),
  ('Presteza Atlética', 'Em teste de facilitar investigação, gasta 1 PE pra usar Força/Agilidade no lugar do atributo-base; se passar, o próximo aliado que usar esse bônus recebe +1d20.', null, 9),
  ('Proteção Pesada', 'Proficiência com Proteções Pesadas.', 'NEX 30%', 10),
  ('Reflexos Defensivos', '+2 em Defesa e testes de resistência.', 'Agi 2', 11),
  ('Saque Rápido', 'Saca/guarda itens como ação livre; com Contagem de Munição ativa, recarrega uma arma de disparo 1x/rodada como ação livre.', 'Treinado em Iniciativa', 12),
  ('Segurar o Gatilho', 'Ao acertar com arma de fogo, pode fazer outro ataque contra o mesmo alvo pagando 2 PE por ataque já feito no turno, escalando até errar ou atingir o limite de PE.', 'NEX 60%', 13),
  ('Sentido Tático', 'Gasta ação de movimento + 2 PE pra analisar o ambiente e receber bônus em Defesa/testes de resistência igual ao Intelecto até o fim da cena.', 'Int 2, treinado em Percepção e Tática', 14),
  ('Tanque de Guerra', 'Usando proteção pesada, a Defesa e resistência a dano dela aumentam +2.', 'Proteção Pesada', 15),
  ('Tiro Certeiro', 'Usando arma de disparo, soma Agilidade no dano e ignora penalidade contra alvos em combate corpo a corpo.', 'Treinado em Pontaria', 16),
  ('Tiro de Cobertura', 'Gasta ação padrão + 1 PE, teste de Pontaria vs. Vontade do alvo; se vencer, o alvo não pode sair do lugar e sofre -5 em ataque até seu próximo turno (efeito de medo).', null, 17),
  ('Transcender', 'Recebe um poder paranormal à escolha, sem ganhar Sanidade nesse aumento de NEX. Pode escolher várias vezes.', null, 18),
  ('Treinamento em Perícia', 'Treina-se em duas perícias (a partir de NEX 35% pode subir treinado→veterano; a partir de 70%, veterano→expert). Pode escolher várias vezes.', null, 19)
) as v(name, description, prereq, ord);

-- ============================================================
-- Poderes de Especialista
-- ============================================================

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'especialista'), v.name, v.description, v.prereq, v.ord from (values
  ('Artista Marcial', 'Ataques desarmados causam 1d6 (1d8 em NEX 35%, 1d10 em NEX 70%), causam dano letal e contam como armas ágeis.', null, 1),
  ('Balística Avançada', 'Proficiência com armas táticas de fogo e +2 em dano com armas de fogo.', null, 2),
  ('Conhecimento Aplicado', 'Teste de perícia (exceto Luta/Pontaria), gasta 2 PE pra mudar o atributo-base pra Int.', 'Int 2', 3),
  ('Hacker', '+5 em Tecnologia pra invadir sistemas; tempo de hackear cai pra uma ação completa.', 'Treinado em Tecnologia', 4),
  ('Mãos Rápidas', 'Teste de Crime, paga 1 PE pra fazê-lo como ação livre.', 'Agi 3, treinado em Crime', 5),
  ('Mochila de Utilidades', 'Um item à escolha (exceto armas) conta como categoria abaixo e ocupa 1 espaço a menos.', null, 6),
  ('Movimento Tático', 'Gasta 1 PE pra ignorar penalidade de deslocamento por terreno difícil/escalar até o fim do turno.', 'Treinado em Atletismo', 7),
  ('Na Trilha Certa', 'Ao ter sucesso em teste de procurar pistas, gasta 1 PE pra +1d20 no próximo teste (custo e bônus cumulativos).', null, 8),
  ('Nerd', '1x/cena, gasta 2 PE pra teste de Atualidades (DT 20); se passar, recebe uma informação útil pra cena.', null, 9),
  ('Ninja Urbano', 'Proficiência com armas táticas corpo a corpo e de disparo (exceto fogo) e +2 em dano com elas.', null, 10),
  ('Pensamento Ágil', '1x/rodada em cena de investigação, gasta 2 PE pra ação de procurar pistas adicional.', null, 11),
  ('Perito em Explosivos', 'Soma Intelecto na DT de resistir aos próprios explosivos; exclui número de alvos igual ao Intelecto dos efeitos.', null, 12),
  ('Primeira Impressão', '+2d20 no primeiro teste de Diplomacia, Enganação, Intimidação ou Intuição numa cena.', null, 13),
  ('Transcender', 'Recebe um poder paranormal à escolha, sem ganhar Sanidade nesse aumento de NEX. Pode escolher várias vezes.', null, 14),
  ('Treinamento em Perícia', 'Treina-se em duas perícias (a partir de NEX 35% treinado→veterano; a partir de 70% veterano→expert). Pode escolher várias vezes.', null, 15)
) as v(name, description, prereq, ord);

-- ============================================================
-- Poderes de Ocultista
-- ============================================================

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Camuflar Ocultismo', 'Ação livre pra esconder símbolos/sigilos em objetos ou na pele; ao lançar ritual, gasta +2 PE pra lançá-lo sem componentes/gesticulação (só concentração) — outros só percebem com teste de Ocultismo (DT 25).', null, 1),
  ('Criar Selo', 'Fabrica selos paranormais dos rituais conhecidos (ação de interlúdio + PE igual ao custo do ritual); máximo de selos simultâneos igual à Presença.', null, 2),
  ('Envolto em Mistério', '+5 em Enganação e Intimidação contra pessoas não treinadas em Ocultismo.', null, 3),
  ('Especialista em Elemento', 'Escolhe um elemento; DT pra resistir aos seus rituais desse elemento +2.', null, 4),
  ('Ferramentas Paranormais', 'Reduz categoria de item paranormal em I e ativa itens paranormais sem pagar seu custo em PE.', null, 5),
  ('Fluxo de Poder', 'Mantém 2 efeitos sustentados de rituais ativos ao mesmo tempo com uma única ação livre (paga o custo de cada um separadamente).', 'NEX 60%', 6),
  ('Guiado pelo Paranormal', '1x/cena, gasta 2 PE pra ação de investigação adicional.', null, 7),
  ('Identificação Paranormal', '+10 em Ocultismo pra identificar criaturas, objetos ou rituais.', null, 8),
  ('Improvisar Componentes', '1x/cena, ação completa + teste de Investigação (DT 15); se passar, encontra componentes ritualísticos de um elemento à escolha.', null, 9),
  ('Intuição Paranormal', 'Ao facilitar investigação, soma Intelecto ou Presença no teste (à escolha).', null, 10),
  ('Mestre em Elemento', 'Escolhe um elemento; custo pra lançar rituais desse elemento cai -1 PE.', 'Especialista em Elemento no mesmo elemento, NEX 45%', 11),
  ('Ritual Potente', 'Soma Intelecto nas rolagens de dano ou efeitos de cura dos rituais.', 'Int 2', 12),
  ('Ritual Predileto', 'Escolhe um ritual conhecido; custo cai -1 PE (acumula com outras reduções).', null, 13),
  ('Tatuagem Ritualística', 'Símbolos na pele reduzem -1 PE o custo de rituais de alcance pessoal que têm você como alvo.', null, 14),
  ('Transcender', 'Recebe um poder paranormal à escolha, sem ganhar Sanidade nesse aumento de NEX. Pode escolher várias vezes.', null, 15),
  ('Treinamento em Perícia', 'Treina-se em duas perícias (a partir de NEX 35% treinado→veterano; a partir de 70% veterano→expert). Pode escolher várias vezes.', null, 16)
) as v(name, description, prereq, ord);

-- ============================================================
-- Trilhas — Combatente
-- ============================================================

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'combatente'), v.slug, v.name, v.description, v.ord from (values
  ('aniquilador', 'Aniquilador', 'Foco em uma arma favorita, categoria reduzida progressivamente.', 1),
  ('comandante_de_campo', 'Comandante de Campo', 'Foco em liderar aliados.', 2),
  ('guerreiro', 'Guerreiro', 'Foco em combate corpo a corpo bruto.', 3),
  ('operacoes_especiais', 'Operações Especiais', 'Foco em velocidade/ações extras.', 4),
  ('tropa_de_choque', 'Tropa de Choque', 'Foco em resistência/tanque.', 5)
) as v(slug, name, description, ord);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'aniquilador' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'A Favorita', 'Categoria da arma escolhida reduz em I.'),
  (40, 'Técnica Secreta', 'Categoria reduz em II; gasta 2 PE por efeito adicional (Amplo: atinge alvo adjacente extra; Destruidor: +1 no multiplicador de crítico).'),
  (65, 'Técnica Sublime', 'Soma efeitos Letal (+2 margem de ameaça, pode escolher 2x pra +5) e Perfurante (ignora até 5 de resistência).'),
  (99, 'Máquina de Matar', 'Categoria reduz em III, +2 margem de ameaça, +1 dado de dano.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'comandante_de_campo' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Inspirar Confiança', 'Reação + 2 PE pra aliado em alcance curto rerrolar um teste.'),
  (40, 'Estrategista', 'Ação padrão + 1 PE por aliado (limitado por Intelecto) pra dar ação de movimento extra no próximo turno deles.'),
  (65, 'Brecha na Guarda', 'Reação + 2 PE quando aliado causa dano, pra ataque adicional contra o mesmo inimigo; alcance de Inspirar/Estrategista sobe pra médio.'),
  (99, 'Oficial Comandante', 'Ação padrão + 5 PE, cada aliado visível em alcance médio recebe ação padrão extra no próximo turno.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'guerreiro' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Técnica Letal', '+2 na margem de ameaça em ataques corpo a corpo.'),
  (40, 'Revidar', 'Ao bloquear, reação + 2 PE pra atacar corpo a corpo o agressor.'),
  (65, 'Força Opressora', 'Ao acertar corpo a corpo, gasta 1 PE pra empurrar (+5 a cada 10 de dano causado) ou derrubar (e gastar 1 PE extra pra ataque adicional no alvo caído).'),
  (99, 'Potência Máxima', 'Usando Ataque Especial com arma corpo a corpo, todos os bônus numéricos dobram.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'operacoes_especiais' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Iniciativa Aprimorada', '+5 em Iniciativa e ação de movimento extra na primeira rodada.'),
  (40, 'Ataque Extra', '1x/rodada, gasta 2 PE pra ataque adicional.'),
  (65, 'Surto de Adrenalina', '1x/rodada, gasta 5 PE pra ação padrão ou de movimento extra.'),
  (99, 'Sempre Alerta', 'Ação padrão extra no início de cada cena de combate.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'tropa_de_choque' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Casca Grossa', '+1 PV a cada 5% de NEX; ao bloquear, soma Vigor na resistência a dano.'),
  (40, 'Cai Dentro', 'Reação + 1 PE quando oponente ataca aliado adjacente, forçando teste de Vontade (DT Vig) ou o oponente ataca você em vez do aliado.'),
  (65, 'Duro de Matar', 'Reação + 2 PE pra reduzir dano não paranormal à metade (paranormal também a partir de NEX85%).'),
  (99, 'Inquebrável', 'Machucado, +5 Defesa e resistência a dano 5; morrendo, não fica indefeso e pode agir normalmente (mas segue as regras de morte).')
) as v(nex, name, description);

-- ============================================================
-- Trilhas — Especialista
-- ============================================================

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'especialista'), v.slug, v.name, v.description, v.ord from (values
  ('atirador_de_elite', 'Atirador de Elite', 'Foco em armas de fogo à distância.', 1),
  ('infiltrador', 'Infiltrador', 'Foco em furtividade e ataques furtivos.', 2),
  ('medico_de_campo', 'Médico de Campo', 'Pré-requisito especial: treinado em Medicina pra escolher a trilha; precisa de kit de medicina pra usar as habilidades.', 3),
  ('negociador', 'Negociador', 'Foco em influência social.', 4),
  ('tecnico', 'Técnico', 'Foco em equipamentos.', 5)
) as v(slug, name, description, ord);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'atirador_de_elite' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Mira de Elite', 'Proficiência com armas de fogo de balas longas; soma Intelecto no dano.'),
  (40, 'Disparo Letal', 'Ao mirar, gasta 1 PE pra +2 na margem de ameaça do próximo ataque até o fim do próximo turno.'),
  (65, 'Disparo Impactante', 'Ao atacar com arma de fogo, gasta 2 PE pra, em vez de dano, fazer manobra (derrubar/desarmar/empurrar/quebrar).'),
  (99, 'Atirar para Matar', 'Crítico com arma de fogo causa dano máximo sem rolar.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'infiltrador' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Ataque Furtivo', '1x/rodada, ao atingir alvo desprevenido/flanqueado em corpo a corpo ou alcance curto, gasta 1 PE pra +1d6 de dano (escala +2d6/+3d6/+4d6 em NEX 40/65/99%).'),
  (40, 'Gatuno', '+5 em Atletismo e Crime; percorre deslocamento normal ao se esconder sem penalidade.'),
  (65, 'Assassinar', 'Ação de movimento + 3 PE pra analisar alvo em alcance curto; próximo Ataque Furtivo tem dano extra dobrado, e se causar dano deixa o alvo inconsciente ou morrendo (Fortitude DT Agi evita).'),
  (99, 'Sombra Fugaz', 'Após atacar/ação chamativa, gasta 3 PE pra não sofrer a penalidade de -3d20 no teste de Furtividade.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'medico_de_campo' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Paramédico', 'Ação padrão + 2 PE pra curar 2d10 PV de si ou aliado adjacente (+1d10 em NEX 40/65/99%, +1 PE por dado extra).'),
  (40, 'Equipe de Trauma', 'Ação padrão + 2 PE pra remover condição negativa (exceto morrendo) de aliado adjacente.'),
  (65, 'Resgate', '1x/rodada, aproxima-se de aliado machucado/morrendo em alcance curto como ação livre; ao curar/remover condição, você e o aliado recebem +5 Defesa até o próximo turno; carregar um personagem custa metade dos espaços.'),
  (99, 'Reanimação', '1x/cena, ação completa + 10 PE pra reviver personagem morto na mesma cena (exceto morte por dano massivo).')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'negociador' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Eloquência', 'Ação completa + 1 PE por alvo em alcance curto; teste de Diplomacia/Enganação/Intimidação vs. Vontade — vencendo, alvos ficam fascinados enquanto se concentrar.'),
  (40, 'Discurso Motivador', 'Ação padrão + 4 PE pra +1d20 em testes de perícia de aliados em alcance curto até o fim da cena (8 PE pra +2d20 a partir de NEX65%).'),
  (65, 'Eu Conheço um Cara', '1x/missão, ativa rede de contatos pra um favor (trocar equipamento, local de descanso, resgate — a critério do mestre).'),
  (99, 'Truque de Mestre', 'Gasta 5 PE pra simular o efeito de qualquer habilidade vista num aliado durante a cena, ignorando pré-requisitos (mas pagando custos normalmente).')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'tecnico' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Inventário Otimizado', 'Soma Intelecto à Força pro cálculo de capacidade de carga.'),
  (40, 'Remendão', 'Ação completa + 1 PE pra remover condição quebrado de equipamento adjacente; equipamento geral tem categoria reduzida em I pra você.'),
  (65, 'Improvisar', 'Ação completa + 2 PE (+2 PE por categoria do item) pra criar versão funcional temporária de um equipamento geral (inútil ao fim da cena).'),
  (99, 'Preparado para Tudo', 'Ação de movimento + 3 PE por categoria pra "lembrar" que tinha um item qualquer (exceto armas) na bolsa.')
) as v(nex, name, description);

-- ============================================================
-- Trilhas — Ocultista
-- ============================================================

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'ocultista'), v.slug, v.name, v.description, v.ord from (values
  ('conduite', 'Conduíte', 'Foco em manipular alcance/velocidade de conjuração.', 1),
  ('flagelador', 'Flagelador', 'Foco em usar dor/vida como catalisador.', 2),
  ('graduado', 'Graduado', 'Foco em conhecer mais rituais.', 3),
  ('intuitivo', 'Intuitivo', 'Foco em resiliência mental.', 4),
  ('lamina_paranormal', 'Lâmina Paranormal', 'Foco em combinar conjuração com combate.', 5)
) as v(slug, name, description, ord);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'conduite' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Ampliar Ritual', 'Ao lançar ritual, gasta +2 PE pra aumentar alcance em um passo ou dobrar a área de efeito.'),
  (40, 'Acelerar Ritual', '1x/rodada, gasta +4 PE pra conjurar um ritual como ação livre.'),
  (65, 'Anular Ritual', 'Ao ser alvo de ritual, gasta PE igual ao custo pago pelo conjurador + teste oposto de Ocultismo; vencendo, anula o ritual.'),
  (99, 'Canalizar o Medo', 'Aprende o ritual "Canalizar o Medo".')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'flagelador' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Poder do Flagelo', 'Ao conjurar, pode gastar os próprios PV pra pagar custo em PE (taxa 2 PV por PE; só recupera com descanso).'),
  (40, 'Abraçar a Dor', 'Reação + 2 PE pra reduzir dano não paranormal à metade.'),
  (65, 'Absorver Agonia', 'Ao reduzir inimigo(s) a 0 PV com ritual, recebe PE temporários igual ao círculo do ritual usado.'),
  (99, 'Medo Tangível', 'Aprende o ritual "Medo Tangível".')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'graduado' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Saber Ampliado', 'Aprende um ritual de 1º círculo extra por círculo alcançado (não conta no limite).'),
  (40, 'Grimório Ritualístico', 'Cria grimório que armazena rituais de 1º/2º círculo igual ao Intelecto (não contam no limite); precisa empunhar + ação completa pra conjurar do grimório; ocupa 1 espaço, replicável com 2 ações de interlúdio se perdido.'),
  (65, 'Rituais Eficientes', 'DT pra resistir a todos os seus rituais +5.'),
  (99, 'Conhecendo o Medo', 'Aprende o ritual "Conhecendo o Medo".')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'intuitivo' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Mente Sã', 'Resistência paranormal +5 (testes de resistência contra efeitos paranormais).'),
  (40, 'Presença Poderosa', 'Soma Presença ao limite de PE por turno (só pra conjurar rituais, não afeta DT).'),
  (65, 'Inabalável', 'Resistência a dano mental e paranormal 10; se passar num teste de Vontade que reduziria dano paranormal à metade, não sofre dano algum.'),
  (99, 'Presença do Medo', 'Aprende o ritual "Presença do Medo".')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'lamina_paranormal' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Lâmina Maldita', 'Aprende o ritual "Amaldiçoar Arma" (ou reduz tempo de conjuração pra movimento gastando +1 PE, se já conhece); pode usar Ocultismo em vez de Luta/Pontaria pra testes de ataque com a arma amaldiçoada.'),
  (40, 'Gladiador Paranormal', 'Ao acertar corpo a corpo, recebe 2 PE temporários (máximo por cena igual ao limite de PE; somem no fim da cena).'),
  (65, 'Conjuração Marcial', '1x/rodada, ao lançar ritual de ação padrão, gasta 2 PE pra ataque corpo a corpo como ação livre.'),
  (99, 'Lâmina do Medo', 'Aprende o ritual "Lâmina do Medo".')
) as v(nex, name, description);
