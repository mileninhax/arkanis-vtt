-- Arquivos Secretos 01 + 02: conteúdo de sistema (lore/narrativa pura e NPCs como
-- "Aliado" ficam de fora, por decisão de escopo).

-- ============================================================
-- AS01 — Origens
-- ============================================================
insert into origins (source_id, name, skill_1_id, skill_2_id, skills_text, power_name, power_description, description, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'Ferido por Ritual',
  (select id from skills where name = 'Ocultismo'), null, 'Ocultismo + 1 perícia definida pelo elemento (Fortitude/Sangue, Vontade/Morte ou Conhecimento, Reflexos/Energia)',
  'Mácula Ritualística', 'Aprende e conjura um ritual de 1º círculo do elemento escolhido (marca da entidade); 1x/cena conjura sem pagar PE (efeitos adicionais ainda custam PE); não conta no limite de rituais conhecidos; mas -1d20 em testes de resistência contra efeitos desse elemento.',
  'Vida ordinária interrompida pelos efeitos paranormais de um ritual (escolhe elemento: Sangue, Morte, Conhecimento ou Energia).', 1
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'Transtornado Arrependido',
  (select id from skills where name = 'Luta'), (select id from skills where name = 'Ocultismo'), null,
  'Sofrimento de Sangue', 'Resistência a dano 2/mental; +1 nessa RD a cada 2 rituais/poderes paranormais de Sangue que possui; mas condição de descanso sempre uma categoria pior (luxuosa→confortável→normal→precária).',
  'Já caminhou entre os Transtornados — seguidor cego ou consciente, mas algo rompeu o ciclo; ainda sente o eco dos rituais.', 2
);

-- Poderes de Ocultista (AS01)
insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Acostumado à Maldição de <Elemento>', 'Escolhe elemento (exceto Medo); falhar em teste do preço da maldição desse elemento não custa Sanidade (outros efeitos negativos continuam).', 'Int 2, conjurar ritual de 2º círculo do elemento', 26),
  ('Reter Ritual de Combate', 'Ritual de duração retida afetando alvo negativamente, muda pra duração cena como reação quando o alvo sai da linha de efeito; sofrendo condição que faz perder retenção, gasta reação + 1 PE por ritual pra mudar duração pra cena. Só disponível usando a regra opcional Reter Ritual.', 'Int 2, conjurar ritual de 1º círculo', 27),
  ('Ritual Intenso', 'Soma Presença nas rolagens de dano/cura dos rituais.', 'Pre 2', 28),
  ('Saúde Sobrenatural', '1x/cena, ação de movimento + 3 PE pra PV temporários = Presença x10 (não cumulativo, some no fim da cena).', 'Int 2, Pre 2, conjurar ritual de 1º círculo', 29)
) as v(name, description, prereq, ord);

insert into class_tracks (class_id, slug, name, description, sort_order)
values ((select id from classes where slug = 'ocultista'), 'maledictologo', 'Maledictólogo', 'Especialista em manipular maldições de itens amaldiçoados.', 9);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'maledictologo'), v.nex, v.name, v.description from (values
  (10, 'Identificação Macabra', 'Identificar item amaldiçoado/ritual, gasta 1 PE pra +1d10; identificar item amaldiçoado como ação completa sofre só -1d20 (em vez da penalidade maior padrão).'),
  (40, 'Compreensão de Maldições', 'Ação de interlúdio + 3 PE + teste de Ocultismo (DT 10+5 por categoria do item) num item amaldiçoado; falhar perde 2d4+2 Sanidade; passando com item que contém ritual, perde 1d4+1 Sanidade + aprende o ritual (item consumido); passando sem ritual, perde 1d4+1 Sanidade + transfere as maldições pra outro item ou pra uma tatuagem.'),
  (65, 'Reproduzir Maldição', 'Ação de interlúdio + 3 PE memoriza uma maldição já conhecida; depois, ação de interlúdio + 3 PE + Ocultismo (DT 10+5 por categoria) aplica a maldição memorizada num item novo até o fim da missão; falhar perde 2d8+2 Sanidade, passar perde 1d8+1 Sanidade; maldições sobem categoria, máximo categoria IV.'),
  (99, 'Maldição Suprema', 'Usando Reproduzir Maldição, item conta 3 categorias efetivas a menos (ex.: categoria IV conta como I) até voltar à categoria real.')
) as v(nex, name, description);

-- Poderes Gerais (AS01)
insert into general_powers (source_id, name, description, prerequisites)
select (select id from sources where slug = 'arquivos_secretos_01'), v.name, v.description, v.prereq from (values
  ('<Habilidade> Aprimorada', 'Escolhe habilidade/ritual com DT; DT pra resistir +2 (pode escolher de novo pra outras, ou até 2x na mesma — total +5).', null),
  ('Cicatrizes Expostas', 'Ação de movimento expõe cicatriz; enquanto exposta, +1d8 dano do mesmo tipo em tudo que causa, mas -1d20 em Vontade e testes que exijam calma; outro ser pode expor à força; dura até o fim da cena.', 'Ter cicatrizes'),
  ('Curiosidade Oculta', 'Treina (ou +2) Ocultismo; teste de Vontade, gasta 2 PE pra usar Ocultismo no lugar.', 'Int 2'),
  ('Especialista Esotérico', 'Combina até 3 catalisadores ritualísticos ao conjurar (em vez de 1).', 'Int 3, conjurar ritual de 2º círculo, Domínio Esotérico'),
  ('Instintos Urbanos', 'Treina (ou +2) Crime; em ambiente fechado, Crime DT 20 identifica rota de fuga — ação de movimento extra no 1º turno de fuga + 2 Defesa até fugir (ou +2 Defesa permanente se não houver rota).', 'Agi 2')
) as v(name, description, prereq);

-- Poderes Paranormais de Sangue (AS01)
insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
values
((select id from sources where slug = 'arquivos_secretos_01'), 'sangue', 'Ferro Maculado', 'Ataque com arma de disparo, gasta 2 PV pra amaldiçoar a munição até o fim do turno: +1d6 dano de Sangue (multiplicado em crítico).', '+1d8.', null),
((select id from sources where slug = 'arquivos_secretos_01'), 'sangue', 'Placas Sanguinolentas', 'Conjurando ritual de Sangue, +Defesa igual ao círculo do ritual até o próprio próximo turno.', 'Bônus = círculo +2.', 'Conjurar ritual de Sangue'),
((select id from sources where slug = 'arquivos_secretos_01'), 'sangue', 'Sangue Corrosivo', 'Ação de movimento + 1 PE transforma sangue em corrosivo até o fim da cena; sofrendo dano de ser adjacente, retorna 1d10 dano de Sangue nele.', '2d10.', null),
((select id from sources where slug = 'arquivos_secretos_01'), 'sangue', 'Sangue Prazeroso', 'Machucado, resistência a dano 5.', 'Também +20 PV temporários 1x/cena enquanto machucado.', 'Sangue 1');

-- Rituais (AS01)
insert into rituals (source_id, name, elemento, circle, execution, range, target, duration, resistance, effect, discente_cost, discente_effect, discente_requires_circle, verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, verdadeiro_requires_affinity)
values
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'Passagem de Conhecimento', 'sangue', 2, 'completa', 'toque', '1 pessoa', 'cena', 'Vontade evita',
  'Transfere a consciência do conjurador pro corpo do alvo — escolhe entre habitar (controla o corpo do alvo, seu próprio corpo cai inconsciente) ou trocar (troca completa de consciências, cada um usa sua própria ficha mas com atributos físicos do outro). Nota: alguns rituais raros pertencem a mais de um elemento simultaneamente (este é Sangue e Conhecimento) — aprender exige cumprir pré-requisitos de todos os elementos + afinidade com pelo menos 1.',
  3, 'Alcance curto, duração 1 dia; no modo habitar, alvo só tenta recuperar 1x/dia ou 1x/cena.', null,
  7, 'Alcance médio, duração permanente; no modo habitar, alvo só tenta recuperar 1x/ano. Requer 4º círculo e afinidade.', 4, true
);

-- Itens Paranormais (AS01)
insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
((select id from sources where slug = 'arquivos_secretos_01'), 'paranormal', 'Agrupador Ritualístico', 'II', 1, 'Item pequeno (tipo uma faca); ação padrão prende componente/catalisador nele (até 4); tudo preso conta como empunhado desde que o agrupador esteja empunhado.', '{}'),
((select id from sources where slug = 'arquivos_secretos_01'), 'paranormal', 'Amuleto Sinalizador de (Elemento)', 'II', 1, 'Vestido, escolhe elemento (exceto Medo); emite sinal sutil quando criatura desse elemento entra em alcance longo, mesmo através de paredes.', '{}'),
((select id from sources where slug = 'arquivos_secretos_01'), 'paranormal', 'Rubra', 'II', 1, 'Droga paranormal; ação de movimento esfrega numa ferida aberta — dá +5 em Força/Agilidade/Vigor + 10 PV temporários até o fim da cena; sem nova dose ao fim, perde 1d3 pontos de atributos físicos.', '{}');

-- Itens Amaldiçoados Especiais (AS01)
insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_01'), 'Arpão do Pescador', 'Arma simples corpo a corpo, uma mão, arremessável em alcance curto; 1d8 perfuração + 1d12 Sangue, crítico 20/x3; acertando arremesso, alvo fica lento até remover com ação padrão + Atletismo DT For.', 'III', 1),
((select id from sources where slug = 'arquivos_secretos_01'), 'Combustível de Sangue', 'Munição pra lança-chamas ou galão vermelho; troca todo o dano do item pra Sangue e sobe 1 categoria de dado — eficaz contra criaturas de Conhecimento.', 'III', 1),
((select id from sources where slug = 'arquivos_secretos_01'), 'Marreta Transtornada', 'Arma tática corpo a corpo, duas mãos; 2d10 impacto + 2d12 Sangue, crítico 20/x4; empunhar ou atacar com ela custa 1d6 PV; crítico força Fortitude DT For do alvo ou fica fraco (fraco de novo pela mesma arma = debilitado).', 'IV', 2);

-- ============================================================
-- AS02 — "Os Mascarados" (poderes derivados, sem as fichas de Aliado — Mesa territory)
-- ============================================================

insert into general_powers (source_id, name, description, prerequisites)
select (select id from sources where slug = 'arquivos_secretos_02'), v.name, v.description, v.prereq from (values
  ('Revidar Violento', 'Faz uma 2ª reação especial de defesa na mesma rodada, desde que seja um contra-ataque.', 'For 2 ou Agi 2'),
  ('Corpo Fechado', '2ª reação especial de defesa na mesma rodada, desde que seja um bloqueio.', 'Vig 2'),
  ('Esquiva Tática', '2ª reação especial de defesa na mesma rodada, desde que seja uma esquiva.', 'Agi 2'),
  ('Palpite Confiante', 'Teste de perícia baseado em Intelecto ou Presença, gasta 1 PE pra somar Intelecto no teste.', 'Int 2')
) as v(name, description, prereq);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'combatente'), v.name, v.description, v.prereq, v.ord from (values
  ('Predador Perfeito', '1x/rodada, gasta 5 PE pra ação padrão adicional (precisa ter intenção de causar dano — soco, disparo, armar armadilha, ritual com dano etc.).', 'Veterano em Luta ou Pontaria, e em Sobrevivência', 31),
  ('Golpes de Arena', 'Acertando ataque corpo a corpo, gasta 2 PE pra ataque corpo a corpo adicional ou manobra de combate no mesmo alvo.', 'Treinado em Luta', 32)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'especialista'), v.name, v.description, v.prereq, v.ord from (values
  ('Assassinato Furtivo', 'Dano de Ataque Furtivo (habilidade de trilha) +1d6; acertando ataque furtivo, gasta 2 PE pra mudar o dado de dano furtivo de d6 pra d8.', 'Ataque Furtivo', 27),
  ('Especialista em Matar', 'Ao atacar, gasta 2 PE pra +4 no teste de ataque ou na rolagem de dano; escala com NEX (25%: 3 PE por +8; 55%: 4 PE por +12; 85%: 5 PE por +16); cada bônus pode ir pra ataque ou dano livremente.', 'Agi 2 ou For 2, treinado em Luta ou Pontaria', 28)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Liturgia de Fortalecimento Ritualístico', 'Cena de interlúdio, gasta 2 PE + ação de interlúdio pra fortalecer um ritual conhecido: DT dele +2 até o início da próxima cena de interlúdio.', 'Int e Pre 2', 30)
) as v(name, description, prereq, ord);

insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
values
((select id from sources where slug = 'arquivos_secretos_02'), 'sangue', 'Predador de Sangue', 'Ação padrão + 3 PE memoriza odor de vítima (precisa de fonte física do odor); +1d20 em testes pra rastrear/perceber/atacá-la; só 1 vítima por vez.', 'Memoriza até 3 vítimas simultâneas.', null),
((select id from sources where slug = 'arquivos_secretos_02'), 'energia', 'Pressão Atmosférica', 'Acertando corpo a corpo em alvo agarrado, gasta 3 PE pra +1d10 dano de Energia + atordoado 1 rodada (Fortitude DT For evita; só 1x/cena por alvo).', 'Também caído e sangrando (resistência não evita essas 2 condições).', null),
((select id from sources where slug = 'arquivos_secretos_02'), 'conhecimento', 'Zona dos Sussurros', 'Ação completa + 3 PE marca área tipo cômodo pequeno; na área, +5 ataque e sem penalidade em Furtividade após ação chamativa; máximo 3 áreas simultâneas.', 'Causando dano em desprevenido ou flanqueado, rerrola dados de dano com resultado 1-2 e fica com o melhor.', null),
((select id from sources where slug = 'arquivos_secretos_02'), 'morte', 'Disparo da Morte', 'Atacando com arma de fogo/disparo, gasta 3 PE (antes do teste) pra +2 margem de ameaça.', 'Ataque também ignora cobertura e 10 de resistência a dano do alvo.', null),
((select id from sources where slug = 'arquivos_secretos_02'), 'sangue', 'Engolir Sangue', 'Ação completa consome porção de carne humana, recupera 2d8+2 PV, mas perde 1d4 Sanidade.', 'Cura sobe pra 4d8+4.', null);

insert into rituals (source_id, name, elemento, circle, execution, range, target, duration, resistance, effect, discente_cost, discente_effect, discente_requires_circle, verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, verdadeiro_requires_affinity)
values
((select id from sources where slug = 'arquivos_secretos_02'), 'Mapa Sanguíneo', 'sangue', 2, 'padrão', 'toque', '1 superfície', 'cena', 'Vontade evita',
 'Toca superfície, desenha mapa de sangue mostrando em tempo real a localização de todos os seres num raio de 1km.',
 3, 'Também revela condição de saúde de quem falhar na resistência — ileso, ferido, machucado, morrendo.', null, null, null, null, false),
((select id from sources where slug = 'arquivos_secretos_02'), 'Capturar Momento', 'morte', 2, 'padrão', 'médio', 'esfera de 18m de raio', 'cena', 'permanente até dissipar',
 'Marca local com símbolo invisível de Morte que capta imagens/sons; ação padrão vê/ouve remotamente de qualquer distância.',
 3, 'Pode fazer o símbolo explodir (ação padrão), 4d8 dano de Morte em todos captados no momento (Fortitude reduz à metade).', null,
 7, 'Como Discente, mas dano sobe pra 8d8. Requer 3º círculo.', 3, false),
((select id from sources where slug = 'arquivos_secretos_02'), 'Labirinto Mental', 'conhecimento', 2, 'padrão', 'médio', '1 pessoa', '1d4 rodadas', 'Vontade evita',
 'Prende a mente do alvo — gasta as ações se movendo em direção aleatória; repete Vontade no início de cada turno pra se libertar.',
 3, 'Alcance longo.', null,
 7, 'Alcance longo + duração cena (ainda libertável por Vontade). Requer 3º círculo.', 3, false),
((select id from sources where slug = 'arquivos_secretos_02'), 'Rajada Caótica', 'energia', 2, 'padrão', 'médio', '1 ser', 'instantânea', 'Reflexos reduz à metade',
 'Raio de Energia, 8d6 dano.',
 3, 'Dano sobe pra 8d8.', null,
 7, 'Canaliza relâmpagos — 8d10 dano; nas rodadas seguintes até o fim da cena, ação padrão dispara outro raio igual. Requer 3º círculo.', 3, false);

insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_02'), 'Machado do Mutilador', 'Arma tática corpo a corpo, uma mão; 1d8 corte + 1d8 Sangue (multiplica em crítico), crítico 20/x3; ao acertar, gasta 1 PE pra deixar a vítima sangrando (cumulativo).', 'IV', 1),
((select id from sources where slug = 'arquivos_secretos_02'), 'Elmo do Colosso', 'Vestimenta, resistência a dano 5; combinado com o resto do equipamento de escafandro, conta como traje de mergulho.', 'III', 2),
((select id from sources where slug = 'arquivos_secretos_02'), 'Manoplas do Colosso', 'Par de manoplas, arma tática corpo a corpo de uma mão, só funcionam em par; 1d6 impacto + 1d10 Energia cada, crítico 20/x2; seguem regras de ataque desarmado, mas efeitos que aumentam o dado de dano desarmado não afetam elas.', 'IV', 2),
((select id from sources where slug = 'arquivos_secretos_02'), 'Punhal X', 'Arma simples corpo a corpo, uma mão, ágil, arremessável em alcance curto; 1d4 perfuração + 1d6 Conhecimento, crítico 19/x2; atacando, gasta 2 PE pra deixar alvo desprevenido — acertando, cego 1 rodada (só 1x/cena por alvo).', 'IV', 1),
((select id from sources where slug = 'arquivos_secretos_02'), 'Sniper Fantasma', 'Arma de fogo tática, duas mãos, alcance longo; 2d10 balístico + 2d4 Morte, crítico 19/x3; veterano em Pontaria mirando com ela, +5 margem de ameaça adicional; alvo reduzido a 0 PV por ela morre iniciando 2 turnos morrendo (em vez de 3).', 'IV', 2),
((select id from sources where slug = 'arquivos_secretos_02'), 'A Antena', 'Arma simples corpo a corpo, duas mãos, conta como improvisada (-1d20 em ataque); 1d6 impacto, crítico 20/x2. Nas mãos de um conjurador de rituais: DT dos seus rituais +3; pode conjurar um ritual NA antena e liberar depois com ação padrão sem gastar recursos de conjuração; só 1 ritual por vez armazenado.', 'IV', 2),
((select id from sources where slug = 'arquivos_secretos_02'), 'Faca Predadora', 'Arma simples corpo a corpo, uma mão, ágil, arremessável em alcance curto; 1d4 perfuração + 2d10 Sangue, crítico 19/x3; atacando, gasta 2 PE pra, acertando, recuperar 2d10 PV (excedente vira temporário).', 'IV', 1);
