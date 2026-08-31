-- Bestiário Arquivos Secretos 05 — Os Alheios (criaturas de Transmissão, elemento
-- combinado Energia+Conhemento, tema TV Varminho): Hospedeiro Parasitado/Aflorado,
-- Interflorado, Fummu, Doppelganger (3 variantes), Bilu, Rastropoda, Memoflígico.

insert into creatures (source_id, categoria, name, vd, flavor_text, descritores, tamanho, presenca_dt, presenca_dano, presenca_nex_imune, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, vulnerabilidades, atributos, pericias, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Hospedeiro Parasitado', 20,
  'Pessoa infectada por um Interflorado — sangue vira plasma verde, dificuldade com cores, pisca um olho por vez. Expelir o parasita sem sofrer dano exige choque térmico forte (aquecer + água gelada); aí "afloroa" e vira um Hospedeiro Aflorado. 4 variantes possíveis: Acólito (INT/PRE 2, Ocultismo/Percepção/Religião/Vontade 2d20+5, conjura 2 rituais de 1º círculo grátis até 3 PE, DT 15); Faz-Tudo (+1 em 2 atributos, +5 em 4 perícias escolhidas, 1 perícia rola 2x e fica com o melhor resultado); Guerrilheiro (AGI/FOR/VIG 2, PV 20/10, Atletismo/Fortitude/Iniciativa/Reflexos 2d20+5, pancada 2d20+10/1d4+10, pistola 2d20+10/1d12+10); Socorrista (INT/PRE 2, Medicina/Percepção/Vontade 2d20+5, 1x/cena cura 1d8+1 PV).',
  '{Energia,Conhecimento}', 'Médio', null, null, null, '+1d20+5', '+1d20+5', 15, '+1d20+5', '+1d20+5', '+1d20+5', 10, 5, null, null,
  '{"agi":1,"for":1,"int":1,"pre":1,"vig":1}', null, '9m | 6',
  '[{"nome":"Parasitado","descricao":"Infectado por interflorado; ver flavor_text pra variantes disponíveis (Acólito, Faz-Tudo, Guerrilheiro, Socorrista)."}]',
  '[{"tipo":"Padrão","nome":"Pancada, corpo a corpo","teste":"1d20+5","dano":"1d4+5 impacto"}]',
  150
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Hospedeiro Aflorado', 60,
  'Estágio seguinte do Hospedeiro Parasitado, após "aflorar".',
  '{Energia,Conhecimento}', 'Médio', 19, '3d6 mental', 35, '2d20 (Percepção às Cegas, Visão no Escuro)', '2d20+5', 25, '3d20+10', '2d20+5', '2d20', 100, 50, 'Balístico, corte, impacto e perfuração 5, Conhecimento/Energia/químico 10', 'Fogo, frio e Sangue',
  '{"agi":2,"for":2,"int":1,"pre":2,"vig":3}', null, '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Pancada, corpo a corpo x2","teste":"2d20+10","dano":"1d6+5 impacto + 2d6 químico"},{"tipo":"Movimento","nome":"Disparada Errante","descricao":"2x deslocamento, Acrobacia DT 20 ou cai."},{"tipo":"Padrão","nome":"Guinchou Gutural","dano":"5d10 (metade Conhecimento/metade Energia)","descricao":"9m raio; tapar ouvidos = metade dano + surdo 1 rodada; não tapar = dano cheio + surdo 1d4+1 rodadas."}]',
  151
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Interflorado', 40,
  'Forma que incuba dentro de hospedeiros e os transforma.',
  '{Energia,Conhecimento}', 'Pequeno', 15, '2d8 mental', 30, '+1d20+5 (Visão no Escuro)', '2d20+5', 19, '+0', '2d20+5', '+1d20+5', 70, 35, 'Balístico, corte, impacto e perfuração 5, Conhecimento/Energia/químico 10', 'Fogo, frio e Sangue',
  '{"agi":2,"for":2,"int":1,"pre":1,"vig":null}', 'Acrobacia/Atletismo 2d20+5, Furtividade 2d20+10', null,
  '[]',
  '[{"tipo":"Movimento","nome":"Contorcer Perturbador","dano":"2d8 mental + apavorado + trêmulo (Vontade DT 15 reduz à metade/evita, mas fica abalado)","descricao":"Imune 1 dia se passar."},{"tipo":"Padrão","nome":"Guincho Gutural","descricao":"Igual ao do Aflorado."},{"tipo":"Completa","nome":"Incubar","descricao":"Após 1 dia num hospedeiro, 1x/dia, incuba 1 ovo (máx 2d4/hospedeiro, -1d6 Sanidade máx permanente por ovo); estourar mata o hospedeiro, gera novos interflorados."},{"tipo":"Completa","nome":"Investida Sufocante","teste":"2d20+10","descricao":"2x deslocamento + agarrar; vitorioso deixa o alvo agarrado/cego/surdo/asfixiado; inconsciente = vira Hospedeiro Parasitado."}]',
  152
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Fummu', 100,
  'Criatura de Transmissão dos Alheios.',
  '{Energia,Conhecimento}', 'Médio', 21, '4d6 mental', 45, '2d20+5 (Visão no Escuro)', '3d20+10', 25, '2d20', '3d20+10', '2d20+5', 200, 100, 'Balístico, corte, impacto e perfuração 10, Conhecimento/Energia/químico 20; imune a fogo', 'Sangue',
  '{"agi":3,"for":2,"int":2,"pre":2,"vig":2}', 'Atletismo 2d20+10, Furtividade 3d20+10', null,
  '[{"nome":"Camuflagem Alheia","descricao":"Invisível, +15 Furtividade vs. ouvir, quem não vê fica desprevenido; +2d20 ataques vs. não-cegos (cegos -5 Defesa); perde invisibilidade em gás/fumaça (fica camuflagem leve)."},{"nome":"Chamas Ferventes","descricao":"Quem agarra sofre 2d10 fogo/rodada."}]',
  '[{"tipo":"Padrão","nome":"Toque Ácido, corpo a corpo x2","teste":"3d20+15","dano":"2d10+10 químico"},{"tipo":"Movimento","nome":"Cintilação Estelar","descricao":"1x/rodada se não agarrado, teleporta 9m."},{"tipo":"Padrão","nome":"Acionar Explosão","dano":"Minúsculo = 2d6 fogo + chamas raio 3m, +2d6/+1,5m por categoria de tamanho acima","descricao":"Combustão de objeto inflamável em alcance médio."},{"tipo":"Padrão","nome":"Chama Viridente","dano":"4d10+20 fogo + chamas (Reflexos DT 21 reduz à metade/evita)","descricao":"1 ser em alcance médio."}]',
  153
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Doppelganger (Civil)', 20,
  'Um dos Alheios disfarçado de humano — 3 variantes de "nível" (Civil, Combatente, Cultista) + uma forma Monstruosa que qualquer um pode assumir quando ameaçado. "Somos Todos Um": sabem a localização uns dos outros, sacrificam-se pelo objetivo comum. Assumir Forma Monstruosa (ação): +10 PV, +2 Defesa, +5 testes, +5 dano, +2 DT.',
  '{Energia,Conhecimento}', 'Médio', null, null, null, '2d20+5', '+0', 14, null, null, null, 14, 7, null, null,
  '{"agi":1,"for":1,"int":3,"pre":2,"vig":1}', null, null,
  '[{"nome":"Disfarce Alheio","descricao":"Enganação: rola 2x e fica com o melhor resultado."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo)","teste":"1d20+5","dano":"1d4+2 impacto"},{"tipo":"Padrão","nome":"Agredir (Pistola Plasma, distância)","teste":"1d20+5, crítico 18","dano":"2d6+2 Energia"}]',
  154
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Doppelganger (Combatente)', 60,
  'Variante de combate do Doppelganger.',
  '{Energia,Conhecimento}', 'Médio', null, null, null, '2d20+5', '2d20+5', 19, null, null, null, 70, 35, null, null,
  '{"agi":2,"for":2,"int":3,"pre":2,"vig":1}', null, null,
  '[{"nome":"Close Quarter Combat","descricao":"+1d20 ataque corpo a corpo e manobras; mira/recarrega/saca como ação livre."},{"nome":"Especialista em Manobras","descricao":"Agarrar/derrubar/desarmar como ação livre (Teste 2d20+12)."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo x2)","teste":"2d20+10","dano":"1d10+5 impacto"},{"tipo":"Padrão","nome":"Agredir (Pistola, distância x2)","teste":"2d20+10, crítico 18","dano":"2d6+5 Energia"},{"tipo":"Reação","nome":"Proteger","descricao":"Vira alvo no lugar de aliado adjacente."}]',
  155
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Doppelganger (Cultista)', 160,
  'Variante ritualística do Doppelganger.',
  '{Energia,Conhecimento}', 'Médio', null, null, null, '4d20+10', '3d20+10', 28, null, null, null, 240, 120, null, null,
  '{"agi":3,"for":2,"int":3,"pre":4,"vig":2}', null, null,
  '[{"nome":"Rituais (DT 23)","descricao":"Grátis até 6 PE por conjuração."}]',
  '[{"tipo":"Padrão","nome":"Ritual Enfeitiçar (Conhecimento 1)","descricao":"Vontade anula, alvo prestativo pela cena, doppelganger +10 Diplomacia; versão Discente = sugestão de ação."},{"tipo":"Padrão","nome":"Ritual Invadir Mente Discente (Conhecimento 2)","descricao":"Rajada 10d6 + atordoado 1 rodada, ou Ligação Telepática por 1 dia."},{"tipo":"Padrão","nome":"Ritual Perturbação Discente (Conhecimento 1)","descricao":"Ordem — Fuja/Largue/Pare/Sente-se/Venha/Sofra (Sofra = 3d8 + abalado)."},{"tipo":"Padrão","nome":"Ritual Tela de Ruído Discente (Energia 1)","descricao":"60 PV temporários vs. físico, ou reação para RD 30; 3x/cena."}]',
  156
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Bilu', 42,
  'Alheio não-hostil, mas causa dano quando ameaçado ou assustado.',
  '{Energia,Conhecimento}', 'Médio', 15, '1d4 mental', 30, '3d20+10', '3d20+10', 12, null, null, null, 42, 21, 'Balístico, corte, impacto e perfuração 5, Conhecimento/Energia/químico 10', 'Sangue',
  '{"agi":3,"for":2,"int":3,"pre":4,"vig":2}', 'Artes, Ciências, Furtividade, Ocultismo, Religião e Tecnologia 3d20+10', null,
  '[]',
  '[{"tipo":"Reação","nome":"Até Breve","descricao":"Machucado = teleporta extradimensional (mestre decide retorno)."},{"tipo":"Reação","nome":"Embaralhamento Mental","dano":"4d10 mental + esmorecido (Vontade DT 20 reduz à metade/muda pra frustrado)","descricao":"Se ameaçado."},{"tipo":"Movimento","nome":"Comer Cimento","descricao":"Cura 10 PV."},{"tipo":"Movimento","nome":"Salto pra Frente","dano":"1ª revelação: 4d4 mental + abalado (Vontade DT 15)","descricao":"12m."},{"tipo":"Padrão","nome":"Fala Enigmática","dano":"3d6 mental + frustrado (Vontade DT 15)","descricao":"1 pessoa."},{"tipo":"Padrão","nome":"Luz Própria","descricao":"Liga/desliga eletrônicos num raio de 9m, ou emite luz verde."}]',
  157
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Rastropoda', 140,
  'Criatura de Transmissão dos Alheios.',
  '{Energia,Conhecimento}', 'Médio', 24, '4d8 mental', 70, '3d20+10', '2d20+5', 31, null, null, null, 200, 100, 'Balístico, corte, impacto e perfuração 10, Conhecimento/Energia/fogo/químico 20; imune a gases', 'Sangue',
  '{"agi":2,"for":2,"int":1,"pre":3,"vig":4}', null, null,
  '[{"nome":"Camuflagem Alheia","descricao":"Igual ao Fummu, mas fica visível em câmeras — tenta destruí-las."}]',
  '[{"tipo":"Padrão","nome":"Toque Ácido, corpo a corpo x2","teste":"2d20+15","dano":"5d8+15 químico"},{"tipo":"Padrão","nome":"Gosma Plasmática, distância x2 curto","teste":"2d20+15","dano":"4d10+15 Energia"},{"tipo":"Livre","nome":"Agarrão Corrosivo","teste":"2d20+17","dano":"2d10 químico/rodada"},{"tipo":"Livre","nome":"Rastro Pestilento","dano":"2d10 químico/rodada em quem toca"},{"tipo":"Movimento","nome":"Rastro Deslizante","descricao":"2x deslocamento em linha reta."},{"tipo":"Padrão","nome":"Fumocinese","dano":"4d8 dano de Sanidade + confuso (Fortitude DT 24)","descricao":"Absorve gás num raio de 9m, libera alucinógeno."},{"tipo":"Padrão","nome":"Telecinese de Plasma","descricao":"Move alvo Médio ou menor 6m/rodada (Vontade DT 24 anula)."}]',
  158
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'paranormal', 'Memoflígico', 200,
  'Criatura de Transmissão dos Alheios.',
  '{Energia,Conhecimento}', 'Médio', 29, '6d6 mental', 130, '4d20+15', '3d20+15', 38, null, null, null, 400, 200, 'Balístico, corte, impacto e perfuração 10, Conhecimento/Energia 20', 'Sangue',
  '{"agi":3,"for":null,"int":3,"pre":4,"vig":2}', null, null,
  '[{"nome":"Camuflagem Alheia + Incorpóreo","descricao":"Só é afetado por dano paranormal."},{"nome":"Círculo de Transmissão","descricao":"Num raio de 10m de eletrônicos ligados, remove sua invisibilidade/incorporeidade."}]',
  '[{"tipo":"Padrão","nome":"Toque Psicônico / Raio Psicônico (distância curto), ambos x2","teste":"3d20+25","dano":"6d6 mental"},{"tipo":"Movimento","nome":"Teletransporte Psicônico","descricao":"18m, se incorpóreo e invisível."},{"tipo":"Padrão","nome":"Manipulação Psicônica","dano":"6d6 mental base (Vontade DT 29) + condição escolhida","descricao":"Escolhe efeito: Abater Mente (alquebrado), Afetar Sentidos (cego + surdo), Causar Pesadelo (apavorado), Confundir Sinapses (confuso), Comunicação Alheia (1d6 só), Destruir Ânimos (esmorecido), Fazer Alianças (pasmo), Ler Pensamentos (-5 Vontade contra outros efeitos dela)."}]',
  159
);
