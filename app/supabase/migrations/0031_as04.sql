-- Arquivos Secretos 04 (tema Energia).

insert into origins (source_id, name, skill_1_id, skill_2_id, power_name, power_description, description, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'Influencer Paranormal',
  (select id from skills where name = 'Enganação'), (select id from skills where name = 'Tecnologia'),
  'Registrar o Paranormal', '1x/cena, ação padrão + 2 PE registra (foto/vídeo) criatura/ritual visto na cena; +5 contra Presença Perturbadora de criaturas já registradas; ação de interlúdio memoriza 1 ritual registrado, conjurável até a próxima cena de interlúdio (círculo limitado pelo NEX: 1º a partir de 5%, 2º 25%, 3º 55%, 4º 85%).',
  null, 1
),
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'Caçador de Recompensas',
  (select id from skills where name = 'Crime'), (select id from skills where name = 'Investigação'),
  'Quem Não Arrisca, Não Petisca', '+2 vs. condições mentais/medo; falhando, +1d20 no próximo teste (até fim da cena, não cumulativo).',
  null, 2
);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'combatente'), v.name, v.description, v.prereq, v.ord from (values
  ('Chuva de Balas', 'Pacotes de munição duram 2x por cena; ao atacar com arma de fogo, sacrifica pacote(s) inteiros pra +2 dados de dano por pacote (antes de rolar); com contagem de munição, +10 balas por pacote.', null, 33),
  ('Combatente Esforçado', '+1 PE por NEX.', 'For 3 ou Vig 3', 34),
  ('Treinamento Militarizado', 'Bônus de exercitar-se em interlúdio vira +1d8, usável em rolagem de dano também (só um bônus por rolagem).', null, 35)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'especialista'), v.name, v.description, v.prereq, v.ord from (values
  ('Análise Conturbada', 'Cena de investigação, ação padrão; voluntários presentes rolam 1d6, ganham esse bônus em testes de Int/Pre até fim da cena, mas perdem o mesmo valor em Sanidade.', null, 29),
  ('Profissão Perigo', 'Ação completa + 4 PE desmonta um item do inventário, cria item operacional novo (categoria/espaços ≤ original). 1x/missão.', null, 30),
  ('Quase Novo', 'Ação de manutenção (Fabricação em Campo) dá +10 PV extra ao item reparado; ou adiciona modificação temporária até a próxima cena de interlúdio.', null, 31)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Explorador da Névoa', '1x/cena, 2 PE, percebe estado da Membrana; se danificada+, perde 1 SAN mas -1 PE no custo de todos os rituais.', null, 32),
  ('Sinestesia Paranormal', 'Em área com Membrana danificada+, pode aceitar sinestesia (perde 1d6 SAN) e trocar o atributo-base de até 2 pares de perícias entre si; dura até sair da área, só reaceita no dia seguinte.', null, 33)
) as v(name, description, prereq, ord);

insert into general_powers (source_id, name, description, prerequisites)
select (select id from sources where slug = 'arquivos_secretos_04'), v.name, v.description, v.prereq from (values
  ('Gororoba', '1x/interlúdio, alimenta-se sem gastar ação/refeição de verdade.', null),
  ('Ruído Branco', 'Em ambiente movimentado, +1d6 Investigação/Percepção; 1x/cena, 1 PE pra info útil ouvida no ruído (critério do mestre).', null),
  ('Uma Última Olhada', '1x/cena, na última rodada de investigação, 2 PE pra +1 rodada disponível.', null),
  ('Terrores Noturnos', 'Ao dormir, 1d100 ≤50 = pesadelo (descanso vira precário, -1d4 SAN) mas escolhe 1 poder paranormal/ritual (cumprindo pré-requisitos) usável 1x até a próxima cena de interlúdio.', null)
) as v(name, description, prereq);

insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
values
((select id from sources where slug = 'arquivos_secretos_04'), 'energia', 'Foco Gravitacional', 'Escolhe um equipamento; ocupa 0 espaços guardado; ao empunhar, 25% de sair voando e cair em espaço aleatório em alcance curto.', 'Aplica a até 3 equipamentos.', null),
((select id from sources where slug = 'arquivos_secretos_04'), 'energia', 'Sobrepor Imprevisível', '2 PE no início do turno, 1d20 — par soma à Iniciativa, ímpar subtrai; reordena a iniciativa.', 'Rola 2d20, escolhe.', null),
((select id from sources where slug = 'arquivos_secretos_04'), 'energia', 'Traço de Inconsistência', 'Reação, 2 PE, esconde-se de câmeras/fotos no momento do registro.', 'Permanente + voz distorcida em gravações.', null);

insert into rituals (source_id, name, elemento, circle, execution, range, target, duration, effect, discente_cost, discente_effect, discente_requires_circle, verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, verdadeiro_requires_affinity)
values
((select id from sources where slug = 'arquivos_secretos_04'), 'Backup', 'energia', 2, 'padrão', 'curto', 'veja texto', '24h',
 'Cria cópia de Energia com sua aparência (movimentos simples + 1 frase); conectada a você em raio de 50km; reação pra trocar de lugar com ela (perde 2d4 SAN); dissipa se sofrer dano ou você sair da área.',
 2, 'Duração permanente; cobrir olhos/ouvidos (ação padrão) alterna percepção entre corpo e cópia (fica cego/surdo/pasmo enquanto isso). Requer 2º círculo.', 2,
 5, 'Como Discente + pode falar pela cópia e mudar a aparência dela; ao trocar de lugar, pode dissipar o ritual causando 6d6 dano de Energia (Reflexos reduz à metade) nos dois pontos. Requer 3º círculo.', 3, false);

insert into class_tracks (class_id, slug, name, description, sort_order)
values ((select id from classes where slug = 'especialista'), 'granadeiro_blaster', 'Granadeiro Blaster', 'Especialista em explosivos autorais.', 9);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'granadeiro_blaster'), v.nex, v.name, v.description from (values
  (10, 'Meus Bebês', 'Treina (ou +5) Profissão (químico); começa com 1 explosivo autoral (não conta no limite); +1 explosivo autoral inicial em NEX 40/65/99%. Explosivos autorais = fabricados via Fabricação em Campo.'),
  (40, 'Fogo Amigo', 'Ganha Perito em Explosivos (ou dobra o bônus dele se repetir, 1x); área dos seus explosivos +6m.'),
  (65, 'O Calor do Momento', 'Ação completa + 4 PE fabrica explosivo autoral improvisado (25% de chance de explodir na mão ao usar).'),
  (99, 'Memória Muscular', 'Qualquer um empunha seus explosivos autorais como ação livre; 4 PE pra usar como ação de movimento; dano dobrado.')
) as v(nex, name, description);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
((select id from sources where slug = 'arquivos_secretos_04'), 'geral', 'Granada de Gás Lacrimogêneo', 'I', 1, 'Raio 6m, 4d6 químico + enjoado + dificuldade de respirar (Fortitude DT Agi reduz à metade e evita enjoado); após sair, +1d4 rodadas de dificuldade de respirar.', '{"tipo":"granada"}'),
((select id from sources where slug = 'arquivos_secretos_04'), 'geral', 'Granada de Tinta', '0', 1, 'Raio 6m, vulnerável + -2d20 Furtividade até fim da cena (Reflexos DT Agi evita).', '{"tipo":"granada"}'),
((select id from sources where slug = 'arquivos_secretos_04'), 'arma', 'Lançador de Granadas', 'II', 2, 'Fogo pesada, duas mãos, alcance longo, 6 granadas 40mm; recarga 1 granada = ação de movimento; dispara com teste de ataque (alvo direto) ou ponto livre (todos na área testam resistência).', '{"proficiencia":"pesadas","empunhadura":"duas_maos","natureza":"fogo","alcance":"longo"}');

insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_04'), 'Granada Ctrl+C Ctrl+V', 'Energia. Raio 6m, 8d6 Energia (Reflexos DT Agi reduz à metade); 1d4 par = gera 2ª granada idêntica noutro ponto da área, repete até 4ª explosão ou ímpar.', 'II', 1);

insert into weapon_mods (source_id, name, applies_to, effect)
values
((select id from sources where slug = 'arquivos_secretos_04'), 'Adesiva', 'granadas', 'Gruda no alvo/espaço; falha automática em resistência se grudada em ser.'),
((select id from sources where slug = 'arquivos_secretos_04'), 'Dupla', 'granadas', 'Soma efeito de outra granada.'),
((select id from sources where slug = 'arquivos_secretos_04'), 'Programada', 'granadas', 'Temporizador em turnos.');

insert into extra_rules (source_id, category, title, content, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'mecanicas_de_cena', 'Hacking (mini-sistema)',
  'Sistema abstrato pra cenas de hacking, com turnos/rodadas. Sistema tem PS (Pontos de Segurança) = DT de Hackear (ex. DT25 = 25 PS); zerar PS = invasão bem-sucedida. Agente treinado em Tecnologia + aparelho conectável gera dados virtuais (d6) = valor de Intelecto, gastos pra ações.

Ações por turno (até 2, conforme grau de treinamento):
- Procurar Brechas (treinado): Tecnologia DT 15 (+5 por tentativa); sucesso = +1 dado virtual.
- Quebrar Códigos (treinado): gasta dados virtuais à escolha, soma = dano aos PS.
- Cobrir Rastros (veterano): Tecnologia DT = PS máximos do sistema; sucesso permite rerrolar 1s na próxima rolagem de dados virtuais.
- Programar Backdoor (veterano): gasta 1+ dados sem rolar; cada dado = 1 acesso futuro sem novo hacking.
- Plantar Vírus (expert): gasta 1 dado sem rolar; vírus espião notifica você de interações futuras; 1d4=1 no momento de qualquer interação = vírus removido pelo firewall.

Imprevistos Digitais (fim de cada rodada, baseado em quantos 1s saíram nos dados virtuais gastos, máx. 4): Dor nos Pulsos (-2 Tecnologia próxima rodada), Código Mal Escrito (perde 1 dado virtual próximo turno), Rastro Detectado (sistema recupera 2d6 PS), Invasão Detectada (perde todo o progresso, sistema recupera todos os PS).',
  9
);
