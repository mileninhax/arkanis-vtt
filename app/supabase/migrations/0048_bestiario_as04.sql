-- Bestiário Arquivos Secretos 04 — "O Anfitrião" (jogo/game show paranormal): NPCs
-- Produtor e Diretor + a criatura de Energia Simulacro (4 estágios de evolução:
-- Troyan, Krypto, Vvorm, Botnetz). PDF-fonte é rascunho com trechos placeholder —
-- só o mecanicamente completo foi catalogado.

insert into creatures (source_id, categoria, tipo_criatura, name, vd, flavor_text, tamanho, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, atributos, pericias, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'mundana', 'Pessoa', 'Produtor', 80,
  'NPC do Jogo do Anfitrião.',
  'Médio', '+◯+5', '+2◯+10', 20, '+3◯+10', '+2◯+10', '+◯+5', 100, 50,
  '{"agi":2,"for":2,"int":2,"pre":1,"vig":3}', 'Atletismo +2◯+10, Crime +2◯+10, Ocultismo +2◯+5', '9m | 6',
  '[{"nome":"Item — Martelo Meteoro USB","descricao":"Arma corpo a corpo alcance 6m, +2 manobras de combate, dano impacto ou Energia à escolha."},{"nome":"Máscara de Gás","descricao":"+10 Fortitude vs. respiração."},{"nome":"Rituais (DT 20)","descricao":"Grátis até 6 PE/conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Martelo, corpo a corpo x2)","teste":"2◯+10, crítico x3","dano":"1d12+10 impacto/Energia"},{"tipo":"Padrão","nome":"Ritual Chamas do Caos (Energia 2)","descricao":"Escolhe efeito (comum: Chamejar, arma +1d6 fogo)."},{"tipo":"Padrão","nome":"Ritual Eletrocussão Discente (Energia 1)","dano":"6d6 Energia (Fortitude reduz à metade)","descricao":"Linha 30m."},{"tipo":"Padrão","nome":"Ritual Tela de Ruído Discente (Energia 2)","descricao":"60 PV temporários (só vs. balístico/corte/impacto/perfuração) até fim da cena, ou reação pra RD 30 num único dano; 3x/cena."}]',
  144
),
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'mundana', 'Pessoa', 'Diretor', 200,
  'NPC do Jogo do Anfitrião.',
  'Médio', '+4◯+15', '+3◯+10', 28, '+3◯+15', '+3◯+10', '+4◯+15', 280, 140,
  '{"agi":3,"for":3,"int":3,"pre":4,"vig":3}', 'Atletismo +3◯+15, Crime +3◯+10, Enganação +4◯+15, Intimidação +4◯+15, Ocultismo +3◯+10, Tecnologia +3◯+10', '9m | 6',
  '[{"nome":"Máscara de Gás","descricao":"Mesma regra do Produtor."},{"nome":"Rituais (DT 29)","descricao":"Grátis até 10 PE/conjuração."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Murro Eletrificado, corpo a corpo x3)","teste":"3◯+20","dano":"4d8+20 eletricidade"},{"tipo":"Padrão","nome":"Agredir (Carga Eletrificada, distância x3 curto)","teste":"3◯+20","dano":"4d8+20 eletricidade"},{"tipo":"Padrão","nome":"Ritual Coincidência Forçada Verdadeiro (Energia 1)","descricao":"Aliados em alcance curto +5 perícias até fim da cena."},{"tipo":"Padrão","nome":"Ritual Dissonância Acústica (Energia 2)","descricao":"Esfera 6m raio, alcance médio; alvos ficam surdos + sem conjurar rituais."},{"tipo":"Padrão","nome":"Ritual Eletrocussão Verdadeiro (Energia 1)","dano":"8d6 Energia em cada ser escolhido em alcance curto (Fortitude reduz à metade)"},{"tipo":"Padrão","nome":"Ritual Salto Fantasma (Energia 3)","descricao":"Teleporte alcance médio, sem precisar de linha de visão (só já ter visto o local)."},{"tipo":"Padrão","nome":"Ritual Tela de Ruído Discente (Energia 2)","descricao":"Mesma de Produtor."}]',
  145
);

insert into creatures (source_id, categoria, name, vd, flavor_text, descritores, tamanho, presenca_dt, presenca_dano, presenca_nex_imune, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, vulnerabilidades, atributos, deslocamento, habilidades, acoes, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'paranormal', 'Simulacro (Troyan)', 32,
  'Consciências de vítimas do Jogo do Anfitrião presas em telas; evolui em 4 estágios (Troyan → Krypto → Vvorm → Botnetz).',
  '{Energia,Conhecimento}', 'Minúsculo', 15, '2d6 mental', 30, '◯+5', '◯+5', 10, '◯+5', '◯+5', '◯+5', 70, 35, 'Dano (exceto Conhecimento)', 'Conhecimento',
  '{"agi":1,"for":null,"int":1,"pre":1,"vig":1}', '0m | 0',
  '[{"nome":"Intangibilidade Digital","descricao":"Incorpóreo, só afetado por Conhecimento; perceber exige Ocultismo DT 4d10."},{"nome":"Exorcismo Digital","descricao":"2+ personagens treinados em Ocultismo/Religião fazem liturgia (teste estendido Ocultismo DT 4d10, 3 sucessos) pra prender o simulacro num objeto analógico (precisa de sigilos de Conhecimento escritos em raio de 9m e nenhum outro aparelho ligado no raio); destruir o objeto o destrói. Falha total = escapa pra internet."}]',
  '[{"tipo":"Movimento","nome":"Saltar","descricao":"Teleporta pra aparelho eletrônico em alcance curto."},{"tipo":"Padrão","nome":"Perturbação Digital","dano":"2d6 mental (Vontade DT 3d10 reduz à metade)","descricao":"Pessoa olhando pra tela; enlouquecer = 50% morre, 50% é levado ao Jogo do Anfitrião (Sanidade 1)."}]',
  146
),
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'paranormal', 'Simulacro (Krypto)', 64,
  'Evolução do Simulacro — 2º estágio.',
  '{Energia,Conhecimento}', 'Pequeno', 15, '2d6 mental', 30, '◯+10', '◯+10', 20, '◯+10', '◯+10', '◯+10', 100, 50, 'Dano (exceto Conhecimento)', 'Conhecimento',
  '{"agi":1,"for":null,"int":1,"pre":1,"vig":1}', '0m | 0',
  '[{"nome":"Intangibilidade Digital","descricao":"Mesma regra do Troyan."},{"nome":"Exorcismo Digital","descricao":"Mesma regra do Troyan."}]',
  '[{"tipo":"Movimento","nome":"Saltar","descricao":"Teleporta pra aparelho eletrônico em alcance médio."},{"tipo":"Padrão","nome":"Perturbação Digital","dano":"3d6 mental (Vontade DT 4d10 reduz à metade)","descricao":"Até 2 pessoas olhando pra tela."}]',
  147
),
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'paranormal', 'Simulacro (Vvorm)', 128,
  'Evolução do Simulacro — 3º estágio.',
  '{Energia,Conhecimento}', 'Médio', 15, '2d6 mental', 30, '2◯+15', '2◯+15', 30, '2◯+15', '2◯+15', '2◯+15', 200, 100, 'Dano (exceto Conhecimento)', 'Conhecimento',
  '{"agi":2,"for":null,"int":2,"pre":2,"vig":2}', '0m | 0',
  '[{"nome":"Intangibilidade Digital","descricao":"Mesma regra do Troyan."},{"nome":"Exorcismo Digital","descricao":"Mesma regra do Troyan."}]',
  '[{"tipo":"Movimento","nome":"Saltar","descricao":"Teleporta pra aparelho eletrônico em alcance longo."},{"tipo":"Padrão","nome":"Perturbação Digital","dano":"4d6 mental (Vontade DT 5d10 reduz à metade)","descricao":"Até 3 pessoas olhando pra tela."}]',
  148
),
(
  (select id from sources where slug = 'arquivos_secretos_04'), 'paranormal', 'Simulacro (Botnetz)', 256,
  'Evolução final do Simulacro — 4º estágio.',
  '{Energia,Conhecimento}', 'Grande', 15, '2d6 mental', 30, '3◯+20', '3◯+20', 40, '3◯+20', '3◯+20', '3◯+20', 500, 250, 'Dano (exceto Conhecimento)', 'Conhecimento',
  '{"agi":3,"for":null,"int":3,"pre":3,"vig":3}', '0m | 0',
  '[{"nome":"Intangibilidade Digital","descricao":"Mesma regra do Troyan."},{"nome":"Exorcismo Digital","descricao":"Mesma regra do Troyan."}]',
  '[{"tipo":"Movimento","nome":"Saltar","descricao":"Teleporta pra aparelho eletrônico em alcance extremo."},{"tipo":"Padrão","nome":"Perturbação Digital","dano":"6d8 mental (Vontade DT 6d10 reduz à metade)","descricao":"Até 4 pessoas olhando pra tela."}]',
  149
);
