-- Seed: rituais (Livro Base, 11.7). Fonte: docs/VTT_Conteudo_Ordem_Paranormal.md
-- Colunas discente/verdadeiro_requires_circle e _requires_affinity extraem a exigência citada no
-- próprio texto da variação; o texto completo da variação (incluindo essa exigência) fica preservado
-- em discente_effect/verdadeiro_effect.

create temporary table ritual_seed (
  name text, elemento elemento, circle int,
  execution text, range text, target text, duration text, resistance text, effect text,
  discente_cost int, discente_effect text, discente_requires_circle int,
  verdadeiro_cost int, verdadeiro_effect text, verdadeiro_requires_circle int, verdadeiro_requires_affinity boolean
);

-- Multi-elemento (I círculo, elemento escolhido ao aprender)
insert into ritual_seed values
('Amaldiçoar Arma', null, 1, 'padrão', 'toque', '1 arma corpo a corpo ou pacote de munição', 'cena', null,
 'Quando aprender este ritual, escolha um elemento entre Conhecimento, Energia, Morte e Sangue. Este ritual passa a ser do elemento escolhido. Você imbui a arma ou munições com o elemento, fazendo com que causem +1d6 de dano do tipo do elemento.',
 2, 'Muda o bônus de dano para +2d6. Requer 2º círculo.', 2,
 5, 'Muda o bônus de dano para +4d6. Requer 3º círculo e afinidade.', 3, true);

-- ============================================================
-- Iº Círculo — Conhecimento
-- ============================================================
insert into ritual_seed values
('Compreensão Paranormal', 'conhecimento', 1, 'padrão', 'toque', '1 ser ou objeto', 'cena', 'Vontade anula (veja texto)',
 'O ritual confere a você compreensão sobrenatural da linguagem. Se tocar um objeto contendo informação, você entende as palavras mesmo que não conheça seu idioma, contanto que se trate de um idioma humano. Se tocar uma pessoa, pode se comunicar com ela como se falassem um idioma em comum. Se tocar um ser não inteligente, pode perceber seus sentimentos básicos. Um alvo involuntário tem direito a um teste de Vontade.',
 2, 'Muda o alcance para "curto" e o alvo para "alvos escolhidos". Você pode entender todos os alvos afetados. Requer 2º círculo.', 2,
 5, 'Muda o alcance para "pessoal" e o alvo para "você". Em vez do normal, pode falar, entender e escrever qualquer idioma humano. Requer 3º círculo.', 3, false),

('Enfeitiçar', 'conhecimento', 1, 'padrão', 'curto', '1 pessoa', 'cena', 'Vontade anula',
 'Torna o alvo prestativo. Ele não fica sob seu controle, mas percebe suas palavras e ações da maneira mais favorável possível. Você recebe +10 em testes de Diplomacia com ele. Alvo hostil ou em combate recebe +5 no teste de resistência. Ações hostis suas contra o alvo dissipam o efeito.',
 2, 'Você sugere uma ação para o alvo e ele obedece, desde que pareça aceitável. Quando executa a ação, o efeito termina. Requer 2º círculo.', 2,
 5, 'Afeta todos os alvos dentro do alcance. Requer 3º círculo.', 3, false),

('Ouvir os Sussurros', 'conhecimento', 1, 'completa', 'pessoal', 'você', 'instantânea', null,
 'Conecta você com os sussurros do Outro Lado. Faça uma pergunta sobre um evento que está prestes a fazer, respondível com "sim" ou "não". O mestre rola 1d6 em segredo: 2-6 o ritual funciona; 1 falha e oferece "não". Lançar múltiplas vezes sobre o mesmo assunto gera sempre o primeiro resultado.',
 2, 'Muda a execução para 1 minuto. Pode consultar os ecos sobre um evento até um dia no futuro, recebendo pistas em vez de sim/não direto. Requer 2º círculo.', 2,
 5, 'Muda a execução para 10 minutos e a duração para 5 rodadas. Pode fazer uma pergunta por rodada, respondível com "sim", "não" ou "ninguém sabe". Requer 3º círculo.', 3, false),

('Perturbação', 'conhecimento', 1, 'padrão', 'curto', '1 pessoa', '1 rodada', 'Vontade anula',
 'Dá uma ordem que o alvo deve obedecer em seu turno: Fuja, Largue, Pare, Sente-se ou Venha.',
 2, 'Muda o alvo para "1 ser" e adiciona o comando "Sofra": 3d8 de dano de Conhecimento e abalado por uma rodada.', null,
 5, 'Muda o alvo para "até 5 seres" ou adiciona o comando "Ataque" (atacar um alvo à sua escolha em alcance médio). Requer 3º círculo e afinidade.', 3, true),

('TecerIlusão', 'conhecimento', 1, 'padrão', 'médio', 'área: ilusão de até 4 cubos de 1,5m', 'cena', 'Vontade desacredita',
 'Cria uma ilusão visual ou sonora simples (sem cheiro, textura ou som complexo). Seres e objetos a atravessam sem sofrer dano.',
 2, 'Muda o efeito para até 8 cubos e a duração para sustentada. Ilusões combinam imagem/som/textura/odor; seres não atravessam sem passar em Vontade; pode mover a ilusão a cada rodada. Requer 2º círculo.', 2,
 5, 'Cria a ilusão de um perigo mortal: quem interagir com ela faz Vontade a cada turno ou sofre 6d6 de dano de Conhecimento (racionaliza o efeito em falhas repetidas). Requer 3º círculo.', 3, false),

('Terceiro Olho', 'conhecimento', 1, 'padrão', 'pessoal', 'você', 'cena', null,
 'Passa a enxergar auras paranormais em alcance longo (rituais, itens amaldiçoados e criaturas), sabendo elemento e poder aproximado. Ação de movimento pra descobrir se um ser em alcance médio tem poderes/rituais e de quais elementos.',
 2, 'Muda a duração para 1 dia.', null,
 5, 'Também enxerga objetos e seres invisíveis, como formas translúcidas.', null, false);

-- ============================================================
-- Iº Círculo — Energia
-- ============================================================
insert into ritual_seed values
('Amaldiçoar Tecnologia', 'energia', 1, 'padrão', 'toque', '1 acessório ou arma de fogo', 'cena', null,
 'Imbui o alvo com Energia, fazendo-o funcionar acima de sua capacidade. O item recebe uma modificação à sua escolha.',
 2, 'Muda para duas modificações. Requer 2º círculo.', 2,
 5, 'Muda para três modificações. Requer 3º círculo e afinidade.', 3, true),

('Coincidência Forçada', 'energia', 1, 'padrão', 'curto', '1 ser', 'cena', null,
 'Manipula os caminhos do caos: o alvo recebe +2 em testes de perícias.',
 2, 'Muda o alvo para aliados à sua escolha. Requer 2º círculo.', 2,
 5, 'Muda o alvo para aliados à sua escolha e o bônus para +5. Requer 3º círculo e afinidade.', 3, true),

('Eletrocussão', 'energia', 1, 'padrão', 'curto', '1 ser ou objeto', 'instantânea', 'Fortitude parcial',
 'Dispara uma corrente elétrica: 3d6 de dano de eletricidade e vulnerável por uma rodada. Passando na resistência, metade do dano e evita a condição. Contra objetos eletrônicos causa o dobro e ignora resistência.',
 2, 'Muda o alvo para "área: linha de 30m". Dispara um raio que causa 6d6 de dano de Energia em todos na área. Requer 2º círculo.', 2,
 5, 'Muda o alvo para "alvos escolhidos": dispara vários relâmpagos, 8d6 de dano de Energia em cada. Requer 3º círculo.', 3, false),

('Embaralhar', 'energia', 1, 'padrão', 'pessoal', 'você', 'cena', null,
 'Cria três cópias ilusórias suas que imitam suas ações. Você recebe +6 na Defesa; cada ataque que erra destrói uma cópia e reduz o bônus em 2.',
 2, 'Muda o número de cópias para 5 (bônus +10). Requer 2º círculo.', 2,
 5, 'Muda o número de cópias para 8 (bônus +16); cada cópia destruída emite um clarão que ofusca o atacante por 1 rodada. Requer 3º círculo.', 3, false),

('Luz', 'energia', 1, 'padrão', 'curto', '1 objeto', 'cena', 'Vontade anula (veja texto)',
 'O alvo emite luz de cores alternadas em raio de 9m (sem calor); pode ser guardado pra interromper.',
 2, 'Muda o alcance para longo e o efeito para 4 esferas brilhantes móveis, cada uma iluminando 6m de raio; ser ocupado por uma fica ofuscado e visível. Requer 2º círculo.', 2,
 5, 'A luz é cálida como a do sol: aliados na área recebem +O em Vontade, inimigos ficam ofuscados. Requer 3º círculo.', 3, false),

('Polarização Caótica', 'energia', 1, 'padrão', 'curto', 'você', 'sustentada', 'Vontade anula',
 'Gera uma aura magnética: Atrair (puxa objeto metálico de espaço 2 ou menor) ou Repelir (resistência a balístico/corte/impacto/perfuração 5).',
 2, 'Muda a duração para instantânea: arremessa até 10 objetos (ou 10 espaços) próximos entre si, causando dano de impacto a quem atingirem (Reflexos reduz à metade).', null,
 5, 'Muda o alcance para médio e a duração para instantânea: levita e move um ser ou objeto de espaço 10 ou menor por até 9m (Vontade anula).', null, false);

-- ============================================================
-- Iº Círculo — Morte
-- ============================================================
insert into ritual_seed values
('Cicatrização', 'morte', 1, 'padrão', 'toque', '1 ser', 'instantânea', null,
 'Acelera o tempo ao redor das feridas: o alvo recupera 3d8+3 PV, mas envelhece 1 ano automaticamente.',
 2, 'Aumenta a cura para 5d8+5 PV. Requer 2º círculo.', 2,
 9, 'Muda o alcance para "curto", o alvo para "seres escolhidos" e aumenta a cura para 7d8+7 PV. Requer 4º círculo e afinidade com Morte.', 4, true),

('Consumir Manancial', 'morte', 1, 'padrão', 'pessoal', 'você', 'instantânea', null,
 'Suga tempo de vida de plantas/insetos/solo ao redor, recebendo 3d6 PV temporários (somem no fim da cena).',
 2, 'Muda os PV temporários para 6d6. Requer 2º círculo.', 2,
 5, 'Muda o alvo para "área: esfera com 6m de raio centrada em você" e a resistência para "Fortitude reduz à metade": suga energia de todos os seres vivos na área, causando 3d6 de dano de Morte em cada e recebendo PV temporários iguais ao dano total. Requer 3º círculo e afinidade.', 3, true),

('Decadência', 'morte', 1, 'padrão', 'toque', '1 ser', 'instantânea', 'Fortitude reduz à metade',
 'Espirais de trevas definham o alvo, causando 2d8+2 de dano de Morte.',
 2, 'Muda a resistência para "nenhuma" e o dano para 3d8+3. Transfere as espirais para uma arma e faz um ataque corpo a corpo com ela (dano da arma + do ritual, somados).', null,
 5, 'Muda o alcance para "pessoal", o alvo para "área: explosão com 6m de raio" e o dano para 8d8+8. Requer 3º círculo.', 3, false),

('Definhar', 'morte', 1, 'padrão', 'curto', '1 ser', 'cena', 'Fortitude parcial',
 'Dispara cinzas que drenam as forças do alvo: fica fatigado; se passar na resistência, fica vulnerável.',
 2, 'Em vez do normal, o alvo fica exausto (fatigado se passar). Requer 2º círculo.', 2,
 5, 'Como Discente, mas muda o alvo para "até 5 seres". Requer 3º círculo e afinidade com Morte.', 3, true),

('Espirais da Perdição', 'morte', 1, 'padrão', 'curto', '1 ser', 'cena', null,
 'Espirais tornam os movimentos do alvo lentos: –O em testes de ataque.',
 2, 'Muda a penalidade para –OO. Requer 2º círculo.', 2,
 8, 'Muda a penalidade para –OO e o alvo para "seres escolhidos". Requer 3º círculo.', 3, false),

('Nuvem de Cinzas', 'morte', 1, 'padrão', 'curto', 'área: nuvem com 6m de raio e 6m de altura', 'cena', null,
 'Fuligem espessa obscurece a visão — seres a até 1,5m têm camuflagem leve, a partir de 3m camuflagem total. Vento forte dispersa em 4 rodadas, vendaval em 1.',
 2, 'Pode escolher seres no alcance ao conjurar que enxergam através do efeito. Requer 2º círculo.', 2,
 5, 'A nuvem fica quase sólida: deslocamento de quem está dentro cai para 3m e sofre –2 em ataque. Requer 3º círculo.', 3, false);

-- ============================================================
-- Iº Círculo — Sangue
-- ============================================================
insert into ritual_seed values
('Arma Atroz', 'sangue', 1, 'padrão', 'toque', '1 arma corpo a corpo', 'sustentada', null,
 'A arma é recoberta por veias carmesim: +2 em testes de ataque e +1 na margem de ameaça.',
 2, 'Muda o bônus para +5 em testes de ataque. Requer 2º círculo.', 2,
 5, 'Muda o bônus para +5 em ataque e +2 na margem de ameaça e no multiplicador de crítico. Requer 3º círculo e afinidade.', 3, true),

('Armadura de Sangue', 'sangue', 1, 'padrão', 'pessoal', 'você', 'cena', null,
 'Seu sangue forma uma carapaça: +5 em Defesa. Cumulativo com outros rituais, mas não com equipamento.',
 5, 'Muda o efeito para +10 na Defesa e resistência a balístico/corte/impacto/perfuração 5. Requer 3º círculo.', 3,
 9, 'Muda o efeito para +15 na Defesa e resistência a balístico/corte/impacto/perfuração 10. Requer 4º círculo e afinidade.', 4, true),

('Corpo Adaptado', 'sangue', 1, 'padrão', 'toque', '1 pessoa ou animal', 'cena', null,
 'Modifica a biologia do alvo: fica imune a calor/frio extremos, pode respirar na água se respira ar (ou vice-versa) e não sufoca em fumaça densa.',
 2, 'Muda a duração para 1 dia.', null,
 5, 'Muda o alcance para "curto" e o alvo para "pessoas ou animais escolhidos".', null, false),

('Distorcer Aparência', 'sangue', 1, 'padrão', 'pessoal', 'você', 'cena', 'Vontade desacredita',
 'Modifica sua aparência pra parecer outra pessoa. +10 em Enganação pra disfarce, mas não recebe habilidades da nova forma.',
 2, 'Muda o alcance para "curto" e o alvo para "1 ser" (involuntário pode anular com Vontade).', null,
 5, 'Como Discente, mas muda o alvo para "seres escolhidos". Requer 3º círculo.', 3, false),

('Fortalecimento Sensorial', 'sangue', 1, 'padrão', 'pessoal', 'você', 'cena', null,
 'Potencializa seus sentidos: +O em Investigação, Luta, Percepção e Pontaria.',
 2, 'Além do normal, inimigos sofrem –O em testes de ataque contra você. Requer 2º círculo.', 2,
 5, 'Além do normal, fica imune a surpreendido e desprevenido e recebe +10 em Defesa e Reflexos. Requer 4º círculo e afinidade.', 4, true),

('Ódio Incontrolável', 'sangue', 1, 'padrão', 'toque', '1 pessoa', 'cena', null,
 'O alvo entra em frenesi: +2 em ataque e dano corpo a corpo e resistência a balístico/corte/impacto/perfuração 5; não pode fazer ações calmas e deve sempre atacar (mesmo aliados) enquanto durar.',
 2, 'Além do normal, sempre que usar agredir, pode fazer um ataque corpo a corpo adicional contra o mesmo alvo.', null,
 5, 'Muda o bônus de ataque/dano para +5 e o alvo sofre só metade do dano balístico/corte/impacto/perfuração. Requer 3º círculo e afinidade.', 3, true);

-- ============================================================
-- Iº Círculo — Medo
-- ============================================================
insert into ritual_seed values
('Cinerária', 'medo', 1, 'padrão', 'curto', 'área: nuvem de 6m de raio', 'cena', null,
 'Manifesta uma névoa carregada de essência paranormal: rituais conjurados dentro têm a DT aumentada em +5.',
 2, 'Além do normal, rituais conjurados dentro da névoa custam –2 PE.', null,
 5, 'Além do normal, rituais conjurados dentro da névoa causam dano maximizado.', null, false);

-- ============================================================
-- IIº Círculo — Conhecimento
-- ============================================================
insert into ritual_seed values
('Aprimorar Mente', 'conhecimento', 2, 'padrão', 'toque', '1 ser', 'cena', null,
 'O alvo recebe +1 em Intelecto ou Presença, à escolha dele (PE, perícias treinadas ou graus de treinamento).',
 3, 'Muda o bônus para +2. Requer 3º círculo.', 3,
 7, 'Muda o bônus para +3. Requer 4º círculo e afinidade.', 4, true),

('Detecção de Ameaças', 'conhecimento', 2, 'padrão', 'pessoal', 'área: esfera de 18m de raio', 'cena', null,
 'Percepção aguçada sobre perigos: quando um hostil/armadilha entra na área, pode gastar ação de movimento pra Percepção (DT 20) e saber direção/distância.',
 3, 'Além do normal, não fica desprevenido contra perigos detectados e recebe +5 em resistência contra armadilhas. Requer 3º círculo.', 3,
 5, 'Muda a duração para "1 dia" e concede os mesmos benefícios de Discente. Requer 4º círculo.', 4, false),

('Esconder dos Olhos', 'conhecimento', 2, 'livre', 'pessoal', 'você', '1 rodada', null,
 'Fica invisível (incluindo equipamento), camuflagem total e +15 em Furtividade. Termina se atacar ou usar habilidade hostil.',
 3, 'Muda a duração para "sustentada": você e aliados a até 3m ficam invisíveis, movendo-se junto com você. Requer 3º círculo.', 3,
 7, 'Muda a execução para "ação padrão", o alcance para "toque", o alvo para "1 ser" e a duração para "sustentada"; não dissipa mesmo com ataque/ação hostil. Requer 4º círculo e afinidade.', 4, true),

('Invadir Mente', 'conhecimento', 2, 'padrão', 'médio ou toque', '1 ser ou 2 pessoas voluntárias', 'instantânea ou 1 dia', 'Vontade parcial ou nenhuma',
 'Escolha: Rajada Mental (6d6 de dano de Conhecimento, atordoado 1 rodada, resistência reduz à metade e evita atordoamento) ou Ligação Telepática (elo mental de comunicação entre duas pessoas por 1 dia).',
 3, 'Rajada: aumenta o dano para 10d6. Ligação: cria elo que permite gastar ação de movimento pra ver/ouvir pelos sentidos do alvo (involuntário pode suprimir por 1h com Vontade). Requer 3º círculo.', 3,
 7, 'Rajada: dano 10d6, alvo "seres escolhidos". Ligação: vínculo entre até 5 pessoas. Requer 4º círculo.', 4, false),

('Localização', 'conhecimento', 2, 'padrão', 'pessoal', 'área: círculo com 90m de raio', 'cena', null,
 'Encontra uma pessoa ou objeto à sua escolha (termos gerais ou específicos); indica direção e distância do mais próximo desse tipo. Bloqueável por uma fina camada de chumbo.',
 3, 'Muda o alcance para "toque", o alvo para "1 pessoa" e a duração para "1 hora": em vez do normal, a pessoa tocada descobre o caminho mais direto pra entrar/sair de um lugar.', null,
 7, 'Aumenta a área para círculo de 1km de raio. Requer 4º círculo.', 4, false);

-- ============================================================
-- IIº Círculo — Energia
-- ============================================================
insert into ritual_seed values
('Chamas do Caos', 'energia', 2, 'padrão', 'curto', 'veja texto', 'cena', null,
 'Manipula calor/fogo — escolha: Chamejar (arma corpo a corpo +1d6 dano de fogo), Esquentar (objeto sofre/causa 1d6/rodada, pode pegar fogo), Extinguir (apaga chama Grande ou menor, cria fumaça 3m) ou Modelar (move chama Grande ou menor 9m/rodada, 3d6 dano a quem atravessar).',
 3, 'Muda a duração para sustentada e adiciona Resistência: Reflexos reduz à metade. Uma vez por rodada projeta uma labareda em alcance curto, 4d6 de dano de Energia.', null,
 7, 'Como Discente, mas muda o dano para 8d6. Requer 3º círculo.', 3, false),

('Contenção Fantasmagórica', 'energia', 2, 'padrão', 'médio', '1 ser', 'cena', 'Reflexos anula',
 'Três laços de Energia enroscam o alvo, deixando-o agarrado. Cada laço: Defesa 10, 10 PV, RD 5, imune a Energia; destruir todos dissipa o ritual.',
 3, 'Aumenta o número de laços para 6, com um mínimo de dois por alvo escolhido. Requer 3º círculo.', 3,
 5, 'Como Discente, e cada laço destruído libera onda de choque (2d6+2 de dano de Energia). Requer 3º círculo e afinidade.', 3, true),

('Dissonância Acústica', 'energia', 2, 'padrão', 'médio', 'área: esfera com 6m de raio', 'sustentada', null,
 'Seres na área ficam surdos e não conseguem conjurar rituais.',
 1, 'Muda a área para "alvo: 1 objeto": emana silêncio de 3m de raio (alvo involuntário pode anular com Vontade).', null,
 3, 'Muda a duração para cena: nenhum som sai da área, mas quem está dentro pode falar/ouvir/conjurar normalmente. Requer 3º círculo.', 3, false),

('Sopro do Caos', 'energia', 2, 'padrão', 'médio', 'área varia', 'sustentada', 'veja texto',
 'Manipula massas de ar — escolha: Ascender (levita alvo Médio até 30m, ação de movimento pra mover 6m/rodada), Sopro (empurra alvos Médios ou menores num cone de 4,5m) ou Vento (cria/aumenta área de vento forte).',
 3, 'Passa a afetar alvos Grandes.', null,
 9, 'Passa a afetar alvos Enormes.', null, false),

('Tela de Ruído', 'energia', 2, 'padrão', 'pessoal', 'você', 'cena', null,
 'Película de Energia absorve energia cinética: 30 PV temporários só contra balístico/corte/impacto/perfuração. Alternativa: reação ao sofrer dano, resistência 15 só contra esse dano.',
 3, 'Aumenta os PV temporários para 60 e a resistência para 30.', null,
 7, 'Muda o alcance para curto e o alvo para 1 ser ou objeto Enorme ou menor: cria esfera intransponível a seres/objetos/dano, mas permite respirar dentro (Reflexos evita ser aprisionado). Requer 4º círculo.', 4, false);

-- ============================================================
-- IIº Círculo — Morte
-- ============================================================
insert into ritual_seed values
('Desacelerar Impacto', 'morte', 2, 'reação', 'curto', '1 ser ou objetos somando até 10 espaços', 'até chegar ao solo ou cena', null,
 'A queda do alvo desacelera para 18m/rodada, sem causar dano. Se o alvo for um projétil, causa metade do dano normal devido à lentidão. Só funciona em queda livre ou similar.',
 null, null, null,
 3, 'Aumenta o total de alvos para seres ou objetos somando até 100 espaços.', null, false),

('Eco Espiral', 'morte', 2, 'padrão', 'curto', '1 ser', '2 rodadas', 'Fortitude reduz à metade',
 'Manifesta uma cópia de cinzas do alvo. No turno seguinte precisa se concentrar (ação padrão) ou ela se dissipa; no segundo turno precisa descarregá-la — se fizer, ela explode causando dano de Morte igual ao dano que o alvo sofreu na rodada da concentração.',
 3, 'Muda o alvo para "até 5 seres".', null,
 7, 'Muda a duração para "até 3 rodadas", permitindo concentrar nas duas primeiras e descarregar na terceira. Requer 4º círculo e afinidade.', 4, true),

('Miasma Entrópico', 'morte', 2, 'padrão', 'médio', 'área: nuvem com 6m de raio', 'instantânea', 'Fortitude parcial (veja texto)',
 'Explosão de emanações tóxicas: 4d8 de dano químico e enjoado por 1 rodada; passando na resistência, metade do dano e sem a condição.',
 3, 'Muda o dano para 6d8 de Morte.', null,
 7, 'Como a versão Discente, mas muda a duração para 3 rodadas — quem inicia o turno na área sofre o dano de novo. Requer 3º círculo.', 3, false),

('Paradoxo', 'morte', 2, 'padrão', 'médio', 'área: esfera com 6m de raio', 'instantânea', 'Fortitude reduz à metade',
 'Implosão de distorção temporal: 6d6 de dano de Morte em todos na área.',
 3, 'Muda a área para "efeito: esfera de 1,5m de diâmetro" e a duração para cena: cria esfera móvel (ação de movimento pra voar 9m) que causa 4d6 de dano de Morte a quem tocar (1x/rodada por alvo).', null,
 7, 'Muda o dano para 13d6; reduzidos a 0 PV devem passar em Fortitude ou são reduzidos a cinzas (morte imediata). Requer 4º círculo.', 4, false),

('Velocidade Mortal', 'morte', 2, 'padrão', 'curto', '1 ser', 'sustentada', null,
 'Distorce o tempo ao redor do alvo: recebe uma ação de movimento adicional por turno (não pode ser usada pra conjurar rituais).',
 3, 'Em vez de ação de movimento, o alvo recebe uma ação padrão adicional por turno.', null,
 7, 'Muda o alvo para "alvos escolhidos". Requer 4º círculo e afinidade.', 4, true);

-- ============================================================
-- IIº Círculo — Sangue
-- ============================================================
insert into ritual_seed values
('Aprimorar Físico', 'sangue', 2, 'padrão', 'toque', '1 ser', 'cena', null,
 'Músculos tonificados e ligamentos reforçados: +1 em Agilidade ou Força, à escolha do alvo.',
 3, 'Muda o bônus para +2. Requer 3º círculo.', 3,
 7, 'Muda o bônus para +3. Requer 4º círculo e afinidade.', 4, true),

('Descarnar', 'sangue', 2, 'padrão', 'toque', '1 ser', 'instantânea', 'Fortitude parcial',
 'Lacerações se manifestam na pele/órgãos do alvo: 6d8 de dano (metade corte, metade Sangue) e hemorragia (2d8/turno até passar dois testes de Fortitude seguidos); passando na resistência inicial, metade do dano e sem hemorragia.',
 3, 'Muda o dano direto para 10d8 e o dano de hemorragia para 4d8. Requer 3º círculo.', 3,
 7, 'Muda o alvo para "você" e a duração para sustentada: seus ataques corpo a corpo causam 4d8 de dano de Sangue adicional e aplicam a hemorragia automaticamente. Requer 3º círculo e afinidade.', 3, true),

('Flagelo de Sangue', 'sangue', 2, 'padrão', 'toque', '1 pessoa', 'cena', 'Fortitude parcial',
 'Grava uma marca escarificada com uma ordem; a cada rodada que o alvo desobedecer, sofre 10d6 de dano de Sangue e fica enjoado (resistência reduz à metade e evita a condição). Passando em dois testes seguidos, a marca desaparece.',
 3, 'Muda o alvo para "1 ser (exceto criaturas de Sangue)". Requer 3º círculo.', 3,
 7, 'Como Discente, e muda a duração para "1 dia". Requer 4º círculo e afinidade.', 4, true),

('Hemofagia', 'sangue', 2, 'padrão', 'toque', '1 ser', 'instantânea', 'Fortitude reduz à metade',
 'Arranca o sangue do alvo: 6d6 de dano de Sangue, recuperando PV iguais à metade do dano causado.',
 3, 'Muda a resistência para "nenhuma": faz um ataque corpo a corpo contra o alvo; acertando, soma o dano do ataque ao do ritual, curando pela metade do total.', null,
 7, 'Muda o alcance para "pessoal", o alvo para "você" e a duração para "cena": a cada rodada pode gastar ação padrão pra tocar um ser e causar 4d6 de dano de Sangue, curando pela metade. Requer 4º círculo.', 4, false),

('Transfusão Vital', 'sangue', 2, 'padrão', 'toque', '1 ser', 'instantânea', null,
 'Transfere sua energia vital: pode perder até 30 PV pra que o alvo recupere a mesma quantidade (você não pode ficar com menos de 1 PV).',
 3, 'Pode transferir até 50 pontos de vida. Requer 3º círculo.', 3,
 7, 'Pode transferir até 100 pontos de vida. Requer 4º círculo.', 4, false);

-- ============================================================
-- IIº Círculo — Medo
-- ============================================================
insert into ritual_seed values
('Proteção contra Rituais', 'medo', 2, 'padrão', 'toque', '1 ser', 'cena', null,
 'Canaliza uma aura de Medo puro: o alvo recebe resistência a dano paranormal 5 e +5 em testes de resistência contra rituais e habilidades de criaturas paranormais.',
 3, 'Muda o alvo para até 5 seres tocados. Requer 3º círculo.', 3,
 6, 'Muda o alvo para até 5 seres tocados, a resistência a dano para 10 e o bônus para +10. Requer 4º círculo.', 4, false),

('Rejeitar Névoa', 'medo', 2, 'padrão', 'curto', 'área: nuvem de 6m de raio', 'cena', null,
 'Rituais conjurados na área têm custo +2 PE por círculo e execução aumentada em um passo. Anula Cinerária a menos que seu conjurador gaste ação completa por rodada pra neutralizar.',
 2, 'Além do normal, a DT de testes de resistência contra rituais na área diminui em –5.', null,
 5, 'Como Discente, e o dano causado por rituais dentro da névoa é sempre mínimo.', null, false);

-- ============================================================
-- IIIº Círculo — Conhecimento
-- ============================================================
insert into ritual_seed values
('Alterar Memória', 'conhecimento', 3, 'padrão', 'toque', '1 pessoa', 'instantânea', 'Vontade anula',
 'Invade a mente do alvo e altera ou apaga suas memórias de até uma hora atrás (pode mudar detalhes, não reescrever tudo). O alvo recupera as memórias após 1d4 dias.',
 null, null, null,
 4, 'Pode alterar ou apagar memórias de até 24 horas atrás. Requer 4º círculo.', 4, false),

('Contato Paranormal', 'conhecimento', 3, 'completa', 'pessoal', 'você', '1 dia', null,
 'Barganha com uma entidade de Conhecimento: recebe seis d6 pra somar em testes de perícia, um por vez. Rolar um 6 custa 2 pontos de Sanidade. O ritual acaba se ficar sem dados ou chegar a Sanidade 0.',
 4, 'Muda os dados de auxílio para d8; rolar um 8 custa 3 de Sanidade. Requer 4º círculo.', 4,
 9, 'Muda os dados de auxílio para d12; rolar um 12 custa 5 de Sanidade. Requer 4º círculo e afinidade.', 4, true),

('Mergulho Mental', 'conhecimento', 3, 'padrão', 'toque', '1 pessoa', 'sustentada', 'Vontade parcial (veja texto)',
 'Mergulha nos pensamentos do alvo (fica desprevenido durante); no início de cada turno sustentando, o alvo faz Vontade — se falhar, responde uma pergunta sim/não sem poder mentir.',
 null, null, null,
 4, 'Muda a execução para 1 dia, o alcance para ilimitado e adiciona componente (cuba de ouro com água + máscara, acessório categoria II): realiza o mergulho à distância, precisando de nome completo e um objeto pessoal/foto do alvo. Requer 4º círculo.', 4, false),

('Vidência', 'conhecimento', 3, 'completa', 'ilimitado', '1 ser', '5 rodadas', 'Vontade anula',
 'Através de uma superfície reflexiva, vê e ouve o alvo escolhido e seus arredores (~6m). O alvo resiste a cada turno; passando duas vezes seguidas, fica imune por uma semana. Bônus/penalidade no teste de resistência conforme o quanto você conhece o alvo: sabe o mínimo +10; algumas informações ou já viu pessoalmente +5; conhece bem –0; pertence pessoal –5; parte do corpo –10.',
 null, null, null,
 null, null, null, false);

-- ============================================================
-- IIIº Círculo — Energia
-- ============================================================
insert into ritual_seed values
('Convocação Instantânea', 'energia', 3, 'padrão', 'ilimitado', '1 objeto de até 2 espaços', 'instantânea', 'Vontade anula',
 'Invoca pra sua mão um objeto previamente preparado com o símbolo do ritual. Se empunhado por outra pessoa, ela pode negar com Vontade (mas você sabe onde está e quem o carrega). Por até 1h após, pode devolvê-lo com ação de movimento.',
 4, 'Muda o alvo para um objeto de até 10 espaços.', null,
 9, 'Muda o alvo para "1 recipiente Médio com itens somando até 10 espaços" e a duração para permanente: esconde o recipiente no Outro Lado, convocável com ação padrão usando uma miniatura (utensílio categoria II). Perde 1 PE permanentemente ao conjurar.', null, false),

('Salto Fantasma', 'energia', 3, 'padrão', 'médio', 'você', 'instantânea', null,
 'Seu corpo vira Energia pura e viaja até outro ponto já observado antes; não pode agir pelo resto do turno; ressurge na área vazia mais próxima se o destino estiver ocupado.',
 2, 'Muda a execução para reação: salta para um espaço adjacente (1,5m), recebendo +10 na Defesa e em Reflexos contra o ataque/efeito iminente.', null,
 4, 'Muda o alcance para longo e o alvo para você e até dois outros seres voluntários tocados.', null, false),

('Transfigurar Água', 'energia', 3, 'padrão', 'longo', 'área: esfera com 30m de raio', 'cena', 'veja texto',
 'Canaliza Energia sobre um corpo de água — escolha: Congelar (imobiliza quem nada), Derreter (gelo mundano vira água), Enchente (eleva o nível em até 4,5m, ou +6m de deslocamento numa embarcação), Evaporar (5d8 de dano de Energia, Fortitude reduz à metade) ou Partir (reduz o nível em até 4,5m).',
 null, null, null,
 5, 'Aumenta o deslocamento de Enchente para +12m e o dano de Evaporar para 10d8.', null, false),

('Transfigurar Terra', 'energia', 3, 'padrão', 'longo', 'área: 9 cubos com 1,5m de lado', 'instantânea', 'veja texto',
 'Imbui terra/pedra/lama/argila/areia com Energia — escolha: Amolecer (desabamento, 10d6 de dano de impacto, Reflexos reduz à metade, ou cria terreno difícil), Modelar (cria objetos simples Enormes ou menores) ou Solidificar (transforma lama/areia em terra/pedra, agarrando pés).',
 3, 'Muda a área para 15 cubos com 1,5m de lado.', null,
 7, 'Também afeta minerais e metais. Requer 4º círculo.', 4, false);

-- ============================================================
-- IIIº Círculo — Morte
-- ============================================================
insert into ritual_seed values
('Âncora Temporal', 'morte', 3, 'padrão', 'curto', '1 ser', 'cena', 'Vontade parcial',
 'Aura espiralada sobre o alvo: no início de cada turno dele, Vontade ou não pode se deslocar (ainda pode agir). Passando dois turnos seguidos, o efeito termina.',
 null, null, null,
 4, 'Muda o alvo para "seres à sua escolha". Requer 4º círculo.', 4, false),

('Poeira da Podridão', 'morte', 3, 'padrão', 'médio', 'área: nuvem com 6m de raio', 'sustentada', 'Fortitude (veja texto)',
 'Nuvem de poeira apodrece seres na área: ao conjurar e no início de cada turno seu, 4d8 de dano de Morte (Fortitude reduz à metade); quem falha também não recupera PV por uma rodada.',
 null, null, null,
 4, 'Muda o dano para 4d8+16.', null, false),

('Tentáculos de Lodo', 'morte', 3, 'padrão', 'médio', 'área: círculo com 6m de raio', 'cena', null,
 'Tentáculos de Lodo emergem de uma fenda: ao conjurar e no início de cada turno seu, faz um teste de agarrar (Ocultismo em vez de Luta) contra cada alvo na área — vencendo, agarra; se já agarrado, esmaga (4d6, metade impacto metade Morte). Área conta como terreno difícil; tentáculos imunes a dano.',
 null, null, null,
 5, 'Aumenta o raio para 9m e o dano dos tentáculos para 6d6.', null, false),

('Zerar Entropia', 'morte', 3, 'padrão', 'curto', '1 pessoa', 'cena', 'Vontade parcial',
 'Zera a entropia do alvo, deixando-o paralisado (ou lento, se passar na resistência). No início de cada turno pode gastar ação completa pra novo teste de Vontade e encerrar o efeito.',
 4, 'Muda o alvo para "1 ser". Requer 4º círculo.', 4,
 11, 'Muda o alvo para "seres escolhidos". Requer 4º círculo e afinidade.', 4, true);

-- ============================================================
-- IIIº Círculo — Sangue
-- ============================================================
insert into ritual_seed values
('Ferver Sangue', 'sangue', 3, 'padrão', 'curto', '1 ser', 'sustentada', 'Fortitude parcial',
 'O sangue do alvo entra em ebulição: ao conjurar e no início de cada turno dele, Fortitude ou sofre 4d8 de dano de Sangue e fica fraco (passando, metade do dano e sem ficar fraco na rodada). Passando dois turnos seguidos, o efeito termina.',
 null, null, null,
 4, 'Muda o alvo para "seres escolhidos". Requer 4º círculo e afinidade.', 4, true),

('Forma Monstruosa', 'sangue', 3, 'padrão', 'pessoal', 'você', 'cena', null,
 'Seu corpo se funde com uma criatura de Sangue: tamanho Grande, +5 em ataque e dano corpo a corpo, 30 PV temporários. Equipamento inacessível (mas bônus mantidos); mente tomada por fúria — deve atacar o ser mais próximo a cada rodada (Vontade DT do ritual pra escolher alvo se for aliado).',
 3, 'Além do normal, recebe imunidade a atordoamento, fadiga, sangramento, sono e veneno.', null,
 9, 'Muda os bônus de ataque/dano para +10 e os PV temporários para 50. Requer 4º círculo e afinidade.', 4, true),

('Purgatório', 'sangue', 3, 'padrão', 'curto', 'área de 6m de raio', 'sustentada', 'Fortitude parcial',
 'Poça de sangue pegajoso: inimigos na área ficam vulneráveis a dano balístico/corte/impacto/perfuração. Quem tenta sair sofre 6d6 de dano de Sangue e Fortitude — falhando, não consegue se mover (perde a ação de movimento).',
 null, null, null,
 null, null, null, false),

('Vomitar Pestes', 'sangue', 3, 'padrão', 'médio', 'área: 1 enxame Grande (quadrado de 3m)', 'sustentada', 'Reflexos reduz à metade',
 'Vomita um enxame de criaturas de Sangue que passa pelo espaço de outros seres; no fim de cada turno seu, causa 5d12 de dano de Sangue a quem estiver no espaço dele. Pode mover o enxame 12m com ação de movimento.',
 2, 'Além do normal, quem falha no Reflexos fica agarrado (pode gastar ação padrão + Acrobacia/Atletismo pra escapar; mover o enxame libera o alvo).', null,
 5, 'O enxame vira Enorme (cubo de 6m de lado) e ganha deslocamento de voo 18m.', null, false);

-- ============================================================
-- IIIº Círculo — Medo
-- ============================================================
insert into ritual_seed values
('Dissipar Ritual', 'medo', 3, 'padrão', 'médio', '1 ser ou objeto, ou esfera com 3m de raio', 'instantânea', null,
 'Dissipa rituais ativos (não anula efeitos instantâneos já concluídos). Teste de Ocultismo: anula rituais com DT igual ou menor ao resultado. Pode tornar um item amaldiçoado mundano por um dia (usuário pode negar com Vontade).',
 null, null, null,
 null, null, null, false);

-- ============================================================
-- IVº Círculo — Conhecimento
-- ============================================================
insert into ritual_seed values
('Controle Mental', 'conhecimento', 4, 'padrão', 'médio', '1 pessoa ou animal', 'sustentada', 'Vontade parcial',
 'Domina a mente do alvo, que obedece todos os comandos exceto ordens suicidas. Testa Vontade no fim de cada turno pra se livrar; passando, fica pasmo 1 rodada (1x/cena).',
 5, 'Muda o alvo para até cinco pessoas ou animais.', null,
 10, 'Muda o alvo para até dez pessoas ou animais. Requer afinidade com Conhecimento.', null, true),

('Inexistir', 'conhecimento', 4, 'padrão', 'toque', '1 ser', 'instantânea', 'Vontade parcial',
 'Ritual cruel que apaga o alvo da existência: 10d12+10 de dano de Conhecimento (ou 2d12 e debilitado 1 rodada se passar na resistência). Se os PV chegarem a 0 ou menos por qualquer via, o alvo é completamente apagado, sem deixar traço.',
 5, 'Muda o dano para 15d12+15 e o dano resistido para 3d12.', null,
 10, 'Muda o dano para 20d12+20 e o dano resistido para 4d12. Requer afinidade.', null, true),

('Possessão', 'conhecimento', 4, 'padrão', 'longo', '1 pessoa viva ou morta', '1 dia', 'Vontade anula',
 'Projeta sua consciência no corpo do alvo, assumindo controle total (se vivo, as consciências trocam de lugar). Continua usando sua ficha, mas com Agilidade/Força/Vigor e deslocamento do alvo. Se o alvo resistir, sabe da tentativa e fica imune por um dia. Retornar ao próprio corpo voluntariamente é ação livre.',
 null, null, null,
 null, null, null, false);

-- ============================================================
-- IVº Círculo — Energia
-- ============================================================
insert into ritual_seed values
('Alterar Destino', 'energia', 4, 'reação', 'pessoal', 'você', 'instantânea', null,
 'Vislumbra o futuro próximo e escolhe a melhor possibilidade: +15 em um teste de resistência ou na Defesa contra um ataque.',
 null, null, null,
 5, 'Muda o alcance para "curto" e o alvo para "um aliado à sua escolha".', null, false),

('Deflagração de Energia', 'energia', 4, 'completa', 'pessoal', 'área: explosão de 15m de raio', null, 'Fortitude parcial',
 'Libera uma explosão intensa: todos na área sofrem 3d10 x 10 de dano de Energia e itens tecnológicos na área quebram. Você não é afetado. Passando na resistência, metade do dano e os itens voltam a funcionar em 1d4 rodadas.',
 null, null, null,
 5, 'Afeta apenas alvos à sua escolha.', null, false),

('Teletransporte', 'energia', 4, 'padrão', 'toque', 'até 5 seres voluntários', 'instantânea', null,
 'Transforma corpo e equipamento dos alvos em energia pura, reaparecendo em um lugar escolhido a até 1.000km. Teste de Ocultismo com DT conforme o conhecimento do destino (25 lugar frequente, 30 já visitado, 35 só por descrição de terceiros). Falhar por 5+ atordoa por 1d4 rodadas sem teletransportar.',
 null, null, null,
 5, 'Pode se teletransportar para qualquer local na Terra.', null, false);

-- ============================================================
-- IVº Círculo — Morte
-- ============================================================
insert into ritual_seed values
('Convocar o Algoz', 'morte', 4, 'padrão', '1,5m', '1 pessoa', 'sustentada', 'Vontade parcial, Fortitude parcial',
 'Manipula os medos subconscientes do alvo pra criar um algoz que só ele vê com nitidez. A cada turno, o algoz flutua 12m em direção à vítima; em alcance curto, Vontade ou fica abalada; adjacente, Fortitude ou colapsa a 0 PV (passando, 6d6 de dano de Morte). Persegue implacavelmente; incorpóreo e imune a dano.',
 null, null, null,
 null, null, null, false),

('Distorção Temporal', 'morte', 4, 'padrão', 'pessoal', 'veja texto', 'veja texto', null,
 'Cria um bolsão temporal de 3 rodadas: você pode agir, mas não se deslocar nem interagir com seres/objetos; efeitos contínuos não o afetam e seus efeitos não afetam a área ao redor enquanto durar.',
 null, null, null,
 null, null, null, false),

('Fim Inevitável', 'morte', 4, 'completa', 'extremo', 'área: buraco negro com 1,5m de diâmetro', '4 rodadas', 'Fortitude parcial',
 'Cria um vácuo num espaço desocupado: a cada um dos 4 turnos seguintes, todos a até 90m (incluindo você) testam Fortitude ou caem e são puxados 30m em direção ao vácuo. Quem toca o vácuo no início do turno sofre 100 de dano de Morte por rodada.',
 5, 'Muda a duração para "5 rodadas" e você não é afetado. Requer afinidade.', null,
 10, 'Muda a duração para "6 rodadas" e seres escolhidos dentro do alcance não são afetados. Requer afinidade.', null, true);

-- ============================================================
-- IVº Círculo — Sangue
-- ============================================================
insert into ritual_seed values
('Capturar o Coração', 'sangue', 4, 'padrão', 'curto', '1 pessoa', 'cena', 'Vontade parcial',
 'Desperta uma paixão obcecada por você no alvo. No início de cada turno dele, Vontade ou age pra ajudá-lo na melhor de suas capacidades. Passando dois turnos seguidos, o efeito termina.',
 null, null, null,
 null, null, null, false),

('Invólucro de Carne', 'sangue', 4, 'padrão', 'curto', '1 clone seu', 'cena', null,
 'Manifesta uma cópia sua idêntica (mesmas estatísticas, Intelecto e Presença nulos), com cópia do equipamento mundano carregado. Ação de movimento pra dar ordens, ou controle ativo em transe no início do turno. Percepção (DT do ritual) revela que é cópia. Desfaz a 0 PV ou fora do alcance.',
 null, null, null,
 null, null, null, false),

('Vínculo de Sangue', 'sangue', 4, 'padrão', 'curto', '1 ser', 'cena', 'Fortitude anula',
 'Símbolo de Sangue em você e no alvo: sempre que você sofre dano, o alvo testa Fortitude — falhando, você sofre metade e ele a outra metade. Pode conjurar com efeito inverso. Alvos voluntários não resistem.',
 null, null, null,
 null, null, null, false);

-- ============================================================
-- IVº Círculo — Medo
-- ============================================================
insert into ritual_seed values
('Canalizar o Medo', 'medo', 4, 'padrão', 'toque', '1 pessoa', 'permanente até ser descarregada', null,
 'Transfere parte do seu poder: escolha um ritual de até 3º círculo conhecido; o alvo pode conjurá-lo na forma básica uma vez, sem pagar PE (mas pode pagar por versões avançadas). Até ser conjurado, seus PE máximos diminuem no valor do custo dele.',
 null, null, null,
 null, null, null, false),

('Conhecendo o Medo', 'medo', 4, 'padrão', 'toque', '1 pessoa', 'instantânea', 'Vontade parcial',
 'Manifesta medo absoluto: falhando, a Sanidade do alvo cai a 0 e ele fica enlouquecendo; passando, sofre 10d6 de dano mental e fica apavorado por 1 rodada. Quem enlouquece por este ritual pode virar criatura paranormal a critério do mestre.',
 null, null, null,
 null, null, null, false),

('Lâmina do Medo', 'medo', 4, 'padrão', 'toque', '1 ser', 'instantânea', 'Fortitude parcial',
 'Golpeia com uma lâmina impossível: falhando, os PV do alvo caem a 0 e fica morrendo; passando, sofre 10d8 de dano de Medo (ignora todas as resistências) e fica apavorado por uma rodada. Se sobreviver morrendo por este ritual, o ferimento nunca cicatriza. Aprender exige um poder de trilha específico.',
 null, null, null,
 null, null, null, false),

('Medo Tangível', 'medo', 4, 'padrão', 'pessoal', 'você', 'cena', null,
 'Transforma seu corpo numa manifestação do Medo: imune a atordoado, cego, debilitado, enjoado, envenenado, exausto, fatigado, fraco, lento, ofuscado, paralisado, doenças e venenos, sem dano adicional de crítico/furtivo. Dano balístico/corte/impacto/perfuração não reduz seus PV abaixo de 1.',
 null, null, null,
 null, null, null, false),

('Presença do Medo', 'medo', 4, 'padrão', 'pessoal', 'área: emanação de 9m de raio', 'sustentada', null,
 'Torna-se receptáculo do Medo puro: quem está na área ao conjurar ou no início de cada turno sofre 5d8 de dano mental e 5d8 de dano de Medo (Vontade reduz ambos à metade); falhando, fica atordoado por uma rodada (1x por cena).',
 null, null, null,
 null, null, null, false);

-- ============================================================
-- Grava tudo na tabela definitiva
-- ============================================================

insert into rituals (
  source_id, name, elemento, circle, execution, range, target, duration, resistance, effect,
  discente_cost, discente_effect, discente_requires_circle,
  verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, verdadeiro_requires_affinity
)
select
  (select id from sources where slug = 'ordem_paranormal'),
  name, elemento, circle, execution, range, target, duration, resistance, effect,
  discente_cost, discente_effect, discente_requires_circle,
  verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, coalesce(verdadeiro_requires_affinity, false)
from ritual_seed;

drop table ritual_seed;
