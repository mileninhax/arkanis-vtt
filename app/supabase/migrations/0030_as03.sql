-- Arquivos Secretos 03: Veículos e Animais viram Regras Extras (5.10); Regra da Paixão já
-- implementada em Interlúdio (mesmos números, sem mudança necessária); itens novos entram
-- no catálogo; fichas "Aliado" dos Couraças ficam de fora (Mesa/bestiário, não personagem).

insert into extra_rules (source_id, category, title, content, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'equipamento_especial', 'Veículos Operacionais',
  'Veículo se torna relevante em 3 situações — viagens (narrativa, sem regra), perseguições (regras de Perseguição já catalogadas), e combates (regras abaixo).

As 3 Categorias de Veículo:
- Categoria II — Carros populares: tamanho Grande, Defesa 8 (+Agi motorista), RD 5, 100 PV, carrega 4 seres médios/20 espaços (ou 100 espaços total), 1 regalia.
- Categoria III — Vans operacionais: tamanho Grande, Defesa 10 (+Agi motorista), RD 10, 150 PV, carrega 5 seres médios/30 espaços (ou 130 total), 2 regalias.
- Categoria IV — Trailers/motocasas: tamanho Enorme, Defesa 12 (+Agi motorista), RD 15, 200 PV, carrega 6 seres médios/40 espaços (ou 160 total), 3 regalias.
A categoria disponível depende da patente mais alta entre os agentes da equipe.

Deslocamento: não depende da categoria, mas da habilidade do condutor. Teste de Pilotagem no início da cena — DT superada define a velocidade até o fim da cena: DT5→15m/rodada · DT10→18m · DT15→21m · DT20→24m · DT25→27m · DT30+→30m.

Direção Combativa:
- Direção: ação completa por rodada; ou ação de movimento + Pilotagem DT 20 (falhar por 5+ = acidente).
- Colidir: alvo testa Reflexos oposto à Pilotagem — perdendo, sofre 1d6 dano de impacto por 1,5m percorrido antes da colisão; veículo sofre metade desse dano.
- Disparos em Movimento: -1d20 em Pontaria de dentro do veículo em movimento; mirar pra fora anula a penalidade mas perde cobertura.
- Manobras Evasivas: treinado em Pilotagem, 1x/rodada, reação pra somar o bônus de Pilotagem na Defesa do veículo contra um ataque.

Combustível: pilha de 5d6 ("tanque cheio"). A cada trecho/parada, rola os dados restantes e remove os que derem 1. Reabastecer volta a 5d6; galão vermelho recupera 2d6.

Danificando Veículos: pontos vitais têm Defesa +10. Metade dos PV = danificado (deslocamento pela metade, perde cobertura). Atingiu o Tanque (arma de fogo, 1d6 ímpar): explode, raio 9m, 12d6 dano (Reflexos DT 25 reduz/evita, só fora do veículo). Estilhaçou as Janelas: 2d4 perfuração no mais próximo (Reflexos DT 20 reduz à metade). Furou um Pneu: -1d20 Pilotagem e -3m deslocamento (cumulativo). Quebrou os Faróis: pilotar no escuro sem faróis = dirigir cego.

Dano Massivo (50%+ dos PV num único ataque, sempre gera defeito persistente, 1d8): 1 Perda Total · 2 Freio Defeituoso · 3 Pneu Furado · 4 Suspensão Danificada (terreno difícil = 2d6 PV/rodada) · 5 Motor Superaquecido · 6 Faróis Quebrados · 7 Tanque Furado (um dado de combustível sempre 1) · 8 Portas Danificadas.

Reparando: cena de interlúdio, 1+ ações + Profissão de conserto — DT10→20PV · DT15→metade+remove 1 penalidade · DT20→metade+remove 3 · DT25→metade+remove todas · DT30→tudo+remove todas.

Regalias (ao adquirir): Arsenal Secreto (até 3x/missão, item da patente acessível sem ocupar espaço), Aprimoramentos de Velocidade (+5 Pilotagem), Bancos Reclináveis (dormir dentro = confortável), Estação de Trabalho (+2 numa perícia dentro do veículo), Janelas Blindadas (RD+5, cobertura total mesmo danificado), Lataria Reforçada (Defesa+5, até 2x), Para-choques Letais (atropelamento +2d6/1,5m, muda tipo de dano), Quadro de Investigação (+5 revisar caso em interlúdio), Tração nas Quatro Rodas (ignora terreno difícil).

Exemplo: Motocicleta — categoria III, tamanho Médio, Defesa 14 (+Agi), RD 5, 120 PV, carrega 2 seres médios/5 espaços (ou 45 total); Arsenal Secreto + Aprimoramentos de Velocidade.',
  1
),
(
  (select id from sources where slug = 'arquivos_secretos_03'), 'mecanicas_de_cena', 'Animais Treinados',
  'Treinar um animal sem origem/poder que já treina: gasta uma Folga da Ordem se dedicando ao relacionamento — independente de passar nos testes, o animal fica adestrado ao final.

Duas formas de jogar o pet:

Aliado Animal (opções especiais, substituem as regras padrão): Corvo (+2 Percepção/Sobrevivência; Ataque os Olhos: 1 PE deixa alvo ofuscado 1 rodada, crítico=cego); Gato (+2 Percepção/Reflexos; Visão Noturna: 1 PE fica alerta até fim da cena em escuridão não-paranormal); Serpente (+2 Enganação/Intimidação; Peçonhenta: 1 PE causa também 1d12 dano por veneno).

Ficha de Ameaça da Realidade (alternativa): o animal não é aliado, tem ficha própria de ameaça mundana controlada pelo dono. VD escala com o NEX do agente (0-10%→VD10, 15%→VD20, 20%→VD40, 25%→VD60, 30%→VD80, 35%→VD100... até 99%→VD360). Animais não sofrem Presença Perturbadora. Como ficha, corre riscos reais (pode morrer em combate).',
  2
);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
((select id from sources where slug = 'arquivos_secretos_03'), 'arma', 'Garra do Harpia', 'I', 2, 'Tática, ágil, corpo a corpo/duas mãos, arremessável em alcance curto; causando dano, gasta 2 PE pra manobra de agarrar como ação livre; compatível com Combater com Duas Armas.', '{"dano":"2d8","critico":"19","tipo_dano":"C","natureza":"corpo_a_corpo","empunhadura":"duas_maos"}'),
((select id from sources where slug = 'arquivos_secretos_03'), 'geral', 'Bloody Mary Batizada', 'II', 1, 'Bebida; remove uma condição mental/de medo, mas causa 2d4 dano mental.', '{}'),
((select id from sources where slug = 'arquivos_secretos_03'), 'geral', 'Paçoca', '0', 0.5, 'Conta como prato rápido; em ocasiões especiais pode dar benefício extra a critério do mestre.', '{}'),
((select id from sources where slug = 'arquivos_secretos_03'), 'paranormal', 'Crânio Dominador', 'III', 1, 'Morte. Empunhando, ação padrão + 2 PE paralisa até 2 alvos em alcance curto com correntes (Reflexos DT Pre evita); só rompe destruindo a corrente (Defesa 10, RD 10, 20 PV); recarrega em 24h.', '{"elemento":"morte"}'),
((select id from sources where slug = 'arquivos_secretos_03'), 'paranormal', 'Gaiola do Corvo', 'IV', 2, 'Morte. Empunhando, ação padrão abre a gaiola — raio 18m vira Lodo/terreno difícil; quem começa turno nele sofre 3d10 dano de Morte (Fortitude DT Vig reduz à metade); quem morre ali é consumido permanentemente; fechar é ação padrão.', '{"elemento":"morte"}');

insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_03'), 'Camiseta Psikolera', 'Sangue. Vestimenta; machucado, rolagens de dano +2d8 Sangue.', 'II', 1),
((select id from sources where slug = 'arquivos_secretos_03'), 'Dupla Obsessiva', 'Sangue. Maça + florete: maça (tática, uma mão, 2d4 perfuração + 1d6 Sangue, crítico 20/x3) e florete (tática ágil, uma mão, 1d6 perfuração + 2d4 Sangue, crítico 18/x2); empunhando as duas, ação padrão ataca com ambas; 2 PE como reação pra virar alvo de ataque destinado a aliado em alcance curto, mais 2 PE pra revidar com a maça.', 'III', 2),
((select id from sources where slug = 'arquivos_secretos_03'), 'Armaduras de Guevara', 'Item único. Proteção pesada amaldiçoada de Sangue: Defesa +10 (+1 por semana de uso, até +20); dispensa proficiência; RD balístico/impacto/perfuração 5, Sangue 10; vulnerabilidade a Morte. Quem toca precisa passar em Vontade (DT rolada em 6d6) ou é compelido a vesti-la; vestida, Fortitude (DT 6d6) ou o Sangue pode assumir controle da pessoa; remover é quase impossível (sofrer dano de Morte até 0 PV). Testes se repetem a cada semana/missão.', 'III', 0);
