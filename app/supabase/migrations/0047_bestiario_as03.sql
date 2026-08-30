-- Bestiário Arquivos Secretos 03 — Os Psikolera (banda, 6 fichas), Os Couraças
-- (culto de Escarlata, 6 fichas), Os Pássaros (5 fichas) + Suellen (1 ficha).

insert into creatures (source_id, categoria, tipo_criatura, name, vd, flavor_text, tamanho, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, vulnerabilidades, atributos, pericias, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Alê', 80,
  'Tecladista do PSIKOLERA, neta de uma cartomante; canaliza Morte e Conhecimento através do teclado. Percepção sinestésica de sons desde criança. Mecânica compartilhada da banda — Música do Diabo: ação livre, só usável se o personagem já estiver de máscara (Hora do Show ativa); todos os membros do PSIKOLERA (mascarados ou não) recebem bônus de dano que escala com quantos membros estão tocando simultaneamente, na ordem: 1º Franco (guitarra) +1d4, 2º Cindy (baixo) +1d6, 3º Alê (teclado) +1d8, 4º Eloy (bateria) +1d10, 5º Caio (vocal, todos tocando) +1d12.',
  'Médio', '+3◯+10', '+3◯+5', 18, '+0', '+3◯+5', '+3◯+10', 45, 22, null, null,
  '{"agi":3,"for":1,"int":3,"pre":3,"vig":1}', 'Artes +3◯+10, Ocultismo +3◯+10', '9m | 6',
  '[{"nome":"Rituais (DT 20)","descricao":"Conjura sem pagar PE, até 6 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Cortar com Teclado, corpo a corpo x2)","teste":"◯+10, crítico 19","dano":"2d6+10 corte"},{"tipo":"Padrão","nome":"Desfazer Sinapses","dano":"3d10+10 Conhecimento + confuso 1 rodada (Vontade DT 20 reduz à metade e evita a condição)","descricao":"Notas dissonantes; alvo em alcance médio."},{"tipo":"Padrão","nome":"Hora do Show (coloca a máscara)","descricao":"+5 ataque, +10 Defesa (total 26), +20 PV atuais/máximos (total 90), DT das habilidades +5, causando dano também causa +2 dados do mesmo tipo, libera Música do Diabo. Arrancar a máscara: perder numa manobra de desarmar (Teste +10) remove a habilidade. Destruir: perder numa manobra de quebrar (Teste +10) causa dano à máscara (RD 10, PV 5); quebrando, remove Hora do Show."},{"tipo":"Padrão","nome":"Ritual Cicatrização Discente (Morte 1)","descricao":"Ser adjacente recupera 5d8+5 PV, mas envelhece 1 ano automaticamente."},{"tipo":"Padrão","nome":"Ritual Proteção Sigilosa (Conhecimento 2)","descricao":"Área de 3m de raio em alcance de toque, sigilos até o fim da cena; ela e aliados na área recebem +5 Defesa, testes de resistência e Furtividade."}]',
  126
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Caio', 80,
  'Vocalista do PSIKOLERA, subserviente e sem vontade própria — encontrou sentido na banda depois de uma vida de irrelevância. Empunha uma espada-microfone.',
  'Médio', '+2◯', '+2◯+5', 17, '+2◯+10', '+2◯+5', '+2◯', 60, 30, null, null,
  '{"agi":2,"for":2,"int":1,"pre":2,"vig":2}', 'Artes +2◯+10, Atletismo +2◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Espada, corpo a corpo x2)","teste":"2◯+10, crítico 19","dano":"2d8+10 corte"},{"tipo":"Padrão","nome":"Berrão","dano":"4d8 impacto + surdo 1 rodada + solta o que segura","descricao":"Finca a espada e grita no ouvido de alvo em alcance de toque; alvo pode largar o item pra tapar os ouvidos (reduz dano à metade e evita a condição)."},{"tipo":"Padrão","nome":"Corte na Jugular","dano":"2d8+10 corte + sangrando (Reflexos DT 20 reduz à metade e evita a condição)","descricao":"Gira a espada-microfone na garganta de adjacente."},{"tipo":"Padrão","nome":"Hora do Show","descricao":"+5 ataque, +10 Defesa (27), +20 PV atuais/máximos (80), DT +5, +2 dados de dano do mesmo tipo, libera Música do Diabo. Arrancar/Destruir a máscara: mesma mecânica de Alê (Teste 2◯+10 pra desarmar; RD 10/PV 5 pra quebrar)."}]',
  127
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Eloy Furtado', 80,
  'Baterista do PSIKOLERA, apartador de discussões, buscou conforto no silêncio da bateria. Máscara em formato de focinheira.',
  'Médio', '+◯', '+2◯+5', 16, '+3◯+10', '+2◯+5', '+◯', 70, 35, null, null,
  '{"agi":1,"for":3,"int":1,"pre":1,"vig":3}', 'Artes +◯+10, Atletismo +3◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo x2)","teste":"3◯+10, crítico 19","dano":"4d4+10 impacto"},{"tipo":"Padrão","nome":"Hora do Show","descricao":"Mesmos bônus dos outros (+5 ataque, +10 Defesa [26], +20 PV [90], DT +5, +2 dados de dano, libera Música do Diabo); arrancar/destruir com Teste 3◯+10."},{"tipo":"Padrão","nome":"Moeller Method","dano":"passando Fortitude DT 20: 2d4+5 impacto; falhando: 4d4+10 impacto + atordoado","descricao":"Ataca adjacente como se fosse um tambor; falhando, permite que Eloy continue batendo (novo teste, mesmo resultado se passar/falhar); repete até o alvo passar ou falhar 3x seguidas."}]',
  128
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Franco', 80,
  'Guitarrista do PSIKOLERA, criança introspectiva de infância negligenciada, fascinado por fogo desde cedo; empunha guitarra que dispara chamas.',
  'Médio', '+◯', '+2◯+5', 16, '+2◯+5', '+2◯+10', '+◯', 55, 27, null, null,
  '{"agi":2,"for":2,"int":1,"pre":1,"vig":2}', 'Acrobacia +2◯+10, Artes +◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Bater com Guitarra, corpo a corpo x2)","teste":"2◯+5","dano":"1d10+5 impacto"},{"tipo":"Padrão","nome":"Hora do Show","descricao":"Mesmos bônus (+5 ataque, +10 Defesa [26], +20 PV [75], DT +5, +2 dados de dano, libera Música do Diabo); arrancar/destruir com Teste 2◯+5."},{"tipo":"Padrão","nome":"Imolar","dano":"10+ no 1d20: 8d6+10 fogo + em chamas (Reflexos DT 20 reduz à metade e evita); 9 ou menos: 4d6 fogo + em chamas no próprio Franco","descricao":"Dispara chamas ao máximo num alvo em alcance curto."},{"tipo":"Padrão","nome":"Incinerar","dano":"6d6+5 fogo + em chamas (Reflexos DT 20 reduz à metade e evita)","descricao":"Dispara chamas da guitarra num alvo em alcance curto."}]',
  129
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Cindy Lopes', 80,
  'Baixista e líder de fato do PSIKOLERA; fez um Pacto de Sangue com Giovanni pra assumir o controle da banda depois de eliminar o antigo vocalista Andrei.',
  'Médio', '+3◯+5', '+3◯+10', 17, '+0', '+3◯+10', '+3◯+5', 50, 25, null, null,
  '{"agi":3,"for":1,"int":2,"pre":3,"vig":1}', 'Artes +3◯+10, Enganação +3◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada com Baixo, corpo a corpo x2)","teste":"◯+10","dano":"1d6+10 impacto"},{"tipo":"Padrão","nome":"Agredir (Disparo com Baixo, distância x2 médio)","teste":"3◯+10, crítico 19/x3","dano":"2d8+10 balístico"},{"tipo":"Padrão","nome":"Hora do Show","descricao":"Mesmos bônus (+5 ataque, +10 Defesa [27], +20 PV [70], DT +5, +2 dados de dano, libera Música do Diabo); arrancar/destruir com Teste +10."},{"tipo":"Padrão","nome":"Silenciar","dano":"2d6 mental + trêmulo 3 rodadas (Vontade DT 20 reduz à metade e reduz duração pra 1 rodada)","descricao":"Sinal de silêncio pra alvo em alcance médio."}]',
  130
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Caíto Rocha', 20,
  'Fã obcecado/rival do PSIKOLERA, mente amargurada que culpa os outros por suas próprias falhas; não é membro oficial da banda, mas ligado à órbita dela pela influência do Sangue.',
  'Médio', '+◯+5', '+2◯+5', 17, '+0', '+2◯+5', '+◯+5', 20, 10, null, null,
  '{"agi":2,"for":1,"int":2,"pre":1,"vig":1}', 'Furtividade +2◯+5', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Disparo de Pistola, distância x2 curto)","teste":"2◯+5, crítico 18","dano":"1d12+5 balístico"},{"tipo":"Completa","nome":"Ódio Suprimido","dano":"falhando Fortitude: caído + 1d4+6 impacto (chute/mordida); falhando Reflexos: 1d12+5 balístico (disparo)","descricao":"Explode de raiva, corre/salta em quem estiver no caminho; todos em alcance curto testam Fortitude E Reflexos (ambos DT 20). Depois da explosão, Caíto cai chorando e trêmulo (fica exausto até o fim da cena)."}]',
  131
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Ana', 100,
  'Enfermeira que teve o coração partido na juventude e jurou nunca mais amar de um jeito "normal" — encontrou em Escarlata (Camila, líder de Os Couraças) uma forma de amor absoluto e obsessivo. Ana é uma seguidora apaixonada, não a líder do culto.',
  'Médio', '+◯+5', '+2◯+5', 27, '+3◯+10', '+2◯+5', '+◯+5', 90, 45, 'Balístico, impacto, perfuração 5, Sangue 10', 'Morte',
  '{"agi":2,"for":3,"int":1,"pre":1,"vig":3}', 'Atletismo +3◯+10', '9m | 6',
  '[{"nome":"Fúria Apaixonada","descricao":"Se Escarlata morrer, 1x/cena até o fim do combate, Ana pode gastar ação padrão pra 3 ataques (2 de maça + 1 de espada) contra quem a matou, cada um +1d10 dano do mesmo tipo."},{"nome":"Paixão Servil","descricao":"Se Ana estiver em alcance curto de Escarlata, +1d6 em todos os testes/rolagens; se Escarlata foi atacada desde a última rodada, bônus sobe pra +1d10."},{"nome":"Rituais (DT 20)","descricao":"Conjura sem pagar PE, até 6 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Maça, corpo a corpo)","teste":"3◯+15, crítico x3","dano":"6d4+10 perfuração"},{"tipo":"Padrão","nome":"Agredir (Espada, corpo a corpo)","teste":"3◯+15, crítico 19","dano":"4d6+10 corte"},{"tipo":"Padrão","nome":"Ritual Hemofagia (Sangue 2)","dano":"6d6 Sangue (Fortitude reduz à metade)","descricao":"Toque; recupera PV = metade do dano causado."}]',
  132
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Torvo (Tadeo)', 20,
  'Ex-marido de Camila/Escarlata; administrador de museu que a traiu com Ana e tentou controlar a relação poliamorosa através de manipulação. Punido — preso numa armadura antiga (a mesma que aprisionou seu bisavô, o professor Boris Fausto, há um século), agora é praticamente um cadáver animado usado como fonte viva de sangue pra rituais.',
  'Médio', '+0', '+0', 21, '+2◯+5', '+0', '+◯+10', 30, 15, 'Balístico, impacto, perfuração 5, Sangue 10', 'Morte',
  '{"agi":1,"for":1,"int":1,"pre":1,"vig":2}', null, '0m | 0',
  '[{"nome":"Fonte de Rituais","descricao":"Se Torvo estiver em alcance curto de Escarlata, ela pode arrancar a vida dele sempre que causar dano com um ritual — o ritual dela causa +2d6 dano do mesmo tipo, e Torvo perde 2d6 PV."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Manopla Espinhenta, corpo a corpo)","teste":"◯+10","dano":"1d6+5 perfuração"}]',
  133
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Escarlata (Camila Perez)', null,
  'Líder verdadeira do culto Os Couraças — ex-bailarina que descobriu prazer em ser desejada por múltiplas pessoas; ao vestir uma das Armaduras de Guevara, ganhou poder de sedução/dominação absoluto sobre seus "asseclas". Traída pelo marido Tadeo, o transformou em Torvo — uma fonte viva de componentes ritualísticos. Nota de extração: o VD dela não aparece explícito no trecho processado (a ficha segue direto da descrição sem o cabeçalho "— VD N" — provável falha de OCR/diagramação); os demais membros do culto vão de VD 20 a 100, então provavelmente fica na faixa 120-160, mas não confirmado no texto.',
  'Médio', '+4◯+10', '+3◯+10', 28, '+2◯+5', '+3◯+5', '+4◯+10', 100, 50, 'Balístico, impacto, perfuração 5, Sangue 10', 'Morte',
  '{"agi":3,"for":2,"int":3,"pre":4,"vig":2}', 'Atletismo +2◯+5, Enganação +4◯+10, Ocultismo +3◯+10', '9m | 6',
  '[{"nome":"Dar o Fora","descricao":"Quem já foi seduzido (habilidade Sedução) pode tentar terminar com ela — testa Vontade (DT 23 + penalidade de 1d8 ou 2d8 de Dominação); passando, os efeitos de Sedução terminam (perde os PE temporários, não afetado por Dominação); falhando, não consegue se livrar dos sentimentos e ainda fica na \"bad\" mental (1d6 dano mental, mais a cada nova tentativa falha)."},{"nome":"Rituais (DT 23)","descricao":"Conjura sem pagar PE, até 7 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Rasgar com Garras, corpo a corpo x2)","teste":"3◯+15, crítico 19","dano":"4d10+10 corte"},{"tipo":"Padrão","nome":"Dominação","descricao":"Ordem a um ser afetado por Sedução; testa Vontade DT 23 — falhando, obedece a ordem da melhor forma possível (se durar mais de 1 rodada, novo teste a cada rodada, +1 cumulativo por teste já feito); passando, anula esse uso; toda vez que falha o teste de resistência, rola 1d8 (\"um pouco a fim\") ou 2d8 (\"muito a fim\") e aplica o resultado como penalidade nesse teste de resistência."},{"tipo":"Padrão","nome":"Ritual Descarnar Discente (Sangue 2)","dano":"10d8 (metade corte/metade Sangue) + hemorragia (Fortitude DT 29 reduz à metade e evita; hemorragia = teste Fortitude DT 23 no início de cada turno, falhar = 4d8 Sangue, 2 sucessos seguidos estanca)","descricao":"Toque."},{"tipo":"Padrão","nome":"Ritual Flagelo de Sangue Discente (Sangue 2)","descricao":"Toque em ser (exceto criaturas de Sangue), grava marca com uma ordem (\"não ataque a mim/meus aliados\", \"siga-me\", \"não saia desta sala\"); dura até o fim da cena; a cada rodada que o alvo desobedece, a marca causa 10d6 dano de Sangue + enjoado 1 rodada (Fortitude DT 23 reduz o dano à metade e evita a condição); 2 sucessos seguidos faz a marca desaparecer."},{"tipo":"Padrão","nome":"Ritual Hemofagia Discente (Sangue 2)","dano":"+6d6 Sangue","descricao":"Ataque de garras como parte da execução; acertando, recupera PV = metade do dano total causado."},{"tipo":"Padrão","nome":"Sedução","descricao":"\"Você parece forte...\"; o alvo decide como se sente — não ficou a fim (nenhum efeito); ficou um pouco a fim (+1d8 PE temporários, mas suscetível a Dominação); ficou muito a fim (+2d8 PE temporários, mesma suscetibilidade); efeitos duram até o alvo usar Dar o Fora."}]',
  134
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Argano (Zacarías)', 100,
  'Rico e arrogante jogador de MMORPG que se apaixonou obsessivamente por Escarlata; usa uma armadura pesada de guerreiro medieval que ele mesmo criou/programou, virando seu "guardião" fanático.',
  'Médio', '-2◯', '+◯+5', 26, '+4◯+10', '+◯+5', '-2◯', 120, 60, 'Balístico, impacto, perfuração 5, Sangue 10', 'Morte',
  '{"agi":1,"for":4,"int":1,"pre":0,"vig":4}', 'Atletismo +4◯+10', '9m | 6',
  '[{"nome":"Guardião","descricao":"1x/rodada, se estiver em alcance curto de Escarlata, sofre um dano direcionado a ela (redireciona pra si)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Maça Pesada, corpo a corpo)","teste":"4◯+15, crítico x3","dano":"4d8+20 perfuração"},{"tipo":"Padrão","nome":"Erguer Maça","descricao":"Não faz nada por si só, mas libera Golpe Arrasador."},{"tipo":"Padrão","nome":"Golpe Arrasador (após Erguer Maça)","dano":"4d12+20 perfuração (Fortitude DT 21 reduz à metade)","descricao":"Golpe de cima pra baixo num adjacente."},{"tipo":"Completa","nome":"Esmagar Ossos","dano":"4d10+20 perfuração + fraco por 1 dia (Reflexos DT 21 reduz à metade e evita a condição)","descricao":"Passa por cima de um ser em alcance curto usando o peso da armadura; só usável em alvo caído ou atordoado."}]',
  135
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Chispa', 100,
  'Mecânico mexicano que perdeu as pernas e o irmão num acidente de carro; reconstruiu-se com um triciclo motorizado alimentado por combustível paranormal, seduzido por Escarlata numa competição de corridas.',
  'Médio', '+◯+10', '+3◯+5', 26, '+◯+5', '+3◯+10', '+◯+10', 90, 45, 'Balístico, impacto, perfuração 5, Sangue 10', 'Morte',
  '{"agi":3,"for":1,"int":4,"pre":1,"vig":1}', 'Pilotagem +3◯+10, Tecnologia +4◯+10', '15m | 10',
  '[{"nome":"Motor Frágil","descricao":"O motor traseiro do triciclo pode ser atacado separadamente — ataques contra ele sofrem -1d20 (alvo pequeno e em movimento constante); Defesa 26, RD 5, PV 20; destruído, explode em nuvem de fumaça, 4d6 dano (metade perfuração/metade fogo) em Chispa, que fica imóvel + desprevenido + perde Acelerar e Investida com Lança até consertar (1d4+1 horas)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Tiro de Escopeta, distância curto)","teste":"3◯+15, crítico x3","dano":"6d6+20 balístico"},{"tipo":"Reação","nome":"Acelerar","descricao":"1x/rodada, esquiva com o triciclo: +5 Defesa e testes de resistência contra um ataque/efeito."},{"tipo":"Padrão","nome":"Granada Flamejante","dano":"6d6 fogo + em chamas (Reflexos DT 21 reduz à metade e evita)","descricao":"Dispositivo explosivo em alcance curto, 3m de raio."},{"tipo":"Completa","nome":"Investida com Lança","dano":"6d8+20 perfuração se trespassado","descricao":"Acelera até alvo em alcance médio pra atravessá-lo; alvo escolhe saltar pra fora (Reflexos DT 21 — passa e escapa; falha = trespassado) ou resistir (pode atacar/agir contra Chispa antes de ser trespassado — atacando, resolve o ataque normalmente e depois sofre o dano; tentando outra ação como subir no triciclo, testa perícia DT 21 — passando consegue o que queria mas ainda é trespassado; falhando, só é trespassado)."}]',
  136
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Miasma', 40,
  'Ex-estudante de medicina que descobriu prazer sádico em dissecação e depois em causar dor real; expulso de vários lugares por ultrapassar limites, encontrou em Escarlata uma figura que finalmente o dominou de volta.',
  'Médio', '+◯', '+2◯+5', 18, '+2◯+5', '+2◯', '+◯', 30, 15, null, null,
  '{"agi":2,"for":2,"int":1,"pre":1,"vig":2}', null, '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Golpe com Correntes, corpo a corpo)","teste":"2◯+5","dano":"2d8+5 impacto"},{"tipo":"Padrão","nome":"Despertar Obsessão","descricao":"Encara alguém em alcance curto — alvo escolhe desviar o olhar (Miasma dá correntada mesmo à distância: 2d8+5 dano de impacto) ou encarar (testa Vontade DT 25; passando, nada acontece; falhando, gasta 1 rodada de ações se aproximando de Escarlata pra adorá-la, ou — se recusar — deve atacar a si mesmo uma vez, encerrando o efeito)."}]',
  137
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Coruja (Cecília Clemm)', 40,
  'De família simples de Catalão-GO, do grupo Os Pássaros; cuidou da mãe doente na adolescência. Pesquisadora que trouxe rumos inesperados ao grupo com seus estudos de rituais.',
  'Médio', '+2◯+10', '+3◯+10', 19, '+0', '+3◯+10', '+2◯+5', 50, 25, null, null,
  '{"agi":3,"for":1,"int":3,"pre":2,"vig":1}', 'Adestramento +2◯+10, Atualidades +3◯+10, Ciências +3◯+10, Furtividade +3◯+10, Sobrevivência +3◯+10', '9m | 6',
  '[{"nome":"Validação de Hipótese","descricao":"Acerto crítico dá +1d10 em testes contra o mesmo alvo."},{"nome":"Rituais (DT 20)","descricao":"Conjura sem pagar PE, até 4 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Tiro de Zarabatana, distância curto)","teste":"3◯+10, crítico 19","dano":"1d4+1 perfuração + sedativo","descricao":"Dardos Sedativos: alvo atingido fica sedado/inconsciente até acordar ou fim da cena (Fortitude DT 20 evita)."},{"tipo":"Padrão","nome":"Ritual Aprimorar Físico (Sangue 2)","descricao":"Toque, alvo +1 Agilidade ou Força (à escolha dele) até o fim da cena."},{"tipo":"Padrão","nome":"Ritual Aprimorar Mente (Conhecimento 2)","descricao":"Toque, alvo +1 Intelecto ou Presença (à escolha dele) até o fim da cena."}]',
  138
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Corvo', 40,
  'Nascido em Recreio-RJ, do grupo Os Pássaros; ilusionista/ocultista discreto, ligado à morte simbolicamente mesmo em vida.',
  'Médio', '+2◯+10', '+3◯+10', 18, '+◯+5', '+2◯+5', '+3◯+10', 60, 30, null, null,
  '{"agi":2,"for":1,"int":3,"pre":3,"vig":1}', 'Adestramento +3◯+10, Atualidades +3◯+10, Furtividade +3◯+10, Ocultismo +3◯+10, Sobrevivência +3◯+10', '9m | 6',
  '[{"nome":"Silêncio Fúnebre","descricao":"Quando morto, o corpo recebe 30 PV temporários e vira mau agouro — testes contra aliados de Corvo num raio de 30m do corpo sofrem -2◯; dura até o fim da cena ou os PV temporários zerarem."},{"nome":"Rituais (DT 20)","descricao":"Conjura sem pagar PE, até 4 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo)","teste":"◯+5","dano":"1d4+5 impacto"},{"tipo":"Livre","nome":"Ritual Esconder os Olhos (Conhecimento 1)","descricao":"Fica invisível 1 rodada (com equipamento), camuflagem total + 15 Furtividade; termina ao atacar/usar habilidade hostil."},{"tipo":"Padrão","nome":"Ritual Cicatrização Discente (Morte 1)","descricao":"Adjacente recupera 5d8+5 PV, envelhece 1 ano."},{"tipo":"Padrão","nome":"Ritual Definhar Discente (Morte 1)","descricao":"Rajada de cinzas em alvo de alcance curto: exausto até o fim da cena (Fortitude DT 15 reduz pra fatigado)."},{"tipo":"Padrão","nome":"Ritual Tecer Ilusão Discente (Conhecimento 1)","descricao":"Ilusão em alcance médio, até 8 cubos de 1,5m, até o fim da cena; visual/sonora/tátil/térmica/olfativa simples (sem sons complexos como música/diálogo); dissipa se sair do alcance."}]',
  139
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Papagaio (Rogério José)', 40,
  'Nascido e criado no Rio de Janeiro, do grupo Os Pássaros; carismático líder de fato do grupo, guiava com palavras e conexões.',
  'Médio', '+3◯+10', '+2◯+10', 21, '+◯+5', '+2◯+5', '+3◯+10', 60, 30, null, null,
  '{"agi":2,"for":2,"int":1,"pre":3,"vig":2}', 'Adestramento +3◯+10, Artes +3◯+5, Crime +2◯+10, Diplomacia +3◯+10, Enganação +3◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Garrafada, corpo a corpo x2)","teste":"2◯+10","dano":"1d4+10 impacto"},{"tipo":"Padrão","nome":"Cachimbo do Capeta","descricao":"Sopra fumaça num adjacente: asfixiado, gasta ação padrão pra recuperar o fôlego (Fortitude DT 20 evita)."},{"tipo":"Livre","nome":"Desarmar","teste":"2◯+15","descricao":"Acertando ataque de garrafa, tenta desarmar o alvo."}]',
  140
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Pomba', 40,
  'Cartógrafa/navegadora do grupo Os Pássaros, desenhava mapas com cuidado extremo pra garantir que ninguém se perdesse.',
  'Médio', '+2◯+10', '+2◯+5', 20, '+2◯+5', '+2◯+5', '+2◯+10', 50, 25, null, null,
  '{"agi":2,"for":1,"int":3,"pre":3,"vig":1}', 'Percepção +2◯+10, Intuição +2◯+10, Atletismo +◯+15, Investigação +2◯+10, Sobrevivência +2◯+5, Pilotagem +2◯+5, Furtividade +2◯+5, Ciências +2◯+10', '9m | 6',
  '[{"nome":"Ensinamentos do Ninho","descricao":"Ao presenciar a morte de um aliado, até o fim da cena pode usar qualquer habilidade conhecida por ele 1x."},{"nome":"Voe para Longe","descricao":"Na 1ª rodada de combate, pode se mover até o dobro do deslocamento com uma única ação de movimento."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Canivete, corpo a corpo x2)","teste":"2◯+10","dano":"1d4+5 corte"}]',
  141
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Harpia (Santiago Luis Borges)', 80,
  'Uruguaio de origem humilde, do grupo Os Pássaros, treinado em colégio militar; adestrador de aves de rapina, o "músculo" tático do grupo.',
  'Médio', '+2◯+10', '+3◯+10', 22, '+3◯+10', '+3◯+10', '+2◯+5', 100, 50, null, null,
  '{"agi":3,"for":3,"int":2,"pre":2,"vig":3}', 'Adestramento +2◯+10, Atletismo +3◯+10, Furtividade +3◯+10, Sobrevivência +2◯+10, Tática +2◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Garra do Harpia, corpo a corpo x2)","teste":"3◯+10, crítico 19","dano":"2d8+10 corte"},{"tipo":"Padrão","nome":"Agredir (Pistola, distância x2 curto)","teste":"3◯+10, crítico 18","dano":"1d12+10 balístico"},{"tipo":"Livre","nome":"Agarrar","teste":"3◯+15","descricao":"Acertando garra, tenta agarrar."},{"tipo":"Livre","nome":"Assobio do Harpia","descricao":"1x/rodada, aves adestradas avançam num alvo em alcance longo — escolhe um efeito: Cegar (3d6 dano de perfuração + cego 1 rodada, Reflexos DT 20 reduz à metade e evita); Distrair (pasmo 1 rodada, Vontade DT 20 evita, só 1x/cena por alvo); Sangrar (5d6 dano de perfuração + sangrando, Fortitude DT 20 reduz à metade e evita)."}]',
  142
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mundana', 'Pessoa', 'Suellen', 20,
  'Antagonista ligada à história de Os Pássaros — cria dependência através de prazer/hedonismo induzido; usa "matrizes" (mães mantidas em cativeiro) pra fins não detalhados nesta extração.',
  'Médio', '+2◯+5', '+1◯+5', 15, '+2◯+5', '+2◯+5', '+2◯+5', 30, 15, null, null,
  '{"agi":1,"for":2,"int":2,"pre":2,"vig":2}', 'Adestramento +2◯+10, Atualidades +2◯+10, Enganação +2◯+10', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Golpe com Cutelo, corpo a corpo)","teste":"2◯+5","dano":"1d8+5 corte"},{"tipo":"Padrão","nome":"Estimular Hedonismo","descricao":"Pessoa em alcance curto tomada por onda de prazer insano; Vontade DT 20 evita; falhando, todos os sentidos/alertas biológicos (reflexo de urgência, dor) só transmitem prazer/euforia — perde autopreservação, fica indefeso 1 rodada."}]',
  143
);
