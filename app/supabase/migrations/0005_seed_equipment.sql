-- Seed: equipamento (Livro Base, 11.8). Fonte: docs/VTT_Conteudo_Ordem_Paranormal.md
-- stats jsonb guarda os campos mecânicos que variam por tipo de item.

-- ============================================================
-- Armas (Tabela 3.3) — proficiência/empunhadura vêm do agrupamento do livro
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
select (select id from sources where slug = 'ordem_paranormal'), 'arma', v.name, v.category::item_category, v.spaces, v.description,
  jsonb_build_object('dano', v.dano, 'critico', v.critico, 'alcance', v.alcance, 'tipo_dano', v.tipo_dano, 'proficiencia', v.proficiencia, 'empunhadura', v.empunhadura, 'natureza', v.natureza)
from (values
  -- Armas Simples — Corpo a Corpo, Leves
  ('Coronhada', '0', null, 'Usar arma de fogo como corpo a corpo — 1d4 impacto (leve/uma mão) ou 1d6 (duas mãos).', '1d4/1d6', 'x2', null, 'I', 'simples', 'leve', 'corpo_a_corpo'),
  ('Faca', '0', 1, 'Lâmina afiada (navalha, faca de cozinha causa só 1d3); arma ágil, pode ser arremessada.', '1d4', '19', 'curto', 'C', 'simples', 'leve', 'corpo_a_corpo'),
  ('Martelo', '0', 1, 'Ferramenta comum usável como arma.', '1d6', 'x2', null, 'I', 'simples', 'leve', 'corpo_a_corpo'),
  ('Punhal', '0', 1, 'Lâmina longa e pontiaguda usada por cultistas; arma ágil.', '1d4', 'x3', null, 'P', 'simples', 'leve', 'corpo_a_corpo'),
  -- Armas Simples — Corpo a Corpo, Uma Mão
  ('Bastão', '0', 1, 'Cilindro de madeira maciça (taco, cassetete, tonfa); uma mão = 1d6, duas mãos = 1d8.', '1d6/1d8', 'x2', null, 'I', 'simples', 'uma_mao', 'corpo_a_corpo'),
  ('Machete', '0', 1, 'Lâmina longa e larga, usada como ferramenta.', '1d6', '19', null, 'C', 'simples', 'uma_mao', 'corpo_a_corpo'),
  ('Lança', '0', 1, 'Ponta metálica afiada; pode ser arremessada.', '1d6', 'x2', 'curto', 'P', 'simples', 'uma_mao', 'corpo_a_corpo'),
  -- Armas Simples — Corpo a Corpo, Duas Mãos
  ('Cajado', '0', 2, 'Cabo de madeira/ferro longo (inclui bo); arma ágil; funciona com Combater com Duas Armas como se fosse uma arma de uma mão + uma leve.', '1d6/1d6', 'x2', null, 'I', 'simples', 'duas_maos', 'corpo_a_corpo'),
  -- Armas Simples — Disparo, Duas Mãos
  ('Arco', '0', 2, 'Arco e flecha comum.', '1d6', 'x3', 'medio', 'P', 'simples', 'duas_maos', 'disparo'),
  ('Besta', '0', 2, 'Besta pesada; recarregar exige ação de movimento a cada disparo.', '1d8', '19', 'medio', 'P', 'simples', 'duas_maos', 'disparo'),
  -- Armas Simples — Fogo, Leves
  ('Pistola', 'I', 1, 'Fácil de recarregar.', '1d12', '18', 'curto', 'B', 'simples', 'leve', 'fogo'),
  ('Revólver', 'I', 1, 'Confiável.', '2d6', '19/x3', 'curto', 'B', 'simples', 'leve', 'fogo'),
  -- Armas Simples — Fogo, Duas Mãos
  ('Fuzil de caça', 'I', 2, 'Popular entre fazendeiros/caçadores.', '2d8', '19/x3', 'medio', 'B', 'simples', 'duas_maos', 'fogo'),
  -- Armas Táticas — Corpo a Corpo, Leves
  ('Machadinha', '0', 1, 'Pode ser arremessada.', '1d6', 'x3', 'curto', 'C', 'taticas', 'leve', 'corpo_a_corpo'),
  ('Nunchaku', '0', 1, 'Arma ágil.', '1d8', 'x2', null, 'I', 'taticas', 'leve', 'corpo_a_corpo'),
  -- Armas Táticas — Corpo a Corpo, Uma Mão
  ('Corrente', '0', 1, '+2 em testes de desarmar e derrubar.', '1d8', 'x2', null, 'I', 'taticas', 'uma_mao', 'corpo_a_corpo'),
  ('Espada', 'I', 1, 'Uma mão = 1d8, duas mãos = 1d10.', '1d8/1d10', '19', null, 'C', 'taticas', 'uma_mao', 'corpo_a_corpo'),
  ('Florete', 'I', 1, 'Espada fina de esgrimista; arma ágil.', '1d6', '18', null, 'C', 'taticas', 'uma_mao', 'corpo_a_corpo'),
  ('Machado', 'I', 1, 'Ferimentos terríveis.', '1d8', 'x3', null, 'C', 'taticas', 'uma_mao', 'corpo_a_corpo'),
  ('Maça', 'I', 1, 'Cabeça metálica cheia de protuberâncias.', '2d4', 'x2', null, 'I', 'taticas', 'uma_mao', 'corpo_a_corpo'),
  -- Armas Táticas — Corpo a Corpo, Duas Mãos
  ('Acha', 'I', 2, 'Machado grande e pesado, corte de árvores largas.', '1d12', 'x3', null, 'C', 'taticas', 'duas_maos', 'corpo_a_corpo'),
  ('Gadanho', 'I', 2, 'Versão maior da foice, duas mãos.', '2d4', 'x4', null, 'C', 'taticas', 'duas_maos', 'corpo_a_corpo'),
  ('Katana', 'I', 2, 'Arma ágil; veterano em Luta pode empunhar como arma de uma mão.', '1d10', '19', null, 'C', 'taticas', 'duas_maos', 'corpo_a_corpo'),
  ('Marreta', 'I', 2, 'Demolir paredes (ou pessoas); mesmas estatísticas de outras ferramentas de construção (picareta).', '3d4', 'x2', null, 'I', 'taticas', 'duas_maos', 'corpo_a_corpo'),
  ('Montante', 'I', 2, 'Espada de 1,5m, duas mãos.', '2d6', '19', null, 'C', 'taticas', 'duas_maos', 'corpo_a_corpo'),
  ('Motosserra', 'I', 2, 'Rolar um 6 num dado de dano soma outro dado; -1d20 nos testes de ataque; ligar é ação de movimento.', '3d6', 'x2', null, 'C', 'taticas', 'duas_maos', 'corpo_a_corpo'),
  -- Armas Táticas — Disparo, Duas Mãos
  ('Arco composto', 'I', 2, 'Materiais de alta tensão + roldanas; ao contrário de outras armas de disparo, soma Força no dano.', '1d10', 'x3', 'medio', 'P', 'taticas', 'duas_maos', 'disparo'),
  ('Balestra', 'I', 2, 'Besta pesada de guerra; recarregar exige ação de movimento a cada disparo.', '1d12', '19', 'medio', 'P', 'taticas', 'duas_maos', 'disparo'),
  -- Armas Táticas — Fogo, Uma Mão
  ('Submetralhadora', 'I', 1, 'Arma de fogo automática, empunhável com uma mão.', '2d6', '19/x3', 'curto', 'B', 'taticas', 'uma_mao', 'fogo'),
  -- Armas Táticas — Fogo, Duas Mãos
  ('Espingarda', 'I', 2, 'Metade do dano em alcance médio ou maior.', '4d6', 'x3', 'curto', 'B', 'taticas', 'duas_maos', 'fogo'),
  ('Fuzil de assalto', 'II', 2, 'Arma automática padrão militar.', '2d10', '19/x3', 'medio', 'B', 'taticas', 'duas_maos', 'fogo'),
  ('Fuzil de precisão', 'III', 2, 'Uso militar; veterano em Pontaria + mirar dá +5 na margem de ameaça.', '2d10', '19/x3', 'longo', 'B', 'taticas', 'duas_maos', 'fogo'),
  -- Armas Pesadas — Fogo, Duas Mãos
  ('Bazuca', 'III', 2, 'Lança-foguetes anti-tanque; causa dano no alvo atingido e em todos num raio de 3m (Reflexos DT Agi reduz à metade pros que não foram o alvo direto); pode disparar num ponto sem rolar ataque; recarregar exige ação de movimento.', '10d8', 'x2', 'medio', 'I', 'pesadas', 'duas_maos', 'fogo'),
  ('Lança-chamas', 'III', 2, 'Atinge todos numa linha de 1,5m de largura, alcance curto; um único teste de ataque contra a Defesa de todos na área; atingidos ficam em chamas.', '6d6', 'x2', 'curto', 'Fogo', 'pesadas', 'duas_maos', 'fogo'),
  ('Metralhadora', 'II', 2, 'Exige Força 4+ ou ação de movimento pra apoiar em tripé (senão -5 no ataque); arma automática.', '2d12', '19/x3', 'medio', 'B', 'pesadas', 'duas_maos', 'fogo')
) as v(name, category, spaces, description, dano, critico, alcance, tipo_dano, proficiencia, empunhadura, natureza);

-- Ataque desarmado e arma improvisada — regras gerais, não itens de inventário próprios
insert into equipment_items (source_id, type, name, category, spaces, description, stats, is_custom)
values (
  (select id from sources where slug = 'ordem_paranormal'), 'arma', 'Ataque Desarmado', '0', null,
  'Soco, chute etc. Conta como arma corpo a corpo leve, dano 1d3 não letal (não é afetado por efeitos que mencionem "armas").',
  '{"dano":"1d3","critico":"x2","tipo_dano":"nao_letal","empunhadura":"leve","natureza":"corpo_a_corpo"}', false
), (
  (select id from sources where slug = 'ordem_paranormal'), 'arma', 'Arma Improvisada', '0', null,
  'Objeto não feito pra combate = arma corpo a corpo de uma mão, dano 1d6, -1d20 no teste de ataque.',
  '{"dano":"1d6","critico":"x2","empunhadura":"uma_mao","natureza":"corpo_a_corpo","penalidade_ataque":"-1_dado"}', false
);

-- ============================================================
-- Munições (Tabela 3.4)
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
select (select id from sources where slug = 'ordem_paranormal'), 'municao', v.name, v.category::item_category, v.spaces, null,
  jsonb_build_object('duracao_pacote', v.duracao)
from (values
  ('Balas curtas', '0', 1, '2 cenas'),
  ('Balas longas', 'I', 1, '1 cena'),
  ('Cartuchos', 'I', 1, '1 cena'),
  ('Combustível', 'I', 1, '1 cena'),
  ('Flechas', '0', 1, '1 missão inteira (reaproveitadas)'),
  ('Foguete', 'I', 1, '1 disparo cada')
) as v(name, category, spaces, duracao);

-- ============================================================
-- Modificações — Armas
-- ============================================================

insert into weapon_mods (source_id, name, applies_to, effect)
select (select id from sources where slug = 'ordem_paranormal'), v.name, v.applies_to, v.effect
from (values
  ('Certeira', 'corpo_a_corpo_disparo', '+2 em testes de ataque'),
  ('Cruel', 'corpo_a_corpo_disparo', '+2 em rolagens de dano'),
  ('Discreta', 'corpo_a_corpo_disparo', '+5 em testes pra ocultar; espaço -1'),
  ('Perigosa', 'corpo_a_corpo_disparo', '+2 em margem de ameaça'),
  ('Tática', 'corpo_a_corpo_disparo', 'Saca como ação livre'),
  ('Alongada', 'armas_fogo', '+2 em testes de ataque'),
  ('Calibre Grosso', 'armas_fogo', '+1 dado de dano do mesmo tipo (exige munição específica)'),
  ('Compensador', 'armas_fogo', 'Anula penalidade por rajada (só automáticas)'),
  ('Discreta', 'armas_fogo', '+5 em testes pra ocultar; espaço -1'),
  ('Ferrolho Automático', 'armas_fogo', 'Arma se torna automática'),
  ('Mira Laser', 'armas_fogo', '+2 em margem de ameaça'),
  ('Mira Telescópica', 'armas_fogo', '+1 categoria de alcance; libera Ataque Furtivo em qualquer alcance'),
  ('Silenciador', 'armas_fogo', '-2d20 na penalidade de Furtividade pra esconder no mesmo turno em que atacou'),
  ('Tática', 'armas_fogo', 'Saca como ação livre'),
  ('Visão de Calor', 'armas_fogo', 'Ignora camuflagem do alvo ao disparar'),
  ('Dum Dum', 'municao_balas', '+1 no multiplicador de crítico'),
  ('Explosiva', 'municao_balas', '+2d6 de dano')
) as v(name, applies_to, effect);

-- ============================================================
-- Proteções (Tabela 3.6) + Modificações
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
  ((select id from sources where slug = 'ordem_paranormal'), 'protecao', 'Proteção Leve', 'I', 2, 'Jaqueta de couro pesada ou colete de kevlar (seguranças/policiais). Sem proficiência: -2d20 em testes baseados em Força e Agilidade.', '{"defesa":5}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'protecao', 'Proteção Pesada', 'II', 5, 'Capacete + ombreiras + joelheiras + caneleiras + colete multicamada (forças especiais/exército); resistência a balístico/corte/impacto/perfuração 2; -5 em perícias com penalidade de carga.', '{"defesa":10,"resistencia":{"balistico":2,"corte":2,"impacto":2,"perfuracao":2}}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'protecao', 'Escudo', 'I', 2, 'Empunhado numa mão, Defesa +2 (acumula com proteção); conta como proteção pesada pra fins de proficiência.', '{"defesa":2}');

insert into weapon_mods (source_id, name, applies_to, effect)
select (select id from sources where slug = 'ordem_paranormal'), v.name, 'protecoes', v.effect
from (values
  ('Antibombas', '+5 em testes de resistência contra efeitos de área (só proteção pesada)'),
  ('Blindada', 'RD sobe pra 5; espaço +1 (só proteção pesada)'),
  ('Discreta', '+5 em testes de ocultar; espaço -1 (só proteção leve)'),
  ('Reforçada', 'Defesa +2; espaço +1 (não combina com Discreta)')
) as v(name, effect);

-- ============================================================
-- Equipamento Geral — Acessórios
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Kit de Perícia', '0', 1, 'Ferramentas específicas de uma perícia; sem ele, -5 no teste.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Utensílio', 'I', 1, 'Item comum com utilidade específica (canivete, smartphone), +2 numa perícia (exceto Luta/Pontaria); precisa estar empunhado.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Vestimenta', 'I', 1, 'Peça de roupa, +2 numa perícia (exceto Luta/Pontaria); máximo 2 vestimentas simultâneas; vestir/despir é ação completa.', '{}');

insert into weapon_mods (source_id, name, applies_to, effect)
select (select id from sources where slug = 'ordem_paranormal'), v.name, 'acessorios', v.effect
from (values
  ('Aprimorado', 'Bônus em perícia sobe pra +5'),
  ('Discreto', '+5 em testes de ocultar; espaço -1'),
  ('Função adicional', '+2 numa perícia adicional'),
  ('Instrumental', 'Funciona como kit de perícia')
) as v(name, effect);

-- ============================================================
-- Equipamento Geral — Explosivos
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Granada de Atordoamento', '0', 1, 'Empunhar + ação padrão pra arremessar em alcance médio; raio de 6m. Atordoados por 1 rodada (Fortitude DT Agi reduz pra ofuscado+surdo por 1 rodada).', '{"tipo":"granada"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Granada de Fragmentação', 'I', 1, 'Empunhar + ação padrão pra arremessar em alcance médio; raio de 6m. 8d6 dano de perfuração (Reflexos DT Agi reduz à metade).', '{"tipo":"granada","dano":"8d6"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Granada de Fumaça', '0', 1, 'Empunhar + ação padrão pra arremessar em alcance médio; raio de 6m. Cegos + camuflagem total por 2 rodadas.', '{"tipo":"granada"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Granada Incendiária', 'I', 1, 'Empunhar + ação padrão pra arremessar em alcance médio; raio de 6m. 6d6 dano de fogo + em chamas (Reflexos DT Agi reduz dano à metade e evita a condição).', '{"tipo":"granada","dano":"6d6"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Mina Antipessoal', 'I', 1, 'Ativada por controle remoto (ação padrão a até alcance longo); cone de 6m, 12d6 dano de perfuração (Reflexos DT Int reduz à metade); instalar exige ação completa + teste de Tática DT 15.', '{"dano":"12d6"}');

-- ============================================================
-- Equipamento Geral — Itens Operacionais
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Algemas', '0', 1, 'Precisa empunhar + agarrar + vencer teste de agarrar; prender os dois pulsos (-5 em testes com as mãos, impede conjuração) ou um pulso num objeto imóvel; escapar exige Acrobacia DT 30.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Arpéu', '0', 1, 'Fixar exige Pontaria DT 15; subir com corda dá +5 em Atletismo.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Bandoleira', 'I', 1, '1x/rodada, saca/guarda item como ação livre.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Binóculos', '0', 1, '+5 em Percepção pra observar coisas distantes.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Bloqueador de Sinal', 'I', 1, 'Impede celulares em alcance médio de se conectarem.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Cicatrizante', 'I', 1, 'Ação padrão pra curar 2d8+2 PV em si ou ser adjacente.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Corda', '0', 1, '10m; +5 em Atletismo pra descer buracos/prédios; amarrar pessoas.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Equipamento de Sobrevivência', '0', 2, '+5 em Sobrevivência pra acampar/orientar-se; permite o teste sem treinamento.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Lanterna Tática', 'I', 1, 'Ilumina cone de 9m; ação de movimento pra ofuscar alvo em alcance curto por 1 rodada.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Máscara de Gás', '0', 1, '+10 em Fortitude contra efeitos que dependam de respiração.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Mochila Militar', 'I', null, 'Não ocupa espaço; +2 espaços de capacidade de carga.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Óculos de Visão Térmica', 'I', 1, 'Elimina penalidade por camuflagem.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Pé de Cabra', '0', 1, '+5 em Força pra arrombar portas; usável como bastão em combate.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Pistola de Dardos', 'I', 1, 'Ataque à distância, alcance curto; acerto deixa inconsciente até o fim da cena (Fortitude DT Agi reduz pra desprevenido+lento por 1 rodada); vem com 2 dardos.', '{"alcance":"curto"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Pistola Sinalizadora', '0', 1, 'Arma de disparo leve, alcance curto, 2d6 dano de fogo; vem com 2 cargas.', '{"dano":"2d6","alcance":"curto"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Soqueira', '0', 1, '+1 em dano desarmado e torna letal; pode receber modificações/maldições de armas corpo a corpo.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Spray de Pimenta', 'I', 1, 'Ação padrão contra adjacente; cego por 1d4 rodadas (Fortitude DT Agi evita); dura 2 usos.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Taser', 'I', 1, 'Ação padrão contra adjacente; 1d6 dano elétrico + atordoado por 1 rodada (Fortitude DT Agi evita); dura 2 usos.', '{"dano":"1d6"}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'geral', 'Traje Hazmat', 'I', 2, '+5 em resistência contra efeitos ambientais; resistência a químico 10.', '{}');

-- ============================================================
-- Itens Paranormais (Tabela 3.10)
-- ============================================================

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Amarras de (Elemento)', 'II', 1, 'Imobilizam criaturas vulneráveis ao elemento — Armadilha (gasta as amarras + ação completa + 2 PE, área 3x3m, Reflexos DT Int ou fica imóvel até o fim da cena) ou Laçar (ação padrão + 1 PE, Vontade DT Agi ou paralisa até o próximo turno; manter custa 1 PE/rodada).', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Câmera de Aura Paranormal', 'II', 1, 'Ação padrão + 1 PE pra tirar foto que revela auras paranormais (cor = elemento).', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Componentes Ritualísticos de (Elemento)', '0', 1, 'Necessários pra conjurar rituais daquele elemento (não existem de Medo). Energia: eletricidade, dispositivos tecnológicos, pilhas, cabos, pólvora, moedas, dados, ímãs. Sangue: órgãos, carne, sangue, animais vivos, navalhas, agulhas, arame farpado, correntes, metal enferrujado, fluidos corporais. Morte: ossos, dentes, cinzas, cabelo, cristais pretos, relógios, galhos/folhas secas, raízes, areia, poeira, Lodo. Conhecimento: escrituras, papéis, livros, pergaminhos, lápis/caneta/tinta/giz, pedras preciosas, ouro, cordas, tecido, cristais brancos, vidro, máscaras.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Emissor de Pulsos Paranormais', 'II', 1, 'Ação completa + 1 PE; emite pulso de um elemento que atrai criaturas do mesmo elemento e afasta do elemento oposto (Vontade DT Pre evita).', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Escuta de Ruídos Paranormais', 'II', 1, 'Ação completa + 2 PE; grava por até 24h; ouvir dá +5 em Ocultismo pra identificar criatura.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Medidor de Estabilidade da Membrana', 'II', 1, 'Avalia (com Ocultismo) a chance de manifestação paranormal numa área — não dá respostas definitivas.', '{}'),
  ((select id from sources where slug = 'ordem_paranormal'), 'paranormal', 'Scanner de Manifestação Paranormal de (Elemento)', 'II', 1, 'Ação padrão pra ativar, consome 1 PE/rodada; indica direção de manifestações ativas daquele elemento em alcance longo (rituais, criaturas, itens amaldiçoados).', '{}');

-- ============================================================
-- Itens Amaldiçoados — Maldições
-- ============================================================

insert into cursed_afflictions (source_id, applies_to, elemento, name, effect)
select (select id from sources where slug = 'ordem_paranormal'), v.applies_to, v.elemento::elemento, v.name, v.effect
from (values
  ('arma', 'conhecimento', 'Antielemento', 'Gasta 2 PE ao atacar criatura de um elemento (aleatório se não especificado: 1d4 Conhecimento/Energia/Morte/Sangue); acertando, +4d8 de dano.'),
  ('arma', 'conhecimento', 'Ritualística', 'Armazena um ritual de alvo/área na arma (paga PE normalmente); descarrega como ação livre ao acertar um ataque.'),
  ('arma', 'conhecimento', 'Senciente', 'Ação de movimento + 2 PE pra arma flutuar e atacar sozinha 1x/rodada com suas estatísticas; 1 PE/turno pra manter, senão cai.'),
  ('arma', 'energia', 'Empuxo', 'Arma corpo a corpo ganha alcance curto de arremesso (ou +1 categoria se já tinha) e +1 dado de dano nesse uso; volta voando pra mão após o ataque.'),
  ('arma', 'energia', 'Energética', '2 PE/ataque, +5 no teste de ataque, ignora resistência a dano, converte dano pra Energia.'),
  ('arma', 'energia', 'Vibrante', 'Concede a habilidade Ataque Extra (trilha Operações Especiais); se já tem, reduz custo em -1 PE.'),
  ('arma', 'morte', 'Consumidora', '2 PE ao atacar, acertando o alvo fica imóvel 1 rodada.'),
  ('arma', 'morte', 'Erosiva', '+1d8 dano de Morte; 2 PE ao acertar, +2d4 dano de Morte no início dos 2 próximos turnos do alvo.'),
  ('arma', 'morte', 'Repulsora', '+2 Defesa enquanto empunhada; ao bloquear, 2 PE pra +5 adicional na Defesa.'),
  ('arma', 'sangue', 'Lancinante', '+1d8 dano de Sangue, multiplicado em crítico.'),
  ('arma', 'sangue', 'Predadora', 'Ignora camuflagem/cobertura leves; +1 categoria de alcance (à distância); margem de ameaça duplicada.'),
  ('arma', 'sangue', 'Sanguinária', 'Alvo fica sangrando (2d6/rodada, cumulativo entre acertos); crítico dá 2d10 PV temporários pra você.'),

  ('protecao', 'conhecimento', 'Abascanta', '+5 em resistência contra rituais; 1x/cena, reação + PE igual ao custo pra refletir um ritual de volta no conjurador.'),
  ('protecao', 'conhecimento', 'Profética', 'Resistência a Conhecimento 10; 2 PE pra rerrolar um teste de resistência.'),
  ('protecao', 'conhecimento', 'Sombria', '+5 Furtividade (ignora penalidade de carga); ação de movimento + 1 PE pra parecer roupa comum sem perder propriedades.'),
  ('protecao', 'energia', 'Cinética', '+2 Defesa + resistência a dano 2 (leve/escudo) ou 5 (pesada).'),
  ('protecao', 'energia', 'Lépida', '+10 Atletismo, +3m deslocamento; 2 PE pra ignorar terreno difícil + deslocamento de escalada + imunidade a queda até 9m até o fim do turno.'),
  ('protecao', 'energia', 'Voltaica', 'Resistência a Energia 10; ação de movimento + 2 PE pra emitir arcos (2d6 dano de Energia em adjacentes no fim de cada turno) até o fim da cena.'),
  ('protecao', 'morte', 'Letárgica', '+2 Defesa; 25% (leve/escudo) ou 50% (pesada) de chance de ignorar dano extra de crítico/furtivo.'),
  ('protecao', 'morte', 'Repulsiva', 'Resistência a Morte 10; ação de movimento + 2 PE pra cobrir de Lodo (quem atacar corpo a corpo sofre 2d8 dano de Morte) até o fim da cena.'),
  ('protecao', 'sangue', 'Regenerativa', 'Resistência a Sangue 10; ação de movimento + 1 PE pra recuperar 1d12 PV.'),
  ('protecao', 'sangue', 'Sádica', 'No início do turno, +1 em ataque/dano a cada 10 pontos de dano sofrido desde o último turno.'),

  ('acessorio', 'conhecimento', 'Carisma', '+1 Presença (sem PE extra).'),
  ('acessorio', 'conhecimento', 'Conjuração', 'Tem um ritual de 1º círculo embutido, conjurável se empunhado (custo -1 PE se você já conhece o ritual).'),
  ('acessorio', 'conhecimento', 'Escudo Mental', 'Resistência mental 10.'),
  ('acessorio', 'conhecimento', 'Reflexão', '1x/rodada, PE igual ao custo pra refletir um ritual no conjurador.'),
  ('acessorio', 'conhecimento', 'Sagacidade', '+1 Intelecto (sem perícias/graus extras).'),
  ('acessorio', 'energia', 'Defesa', '+5 Defesa.'),
  ('acessorio', 'energia', 'Destreza', '+1 Agilidade.'),
  ('acessorio', 'energia', 'Potência', '+1 na DT contra suas próprias habilidades/poderes/rituais.'),
  ('acessorio', 'morte', 'Esforço Adicional', '+5 PE (ativa após 1 dia de uso).'),
  ('acessorio', 'sangue', 'Disposição', '+1 Vigor.'),
  ('acessorio', 'sangue', 'Pujança', '+1 Força.'),
  ('acessorio', 'sangue', 'Vitalidade', '+15 PV (ativa após 1 dia de uso).'),
  ('acessorio', null, 'Proteção Elemental', 'Resistência 10 contra um elemento (varia); o acessório conta como item desse elemento.')
) as v(applies_to, elemento, name, effect);

-- ============================================================
-- Itens Amaldiçoados Especiais
-- ============================================================

insert into cursed_items_special (source_id, name, description, category, spaces)
select (select id from sources where slug = 'ordem_paranormal'), v.name, v.description, 'II'::item_category, 1
from (values
  ('Coração Pulsante', 'Reação pra reduzir dano à metade ao espremer o item; teste de Fortitude crescente a cada uso/dia ou o item é destruído; precisa ser drenado 1x/dia.'),
  ('Coroa de Espinhos', '1x/rodada, reação pra converter dano mental em dano de Sangue; não recupera Sanidade por descanso enquanto veste. Ativa após 1 semana de uso.'),
  ('Frasco de Vitalidade', '1 minuto + até 20 PV pra encher com o próprio sangue; ação padrão pra beber e recuperar o mesmo PV (Fortitude DT 20 ou fica enjoado 1 rodada).'),
  ('Pérola de Sangue', 'Ação de movimento pra absorver, +5 em Agilidade/Força/Vigor até o fim da cena; ao final, Fortitude DT 20 ou fatigado (falhar por 5+ = parada cardíaca, morrendo).'),
  ('Punhos Enraivecidos', 'Soqueiras +1d8 dano de Sangue desarmado, letal; ataques desarmados extra pagando PE crescente (2/4/6...).'),
  ('Seringa de Transfiguração', 'Ação padrão pra sugar sangue de adjacente; ação padrão pra injetar em outro, transfigurando a aparência (como Distorcer Aparência, duração 1 dia); ao acabar, 1d6 — resultado 1 causa -1 PV permanente.'),
  ('Amarras Mortais', 'Ação padrão + 2 PE pra agarrar (+10 no teste oposto) alvo Grande ou menor em alcance curto; ação de movimento pra puxar alvo agarrado pra adjacente.'),
  ('Casaco de Lodo', 'Resistência a corte/impacto/Morte/perfuração 5, vulnerabilidade a balístico e Energia.'),
  ('Coletora', 'Ação completa pra apunhalar um moribundo, matando-o e armazenando 1d8 PE (máx. 20, usáveis como seus após 1 semana portando); pesadelos = condições de descanso sempre ruins.'),
  ('Crânio Espiral', 'Ação livre pra ação padrão extra na rodada; Vontade DT crescente por uso/dia ou envelhece 1d4 anos e não pode reusar no dia.'),
  ('Frasco de Lodo', 'Ação padrão pra curar — ferimento recente (até 1 rodada): 6d8+20 PV; mais antigo: 1d, par=3d8+10 PV cura, ímpar=3d8+10 dano de Morte (infecciona). Uso único.'),
  ('Vislumbre do Fim', 'Ação de movimento pra descobrir informação de morte de um alvo visto (contador de tempo pra pessoas comuns; pior resistência + vulnerabilidades pra Marcados/criaturas).'),
  ('Anéis do Elo Mental', 'Par de anéis; 24h de uso pra ativar; conecta como o ritual Invadir Mente (ligação telepática) enquanto usados; dano mental de um afeta o outro dobrado, condições mentais/medo se propagam.'),
  ('Lanterna Reveladora', 'Ação padrão + 1 PE, luz por 1 cena com propriedades de Terceiro Olho; incomoda criaturas de Sangue (atacam o portador preferencialmente).'),
  ('Máscara das Pessoas nas Sombras', 'Resistência a Conhecimento 10; ação de movimento + 2 PE pra "entrar" numa sombra adjacente e reaparecer noutra em alcance médio.'),
  ('Munição Jurada', 'Ritual de 1h vincula a bala a um ser conhecido; contra ele, +10 no ataque, dobra margem de ameaça, +6d12 dano de Conhecimento; -2 Defesa/ataque contra qualquer outro alvo enquanto a possuir.'),
  ('Pergaminho da Pertinácia', 'Ação padrão pra 5 PE temporários até o fim da cena; Ocultismo DT crescente por uso/dia ou o pergaminho se desfaz.'),
  ('Bateria Reversa', 'Ação padrão + 2 PE pra descarregar dispositivo eletrônico em alcance curto; se cheia, ação padrão pra recarregar outro; Ocultismo DT crescente por uso/dia ou explode (12d6 dano de Energia em 3m).'),
  ('Peitoral da Segunda Chance', 'Ao cair a 0 PV, gasta 5 PE automaticamente pra reanimar com 4d10 PV (falha se não tiver PE); 1 em 1d10 de chance de explodir e matar instantaneamente.'),
  ('Talismã da Sorte', 'Reação + 3 PE ao sofrer dano, rola 1d4 — 2-3: evita todo o dano; 4: evita o dano mas o talismã se destrói; 1: sofre o dobro do dano e o talismã se destrói.'),
  ('Teclado de Conexão Neural', 'Conecta mente a computador — sem impedimento tecnológico/idioma, +10 pra hackear, metade do tempo pra localizar arquivos; 1d6 dano mental por rodada de uso.'),
  ('Tela do Pesadelo', 'Ação padrão + 2 PE pra ativar; próxima pessoa a tocar sofre Vontade DT crescente ou fica atordoada + 4d6 dano mental (repete o teste a cada rodada até passar ou enlouquecer, ou até destruírem a tela).'),
  ('Veículo Energizado', 'Não precisa de combustível; reação + Pilotagem DT 25 pra atravessar um objeto como incorpóreo por um instante.'),
  ('Jaqueta de Veríssimo', 'Item único, categoria IV. Resistência a dano paranormal 15; reação + 2 PE pra virar o alvo do dano em vez de um aliado adjacente.'),
  ('Dedo Decepado', 'Concede um poder paranormal do dono original (elemento define a maldição); ao descansar, 1d4 — resultado 1 = assombrado por memórias, não recupera PV/PE/Sanidade; usar o item é visto = -10 Diplomacia. Ativa após 1 semana de uso.'),
  ('Selos Paranormais', 'Cada selo contém um ritual pronto — empunhar + ler em voz alta (ação padrão ou a ação de conjuração do ritual, o que for maior); precisa conhecer o ritual ou Ocultismo DT 20+custo em PE; ao ativar, o ritual é conjurado e o selo vira cinzas; categoria = círculo do ritual contido.')
) as v(name, description);

-- Arcabuz dos Moretti e Relógio de Arnaldo são itens únicos (elemento Energia) com regras próprias
insert into cursed_items_special (source_id, name, description, category, spaces)
values
  ((select id from sources where slug = 'ordem_paranormal'), 'Arcabuz dos Moretti', 'Item único. Arma simples de fogo, uma mão, +2 ataque, dano de Energia; ao disparar, 1d6 define o dado de dano (2d4 a 2d20); alcance curto, crítico x3, sem necessidade de munição.', 'II', 1),
  ((select id from sources where slug = 'ordem_paranormal'), 'Relógio de Arnaldo', 'Item único. 1 PE/rodada pra rerrolar qualquer dado com resultado 1; custo sobe +1 a cada uso no mesmo dia.', 'II', 1);
