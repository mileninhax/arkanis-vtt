-- Bestiário Sobrevivendo ao Horror — Ameaças da Realidade (Mundanas): 9 pessoas
-- (incluindo 2 variantes de Serial Killer) + 8 animais. Fecha o bestiário do livro.

insert into creatures (source_id, categoria, tipo_criatura, name, vd, flavor_text, tamanho, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, atributos, pericias, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Bêbado Local', 10,
  'Sujeito simpático e falante, fonte de causos e fofocas locais — pode ser informante valioso ou espião involuntário.',
  'Médio', '-2d20+5', '+1d20', 12, '+1d20+5', '+1d20', '-2d20', 6, 3, 'Químico 1',
  '{"agi":1,"for":1,"int":0,"pre":0,"vig":1}', 'Diplomacia +1d20+5', '6m | 4',
  '[{"nome":"Causos e Histórias","descricao":"+5 Investigação pra interrogá-lo, se a DT da informação for 20 ou menos."},{"nome":"Espião Involuntário","descricao":"Quem interage com ele testa Intuição ou Vontade DT 15; falhando, revela info relevante ao NPC que o usa de espião — cada revelação dá +5 que o mestre usa pra subir a DT de um teste de investigação depois."},{"nome":"Invisibilidade Social","descricao":"Sem ação chamativa, outros precisam de Percepção DT 15 pra notá-lo."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Soco, corpo a corpo)","teste":"+1d20","dano":"1d3+1 impacto"}]',
  80
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Burocrata', 10,
  'Encarregado de trâmites organizacionais — um mal necessário, especialmente quando o tempo é fator crítico.',
  'Médio', '+2d20+5', '+1d20', 11, '+1d20', '+1d20', '+2d20+5', 6, 3, null,
  '{"agi":1,"for":1,"int":2,"pre":2,"vig":1}', 'Diplomacia +2d20+5, Profissão (burocrata) +2d20+10', '9m | 6',
  '[{"nome":"Atendimento Protocolar","descricao":"Atitude inicial sempre indiferente; enquanto indiferente ou pior, -5 em testes de Int/Pre contra ele."},{"nome":"Burocracia Frustrante","descricao":"Falhar em teste de Int/Pre contra ele custa 1 Sanidade."},{"nome":"Morosidade","descricao":"Cena com urgência, ao encontrá-lo, Diplomacia DT 15 ou perde 1 rodada."},{"nome":"Preencha o Formulário","descricao":"Interrogá-lo exige a perícia certa (definida pelo mestre conforme sua área); perícia errada falha automaticamente."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Soco, corpo a corpo)","teste":"+1d20","dano":"1d3+1 impacto"}]',
  81
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Fazendeiro Isolado', 20,
  'Vida no campo torna as pessoas autossuficientes, desconfiadas de estranhos, acostumadas a resolver tudo com as próprias mãos.',
  'Médio', '+2d20+5', '+1d20', 16, '+2d20+5', '+1d20', '+2d20+5', 16, 8, null,
  '{"agi":1,"for":2,"int":1,"pre":2,"vig":2}', 'Profissão (fazendeiro) +1d20+10', '9m | 6',
  '[{"nome":"De Sol a Sol","descricao":"Não fica inconsciente ao ser reduzido a 0 PV."},{"nome":"Histórias de Pescador","descricao":"Compartilhar a investigação com ele permite teste de revisar caso com Profissão (fazendeiro), a critério do mestre."},{"nome":"Resiliência do Campo","descricao":"Usa Profissão (fazendeiro) no lugar de perícias baseadas em Força ou Presença."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Peixeira, corpo a corpo)","teste":"+2d20+5, crítico 19","dano":"1d8+5 corte"},{"tipo":"Padrão","nome":"Agredir (Espingarda, distância curto)","teste":"+1d20+5, crítico x3","dano":"4d6 balístico"},{"tipo":"Movimento","nome":"Atiçar os Cães","descricao":"Próximo ataque acertado causa +1d8 dano de perfuração + alvo caído (Luta DT 15 evita)."}]',
  82
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Investigador', 40,
  'Agente da lei especializado em trabalho de campo — escrivão, polícia civil, investigador privado ou detetive; pode trabalhar a favor ou contra os agentes.',
  'Médio', '+2d20+5', '+2d20+5', 18, '+2d20', '+2d20+5', '+1d20+5', 68, 34, null,
  '{"agi":2,"for":1,"int":2,"pre":1,"vig":2}', 'Crime +2d20+5, Diplomacia +1d20+5, Furtividade +2d20+5, Intuição +1d20+5, Investigação +2d20+5', '9m | 6',
  '[{"nome":"Fonte de Informações","descricao":"Amigável (atitude amistosa/prestativa), 1x/interlúdio dá +5 numa ação de revisar caso."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Soco, corpo a corpo)","teste":"+1d20+10","dano":"1d3+1 impacto"},{"tipo":"Padrão","nome":"Agredir (Revólver, distância curto)","teste":"+2d20+10, crítico 19/x3","dano":"2d6+6 balístico"},{"tipo":"Movimento","nome":"Olhar do Investigador","descricao":"Investigação DT 15 num alvo em alcance médio; passando, +1d6 dano contra ele até o fim da cena."}]',
  83
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Médico', 20,
  'Treinado pra socorrer — mas nas mãos erradas, o mesmo conhecimento causa dor ou morte.',
  'Médio', '+2d20+5', '+1d20', 13, '+1d20+5', '+1d20', '+2d20+5', 14, 7, null,
  '{"agi":1,"for":1,"int":2,"pre":2,"vig":1}', 'Ciências +2d20+5, Medicina +2d20+10', '9m | 6',
  '[{"nome":"Conhecimento Anatômico","descricao":"Bisturi acertado deixa atordoado 1 rodada + sangrando (Fortitude DT 15 evita); 1x/cena por pessoa."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Bisturi, corpo a corpo)","teste":"+2d20+5, crítico 18","dano":"1d4+1 corte"},{"tipo":"Padrão","nome":"Tratar Ferimentos","dano":"Cura 2d10+2 PV","descricao":"Cura si/adjacente; 1x/dia por pessoa."}]',
  84
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Religioso', 40,
  'Líder de fé carismático — pode genuinamente ajudar sua congregação ou manipulá-la em busca de poder/riqueza/acesso ao paranormal.',
  'Médio', '+3d20+5', '+1d20+5', 15, '+1d20', '+1d20', '+3d20+5', 32, 16, null,
  '{"agi":1,"for":1,"int":2,"pre":3,"vig":1}', 'Diplomacia +3d20+5, Intuição +3d20+5, Religião +3d20+5', '9m | 6',
  '[{"nome":"Fé Inabalável","descricao":"+10 Vontade contra efeitos paranormais (inclusive rituais)."},{"nome":"Potência da Voz","descricao":"Com microfone, alcance das habilidades +1 passo, DT de resistência +5."},{"nome":"Seguidores","descricao":"Acompanhado de 1d4+1 devotos fiéis (ficha de Iniciado) dispostos a protegê-lo."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo)","teste":"+1d20+5","dano":"1d3+1 impacto"},{"tipo":"Padrão","nome":"Voz Guia","descricao":"Pessoa em alcance curto que ouça recebe +1d20 no próximo teste de perícia até o fim da próxima rodada."},{"tipo":"Padrão","nome":"Voz Acusadora","dano":"3d6 mental + alquebrado (Vontade DT 15 reduz à metade e evita)","descricao":"Alvo em alcance curto."},{"tipo":"Reação","nome":"Sacrifício Sagrado","descricao":"1x/rodada, ao sofrer dano, troca de lugar com seguidor adjacente que sofre o dano no lugar."}]',
  85
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Predador Sofisticado', 60,
  'Serial killer — assassino de alta classe social — vive no topo de arranha-céus, prefere mortes limpas e discretas mas é brutal quando tem a chance; usa status pra encobrir crimes.',
  'Médio', '+3d20+10', '+3d20+5', 21, '+1d20+5', '+3d20+10', '+3d20+10', 60, 30, null,
  '{"agi":3,"for":3,"int":2,"pre":3,"vig":1}', 'Diplomacia +3d20+10, Enganação +3d20+10, Intimidação +3d20+10', '9m | 6',
  '[{"nome":"Escondido em Plena Vista","descricao":"Em ambientes movimentados, usa Enganação no lugar de Furtividade, sem penalidade/redução de deslocamento por ações chamativas em furtividade."},{"nome":"Recursos Abundantes","descricao":"Acessa locais/documentos restritos, comete crimes menores sem punição; crimes graves podem ter um \"bode expiatório\" (a critério do mestre)."},{"nome":"Sorriso Sedutor","descricao":"Quem não sabe que é assassino fica desprevenido contra ele, -1d20 em testes contra ele."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Navalha, corpo a corpo x2)","teste":"+3d20+10, crítico 19/x3","dano":"1d8+13 corte"},{"tipo":"Padrão","nome":"Agredir (Machado, corpo a corpo x2)","teste":"+3d20+10, crítico x3","dano":"2d8+13 corte"},{"tipo":"Padrão","nome":"Agredir (Pistola Silenciada, distância x2 curto)","teste":"+3d20+10, crítico x3","dano":"1d12+13 balístico"},{"tipo":"Livre","nome":"Ataque Furtivo","descricao":"1x/rodada, +3d6 dano contra desprevenido/flanqueado (corpo a corpo ou distância curta)."},{"tipo":"Padrão","nome":"Guarda-Costas","descricao":"1x/cena, chama 1d4+1 capangas que chegam na próxima rodada."}]',
  86
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Caçador de Gente', 80,
  'Serial killer — além da convivência social, brutal e grotesco, sede de sangue incontrolável — isolado no campo ou prédios abandonados, considerado "monstruoso" mesmo sendo humano.',
  'Médio', '+1d20+5', '+2d20+10', 23, '+3d20+10', '+2d20+10', '+1d20+5', 80, 40, null,
  '{"agi":2,"for":3,"int":1,"pre":1,"vig":3}', 'Atletismo +3d20+10, Sobrevivência +1d20+10', '9m | 6',
  '[{"nome":"Abrutalhado","descricao":"Usa itens de duas mãos com uma só, usa objetos de criatura Grande sem penalidade; resistência a dano 10/paranormal enquanto machucado."},{"nome":"Área de Caça","descricao":"+1d20 em perícia na área onde caça (definida pelo mestre)."},{"nome":"Faro para Humanos","descricao":"+2d20 em Sobrevivência envolvendo pessoas; percebe humanos por faro."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo x2)","teste":"3d20+15","dano":"1d4+15 impacto"},{"tipo":"Padrão","nome":"Agredir (Machado, corpo a corpo x2)","teste":"3d20+15, crítico x3","dano":"2d8+15 corte"},{"tipo":"Padrão","nome":"Agredir (Motosserra, corpo a corpo x2)","teste":"3d20+15, crítico x4","dano":"3d6+15 corte"},{"tipo":"Livre","nome":"Ataque Furtivo","descricao":"1x/rodada, +4d6 dano contra desprevenido/flanqueado."},{"tipo":"Movimento","nome":"Imparável","descricao":"Anula qualquer redução de deslocamento (outras consequências do efeito continuam)."},{"tipo":"Padrão","nome":"Assustar","dano":"4d6 mental (Vontade DT 20 reduz à metade)","descricao":"Em quem vê/ouve em alcance curto."},{"tipo":"Padrão","nome":"Fatalidade","descricao":"1 ataque de pancada; acertando, também causa ferimento debilitante; 1x/cena por alvo."}]',
  87
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Pessoa', 'Artista da Morte', 140,
  'Serial killer — pra este assassino, matar é uma arte meticulosa — nem sempre é combatente, muitas vezes tem profissão comum na sociedade; a cena do crime precisa ser "perfeita".',
  'Médio', '+3d20+15', '+3d20+15', 27, '+1d20+5', '+3d20+15', '+3d20+15', 150, 75, null,
  '{"agi":3,"for":1,"int":3,"pre":3,"vig":1}', 'Artes +3d20+15, Enganação +3d20+15, Furtividade +3d20+15', '9m | 6',
  '[{"nome":"Matar É Uma Arte","descricao":"Usa Artes no lugar de qualquer perícia envolvendo mentes/corpos humanos (necropsia, persuadir); com horas pra analisar cena/vítima, substitui Investigação por Artes com +1d20."},{"nome":"Cenas Imprevisíveis","descricao":"Se quis disfarçar como acidente, DT pra achar pistas na cena +5; se quis deixar sua marca, quem vê a cena e não sai imediatamente fica enjoado + 4d8 dano mental (Vontade DT 25 reduz à metade e evita)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Bisturi, corpo a corpo x2)","teste":"3d20+15, crítico 19/x4","dano":"1d4+17 corte"},{"tipo":"Livre","nome":"Ataque Furtivo","descricao":"1x/rodada, +7d6 dano contra desprevenido/flanqueado."},{"tipo":"Padrão","nome":"Discurso Artístico","dano":"4d8 mental + alquebrado e frustrado (Vontade DT 25 reduz à metade e evita frustrado)","descricao":"Todos em alcance curto que ouvem; 1x/cena por pessoa."}]',
  88
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Ariranha', 20,
  'Predador brincalhão e corajoso do Pantanal/Amazônia, vive em bandos que se protegem mutuamente.',
  'Médio', '+1d20+5 (Faro, Visão na Penumbra)', '+2d20+5', 16, '+2d20', '+2d20+5', '+1d20', 32, 16, null,
  '{"agi":2,"for":1,"int":0,"pre":1,"vig":2}', null, '12m | 8, Natação 9m | 6',
  '[{"nome":"Evasão","descricao":"Ataque que permite Reflexos pra reduzir dano à metade — passando, não sofre dano nenhum."},{"nome":"Táticas Familiares","descricao":"+2 ataque/dano por cada outra ariranha atacando o mesmo alvo na mesma rodada."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"2d20+5","dano":"2d4+2 corte"}]',
  89
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Cavalo', 10,
  'Usado por forças policiais, esporte, ou como transporte/tração no campo.',
  'Grande', '+1d20+5 (Faro, Visão na Penumbra)', '+1d20+5', 13, '+2d20', '+1d20+5', '+1d20', 12, 6, null,
  '{"agi":1,"for":3,"int":0,"pre":1,"vig":2}', null, '15m | 10',
  '[{"nome":"Montaria","descricao":"Treinado em Adestramento pode usá-lo como aliado que aumenta deslocamento pra 15m + ação extra por rodada (só pra se deslocar)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Cascos, corpo a corpo)","teste":"3d20+5","dano":"2d4+3 impacto"}]',
  90
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal (Enxame)', 'Enxame de Tocandiras', 20,
  'Formiga-bala amazônica, mordida de dor intensa e debilitante.',
  'Médio', '+1d20+5 (Visão na Penumbra)', '+1d20+5', 16, '-2d20', '+1d20+5', '+1d20', 22, 11, null,
  '{"agi":1,"for":0,"int":0,"pre":1,"vig":0}', null, '6m | 4, Escalar 6m | 4',
  '[{"nome":"Enxame","descricao":"Entra no espaço de outros; 4d4 dano de perfuração automático no fim do turno a quem estiver no espaço; imune a manobras/efeitos de alvo único sem dano; metade do dano de armas; +50% dano de área."},{"nome":"Dor Debilitante","descricao":"Quem sofre dano dele sofre -1d20 em todos os testes (Fortitude DT 20 evita); remove só com dormir ou dose de antídoto."},{"nome":"Por Dentro das Roupas","descricao":"Sair do espaço do enxame ainda carrega formigas — continua sofrendo metade do dano (2d4) até gastar ação de movimento pra se livrar."}]',
  '[]',
  91
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Gorila', 40,
  'Territorialista e imponente, protege seu habitat.',
  'Grande', '+1d20+5 (Faro, Visão na Penumbra)', '+2d20+5', 19, '+3d20+5', '+2d20+5', '+1d20', 70, 35, null,
  '{"agi":2,"for":3,"int":0,"pre":1,"vig":3}', 'Atletismo +3d20+5', '9m | 6, Escalar 9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo x2)","teste":"2d20+10","dano":"1d6+3 impacto"},{"tipo":"Livre","nome":"Morder","teste":"2d20+10","dano":"1d6+4 corte","descricao":"Acertando as 2 pancadas no mesmo alvo, ataca também com mordida."}]',
  92
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Leão', 60,
  '"Rei das selvas" — um dos maiores predadores das savanas africanas; no Brasil, encontrado em abrigos/coleções exóticas (geralmente ilegais).',
  'Grande', '+1d20+10 (Faro, Visão na Penumbra)', '+3d20+10', 18, '+2d20+5', '+3d20+10', '+2d20+5', 80, 40, null,
  '{"agi":3,"for":3,"int":0,"pre":2,"vig":2}', 'Atletismo +3d20+10, Furtividade +3d20+8', '15m | 10',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Garras, corpo a corpo x2)","teste":"3d20+10, crítico 19","dano":"1d6+4 corte"},{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"3d20+10","dano":"1d8+4 corte"},{"tipo":"Livre","nome":"Agarrão","teste":"3d20+12","descricao":"Ao acertar mordida em alvo Médio ou menor, tenta agarrar."},{"tipo":"Completa","nome":"Bote","descricao":"Investida + ataca com mordida e as 2 garras (3 ataques, todos com bônus de investida) contra o mesmo alvo."}]',
  93
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Lobo', 20,
  'Caçador habilidoso em grupo — ao ouvir o uivo, nunca está sozinho.',
  'Médio', '+1d20+5 (Faro, Visão na Penumbra)', '+3d20+5', 15, '+2d20+5', '+3d20+5', '+1d20', 18, 9, null,
  '{"agi":3,"for":3,"int":0,"pre":1,"vig":2}', 'Sobrevivência +1d20+10', '12m | 8',
  '[{"nome":"Táticas de Alcateia","descricao":"Flanqueando, +1d20 adicional no ataque (total +2d20 com o bônus normal de flanquear) + 1d6 dano extra na mordida."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"3d20+5","dano":"1d6+4 corte"},{"tipo":"Livre","nome":"Derrubar","teste":"3d20+5","descricao":"Acertando mordida, manobra de derrubar."}]',
  94
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Touro', 20,
  'Montanha de músculos de temperamento imprevisível.',
  'Grande', '+1d20+5 (Faro, Visão na Penumbra)', '+1d20', 15, '+2d20+5', '+1d20', '+1d20', 38, 19, null,
  '{"agi":1,"for":3,"int":0,"pre":1,"vig":2}', null, '12m | 8',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Chifres, corpo a corpo)","teste":"3d20+5","dano":"2d6+6 perfuração"},{"tipo":"Completa","nome":"Atropelamento (recarga: movimento)","dano":"2d6+6 impacto + caído (Reflexos DT 15 reduz à metade e evita)","descricao":"Percorre o dobro do deslocamento em linha reta, atravessando espaços de seres menores; quem está na linha sofre o efeito."}]',
  95
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'), 'mundana', 'Animal', 'Urso Pardo', 60,
  'Um dos ursos mais perigosos — predador imponente e poderoso.',
  'Grande', '+1d20+5 (Faro, Visão na Penumbra)', '+1d20+5', 19, '+3d20+10', '+1d20+5', '+2d20', 90, 45, 'Balístico, corte, impacto e perfuração 2',
  '{"agi":1,"for":3,"int":0,"pre":2,"vig":3}', 'Atletismo +3d20+10', '12m | 8',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Garras, corpo a corpo x2)","teste":"3d20+10, crítico 19","dano":"1d6+4 corte"},{"tipo":"Padrão","nome":"Agredir (Mordida, corpo a corpo)","teste":"3d20+10","dano":"1d8+4 corte"},{"tipo":"Livre","nome":"Agarrão","teste":"3d20+12","descricao":"Ao acertar mordida em alvo Médio ou menor, tenta agarrar."}]',
  96
);
