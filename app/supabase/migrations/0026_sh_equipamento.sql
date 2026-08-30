-- Sobrevivendo ao Horror, parte 3: novas armas, equipamentos gerais/paranormais.

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
select (select id from sources where slug = 'sobrevivendo_ao_horror'), 'arma', v.name, v.category::item_category, v.spaces, v.description,
  jsonb_build_object('dano', v.dano, 'critico', v.critico, 'alcance', v.alcance, 'tipo_dano', v.tipo_dano, 'proficiencia', v.proficiencia, 'empunhadura', v.empunhadura, 'natureza', v.natureza, 'tipo_municao', v.tipo_municao)
from (values
  ('Pregador pneumático', '0', 1, 'Conta como arma de fogo pra poderes que afetam esse tipo; 300 pregos por rolo (dura 1 missão).', '1d4', 'x4', 'curto', 'P', 'simples', 'uma_mao', 'disparo', null),
  ('Estilingue', '0', 1, 'Soma Força no dano (diferente de outras armas de disparo); bolinhas reaproveitáveis (pacote dura 1 missão); pode lançar granadas em alcance longo.', '1d4', 'x2', 'curto', 'I', 'simples', 'duas_maos', 'disparo', null),
  ('Revólver compacto', 'I', 1, 'Treinado em Crime, carrega sem ocupar espaço.', '2d4', '19/x3', 'curto', 'P', 'simples', 'leve', 'fogo', 'Balas curtas'),
  ('Baioneta', '0', 1, 'Ação de movimento pra fixar numa arma de fogo de duas mãos, virando arma de duas mãos ágil com dano 1d6; ainda pode atacar com a arma de fogo, mas -◯ à distância com ela.', '1d4', '19', null, 'P', 'taticas', 'leve', 'corpo_a_corpo', null),
  ('Faca tática', 'I', 1, 'Arma ágil, pode ser arremessada; ação especial contra-ataque com ela dá +2 no teste de ataque; ação especial bloqueio, gasta 2 PE + sacrifica a faca pra +20 na RD do bloqueio.', '1d6', '19', 'curto', 'C', 'taticas', 'leve', 'corpo_a_corpo', null),
  ('Gancho de carne', '0', 1, 'Amarrado a corda/corrente, alcance sobe pra 4,5m e vira item de espaço 2.', '1d4', 'x4', null, 'P', 'taticas', 'leve', 'corpo_a_corpo', null),
  ('Bastão policial', 'I', 1, 'Arma ágil; usando a ação especial esquiva com ela, bônus na Defesa +1.', '1d6', 'x2', 'curto', 'I', 'taticas', 'uma_mao', 'corpo_a_corpo', null),
  ('Picareta', '0', 1, 'Ferramenta de mineração usável como arma.', '1d6', 'x4', null, 'P', 'taticas', 'uma_mao', 'corpo_a_corpo', null),
  ('Shuriken', 'I', 0.5, 'Veterano em Pontaria, 1x/rodada gasta 1 PE pra ataque adicional de shuriken no mesmo alvo; 1 shuriken = pacote pra 2 cenas (ou 10 unidades com contagem de munição).', '1d4', 'x2', 'curto', 'P', 'taticas', null, 'arremesso', null),
  ('Pistola pesada', 'I', 1, '-◯ em testes de ataque (anula empunhando com as duas mãos).', '2d8', '18', 'curto', 'B', 'taticas', 'uma_mao', 'fogo', 'Balas curtas'),
  ('Espingarda de cano duplo', 'II', 2, 'Recarrega com ação de movimento após os 2 cartuchos; pode disparar os 2 canos no mesmo alvo (-◯ no teste, dano sobe pra 6d6).', '4d6', 'x3', 'curto', 'B', 'taticas', 'duas_maos', 'fogo', 'Cartuchos')
) as v(name, category, spaces, description, dano, critico, alcance, tipo_dano, proficiencia, empunhadura, natureza, tipo_municao);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
select (select id from sources where slug = 'sobrevivendo_ao_horror'), 'geral', v.name, v.category::item_category, v.spaces, v.description, '{}'::jsonb
from (values
  ('Amuleto sagrado', '0', 1, '+2 Religião e Vontade.'),
  ('Celular', '0', 1, 'Com internet, +2 em testes de perícia pra adquirir informação; lanterna fraca (cone 4,5m).'),
  ('Chave de fenda universal', '0', 1, '+2 em testes de perícia pra criar/reparar objetos ou como item de apoio.'),
  ('Chaves', '0', 1, 'Distrair jogando o molho dá +2 Furtividade na mesma rodada.'),
  ('Documentos falsos', 'I', 1, '+2 Diplomacia/Enganação/Intimidação pra se passar pela identidade falsa.'),
  ('Manual operacional', 'I', 1, 'Ação de interlúdio lendo um manual (1 por perícia) dá treinamento nela até o próximo interlúdio (versão aprimorada dá +5); só 1 manual ativo por vez.'),
  ('Notebook', '0', 2, 'Como celular, mas relaxar em interlúdio com ele recupera +1 Sanidade adicional; luz cone 4,5m; inclui tablets.'),
  ('Dinamite', 'I', 1, 'Ação padrão acende + arremessa em alcance médio; raio 6m, 4d6 impacto + 4d6 fogo + em chamas (Reflexos DT Agi reduz à metade e evita).'),
  ('Explosivo plástico', 'I', 1, '2 rodadas pra preparar/grudar; detona por ação livre (alcance longo) ou 1+ dano de fogo/eletricidade; raio 3m, 16d6 impacto (Reflexos DT Int reduz à metade).'),
  ('Galão vermelho', '0', 2, 'Ao sofrer dano de fogo/balístico, explode (raio 6m): 12d6 fogo + em chamas (Reflexos DT 25 reduz/evita); área fica em chamas (1d6/rodada) até apagar ou a cena acabar.'),
  ('Granada de gás sonífero', 'I', 1, 'Raio 6m, quem começa turno na área fica inconsciente+caído (ou exausto→fatigado se em atividade física intensa; Fortitude DT Agi reduz pra fatigado 1d4 rodadas); gás dura 2 rodadas.'),
  ('Granada de PEM', 'I', 1, 'Raio 18m, desativa equipamento elétrico até o fim da cena; criaturas de Energia na área sofrem 6d6 impacto + paralisadas 1 rodada.'),
  ('Alarme de movimento', '0', 1, 'Ação completa posiciona/ativa; cone de 30m, sinaliza dispositivo de controle a movimento significativo.'),
  ('Alimento energético', 'II', 1, 'Ação padrão consome, recupera 1d4 PE.'),
  ('Aplicador de medicamentos', 'I', 1, 'Aplica cicatrizante/medicamento em si/adjacente com ação de movimento; carrega até 3 doses (carregar 1 dose = ação padrão).'),
  ('Braçadeira reforçada', 'I', 1, '+2 na RD de bloqueio.'),
  ('Cão adestrado', 'I', null, 'Treinado em Adestramento pode usá-lo como aliado (+2 Investigação/Percepção; Ladrar e Morder: 1 PE pra +2 Defesa por 1 rodada).'),
  ('Coldre saque rápido', 'I', 1, '1x/rodada, saca/guarda arma de fogo leve como ação livre.'),
  ('Equipamento de escuta', 'I', 1, 'Receptor alcance 90m + 3 transmissores (raio captação 9m); instalar exige minutos + Crime DT 20.'),
  ('Estrepes (saco)', '0', 1, 'Ação padrão cobre quadrado de 1,5m; quem pisa sofre 1d4 perfuração + lento por 1 dia; Reflexos DT Agi evita.'),
  ('Faixa de pregos', 'I', 2, 'Como estrepes mas linha de 9m; veículos de pneu de borracha furam automaticamente (deslocamento pela metade).'),
  ('Isqueiro', '0', 0.5, 'Ação de movimento produz chama; ilumina raio 3m.'),
  ('Antibiótico', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: +5 no próximo teste de Fortitude vs. doença (até fim do dia).'),
  ('Antídoto', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: +5 no próximo teste de Fortitude vs. veneno (ou remove veneno específico).'),
  ('Antiemético', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: remove enjoado + 5 pra evitar até fim da cena.'),
  ('Antihistamínico', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: +5 vs. alergia até fim do dia.'),
  ('Anti-inflamatório', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: 1d8+2 PV temporários.'),
  ('Antitérmico', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: novo teste contra condição mental 1x/cena.'),
  ('Broncodilatador', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: +5 vs. asfixiado/fatigado até fim do dia.'),
  ('Coagulante', 'I', 0.5, 'Ação padrão + item aplica em si/adjacente: +5 pra estabilizar sangrando (+5 também em Medicina pra remover morrendo, se combinado).'),
  ('Óculos de visão noturna', 'I', 1, 'Visão no escuro; mas -◯ em resistência a ofuscado e efeitos de luz.'),
  ('Óculos escuros', '0', 1, 'Imune a ofuscado.'),
  ('Pá', '0', 2, '+5 Força pra cavar/mover detritos; usável como bastão.'),
  ('Paraquedas', 'I', 2, 'Anula dano de queda; veterano em Acrobacia/Pilotagem/Reflexos/Tática/Profissão específica usa automaticamente; senão exige Reflexos DT 20 — falhar reduz o dano só à metade.'),
  ('Traje de mergulho', 'I', 2, '+5 resistência a efeitos ambientais, resistência a químico 5; 1h de oxigênio; espaço de vestimenta.'),
  ('Traje espacial', 'II', 5, '+10 resistência a efeitos ambientais, resistência a químico 20; 8h água/oxigênio; espaço de vestimenta.'),
  ('Ligação Direta Infernal', 'II', 1, 'Ação completa liga veículo automaticamente com fios de Sangue/Energia; veículo ganha RD 20 (cumulativa) + imunidade a Sangue, +5 Pilotagem pra conduzir; mas falhas em Pilotagem têm consequências dobradas.'),
  ('Medidor de Condição Vertebral', 'II', 1, 'Conectar exige ação completa + atordoado 1 rodada; conta como vestimenta, +2 Fortitude; luzes indicam saúde e pulsa lilás sob efeito paranormal; +5 em Medicina pra auxiliar o usuário.'),
  ('Pé de Morto', 'II', 1, '+5 Furtividade; em cena de furtividade, ação chamativa de só se mover (correr/saltar) aumenta visibilidade em só +1 (em vez do padrão).'),
  ('Pendrive selado', 'II', 0.5, 'Imune a invasão/rituais/seres/efeitos de Energia; existem variantes (HD externo, celular).'),
  ('Valete da Salvação', 'I', 0.5, 'Ação padrão arremessa a carta; voa em alcance médio apontando a melhor rota de fuga, depois some; usada em cena de perseguição, sucede automaticamente numa ação de cortar caminho.')
) as v(name, category, spaces, description);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
select (select id from sources where slug = 'sobrevivendo_ao_horror'), 'paranormal', v.name, v.category::item_category, v.spaces, v.description, '{}'::jsonb
from (values
  ('Catalisador Ritualístico Ampliador', 'I', 0.5, 'Precisa ser empunhado; só 1 por ritual; consumido ao usar. +1 passo de alcance ou dobra área.'),
  ('Catalisador Ritualístico Perturbador', 'I', 0.5, 'Precisa ser empunhado; só 1 por ritual; consumido ao usar. DT pra resistir ao ritual +2.'),
  ('Catalisador Ritualístico Potencializador', 'I', 0.5, 'Precisa ser empunhado; só 1 por ritual; consumido ao usar. +1 dado de dano do mesmo tipo.'),
  ('Catalisador Ritualístico Prolongador', 'I', 0.5, 'Precisa ser empunhado; só 1 por ritual; consumido ao usar. Dobra a duração (não funciona em instantâneo/sustentado).')
) as v(name, category, spaces, description);
