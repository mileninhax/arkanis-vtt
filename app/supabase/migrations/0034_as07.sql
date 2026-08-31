-- Arquivos Secretos 07 (temas Vampyrus + Terribilis Fides) — fecha o catálogo dos 7 pacotes.

insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_07'), 'Cajado da Cruz de Sangue', 'Arma simples corpo a corpo duas mãos, 1d12 corte crítico 20/x2, ágil (funciona com Combater com Duas Armas); se usuário for ocultista com ritual de Sangue: rituais/poderes de Sangue -1 PE custo, +1 DT, +1 dado de dano.', 'III', 2),
((select id from sources where slug = 'arquivos_secretos_07'), 'Terço Maculado', 'Vestimenta. Herda súplica reprimida (definida pelo mestre); agir a favor dela = +2d10 no teste; não pode remover enquanto vivo (falha automática + 2d10 PV perdido se tentar); agir contra a súplica também -2d10 PV; remove-se decepando a parte do corpo, ou cumprindo a súplica (vira mundano).', 'II', 1);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
((select id from sources where slug = 'arquivos_secretos_07'), 'paranormal', 'Carranca Caçadora', 'II', 2, 'Coloca material de criatura na boca dela → olhos apontam pro caminho até a criatura (10min, depois consome o material, só funciona 1x por criatura).', '{}'),
((select id from sources where slug = 'arquivos_secretos_07'), 'paranormal', 'Pé de Coelho', 'I', 1, 'Vestimenta. 1x/cena, ação de movimento, +1d4 em todos os testes até fim da cena; se d4 ímpar, -1d4 PV (acidente).', '{}'),
((select id from sources where slug = 'arquivos_secretos_07'), 'paranormal', 'Sal Dourado', 'I', 1, 'Forma linha em porta/janela (3 usos) ou círculo (1 uso); criatura de Sangue VD≤80 cruzando testa Vontade DT 20 — passa=frustrado até fim cena mas cruza; falha=frustrado e não cruza.', '{}');

insert into origins (source_id, name, skill_1_id, skill_2_id, power_name, power_description, description, sort_order)
values
((select id from sources where slug = 'arquivos_secretos_07'), 'Exorcizado', (select id from skills where name = 'Fortitude'), (select id from skills where name = 'Ocultismo'), 'O Que Restou', 'Escolhe elemento (exceto Medo), resistência a dano 5 contra ele; mas -2 Sanidade na 1ª exposição a esse elemento por cena.', null, 1),
((select id from sources where slug = 'arquivos_secretos_07'), 'Sensitivo Rebelde', (select id from skills where name = 'Intuição'), (select id from skills where name = 'Vontade'), 'Sussurros e Vultos', 'Diplomacia/Enganação/Intimidação/Intuição, -2 Sanidade pra +5 no teste.', null, 2);

-- Trilha "Monstruoso" — variante de Especialista (usa Progressão de NEX opcional mesmo sem a
-- regra ativa; com Nível de Experiência ativo, ganha NEX em dobro). Habilidade central
-- consome componente ritualístico 1x/dia pra curar PV + efeitos por elemento.
insert into class_tracks (class_id, slug, name, description, sort_order)
values ((select id from classes where slug = 'especialista'), 'monstruoso_variante', 'Monstruoso (variante)', 'Variante da trilha Monstruoso de Sobrevivendo ao Horror, adaptada pro Especialista. Habilidade central "Ser Experimentado/Testado/Expurgado/Apavorante": 1x/dia, ação completa, consome componente ritualístico de 1 elemento escolhido → cura PV + efeitos até fim do dia; sem fazer, sofre como fome/sede. Penalidade social cresce por tier.', 11);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'monstruoso_variante' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Ser Experimentado (recupera 1d8+1 PV)', 'Treina Ocultismo. Efeitos por elemento: Sangue (Grande, +2/-2 manobra/Furtividade, soma For em testes For, PE por For); Morte (+2d6 PV temp, ação padrão extra/cena, soma Vig, PE por Vig); Conhecimento (2 perícias treinadas, soma Int, PE por Int); Energia (saca item livre 1x/rodada, +6m deslocamento, soma Agi, PE por Agi).'),
  (40, 'Ser Testado (recupera 2d8+2 PV)', 'Sangue (+1d6 dano Sangue+RD2; devora Intelecto→+1d6 dano/+2 RD por ponto); Morte (+1 turno morrendo, +2d8 PV temp/cena; necrosa Força→mais turnos+PV temp por ponto); Conhecimento (+1d6 testes Intelecto; inexiste Agilidade→+1d6 por ponto); Energia (+1d6 ataque, +2 Defesa; queima Vigor→+1d6/+2 Defesa por ponto).'),
  (65, 'Ser Expurgado (recupera 3d8+3 PV, braço substituído)', 'Sangue (+1 Força, +1d8 ataque corpo a corpo, 1 PE pra ataque desarmado extra); Morte (+1 Vigor, 3 PE toca item pra envelhecer [50 dano Morte] ou ver o passado dele); Conhecimento (+1 Intelecto, 3 PE+ação completa toca cabeça pra Detecção de Ameaças discente[self] ou Mergulho Mental 3 rodadas [outro]); Energia (+1 Agilidade, 2 PE+movimento pra atravessar sólidos até fim cena).'),
  (99, 'Ser Apavorante (recupera 4d8+4 PV)', 'Sangue (Enorme +5/-5, soma For, PE por For, +1 For, ritual Vínculo de Sangue); Morte (+4d6 PV temp, 2 ações padrão extra/cena, soma Vig, PE por Vig, +1 Vig, ritual Distorção Temporal); Conhecimento (3 perícias expert, soma Int, PE por Int, +1 Int, ritual Controle Mental); Energia (saca item livre 3x/rodada, +12m deslocamento, soma Agi, PE por Agi, +1 Agi, ritual Teletransporte).')
) as v(nex, name, description);

-- Trilha "Monstruoso" — variante de Ocultista (escarificação em vez de consumir componente).
insert into class_tracks (class_id, slug, name, description, sort_order)
values ((select id from classes where slug = 'ocultista'), 'monstruoso_variante', 'Monstruoso (variante)', 'Mesma base da variante de Especialista, mas por escarificação: "Ser Escarificado/Perfurado/Rasgado/Mutilado".', 11);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'monstruoso_variante' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Ser Escarificado (recupera 1d4 PE)', '+2 Ocultismo, escolhe elemento; escarificação diária (ação completa, consome componente).'),
  (40, 'Ser Perfurado (recupera 1d6 PE)', 'Ganha Tatuagem Ritualística (aplicada a TODOS os rituais do elemento marcados na pele, não só alcance pessoal); 1x/cena conjura ritual marcado como reação SE sob condição específica por elemento (Sangue=machucado/fadiga; Morte=morrendo/sentidos; Conhecimento=mental/medo; Energia=paralisia/sentidos); +5 concentração em rituais marcados desse elemento.'),
  (65, 'Ser Rasgado (recupera 1d8 PE, Presença -1 permanente)', 'Sangue (ritual de Sangue: move+2d8+2 PV pra aliado beber=+1d20 For/Agi/Vig até fim cena; DT rituais marcados+2); Morte (aprende/reduz -1 PE Cicatrização; outro ritual Morte conjura Cicatrização como movimento; DT+2); Conhecimento (ritual de Conhecimento: movimento+2 PE=5 perguntas sim/não sobre alvo, ou visão incorpóreo/invisível se alvo=você; DT+2); Energia (ritual de Energia: movimento+3 PE teleporta 3m+Defesa=PE gasto por 1 rodada; DT+2).'),
  (99, 'Ser Mutilado (recupera 1d12 PE, Presença -1 permanente)', 'Conjura rituais marcados do elemento sem fala/gestos/componentes; +1 no atributo do elemento; aprende 1 ritual do elemento 4º círculo + 1 ritual de Medo 4º círculo à escolha (o de Medo herda os benefícios da trilha como se fosse do elemento escolhido).')
) as v(nex, name, description);
