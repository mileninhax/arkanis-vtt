-- Bestiário Livro Base — Ameaças da Realidade (Mundanas): Criminosos & Mercenários,
-- Cultistas, Policiais, Animais. Fichas sem Presença Perturbadora nem elemento.

insert into creatures (source_id, categoria, tipo_criatura, name, vd, flavor_text, tamanho, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, atributos, pericias, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Bandido', 10,
  'Criminoso típico, como ladrão ou assaltante.',
  'Médio', '+0', '+5 (2◯)', 14, '+0', '+5 (2◯)', '+0', 8, 4, null,
  '{"agi":2,"for":2,"int":1,"pre":1,"vig":1}', 'Crime +5 (2◯), Furtividade +5 (2◯)', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo)","teste":"+5 (2◯)","dano":"1d4+2 perfuração"},{"tipo":"Livre","nome":"Ataque Furtivo","descricao":"1x/rodada, +1d6 dano corpo a corpo ou à distância curta contra desprevenido/flanqueado."}]',
  49
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Capanga', 20,
  'Pessoas embrutecidas que vivem pela violência — membros de gangue, executores da máfia, seguranças de boate.',
  'Médio', '+5', '+5', 13, '+5 (2◯)', '+5', '+0', 17, 8, null,
  '{"agi":1,"for":2,"int":1,"pre":1,"vig":2}', 'Intimidação +5', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Bastão, corpo a corpo)","teste":"+5 (2◯)","dano":"1d8+7 impacto"},{"tipo":"Padrão","nome":"Agredir (Revólver, distância, curto)","teste":"+5, crítico 19/x3","dano":"2d6+5 balístico"},{"tipo":"Livre","nome":"Ataque Furtivo","descricao":"1x/rodada, +2d6 dano corpo a corpo ou à distância curta contra desprevenido/flanqueado."}]',
  50
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Soldado de Aluguel', 40,
  'Combatente profissional que trabalha pra quem pagar mais.',
  'Médio', '+5', '+10 (2◯)', 18, '+5 (2◯)', '+5 (2◯)', '+0', 25, 12, null,
  '{"agi":2,"for":2,"int":1,"pre":1,"vig":2}', null, '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Machete, corpo a corpo)","teste":"+10 (2◯), crítico 19","dano":"1d6+9 corte"},{"tipo":"Padrão","nome":"Agredir (Fuzil de Assalto, distância, médio)","teste":"+10 (2◯), crítico 19/x3","dano":"2d8+9 balístico"},{"tipo":"Completa","nome":"Ataque em Movimento","descricao":"Percorre o deslocamento e ataca em qualquer ponto do movimento."}]',
  51
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Assassino', 80,
  'Matador habilidoso e furtivo que elimina alguém de forma discreta e eficiente.',
  'Médio', '+10 (3◯)', '+15 (4◯)', 26, '+5 (2◯)', '+10 (4◯)', '+10 (3◯)', 90, 45, null,
  '{"agi":4,"for":2,"int":3,"pre":3,"vig":2}', 'Crime +10 (4◯), Enganação +10 (3◯), Furtividade +10 (4◯)', '9m | 6',
  '[{"nome":"Evasão","descricao":"Teste de Reflexos pra reduzir dano à metade — se passar, não sofre dano algum."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo x2)","teste":"+17 (4◯), crítico 19","dano":"1d4+11 corte"},{"tipo":"Padrão","nome":"Agredir (Pistola, distância x2, curto)","teste":"+15 (4◯), crítico 16/x4","dano":"1d12+14 balístico"},{"tipo":"Livre","nome":"Ataque Furtivo","descricao":"1x/rodada, +4d6 dano corpo a corpo ou distância curta contra desprevenido/flanqueado."},{"tipo":"Livre","nome":"Mão na Boca","teste":"+15 (2◯)","descricao":"Ataque corpo a corpo furtivo contra desprevenido pode agarrar; agarrado não fala."},{"tipo":"Movimento","nome":"Assassinar","descricao":"Analisa um alvo em alcance curto; até o fim do próximo turno, o primeiro Ataque Furtivo que causar dano nele dobra os dados extras."}]',
  52
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Comandante Mercenário', 120,
  'Endurecido por anos de conflito — oficial competente e combatente perigoso por si só.',
  'Médio', '+10 (2◯)', '+15 (3◯)', 29, '+10 (3◯)', '+10 (3◯)', '+5 (2◯)', 145, 72, 'Balístico, corte, impacto e perfuração 5',
  '{"agi":3,"for":3,"int":2,"pre":2,"vig":3}', 'Intimidação +10 (2◯), Tática +10 (2◯)', '6m | 4',
  '[{"nome":"Sadismo","descricao":"Ao causar dano, o próximo ataque recebe +◯ e, se acertar, +1 dado de dano do mesmo tipo."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Machete, corpo a corpo x2)","teste":"+17 (3◯), crítico 19","dano":"1d6+15 corte"},{"tipo":"Padrão","nome":"Agredir (Metralhadora, distância x2, médio)","teste":"+17 (2◯), crítico 19/x3","dano":"3d12+15 balístico"},{"tipo":"Completa","nome":"Ataque em Movimento","descricao":"Percorre o deslocamento e ataca (os dois ataques corpo a corpo ou à distância) em qualquer ponto."},{"tipo":"Movimento","nome":"Ordens","descricao":"Aliados em alcance médio recebem +◯ em perícias e +1 dado de dano até o fim da cena."}]',
  53
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Iniciado', 20,
  'No começo do caminho da adoração, já capaz de conjurar rituais — pode ser perigoso pra agentes inexperientes.',
  'Médio', '+5 (2◯)', '+0', 16, '+0', '+0', '+5 (2◯)', 15, 7, null,
  '{"agi":1,"for":1,"int":2,"pre":2,"vig":1}', 'Enganação +5 (2◯), Ocultismo +5 (2◯)', '9m | 6',
  '[{"nome":"Conjurador","descricao":"2 rituais de 1º círculo de um elemento, conjuráveis sem pagar PE (limite 3 PE por conjuração); DT pra resistir 15."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo)","teste":"+0, crítico 19","dano":"1d4+1 corte"}]',
  54
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Investido', 40,
  'Comprometido com as Entidades após ritos de admissão — um perigo real pra Realidade.',
  'Médio', '+5 (2◯)', '+5 (2◯)', 17, '+0', '+0 (2◯)', '+5 (2◯)', 35, 17, null,
  '{"agi":2,"for":1,"int":2,"pre":2,"vig":1}', 'Enganação +10 (2◯), Ocultismo +10 (2◯)', '9m | 6',
  '[{"nome":"Conjurador","descricao":"2 rituais de 1º e 2 de 2º círculo de até dois elementos, sem pagar PE (limite 5 PE por conjuração); DT 17."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo)","teste":"+5 (2◯), crítico 19","dano":"1d4+1 corte"},{"tipo":"Padrão","nome":"Agredir (Revólver, distância, curto)","teste":"+0, crítico 19/x3","dano":"2d6 balístico"}]',
  55
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Líder de Culto', 140,
  'Experiente, capaz de rituais mais poderosos — mantém disfarce de bom cidadão; pode ser qualquer um, até alguém próximo dos agentes.',
  'Médio', '+10 (3◯)', '+10 (2◯)', 27, '+10 (2◯)', '+5 (2◯)', '+15 (3◯)', 150, 75, null,
  '{"agi":2,"for":1,"int":3,"pre":3,"vig":2}', 'Enganação +15 (3◯), Ocultismo +15 (3◯)', '9m | 6',
  '[{"nome":"Conjurador","descricao":"2 rituais de 1º, 2 de 2º e 2 de 3º círculo de até dois elementos, sem pagar PE (limite 10 PE por conjuração); DT 25."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo)","teste":"+10 (2◯), crítico 19","dano":"1d4+1 corte"},{"tipo":"Padrão","nome":"Agredir (Revólver, distância, curto)","teste":"+5 (2◯), crítico 19/x3","dano":"2d6 balístico"}]',
  56
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Policial', 20,
  'Padrão, patrulhando ruas e praças; provavelmente nunca teve contato com o paranormal. Ficha também serve pra vigias, seguranças corporativos, pessoas com treinamento básico em armas.',
  'Médio', '+5', '+5 (2◯)', 19, '+5 (2◯)', '+5 (2◯)', '+0', 15, 7, null,
  '{"agi":2,"for":2,"int":1,"pre":1,"vig":2}', null, '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Bastão, corpo a corpo)","teste":"+5 (2◯)","dano":"1d8+7 impacto"},{"tipo":"Padrão","nome":"Agredir (Pistola, distância, curto)","teste":"+5 (2◯), crítico 18","dano":"1d12+5 balístico"}]',
  57
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Policial de Elite', 60,
  'Treinados e equipados pra situações extremas — os primeiros a chegar quando uma investigação discreta vira confronto armado.',
  'Médio', '+10', '+15 (3◯)', 27, '+10 (3◯)', '+10 (3◯)', '+10 (1◯)', 40, 20, 'Balístico, corte, impacto e perfuração 5',
  '{"agi":3,"for":3,"int":1,"pre":1,"vig":3}', null, '6m | 4',
  '[{"nome":"Fortificação","descricao":"50% de chance de ignorar dano adicional de crítico/furtivo."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Bastão, corpo a corpo x2)","teste":"+10 (3◯)","dano":"1d8+13 impacto"},{"tipo":"Padrão","nome":"Agredir (Fuzil de Assalto, distância, médio)","teste":"+10 (3◯), crítico 17/x3","dano":"2d8+13 balístico"},{"tipo":"Padrão","nome":"Lança-Granadas","dano":"8d6 impacto (Reflexos DT 19 reduz à metade)","descricao":"1x/cena, granada em alcance médio; 6m do impacto."},{"tipo":"Completa","nome":"Empurrar e Atirar","descricao":"Empurra adjacente 3m (Fortitude DT 19 evita), depois atira com o fuzil; se empurrou, +◯ e +2d8 dano nesse ataque."}]',
  58
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Pessoa', 'Chefe de Polícia', 100,
  'Delegado ou coronel que já passou por situações difíceis e não se intimida fácil.',
  'Médio', '+15 (3◯)', '+10 (2◯)', 25, '+10 (3◯)', '+10 (2◯)', '+15 (3◯)', 105, 52, null,
  '{"agi":2,"for":3,"int":2,"pre":3,"vig":3}', null, '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Bastão, corpo a corpo x2)","teste":"+15 (3◯)","dano":"1d8+8 impacto"},{"tipo":"Padrão","nome":"Agredir (Espingarda, distância x2, curto)","teste":"+17 (2◯), crítico x3","dano":"4d6+12 balístico"},{"tipo":"Reação","nome":"Teimoso","descricao":"1x/cena, ignora um efeito que exija teste de resistência, ou reduz um dano recém sofrido à metade."}]',
  59
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal', 'Cão de Guarda', 10,
  'Treinado pra guarda — atrapalha grupos que precisam ser furtivos. Também serve pra cães policiais ou lobos.',
  'Médio', '+10 (Faro, Visão na Penumbra)', '+5 (2◯)', 14, '+5 (2◯)', '+5 (2◯)', '+0', 12, 6, null,
  '{"agi":2,"for":2,"int":0,"pre":1,"vig":2}', 'Sobrevivência +10', '12m | 8',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"+5 (2◯)","dano":"1d6+2 corte"},{"tipo":"Livre","nome":"Derrubar","teste":"+5 (2◯)","descricao":"Ao acertar mordida, manobra de derrubar."}]',
  60
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal (Enxame)', 'Enxame de Abelhas', 10,
  'Normalmente pacíficas, mas agressivas se a colmeia é ameaçada — comuns em zonas rurais.',
  'Médio', '+5 (Visão na Penumbra)', '+5', 15, '-2◯', '+5', '+0', 10, 5, null,
  '{"agi":1,"for":0,"int":0,"pre":1,"vig":0}', null, '3m | 2, voo 9m | 6',
  '[{"nome":"Enxame","descricao":"Entra no espaço de outro ser; no fim do turno, 2d6 dano de perfuração automático a quem estiver no espaço; imune a manobras/efeitos de alvo único sem dano; metade do dano de armas; +50% dano de área."},{"nome":"Zumbido Nauseante","descricao":"Quem sofre dano do enxame fica enjoado 1 rodada (Fortitude DT 15 evita)."}]',
  '[]',
  61
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal (Enxame)', 'Enxame de Ratos', 10,
  'Encontrados quase em todo lugar habitado por humanos; normalmente tímidos, se unem em enxame por fome ou energias paranormais.',
  'Médio', '+5 (Faro, Visão na Penumbra)', '+5', 13, '+5', '+5', '+0', 15, 7, null,
  '{"agi":1,"for":0,"int":0,"pre":1,"vig":1}', null, '9m | 6, escalar/nadar 6m | 4',
  '[{"nome":"Enxame","descricao":"Entra no espaço de outro ser; no fim do turno, 2d6 dano de perfuração automático a quem estiver no espaço; imune a manobras/efeitos de alvo único sem dano; metade do dano de armas; +50% dano de área."},{"nome":"Doença","descricao":"Quem sofre dano contrai febre hemorrágica (Fortitude DT 15 evita)."}]',
  '[]',
  62
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal', 'Jacaré', 40,
  'Várias espécies existem, algumas até em áreas urbanas — ficha representa um espécime grande, perigoso pra agentes. (Versão simplificada; ver "Jacaré (completo)" para a ficha com ações.)',
  'Grande', '+5 (Visão na Penumbra)', '+5', 16, '+5 (2◯)', '+5', '+0', 40, 20, null,
  '{"agi":1,"for":3,"int":0,"pre":1,"vig":2}', 'Furtividade +8', null,
  '[]',
  '[]',
  63
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal', 'Jacaré (completo)', 40,
  'Várias espécies existem, algumas até em áreas urbanas — ficha representa um espécime grande, perigoso pra agentes.',
  'Grande', '+10 (Faro, Visão na Penumbra)', '+10 (3◯)', 16, '+5 (2◯)', '+5 (3◯)', '+5', 55, 27, null,
  '{"agi":3,"for":3,"int":0,"pre":1,"vig":2}', 'Furtividade +13 (3◯)', '6m | 4, nadar 9m | 6',
  '[{"nome":"Giro da Morte","descricao":"Agarrando um ser na água, repetir a manobra de agarrar causa +2d8 dano."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"+5 (3◯)","dano":"1d8+8 corte"},{"tipo":"Padrão","nome":"Agredir (Cauda, corpo a corpo)","teste":"+5 (3◯)","dano":"1d12 impacto"},{"tipo":"Livre","nome":"Agarrão","teste":"+7 (3◯)","descricao":"Ao acertar mordida num alvo Médio ou menor, tenta agarrar."}]',
  64
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal', 'Javaporco', 20,
  'Cruzamento de javali com porco doméstico, virou praga em regiões rurais — voraz e agressivo.',
  'Médio', '+5 (Faro, Visão na Penumbra)', '+5', 14, '+5 (3◯)', '+5', '+0', 35, 17, null,
  '{"agi":1,"for":2,"int":0,"pre":1,"vig":3}', null, '12m | 8',
  '[{"nome":"Ferocidade","descricao":"Ao sofrer dano, +◯ em ataques e +1 dado de dano em todas as rolagens até o fim da cena."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"+5 (2◯)","dano":"1d8+4 corte"},{"tipo":"Reação","nome":"Mordida Final","descricao":"Ao ser reduzido a 0 PV, ataca de mordida um oponente aleatório ao alcance antes de morrer."}]',
  65
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal', 'Onça-Pintada', 40,
  'O maior felino das Américas, principal predador das selvas brasileiras — raramente fora de seu território, mas mortal pra agentes embrenhados nele.',
  'Grande', '+10 (Faro, Visão na Penumbra)', '+10 (3◯)', 16, '+5 (2◯)', '+5 (3◯)', '+5', 55, 27, null,
  '{"agi":3,"for":3,"int":0,"pre":1,"vig":2}', 'Furtividade +13 (3◯)', '12m | 8, escalar/nadar 6m | 4',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"+10 (3◯)","dano":"1d8+5 corte"},{"tipo":"Padrão","nome":"Agredir (Garras, corpo a corpo x2)","teste":"+10 (3◯), crítico 19","dano":"1d6+5 corte"},{"tipo":"Livre","nome":"Agarrão","teste":"+7 (3◯)","descricao":"Ao acertar mordida num alvo Médio ou menor, tenta agarrar."},{"tipo":"Completa","nome":"Bote","descricao":"Investida + ataca com mordida e garras no mesmo alvo (todos com +◯ da investida)."}]',
  66
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'mundana', 'Animal', 'Sucuri', 40,
  'Grande cobra constritora das selvas amazônicas — encontrada com colecionadores de animais exóticos ou como mascote perigoso de cultistas excêntricos.',
  'Grande', '+5 (Faro, Visão na Penumbra)', '+5 (2◯)', 16, '+5 (3◯)', '+5 (2◯)', '+0', 68, 34, null,
  '{"agi":2,"for":3,"int":0,"pre":1,"vig":3}', 'Furtividade +8 (2◯)', '6m | 4, escalar/nadar 9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"+10 (3◯)","dano":"1d6+8 corte"},{"tipo":"Livre","nome":"Agarrão","teste":"+12 (3◯)","descricao":"Ao acertar mordida num alvo Médio ou menor, tenta agarrar."},{"tipo":"Livre","nome":"Constrição","descricao":"No início de cada turno, 2d6+8 dano de impacto em quem estiver agarrando."}]',
  67
);
