-- Arquivos Secretos 05 (tema TV Varminho / Os Alheios). Poderes de Transmissão (gated,
-- exige 2+ pessoas com o mesmo poder + contato com o Sino) ficam de fora por ora — sistema
-- muito nichado, baixo retorno sem uma mesa multiplayer real pra testar.

insert into origins (source_id, name, skill_1_id, skill_2_id, power_name, power_description, description, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'Ufólogo',
  (select id from skills where name = 'Ciências'), (select id from skills where name = 'Ocultismo'),
  'Minha Teoria Absurda', '1x/missão, 10min apresenta teoria sobre investigação antes das respostas; se confirmar certa no fim, +3 PE máx/atuais.',
  null, 1
),
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'Funcionário de Beira de Estrada',
  (select id from skills where name = 'Fortitude'), (select id from skills where name = 'Intuição'),
  'Turno Invertido', '1x/missão, benefícios de dormir sem precisar da ação; +2 vs. efeitos que deixariam inconsciente.',
  null, 2
);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'combatente'), v.name, v.description, v.prereq, v.ord from (values
  ('Aura de Confiança', 'Aliados em 18m de raio +5 Iniciativa e vs. Presença Perturbadora (você não recebe).', null, 36),
  ('Fôlego de Emergência', '1x/cena com ameaça presente, ação de movimento, 1d8+Vig PV ou PE.', null, 37),
  ('Parede de Carne', 'Cobertura leve (+5 Defesa) pra aliados adjacentes.', 'Vig 3 ou For 3', 38)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'especialista'), v.name, v.description, v.prereq, v.ord from (values
  ('Adepto do Escuro', 'Ignora camuflagem por escuridão; +2 Investigação em penumbra.', null, 32),
  ('Saudosista Hi-Tech', '+5 Tecnologia em aparelhos pré-2000, gambiarras com digital.', null, 33),
  ('Treinado nas Telas', 'Iniciativa/Reflexos, 2 PE pra usar Intelecto em vez de Agilidade.', null, 34)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Catálogo de Criaturas Ambulante', '+5 Ocultismo pra identificar criaturas, mesmo sem ver (só vestígios).', null, 34),
  ('Meditação Ocultista', 'Nova ação de interlúdio, recupera PE conforme condição de descanso (normal=2x limite/rodada; precária=metade; confortável=3x; luxuosa=4x); 1x/interlúdio.', null, 35),
  ('Ruído de Comunicação', 'Reação + 4 PE, inverte bônus↔penalidade de um efeito visto em alcance curto, até fim da cena.', null, 36)
) as v(name, description, prereq, ord);

insert into general_powers (source_id, name, description, prerequisites)
select (select id from sources where slug = 'arquivos_secretos_05'), v.name, v.description, v.prereq from (values
  ('Apaixonado por Veículos', 'Treina Pilotagem (+2 se já treinado); +◯ em testes de segurança do veículo; com Veículos Operacionais, +1 regalia extra.', 'Agi 2'),
  ('Desafiar o Ego', 'Reação + 1 PE ao ver aliado atacar, grita incentivo; acertando, +dano = Presença; errando, recupera PE.', 'Pre 2'),
  ('Direção Defensiva', 'Treina Pilotagem (+2 se já); dirigindo, todos no veículo +2 Defesa/resistência (+2 Defesa do veículo com Veículos Operacionais).', null)
) as v(name, description, prereq);

insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
values
((select id from sources where slug = 'arquivos_secretos_05'), 'energia', 'Ácido Corrosivo', '1 PE, mãos viram ácido até fim da cena: +2 ataque desarmado, +5 dano desarmado, tipo muda pra químico (ou aplica a arma corpo a corpo empunhada, não amaldiçoada é destruída).', '+4 ataque/+10 dano.', null),
((select id from sources where slug = 'arquivos_secretos_05'), 'conhecimento', 'Dead Man Switch', 'Machucado, escolhe alvo + perícia treinada em alcance médio; alvo ganha seu nível de treinamento nela até você se curar acima da metade PV ou morrer.', 'Até 3 alvos/perícias, efeitos persistem até fim da missão mesmo após sua morte.', null),
((select id from sources where slug = 'arquivos_secretos_05'), 'conhecimento', 'Paralinguística Ampliada', '+5 pra compreender "linguagens" do Outro Lado; aprende ritual Compreensão Paranormal (ou -1 PE se já conhece).', 'Bônus vira +10, sempre sob efeito Discente do ritual.', null);

insert into class_tracks (class_id, slug, name, description, sort_order)
values ((select id from classes where slug = 'ocultista'), 'criptologista_do_oculto', 'Criptologista do Oculto', 'Especialista em Selos paranormais.', 10);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'criptologista_do_oculto'), v.nex, v.name, v.description from (values
  (10, 'Selos Duplicados', 'Ganha Criar Selo (2x = dobra selos simultâneos + cria 2 por ação de interlúdio; +1 selo/ação por habilidade adicional da trilha).'),
  (40, 'Selo Decifrado', 'Selo desconhecido usável via Ocultismo DT 10+custo PE; +5 pra identificar rituais.'),
  (65, 'Leitura Silenciosa', 'Usa Selo sem empunhar/ler em voz alta (só ler mentalmente, alcance curto); +5 "linguagens" do Outro Lado.'),
  (99, 'Domínio dos Selos', 'Selos dispensam teste de Ocultismo; rituais dos Selos: DT resistência +5, dano +3 dados extra, forma avançada sem custo adicional de PE.')
) as v(nex, name, description);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
((select id from sources where slug = 'arquivos_secretos_05'), 'geral', 'Câmera Filmadora', '0', 1, '+2 Investigação/Percepção; lanterna 9m ou visão no escuro.', '{}');

insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_05'), 'Faixas da Vidência', 'Morte. +5 Defesa/resistência vs. origem em alcance curto, -5 vs. origem além de 9m; +2 Intimidação.', 'III', 1),
((select id from sources where slug = 'arquivos_secretos_05'), 'Joias da Mente', 'Conhecimento. Par piercing+brinco; +2 Diplomacia, resistência mental 10.', 'III', 1),
((select id from sources where slug = 'arquivos_secretos_05'), 'Larva da Fúria', 'Sangue. Consumível, ódio até fim da cena (+4 ataque/dano corpo a corpo, sem ações calmas/rituais); termina se não atacar/ser atacado numa rodada.', 'II', 1),
((select id from sources where slug = 'arquivos_secretos_05'), 'Skate Caótico', 'Energia. +3m deslocamento (treinado Acrobacia/Atletismo/Pilotagem) OU arma improvisada 1d12 impacto x2 OU escudo +5 Defesa.', 'II', 2),
((select id from sources where slug = 'arquivos_secretos_05'), 'Tênis Lépidos', 'Energia. +12 Atletismo, +3m deslocamento; 2 PE pra ignorar terreno difícil+escalada+imune a queda até 9m (1 turno).', 'III', 1);

insert into extra_rules (source_id, category, title, content, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_05'), 'mecanicas_de_cena', 'Perigos Complexos',
  'Framework do mestre pra transformar cenas de ação (não-combate) em desafios estruturados via teste estendido, com "fichas" próprias (Nome+VD, Objetivo, Efeito, lista de Ações disponíveis por rodada com seus testes). Cada personagem faz 1 ação/rodada; VD segue a mesma tabela de referência de ameaças comuns.

Exemplos dados no livro: Explosão em Contagem Regressiva (VD80, desarmar/escapar em 5 rodadas — zona 8d4 fogo+8d4 impacto+soterrado / onda de choque 8d4 impacto), Navio Naufragando (VD120, detalhado abaixo), Prédio Ocupado por Criaturas (VD180, elemento aleatório 1d4, exterminar horda em 1d10+5 rodadas), mais 2 exemplos não detalhados (escapar de horda, atravessar chuva de Sangue).

Navio Naufragando — VD 120: Objetivo: escapar em 1d6+6 rodadas ou afunda com todos. Início de cada turno: Reflexos DT 20+1d6 (mesma rolagem pra todos na rodada) ou 6d6 impacto; falhar por 10+ = preso 1 rodada. Ações: Nadar (sucesso acumula rumo a 5 pra escapar), Carregar Outro (Atletismo DT28, puxa aliado), Abrir Caminho (ataque DT23), Libertar Aliado (sem teste), Proteger-se (sem teste, DT do Reflexos vira fixo 20 sem risco de ficar preso, mas não acumula sucesso).',
  10
);
