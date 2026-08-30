-- Sobrevivendo ao Horror, parte 4: poderes paranormais, rituais e itens amaldiçoados.

insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
select (select id from sources where slug = 'sobrevivendo_ao_horror'), v.elemento::elemento, v.name, v.description, v.affinity, v.prereq
from (values
  ('sangue', 'Espreitar da Besta', '+5 Furtividade; sendo o caçador numa perseguição, usa Furtividade em vez de Atletismo; em cena de furtividade, ações discretas sem -◯.', 'Bônus sobe pra +10.', null),
  ('sangue', 'Instintos Sanguinários', 'Visão no escuro e faro.', 'Não pode ser flanqueado, não fica desprevenido, +5 em resistência contra armadilhas.', null),
  ('morte', 'Antecipar Vitalidade', 'Teste, acumula carga de antecipação pra +◯ (máx. = Vigor); com carga pendente, a próxima ação dormir perde uma carga em vez de recuperar PV.', 'Limite de cargas +2, perde 2 cargas por dormir (em vez de recuperar PV).', null),
  ('morte', 'Aura de Pavor', '2 PE + ação de movimento deixa pessoa/animal em alcance médio apavorado (Vontade DT Pre reduz pra abalado); não precisa ver você; só 1x/dia por alvo.', 'DT +5, pode afetar múltiplos alvos ao mesmo tempo em alcance.', null),
  ('conhecimento', 'Absorver Conhecimento', 'Empunhando fonte de conhecimento escrito, 1 PE + ação completa faz uma pergunta à fonte (resposta automática se estiver armazenada nela); combinado com ação ler, sobe o dado de bônus um passo.', 'Ritual de Conhecimento com alvo 1 pessoa (que não você), tocando o alvo, custo -1 PE.', null),
  ('conhecimento', 'Apatia Herege', 'Teste contra condição de medo, gasta 2 PE pra rerrolar (aceita o novo resultado).', 'Pode usar depois de ver o resultado, e fica com a melhor rolagem.', 'Conhecimento 1'),
  ('energia', 'Conexão Empática', 'Ação completa + 2 PE toca objeto elétrico ligado; até o fim da cena (ou soltar), "conversa" com ele (atitude inicial indiferente).', '+5 em perícias de Int/Pre com o item.', 'Energia 1'),
  ('energia', 'Valer-se do Caos', 'Teste, escolhe controlar o caos pra +◯; se falhar o teste OU o d20 extra sair ≤5, perde 1d4 Sanidade.', 'Só perde Sanidade se o teste falhar OU o dado extra sair 1-2.', null)
) as v(elemento, name, description, affinity, prereq);

insert into rituals (
  source_id, name, elemento, circle, execution, range, target, duration, resistance, effect,
  discente_cost, discente_effect, discente_requires_circle,
  verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, verdadeiro_requires_affinity
)
select (select id from sources where slug = 'sobrevivendo_ao_horror'),
  v.name, v.elemento::elemento, v.circle, v.execution, v.range, v.target, v.duration, v.resistance, v.effect,
  v.discente_cost, v.discente_effect, v.discente_circle,
  v.verdadeiro_cost, v.verdadeiro_effect, v.verdadeiro_circle, v.verdadeiro_affinity
from (values
  ('Esfolar', 'sangue', 1, 'padrão', 'curto', '1 ser', 'instantânea', 'Reflexos parcial',
   'Projeta agulhas/lâminas de Sangue quase imperceptíveis; 3d4+3 dano de corte + sangrando (resistência reduz à metade e evita a condição).',
   2, 'Alcance médio, dano 5d4+5, alvo vira explosão 6m de raio. Requer 2º círculo.', 2,
   5, 'Alcance longo, dano 10d4+10, explosão 6m; resistência não evita mais a condição sangrando. Requer 3º círculo.', 3, false),

  ('Sede de Adrenalina', 'sangue', 2, 'reação', 'pessoal', 'você', 'instantânea', null,
   'Falhar em Acrobacia/Atletismo, conjura pra rerrolar usando Presença no lugar do atributo-base; alternativamente, ao sofrer dano de impacto, reduz em 20; só 1x/rodada em qualquer caso. Se usado pra reduzir dano, fica atordoado 1 rodada logo depois.',
   3, 'Redução sobe pra 40.', null,
   7, 'Redução sobe pra 70. Requer 4º círculo e afinidade.', 4, true),

  ('Odor da Caçada', 'sangue', 3, 'padrão', 'pessoal', 'você', 'cena', null,
   'Recebe faro; em cena de perseguição, +5 Atletismo e não perde PV pela ação esforço extra (desde que caçador/presa emita odores). Preço: na próxima cena, sofre fome e sede como se tivesse falhado o teste do 1º dia.',
   4, 'Alcance toque, alvo 1 ser.', null,
   9, 'Alcance curto, alvo até 5 seres. Requer afinidade.', null, true),

  ('Martírio de Sangue', 'sangue', 4, 'padrão', 'pessoal', 'você', 'veja texto (sem fim natural)', null,
   'Transforma-se numa monstruosidade bestial: faro, visão no escuro, cura acelerada 10, +10 em ataque/dano corpo a corpo/Defesa, 30 PV temporários, ataques desarmados +1 dado e letais; não pode mais focar/concentrar; -3◯ em perícias de interação social. Sem fim natural — a cada rodada perde um pedaço da mente; quando a cena termina, vira permanentemente uma criatura de Sangue (perda definitiva do personagem).',
   5, 'Bônus sobem pra +20, PV temporários pra 50. Requer afinidade.', null,
   null, null, null, false),

  ('Apagar as Luzes', 'morte', 1, 'padrão', 'pessoal', 'você', 'instantânea', null,
   'Apaga toda fonte de luz em alcance curto (natural ou paranormal); efeitos temporários mantêm a escuridão até o fim da cena; você recebe visão no escuro até o fim da cena.',
   2, 'Alcance pra determinar fontes afetadas sobe pra longo. Requer 2º círculo.', 2,
   5, 'Como Discente, mas até 5 outros seres no alcance também recebem visão no escuro. Requer 3º círculo.', 3, false),

  ('Língua Morta', 'morte', 2, 'padrão', 'toque', '1 cadáver', 'sustentada', null,
   'Reanima cadáver humano com Lodo; responde 1 pergunta por rodada sustentada (máx. 3 rodadas); ao fim da 3ª resposta, o cadáver vira esqueleto de Lodo.',
   3, 'Limite sobe pra 4 rodadas; ao fim, vira um enraizado em vez de esqueleto de Lodo.', null,
   7, 'Limite sobe pra 5 rodadas; ao fim, vira uma marionete. Requer 4º círculo e afinidade.', 4, true),

  ('Fedor Pútrido', 'morte', 3, 'padrão', 'pessoal', 'você', 'sustentada', null,
   'Suspende funções biológicas, cheira a cadáver; animais se afastam, -3◯ Diplomacia, +5 Furtividade, +10 Enganação pra fingir de morto; cada rodada sustentado causa 1d4 dano de Morte que ignora resistências.',
   4, 'Alcance toque, alvo 1 ser voluntário.', null,
   9, 'Alcance curto, alvo até 5 voluntários. Requer afinidade.', null, true),

  ('Singularidade Temporal', 'morte', 4, 'padrão', 'curto', '1 objeto não paranormal Médio', 'instantânea', 'veja texto',
   'Avança um objeto pro estado de decomposição mais avançado possível (danificado: -5 nos usos; ou destruído). Objeto em uso permite Fortitude de quem usa pra proteger.',
   5, 'Tamanho sobe pra Grande.', null,
   10, 'Tamanho sobe pra Enorme.', null, false),

  ('Desfazer Sinapses', 'conhecimento', 1, 'padrão', 'curto', '1 ser', 'instantânea', 'Vontade parcial',
   '2d6+2 dano de Conhecimento + frustrado 1 rodada (resistência reduz à metade e evita); precisa ter cérebro.',
   2, 'Alcance longo, dano 3d6+3, até 5 alvos. Requer 2º círculo.', 2,
   5, 'Alcance extremo, dano 8d6+8, condição vira esmorecido. Requer 3º círculo.', 3, false),

  ('Aurora da Verdade', 'conhecimento', 2, 'padrão', 'curto', 'área: esfera 3m', 'sustentada', 'Vontade parcial',
   'Área onde ninguém consegue mentir (inclusive o conjurador, salvo resistir); quem tenta se esconder/camuflar/ficar invisível é revelado por sigilos brilhantes.',
   3, 'Alcance médio, área 9m de raio, conjurador não é mais afetado.', null,
   7, 'Como Discente + alcance longo + duração cena + ouve tudo dito na área independente da distância. Requer 4º círculo e afinidade.', 4, true),

  ('Relembrar Fragmento', 'conhecimento', 3, 'padrão', 'toque', '1 objeto', 'instantânea', null,
   'Restaura fonte de conhecimento escrito danificada/ilegível pro estado da última anotação (só enquanto tocado — solta, volta a ficar danificado).',
   4, 'Restauração permanece até o fim da missão.', null,
   9, 'Pode alterar o objeto de forma imperceptível conforme a vontade do conjurador (ex.: falsificar documento), permanece até o fim da missão. Requer afinidade.', null, true),

  ('Pronunciar Sigilo', 'conhecimento', 4, 'padrão', 'curto', '1 ser', 'instantânea/veja texto', 'Vontade parcial',
   'Escolhe um efeito: Esquecer (atordoado 1d4+1 rodadas, 1x/cena); Cegar (cego, resistindo ofuscado 1d4 rodadas); Inexistir (deixa de existir 1d4+1 rodadas, 1 rodada se resistir; só 1x/cena por ser).',
   5, 'Alcance extremo.', null,
   10, 'Até 5 alvos. Requer afinidade.', null, true),

  ('Overclock', 'energia', 1, 'reação', 'pessoal', 'você', 'instantânea', null,
   'Ao testar Tecnologia num objeto eletrônico, depois de ver o resultado, conjura pra ter a informação mesmo assim através de um "minigame" de estátua; após, o objeto fica temporariamente inutilizável.',
   2, 'Só falha errando 2x no jogo. Requer 2º círculo.', 2,
   5, 'Só falha errando 3x. Requer 3º círculo.', 3, false),

  ('Tremeluzir', 'energia', 2, 'padrão', 'pessoal', 'você', 'sustentada', null,
   'Corpo "pisca" como monitor, permite atravessar objetos sólidos (exige ação de movimento por objeto, 25% de chance de não atravessar); cada rodada ativo causa 1d4 dano de Energia (ignora resistência); terminar a rodada dentro de um sólido causa +1d4.',
   3, 'Alcance toque, alvo 1 ser voluntário.', null,
   7, 'Alcance curto, até 5 voluntários. Requer 4º círculo.', 4, false),

  ('Mutar', 'energia', 3, 'padrão', 'pessoal', 'você', 'cena', null,
   'Isola de todo som (emitido e recebido); +10 Furtividade, ganho de visibilidade em furtividade reduzido em 1; falar sem permissão do mestre encerra o ritual.',
   4, 'Alcance toque, alvo 1 ser.', null,
   9, 'Alcance curto, até 5 seres. Requer afinidade com Energia.', null, true),

  ('Milagre Ionizante', 'energia', 3, 'completa', 'toque', '1 ser', 'instantânea', null,
   'Cura uma condição à escolha entre abalado/apavorado/alquebrado/atordoado/cego/confuso/debilitado/enjoado/envenenado/esmorecido/exausto/fascinado/fatigado/fraco/frustrado/lento/ofuscado/paralisado/pasmo/surdo, ou uma doença ou veneno. Depois, o alvo testa Fortitude DT 30 ou é incubado pelo vírus do Infecticídio.',
   null, null, null,
   null, null, null, false)
) as v(name, elemento, circle, execution, range, target, duration, resistance, effect, discente_cost, discente_effect, discente_circle, verdadeiro_cost, verdadeiro_effect, verdadeiro_circle, verdadeiro_affinity);

-- ============================================================
-- Itens Amaldiçoados Especiais (Sangue, Morte, Conhecimento, Energia, Medo)
-- ============================================================
insert into cursed_items_special (source_id, name, description, category, spaces)
select (select id from sources where slug = 'sobrevivendo_ao_horror'), v.name, v.description, v.category::item_category, v.spaces
from (values
  ('Conector de Membros', 'Ação padrão reconecta braço/perna/cabeça decepados até 3 rodadas atrás; não cura PV, mas remove morrendo/morto (fica inconsciente com 1 PV); removendo o conector, a parte decepa de novo. 25% de chance de dar "vida própria" à parte (perna=lento; braço=-◯ em testes com o braço; cabeça=25% confuso em cenas de tensão).', 'III', 1),
  ('Dose d''A Praga', 'Frasco; ação padrão abre e dá a você ou adjacente os poderes Arma de Sangue + Sangue de Ferro + Sangue Vivo até o fim da cena; ao acabar, Fortitude DT 20+5 por dose anterior desde o último interlúdio ou sofre 2d4 dano mental e mantém os poderes até o fim da PRÓXIMA cena também, mais o efeito de Ódio Incontrolável.', 'III', 1),
  ('Mandíbula Agonizante', 'Ação padrão pressiona + arremessa em alcance médio; grita alto (cobre sons num raio de 30m até o fim da cena); em furtividade, sucesso automático em distrair; criaturas de Sangue precisam de Vontade DT 35 pra não ir até ela; recarrega após descansar 1 cena.', 'II', 1),
  ('Retalho Tenebroso', 'Ação padrão aplica no rosto como máscara; dá faro e visão no escuro, mas vulnerabilidade a Morte e -2◯ em perícias de interação social; a cada dia seguido usando, +1 cumulativo em rolagens de dano; mas ao fim de cada dia, perde 1d6 PV (Fortitude DT 15, +5 por teste adicional em sequência, evita); remover exige ação padrão + mesmo teste; PV perdido só recupera após remover; solta sozinho se a pessoa morrer.', 'II', 1),
  ('Ampulheta do Tempo Sofrido', 'Empunhando, gasta 5 PE pra receber imediatamente os benefícios de uma ação de interlúdio à escolha; depois de usar, só reusa gastando uma ação de interlúdio pra "devolver o tempo".', 'II', 1),
  ('Injeção de Lodo', 'Ação padrão + conteúdo injeta em si/adjacente voluntário; até o fim da cena, vulnerabilidade a balístico e Energia, mas a próxima vez que cairia a 0 PV na mesma cena, fica em 1 PV em vez disso.', 'II', 0.5),
  ('Instantâneo Mortal', 'Empunhando + teste de perícia pra procurar pistas relacionado às circunstâncias de morte retratadas, gasta 1 PE pra +◯ (mestre define quando se aplica).', 'II', 0.5),
  ('Projétil de Lodo, curto', 'Troca todo o dano da arma pra Morte; a arma se degrada e desfaz ao fim da cena.', 'I', 1),
  ('Projétil de Lodo, longo', 'Troca todo o dano da arma pra Morte; a arma se degrada e desfaz ao fim da cena.', 'II', 1),
  ('Rádio Chiador', 'Pilha dura 12h; ligado, chia se houver criatura paranormal em alcance extremo (mais alto = mais perto; estima direção/categoria); criaturas paranormais são atraídas pelo chiado; funções normais de gravador não funcionam.', 'II', 1),
  ('Câmera Obscura', 'Câmera de aura paranormal com lente de revelação já embutida; DT pra resistir +10; se a criatura falhar E tiver invisibilidade/incorporeidade/camuflagem, sofre também 6d6 dano de frio.', 'III', 1),
  ('Enxame Fantasmagórico', 'Vestido, dá invisibilidade; mas 1 dano mental (ignora toda resistência) no início de cada turno seu.', 'III', 1),
  ('Repositório do Fracasso', 'Criatura paranormal em alcance médio tira 1 num d20 de teste = +1 carga (máx. 6); 1x/rodada, consome 1 carga pra recuperar 1d4 PE, mas -1 cumulativo em Vontade até o próximo interlúdio.', 'II', 1),
  ('Tablet do Saber Custoso', 'Empunhando, usa pra ter os benefícios de treinamento numa perícia por 1 teste; custa Sanidade = valor do atributo-chave dessa perícia.', 'II', 1),
  ('Arreio Neural', 'Usando, sofrer 5+ dano de eletricidade/Energia recupera 1 PE; máximo por dia = 2x Vigor.', 'II', 1),
  ('Centrifugador Existencial', 'Ação padrão + 3 PE ativa; divide você em 2 possibilidades de futuro, turno adicional na última contagem de iniciativa da rodada; sorteia qual versão se dissipa no fim da rodada.', 'III', 1),
  ('Espelho Refletor', 'Ação de movimento observa ponto/ser fora do ângulo de visão em alcance médio, +◯ em Percepção, chance de enxergar através de cobertura total; ao sofrer dano de Energia, sacrifica o espelho pra evitar o dano e refletir de volta na origem.', 'II', 1),
  ('Fuzil Alheio', 'Fuzil de precisão com mira telescópica + mira laser já embutidas; dano de Energia; não precisa de munição.', 'IV', 2),
  ('A Primeira Adaga', 'Usada como componente ritualístico, dá ao ritual os efeitos combinados dos catalisadores Ampliador + Perturbador + Potencializador + Prolongador simultaneamente, e reduz o tempo de conjuração pra 1 rodada. Preço: conjurador perde PV = metade do total (conta como dano massivo); pode usar uma vítima de sacrifício pra pagar esse preço em vida no lugar.', 'III', 1)
) as v(name, description, category, spaces);
