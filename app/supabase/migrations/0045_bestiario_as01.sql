-- Bestiário Arquivos Secretos 01 — Os Transtornados (culto do Diabo), NPCs bônus do
-- Hexatombe (Cleo Brisa, Cristino) e a criatura paranormal Anulado. Por decisão de
-- Millie: só fichas de personagem/NPC entram aqui — lore/narrativa fica de fora.

insert into creatures (source_id, categoria, tipo_criatura, name, vd, flavor_text, tamanho, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, atributos, pericias, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Assecla', 40,
  'Recém-chegado ao culto Os Transtornados — hierarquia mais baixa.',
  'Médio', '+1d20+5', '+1d20+5', 18, '+2d20+5', '+1d20+5', '+1d20+5', 30, 15, null,
  '{"agi":1,"for":2,"int":2,"pre":1,"vig":2}', 'Atletismo +2d20+5, Intimidação +1d20+5, Ocultismo +2d20+5', '9m | 6',
  '[{"nome":"Rituais (DT 15)","descricao":"Conjura sem pagar PE, até 3 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Corrente Farpada, corpo a corpo)","teste":"2d20+5, crítico 19","dano":"1d8+10 corte","descricao":"Corrente alcança 3m, +2 em desarmar/derrubar."},{"tipo":"Padrão","nome":"Ritual Armadura de Sangue (Sangue 1)","descricao":"+5 Defesa até o fim da cena."},{"tipo":"Padrão","nome":"Ritual Esfolar Discente (Sangue 1)","dano":"5d4+5 corte + sangrando (Reflexos DT 15 reduz à metade e evita)","descricao":"Explosão 6m raio, alcance médio."}]',
  97
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Investido (Transtornado)', 80,
  'Marcado, executor do culto Os Transtornados — hierarquia intermediária.',
  'Médio', '+2d20+10', '+3d20+5', 23, '+2d20+10', '+1d20+5', '+2d20+10', 90, 45, null,
  '{"agi":1,"for":3,"int":2,"pre":2,"vig":2}', 'Atletismo +3d20+10, Intimidação +2d20+10, Ocultismo +2d20+10', '9m | 6',
  '[{"nome":"Rituais (DT 20)","descricao":"Conjura sem pagar PE, até 6 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Cutelo, corpo a corpo x2)","teste":"4d20+15, crítico x3","dano":"1d6+15 corte"},{"tipo":"Padrão","nome":"Ritual Armadura de Sangue Discente (Sangue 1)","descricao":"+10 Defesa + resistência a balístico/corte/impacto/perfuração 5 até o fim da cena."},{"tipo":"Padrão","nome":"Ritual Descarnar Discente (Sangue 2)","dano":"10d8 (metade corte/metade Sangue) + hemorragia (Fortitude DT 20 reduz à metade e evita; hemorragia = 4d8 Sangue por turno até passar 2 testes de Fortitude seguidos)","descricao":"Toque."},{"tipo":"Padrão","nome":"Ritual Esfolar Discente (Sangue 1)","dano":"5d4+5 corte + sangrando (Reflexos DT 20 reduz à metade e evita)","descricao":"Explosão 6m raio, alcance médio."},{"tipo":"Padrão","nome":"Ritual Transfusão Vital (Sangue 2)","descricao":"Perde até 50 PV, toca aliado que recupera o mesmo tanto."}]',
  98
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Apóstolo do Sangue', 200,
  'Líder do culto Os Transtornados, deformado pelo paranormal — hierarquia mais alta.',
  'Médio', '+3d20+15 (Percepção às Cegas)', '+2d20+10', 30, '+3d20+15', '+2d20+10', '+3d20+15', 300, 150, null,
  '{"agi":2,"for":4,"int":2,"pre":3,"vig":3}', 'Atletismo +4d20+15, Intimidação +3d20+15, Ocultismo +2d20+15', '9m | 6',
  '[{"nome":"Marreta Transtornada","descricao":"Crítico com a marreta também quebra um osso — alvo fica fraco até cuidados prolongados em interlúdio (Fortitude DT 29 evita); se ficar fraco de novo pela mesma arma, vira debilitado."},{"nome":"Rituais (DT 29)","descricao":"Conjura sem pagar PE, até 10 PE por conjuração."}]',
  '[{"tipo":"Livre","nome":"Rituais Acelerados","descricao":"1x/rodada, ritual de execução até ação completa vira execução livre."},{"tipo":"Padrão","nome":"Agredir (Marreta Sanguinária, corpo a corpo x2)","teste":"4d20+20, crítico x4","dano":"4d10+30 impacto, perfuração ou Sangue (à escolha)"},{"tipo":"Padrão","nome":"Ritual Armadura de Sangue Discente (Sangue 1)","descricao":"+10 Defesa + resistência 5 até o fim da cena."},{"tipo":"Padrão","nome":"Ritual Descarnar Discente (Sangue 2)","dano":"10d8 + hemorragia (Fortitude DT 29, mesma mecânica do Investido)","descricao":"Toque."},{"tipo":"Padrão","nome":"Ritual Esfolar Verdadeiro (Sangue 1)","dano":"10d4+10 corte + sangrando (Reflexos DT 29 reduz à metade e evita)","descricao":"Explosão 6m raio, alcance longo."},{"tipo":"Padrão","nome":"Ritual Hemofagia Discente (Sangue 2)","dano":"+6d6 Sangue","descricao":"Ataque de marreta + ritual; acertando, recupera metade do dano total causado em PV."},{"tipo":"Padrão","nome":"Ritual Transfusão Vital (Sangue 2)","descricao":"Perde até 50 PV, cura aliado no mesmo tanto."},{"tipo":"Padrão","nome":"Ritual Vomitar Pestes Discente (Sangue 3)","dano":"5d12 Sangue + agarrado (Reflexos DT 29 reduz à metade e evita)","descricao":"Vomita enxame Grande (3m) de criaturas de Sangue no fim de cada turno; ação de movimento move o enxame 12m; escapar exige ação padrão + Acrobacia/Atletismo DT 29."}]',
  99
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Giovanni Opspor', 80,
  'Empresário que fez um Pacto de Sangue pra salvar sua fortuna; perdeu o filho num incêndio e se tornou um dos membros mais perigosos do culto — manipulador, sem escrúpulos, sempre um passo à frente. Líder da equipe dos Transtornados no Hexatombe.',
  'Médio', '+3d20+10', '+2d20+5', 23, '+1d20+5', '+2d20+5', '+3d20+10', 70, 35, null,
  '{"agi":2,"for":1,"int":4,"pre":3,"vig":1}', 'Crime +2d20+10, Enganação +3d20+10, Furtividade +2d20+10, Ocultismo +4d20+10', '9m | 6',
  '[{"nome":"Rituais (DT 20)","descricao":"Conjura sem pagar PE, até 6 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Revólver, distância curto)","teste":"2d20+5, crítico 19","dano":"2d6+10 balístico"},{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo)","teste":"2d20+5, crítico 19","dano":"1d4+10 perfuração"},{"tipo":"Padrão","nome":"Ritual Distorcer Aparência (Sangue 1)","descricao":"Muda aparência própria/de outro em alcance curto até o fim da cena; +10 Enganação pra disfarce; resistir/identificar exige Vontade DT 20."},{"tipo":"Padrão","nome":"Ritual Esconder dos Olhos (Conhecimento 2)","descricao":"Invisível (camuflagem total + 15 Furtividade); termina se atacar ou usar habilidade hostil."},{"tipo":"Padrão","nome":"Ritual Espelho (Sangue+Conhecimento 2)","descricao":"Cria cópia de carne/sangue de si mesmo ou de ser já visto (mesmas estatísticas); controla e percebe através dela; fica atordoado enquanto concentrado; identificar exige Intuição/Ocultismo/Percepção/Vontade DT 20."},{"tipo":"Padrão","nome":"Ritual Fortalecimento Sensorial Discente (Sangue 1)","descricao":"+1d20 em Investigação/Luta/Percepção/Pontaria até o fim da cena; inimigos -1d20 pra atacá-lo."},{"tipo":"Padrão","nome":"Ritual Terceiro Olho (Conhecimento 1)","descricao":"Vê auras paranormais em alcance longo por 1 dia; ação de movimento identifica poderes paranormais/rituais de alguém em alcance médio."}]',
  100
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Mosto', 60,
  'Ex-segurança de creche, brutamontes silencioso que virou Transtornado após um Pacto pra salvar seu emprego; rosto desfigurado em luta contra Colosso, cobre o rosto com um saco de pão. Guarda-costas leal de Giovanni.',
  'Médio', '+0', '+2d20+5', 20, '+3d20+10', '+1d20+5', '+0', 100, 50, null,
  '{"agi":1,"for":4,"int":1,"pre":1,"vig":3}', 'Atletismo +4d20+10', '9m | 6',
  '[{"nome":"Rosto Desfigurado","descricao":"Sem o saco cobrindo o rosto, fica furioso — +1d8 em rolagens de dano e libera o poder Trocação Justa."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Cutelo, corpo a corpo)","teste":"4d20+10, crítico 19/x3","dano":"1d6+10 corte"},{"tipo":"Padrão","nome":"Agredir (Desarmado, corpo a corpo)","teste":"4d20+10","dano":"1d4+10 impacto"},{"tipo":"Completa","nome":"Surra Brutal","descricao":"2 ataques (cutelo + desarmado); -5 Defesa até o próximo turno."},{"tipo":"Completa","nome":"Trocação Justa (só furioso)","descricao":"Salta no inimigo, golpes ininterruptos — alvo escolhe \"trocar\" (revezam rolando dano um no outro até alguém desistir/cair; dano não pode ser bloqueado) ou \"se defender\" (Fortitude DT 20: passa sofre 1d6+10, falha sofre 1d6+1d4+20 — esses sim podem ser bloqueados normalmente)."}]',
  101
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Tarrafa', 60,
  'Pescador simples que vendeu a alma num Pacto pra sobreviver à fome; morto durante o Hexatombe por Aguiar e Jae-Yoon, ressurgiu como Zumbi de Sangue, depois destruído de vez.',
  'Médio', '+1d20+5', '+3d20+10', 21, '+2d20+5', '+3d20+10', '+0', 80, 40, null,
  '{"agi":3,"for":2,"int":1,"pre":1,"vig":2}', 'Acrobacia +3d20+10, Atletismo +2d20+10', '9m | 6',
  '[{"nome":"Perfuração Permanente","descricao":"Acertando o arpão, alvo fica lento até remover com ação padrão + Atletismo/Luta DT 20."},{"nome":"Prazer na Dor","descricao":"Machucado, resistência a dano 5."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Arpão do Pescador, distância curto)","teste":"3d20+10, crítico x3","dano":"1d6+10 perfuração +1d6 Sangue"},{"tipo":"Padrão","nome":"Agredir (Faca, corpo a corpo x2)","teste":"3d20+10, crítico 19","dano":"1d4+10 perfuração"},{"tipo":"Padrão","nome":"Engolir Metal","descricao":"Engole objeto metálico Pequeno ou menor; perde 1d6 PV, +2 em testes de Força/Agilidade (cumulativo, até 3 itens)."}]',
  102
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Carrara', 60,
  'Transtornado de meia-idade com pregos cravados ao redor do crânio/pescoço/braços; morto por Kemi antes mesmo do início do ritual Hexatombe.',
  'Médio', '+2d20+5', '+2d20+10', 18, '+0', '+2d20+10', '+2d20+5', 70, 35, null,
  '{"agi":2,"for":1,"int":2,"pre":2,"vig":1}', 'Atletismo +1d20+10, Enganação +2d20+10', '9m | 6',
  '[{"nome":"Sangue Maldito","descricao":"Munição banhada em seu sangue causa +1d6 dano de Sangue (uma única vez)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Soco com Pregos, corpo a corpo x2)","teste":"1d20+10","dano":"1d4+10 impacto"},{"tipo":"Padrão","nome":"Agredir (Pregador Pneumático, distância x2 curto)","teste":"2d20+10, crítico x4","dano":"3d4+10 perfuração +1d6 Sangue"},{"tipo":"Completa","nome":"Pregos de Sangue","descricao":"Remove pregos do corpo e recarrega o pregador, aplicando Sangue Maldito."}]',
  103
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Nando Salles', 20,
  '"Criptobro" arrogante, influenciador de finanças; era o sacrifício da equipe dos Transtornados no Hexatombe, carregando o Estigma da Coroa de Espinhos (Orgulho/Desprezo/Arrogância). Morto por Kemi após tentar matar Henri pelas costas.',
  'Médio', '+2d20+5', '+2d20+5', 16, '+2d20+5', '+2d20+5', '+2d20+5', 35, 17, null,
  '{"agi":2,"for":1,"int":2,"pre":2,"vig":2}', 'Enganação +2d20+5', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Pistola, distância curto)","teste":"2d20+5, crítico 18","dano":"1d12+5 balístico"},{"tipo":"Completa","nome":"Arrogância Diabólica","dano":"2d6 dano mental inevitável (sem redução/resistência) se recusar","descricao":"Pessoa em alcance longo testa Vontade DT 25; falhando, faz uma ação imprudente no próximo turno (atacar alguém mais forte, saltar de um lugar alto)."}]',
  104
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Cleo Brisa', 60,
  'Policial civil de Inquisidor do Vale (norte do Paraná), investigava clandestinamente seu próprio delegado (o serial killer "Mutilador Noturno"). Capturada pelos Transtornados e jogada num portal pro Hexatombe pra preencher a vaga de Carrara. Morta pelos Vampiros de forma brutal. Não era cultista de fato.',
  'Médio', '+2d20+5', '+2d20+10', 20, '+2d20+5', '+2d20+5', '+2d20+10', 80, 40, null,
  '{"agi":2,"for":2,"int":2,"pre":2,"vig":2}', 'Atletismo +2d20+5, Crime +2d20+5, Intuição +2d20+10, Investigação +2d20+10, Tática +2d20+5', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Pistola, distância x2 curto)","teste":"2d20+10, crítico 18","dano":"1d12+10 balístico"},{"tipo":"Padrão","nome":"Agredir (Pé de Cabra, corpo a corpo x2)","teste":"2d20+10","dano":"1d8+10 impacto"},{"tipo":"Reação","nome":"Durona","descricao":"1x/cena, dano que reduziria a 0 PV a deixa em 1 PV (não funciona com dano massivo)."},{"tipo":"Completa","nome":"Empurrar e Atirar","descricao":"Empurra alvo 3m com o pé de cabra (Fortitude DT 20 evita) + atira; empurrando com sucesso, +1d20 no ataque e +1d12 dano se acertar."}]',
  105
),
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'mundana', 'Pessoa', 'Cristino', 180,
  'Cangaceiro enigmático que chegou à Coroa de Espinhos a pé (não cruzou portal). Caçador do Quibungo (recuperou um medalhão de Tenebris de dentro da criatura). Frio e metódico, cumpria promessas com brutalidade. Morto por Henri (Juan), que usou o ritual Descarnar pra removê-lo pele. Não era cultista de fato.',
  'Médio', '+2d20+5', '+2d20+15', 36, '+3d20+15', '+3d20+15', '+2d20+10', 240, 120, null,
  '{"agi":3,"for":3,"int":2,"pre":2,"vig":3}', 'Atletismo +3d20+15, Furtividade +3d20+15, Medicina +2d20+15, Sobrevivência +2d20+15', '9m | 6',
  '[{"nome":"Combinação Cruel","descricao":"2 ataques por rodada combinando tipos diferentes (ex.: disparo + coronhada)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Peixeira, corpo a corpo x2)","teste":"3d20+20, crítico 19","dano":"3d8+30 corte"},{"tipo":"Padrão","nome":"Agredir (Coronha da Espingarda, corpo a corpo x2)","teste":"3d20+20, crítico x3","dano":"3d6+30 perfuração"},{"tipo":"Padrão","nome":"Agredir (Espingarda, distância x2 curto)","teste":"3d20+20, crítico x3","dano":"4d6+30 balístico"},{"tipo":"Padrão","nome":"Luzernas","dano":"6d6 fogo + em chamas (Reflexos DT 28 reduz à metade e evita)","descricao":"Posiciona lamparina, iluminando alcance curto — percebe automaticamente quem for iluminado por ela, qualquer distância; atirando na lamparina, explode causando o dano a todos em alcance curto."},{"tipo":"Completa","nome":"Emboscada do Cangaço","descricao":"Escondido, inimigos testam Percepção DT 30; se ninguém passar, faz 2 disparos de espingarda + 1 coronhada (3 ataques na mesma ação); alvos ficam desprevenidos (-5 Defesa, -1d20 Reflexos) e sem reações."}]',
  106
);

insert into creatures (source_id, categoria, name, vd, flavor_text, descritores, tamanho, presenca_dt, presenca_dano, presenca_nex_imune, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, vulnerabilidades, atributos, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_01'), 'paranormal', 'Anulado', 100,
  '"O corpo abandonado por tempo demais se torna a manifestação física do fracasso e da incompletude" — criatura de Sangue/Conhecimento que se forma quando um caixão do ritual Passagem de Conhecimento Expandido é aberto antes da hora (1d6+1 dias). Humanoide retorcido e visceral, textura gosmenta, pescoço longo e quebrado, braços desproporcionais terminados em garras; raios vermelhos percorrem seu corpo instável (falha na Membrana). Amálgama errante de carne/órgãos/memórias sem vida, consciência ou alma — um "quase ser" preso em formação e agonia eterna. Ataca com agressividade desesperada, tentando absorver tecido/ossos/órgãos pra se completar.',
  '{Sangue,Conhecimento}', 'Médio', 20, '4d6 mental', 45, '1d20+10', '2d20+10, Visão no Escuro', 25, '3d20+10', '2d20+5', '1d20+10', 190, 95, 'Balístico, impacto e perfuração 5, Conhecimento e Sangue 10', 'Morte',
  '{"agi":2,"for":3,"int":1,"pre":1,"vig":3}', '9m | 6',
  '[{"nome":"Corpo Oscilante","descricao":"Na 1ª vez que alguém olha diretamente pra ele, sofre 2d6 dano mental; qualquer ação visando o Anulado conta como \"olhar diretamente\" (evitar isso dá -1d20 nos testes contra ele, mas evita o dano)."},{"nome":"Golpes Anulados","descricao":"Distribui os ataques entre até 3 alvos diferentes."},{"nome":"Quero o Seu Corpo","descricao":"Ao errar um ataque contra ele, testa Reflexos DT 25 ou fica agarrado; começando o turno agarrando alguém, suga órgãos: 4d10 dano de Sangue, recupera metade do dano em PV."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Braços Grotescos, corpo a corpo x2)","teste":"3d20+15","dano":"1d8+10 impacto"},{"tipo":"Padrão","nome":"Agredir (Mordida Asquerosa, corpo a corpo)","teste":"3d20+15","dano":"1d10+10 Sangue"}]',
  107
);
