-- Bestiário Livro Base — Criaturas de Conhecimento (11) + Máscara do Desespero (chefe único/Relíquia).

insert into creatures (source_id, name, vd, flavor_text, descritores, tamanho, presenca_dt, presenca_dano, presenca_nex_imune, percepcao, iniciativa, defesa, fortitude, reflexos, vontade, pv_maximo, pv_machucado, resistencias, vulnerabilidades, atributos, pericias, deslocamento, habilidades, acoes, enigma_medo, sort_order)
values
(
  (select id from sources where slug = 'ordem_paranormal'), 'Anjo', 380,
  'Poucas experiências paranormais têm o impacto de uma visita de um anjo — manifestação revelada por transcendência espontânea, descrita por ocultistas em locais/tempos/culturas diferentes. Tão poderoso que desmantela a sanidade só de ser observado, derretendo os olhos de quem vê, que escorrem como lágrimas douradas. Escritas enigmáticas o chamam de "o rosto da verdade impossível". Sem registros de manifestação desde o século XIII. Todos que encontraram um anjo foram tocados por algo maligno e profundo, e nunca mais foram os mesmos.',
  '{Conhecimento}', 'Enorme', 40, '10d6 mental', null, '+25 (5◯, Percepção às Cegas)', '+25 (4◯)', 57, '+25 (5◯)', '+25 (4◯)', '+30 (5◯)', 1111, 555, 'Dano 50', 'Sangue',
  '{"agi":4,"for":5,"int":5,"pre":5,"vig":5}', null, 'Voo 24m | 16',
  '[{"nome":"Imunidades","descricao":"Condições de paralisia, dano e efeitos de Conhecimento."},{"nome":"Julgamento","descricao":"Sempre que causa dano de Conhecimento (asas ou olhares), também causa dano mental igual à metade do dano de Conhecimento (após resistências); quem é reduzido a Sanidade 0 assim tem a mente colapsada e inexiste, morrendo instantaneamente."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Asas do Conhecimento, corpo a corpo x2)","teste":"+40 (5◯)","dano":"4d10+40 Conhecimento"},{"tipo":"Padrão","nome":"Agredir (Olhares do Saber, distância x2, longo)","teste":"+40 (4◯)","dano":"6d8+20 Conhecimento"},{"tipo":"Livre","nome":"Faixas Detentoras","teste":"+45 (5◯)","descricao":"Ao acertar asas num alvo Médio ou menor, tenta agarrar; agarrado fica fascinado; mantém 1 agarrado por vez, sem impedir o uso das asas."},{"tipo":"Padrão","nome":"Chamas Reveladoras","dano":"10d8 Conhecimento (Vontade DT 43 reduz à metade)","descricao":"Círculo de chamas douradas se expande em alcance médio; quem sofre ganha uma \"auréola reveladora\" — até o fim da cena o anjo sabe onde estão todos com auréola, ignorando furtividade/invisibilidade/ilusão."},{"tipo":"Completa","nome":"Raio Dourado","dano":"15d8+50 Conhecimento (Reflexos DT 43 reduz à metade)","descricao":"1x/cena, linha de 3m em alcance longo."}]',
  'Seres puros de Conhecimento podem ser enganados por seu próprio alinhamento de Justiça Perfeita — um anjo que julgue errado pode cair e ser alcançado por mortais. Ao resolver, perde resistência a dano, voo e Julgamento.', 24
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Bicho-Papão', 300,
  'Originado da história que pais contam pra filhos não desobedecerem — o Medo gerado por tantas crianças se manifestou numa aberração poderosa que espreita telhados de casas com crianças pequenas. Figura encapuzada e alongada, como uma centopeia de braços e pernas humanoides, rastejando por telhados, dutos, chaminés, janelas esquecidas. Comunica-se com vítimas por sussurros e cantigas macabras durante o sono, implantando medos/paranoias que crescem com o tempo; quando a sanidade está destroçada, se revela pra devorar.',
  '{Conhecimento}', 'Grande', 35, '7d8 mental', 90, '+20 (5◯, Percepção às Cegas)', '+20 (5◯)', 41, '+15 (4◯)', '+25 (5◯)', '+20 (5◯)', 750, 375, 'Balístico, corte, impacto e Conhecimento 20', 'Sangue',
  '{"agi":5,"for":4,"int":3,"pre":5,"vig":4}', 'Atletismo +15 (4◯), Furtividade +18 (5◯)', '15m | 10',
  '[{"nome":"Tamanho Adaptável","descricao":"Reduz o corpo paranormalmente pra qualquer categoria menor; deslocamento não reduzido por furtividade/escalada."},{"nome":"Tormento Infantil","descricao":"Fica desprevenido ouvindo cantiga de ninar; ouvindo choro de criança, usa todas as ações pra encontrar e silenciar a fonte."},{"nome":"Destruir Mente","descricao":"Ao acertar garras num alvo perturbado, +1d8 dano mental por acerto."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Garras Atormentadoras, corpo a corpo x3)","teste":"+35 (5◯)","dano":"4d10+10 Conhecimento"},{"tipo":"Movimento","nome":"Atormentar","dano":"3d8 mental, +3d8 se escondido (Vontade DT 30 reduz à metade)","descricao":"Sussurros num alvo em alcance curto."},{"tipo":"Completa","nome":"Saltar e Assustar","dano":"10d8 mental (Vontade DT 35 reduz à metade)","descricao":"Se escondido de um alvo em alcance curto, sai do esconderijo assumindo forma assustadora."}]',
  null, 25
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Espreitador', 220,
  'Forma asquerosa, curvada, cinza, pele rugosa e pelancuda. A cabeça tem dezenas de olhos de tamanhos e formatos diferentes com pupilas amarelas que se multiplicam enquanto espreita. Treme o tempo todo, como se estivesse com frio, ansioso ou com medo. Escolhe um alvo pra assombrar, perseguindo quem se envolve com o ser/objeto assombrado, devorando a sanidade da vítima ao impedir o sono.',
  '{Conhecimento}', 'Médio', 30, '7d6 mental', 70, '+15 (3◯, Percepção às Cegas)', '+15 (4◯)', 34, '+10 (2◯)', '+15 (4◯)', '+15 (3◯)', 500, 250, null, 'Sangue',
  '{"agi":4,"for":2,"int":3,"pre":3,"vig":2}', 'Furtividade +20 (4◯)', '12m | 8',
  '[{"nome":"Imunidades","descricao":"Dano."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo x2)","teste":"+10 (2◯)","dano":"1d6+2 impacto"},{"tipo":"Movimento","nome":"Correr pelas Frestas","descricao":"Teletransporta-se pra qualquer espaço em alcance longo, desde que haja uma fresta (espaço Pequeno ou menor delimitado por objeto/superfície) no caminho."},{"tipo":"Completa","nome":"Espreitar","dano":"10d6 mental (Vontade DT 30 reduz à metade)","descricao":"1x/cena, adjacente a um ser dormindo; se a vítima enlouquecer com esse dano, pode criar uma Cópia Observada dela."},{"tipo":"Padrão","nome":"Cópia Observada","descricao":"Manifesta uma cópia de alguém deixado enlouquecendo por Espreitar — usa a mesma ficha, mas causa dano de Conhecimento em vez do normal, não conjura rituais/habilidades paranormais, dura até o fim da cena."}]',
  'Derrotá-lo exige que o alvo espreitado o atraia pra fora do esconderijo fingindo dormir no escuro. Às 2h11 especificamente, ele sai pra espreitar de perto — a porta do esconderijo deve ser fechada antes que ele retorne, encurralando-o. Encurralado, perde a imunidade a dano.', 26
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Estrangeiro', 340,
  'Mensagens misteriosas em horários específicos, sinais incompreensíveis vindos das direções mais longínquas do Universo, levando governos a tentar estabelecer comunicação — mas a resposta do Outro Lado não foi a esperada. Manifestação muitíssimo inteligente com motivações complexas, desenvolveu linguagem própria e aprende novas. Relatos descrevem abduções sempre no mesmo horário da madrugada; dispositivos digitais reagem à sua presença com sigilos misteriosos nas telas.',
  '{Conhecimento,Energia}', 'Grande', 40, '10d6 mental', 99, '+25 (5◯, Percepção às Cegas)', '+20 (3◯)', 50, '+15 (3◯)', '+20 (3◯)', '+25 (5◯)', 750, 375, null, 'Sangue',
  '{"agi":3,"for":5,"int":5,"pre":5,"vig":3}', 'Ciência +20 (5◯), Ocultismo +20 (5◯), Furtividade +20 (3◯)', 'Voo 15m | 10',
  '[{"nome":"Imunidades","descricao":"Dano."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Toque Sutil, corpo a corpo x3)","teste":"+35 (5◯)","dano":"4d8+10 Conhecimento"},{"tipo":"Padrão","nome":"Agredir (Rajada Psíquica, distância x2, extremo)","teste":"+35 (5◯)","dano":"4d10+20 Conhecimento"},{"tipo":"Livre","nome":"Comandar","descricao":"Ao causar dano com rajada psíquica, tenta dominar a mente (Vontade DT 35 evita, Intelecto 5+ é imune); obedece uma ordem no próximo turno — Atacar, Render-se, ou Fugir."},{"tipo":"Livre","nome":"Apagar Memória","descricao":"Um alvo que enlouqueça pelo Estrangeiro fica com a mente controlada por ele; alternativamente, pode apagar a memória da vítima e devolver 1d4 de Sanidade."},{"tipo":"Livre","nome":"Oblívio","descricao":"Quem sofre dano do Toque Sutil esquece a existência do Estrangeiro (Vontade DT 30 evita); considera-o invisível; repete o teste no fim de cada turno (passar encerra o efeito mas causa 6d6 dano mental); vítima incubando uma larva não repete o teste."},{"tipo":"Completa","nome":"Incubar","descricao":"Toca um adjacente alheio à sua presença (sob Oblívio) e implanta uma larva; enquanto incuba, o Estrangeiro tem acesso total à mente do hospedeiro; a larva causa 1d6 dano mental no início de cada cena; Sanidade 0 faz um novo Estrangeiro eclodir da cabeça, matando o hospedeiro instantaneamente."}]',
  'Suas intenções são complexas e precisam ser decifradas — investigar os sinais e aprender sua linguagem/mensagens crípticas é a única forma de se comunicar e entender como usar suas tecnologias pra derrotá-lo. Ao decifrar, perde a imunidade a dano (mas continua imune a dano de Conhecimento) e não pode mais usar Incubar.', 27
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Existido', 20,
  '"Saber tudo é perder tudo" — ditado sussurrado no submundo ocultista. Uma vez humano, hoje só uma casca buscando desesperadamente continuar existindo, sendo observado por alguém consciente. Foi longe demais, ultrapassou a barreira do Conhecimento e entendeu o Outro Lado por completo — lembrou da verdade impossível e não consegue esquecê-la. Tudo que pode fazer é repetir seu próprio nome, tentando ser reconhecido.',
  '{Conhecimento}', 'Médio', 14, '1d6 mental', 25, '+5 (2◯, Percepção às Cegas)', '+5 (1◯)', 13, '+0 (2◯)', '+0 (1◯)', '+10 (2◯)', 36, 18, 'Balístico, corte e impacto 5, Conhecimento 10', 'Sangue',
  '{"agi":1,"for":1,"int":4,"pre":2,"vig":2}', 'Ciências +10 (4◯), Ocultismo +10 (4◯)', '9m | 6',
  '[]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo)","teste":"+5 (1◯)","dano":"1d4+1 impacto"},{"tipo":"Livre","nome":"Brilho Enlouquecedor","dano":"1d6 mental (Vontade DT 14 reduz à metade)","descricao":"1x/rodada, marcas douradas brilham; todos em alcance médio que o veem."},{"tipo":"Movimento","nome":"Fortalecimento Paranormal","descricao":"Até o fim da cena, +◯ em testes de Agilidade/Força/Vigor e +2d4 dano de Conhecimento nas pancadas; só usável se já causou dano mental com Brilho Enlouquecedor nesta cena."}]',
  null, 28
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Lembrado', 100,
  'O processo que transformaria alguém num existido, quando amplificado pela contenção psicológica de alta exposição paranormal, gera uma manifestação ainda mais intensa: o lembrado. Ser amaldiçoado pelo desespero, que não se importa com a frivolidade da existência — aspira só se tornar uma história memorável. Gritando o nome que lhe foi entregue pelo Outro Lado, comete atrocidades absurdas só pra jamais ser esquecido.',
  '{Conhecimento}', 'Médio', 20, '4d6 mental', 45, '+10 (2◯, Percepção às Cegas)', '+10 (2◯)', 22, '+5 (2◯)', '+0 (2◯)', '+10 (2◯)', 180, 90, 'Balístico, corte e impacto 10, Conhecimento 20', 'Sangue',
  '{"agi":2,"for":2,"int":4,"pre":2,"vig":2}', 'Ciências +10 (4◯), Ocultismo +10 (4◯)', '9m | 6',
  '[{"nome":"Aura Manifestada","descricao":"Cercado por uma aura dourada de faces flutuantes que gritam; quem está em alcance curto sofre -◯◯ em todos os testes."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo x2)","teste":"+5 (2◯)","dano":"2d4+7 impacto"},{"tipo":"Padrão","nome":"Expandir Aura","dano":"6d6 mental (Vontade DT 20 reduz à metade)","descricao":"Quem está em alcance curto."}]',
  null, 29
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Ocioso', 260,
  'Manifestação que aterroriza e desestabiliza aos poucos, observando passivamente em todo ambiente. Não aparenta ter vontade própria. Relatos dizem que só observa, parada — visível em todo momento e ambiente pra vítima, como alucinação constante, mas invisível pros demais. Vítimas desenvolvem claustrofobia. Parece deixar de existir quando o alvo fecha os olhos. Não ataca ativamente, mas reage se atacado.',
  '{Conhecimento}', 'Grande', 35, '8d6 mental', 80, '+15 (5◯, Percepção às Cegas)', '+0', 37, '+15 (3◯)', '+0', '+20 (5◯)', 390, 195, 'Balístico, corte, impacto e Conhecimento 20', 'Sangue',
  '{"agi":1,"for":5,"int":1,"pre":5,"vig":3}', null, 'Voo 0m | 0',
  '[{"nome":"Sempre Presente","descricao":"No início da cena, escolhe um personagem que possa ver como alvo; só esse alvo consegue vê-lo, invisível pros demais."}]',
  '[{"tipo":"Reação","nome":"Retaliação","teste":"+30 (5◯)","dano":"4d10+20 impacto não letal","descricao":"Ao ser atacado ou alvo de habilidade, teleporta pra adjacente ao atacante e ataca corpo a corpo."},{"tipo":"Livre","nome":"Permanecer Próximo","descricao":"1x/rodada, teleporta pra qualquer ponto dentro do campo de visão do alvo."},{"tipo":"Completa","nome":"Aterrorizar","dano":"4d10+10 mental","descricao":"Fica parado, olhar profundo entra na alma do alvo; se adjacente."}]',
  null, 30
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Parasita de Culpa', 60,
  'Criatura disforme que se alimenta da culpa despertada em suas vítimas através de pesadelos e ilusões terríveis, usando alucinações de sentimentos não resolvidos pra distorcer figuras e acontecimentos do passado da vítima. Curiosamente, alguns se dissipam ou não se importam de serem destruídos depois de se alimentar. Mesmo sabendo que eram ilusões, as memórias ainda são reais.',
  '{Conhecimento,Sangue,Morte}', 'Médio', 20, '2d6 mental', 35, '+0 (4◯, Percepção às Cegas)', '+0 (2◯)', 15, '+10 (1◯)', '+10 (2◯)', '+10 (4◯)', 90, 45, null, null,
  '{"agi":2,"for":0,"int":4,"pre":4,"vig":1}', null, '6m | 4',
  '[{"nome":"Imunidades","descricao":"Dano (exceto causado pelo hospedeiro)."},{"nome":"Devorar Culpa","descricao":"Ao se fixar num ser dormindo, todos que dormem em alcance médio ficam presos num sonho compartilhado até o parasita ser derrotado ou o hospedeiro morrer/enlouquecer."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Pancada, corpo a corpo)","teste":"+0","dano":"1d4 impacto"},{"tipo":"Completa","nome":"Fixar","descricao":"Aproxima-se de alguém dormindo; Percepção do alvo (-◯◯ por dormir) vs. Furtividade do parasita (+15, 2◯) — se falhar, vira hospedeiro."},{"tipo":"Completa","nome":"Atormentar","dano":"2d6 mental (Vontade DT 20 reduz à metade)","descricao":"Fixado, todos no sonho sofrem no início de cada cena do sonho."},{"tipo":"Completa","nome":"Cópias do Hospedeiro","descricao":"Fixado, manifesta uma cópia de Conhecimento do hospedeiro (mesmas estatísticas, mas 20 PV e dano de Conhecimento); até 4 cópias por vez."}]',
  'Os personagens precisam perceber que vivem um sonho compartilhado e identificar quem é o hospedeiro; o hospedeiro deve então confrontar e derrotar as manifestações sozinho dentro do sonho.', 31
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Rastejador Sombrio', 180,
  'Entidade maligna que se aproxima lentamente das vítimas escondida em sombras distorcidas. Inteligente, sádico, escolhe causar a maior dor possível (física e psicológica). Sobreviventes relatam avistar pelo canto do olho uma forma humanoide nas sombras, sobretudo e chapéu escondendo o rosto — ao se revelar, uma boca enorme se abre num rosto acinzentado usado pra se camuflar nas sombras.',
  '{Conhecimento,Sangue}', 'Médio', 25, '6d6 mental', 60, '+15 (3◯, Percepção às Cegas)', '+15 (4◯)', 41, '+15 (3◯)', '+15 (4◯)', '+10 (3◯)', 330, 165, 'Balístico, corte e impacto 10, Conhecimento 20', 'Sangue',
  '{"agi":4,"for":3,"int":3,"pre":3,"vig":3}', 'Furtividade +15 (4◯), Ocultismo +15 (3◯)', '12m | 8',
  '[{"nome":"Vulnerabilidade a Luz","descricao":"Exposto diretamente a luz forte que o ilumina por completo, sofre -10 Defesa e perde Desespero, Rastejar e Tentáculos das Sombras."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Toque da Dor, corpo a corpo x3)","teste":"+20 (4◯)","dano":"4d8+5 Conhecimento"},{"tipo":"Livre","nome":"Desespero","descricao":"Quem sofre dano do toque da dor sofre o mesmo tanto de dano mental (Vontade DT 25 reduz o dano mental à metade)."},{"tipo":"Livre","nome":"Rastejar","descricao":"Até o início do próximo turno, sob cobertura/camuflagem, +10 em Furtividade e desloca furtivamente sem penalidade."},{"tipo":"Movimento","nome":"Tentáculos das Sombras","dano":"4d6 mental/turno agarrado","descricao":"Projeta fibras pelas sombras em até 3 alvos em alcance médio, agarrando-os (Reflexos DT 28 evita); pode arrastar os agarrados até outro ponto em alcance médio."}]',
  null, 32
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Silhueta', 360,
  'A ausência consciente de si mesma. Manifestação desesperadora, extremamente rara, de alguém que foi inexistido pelo Conhecimento, mas perdura na Realidade através do eco de suas memórias. Forma humanoide vazia cercada por sigilos do Outro Lado flutuando como se reescrevessem a Realidade a cada instante. Comportamento passivo — mas tudo que a toca sofre um efeito devastador. Quando você olha para o abismo do Conhecimento por tempo demais, o Outro Lado também te observa de volta.',
  '{Conhecimento}', 'Médio', 40, '8d8 mental', null, '+25 (5◯, Percepção às Cegas)', '+20 (4◯)', 55, '+20 (4◯)', '+20 (4◯)', '+25 (5◯)', 500, 250, 'Dano 30', 'Sangue',
  '{"agi":4,"for":4,"int":5,"pre":5,"vig":4}', null, '12m | 8',
  '[{"nome":"Imunidades","descricao":"Condições de paralisia, efeitos e dano de Conhecimento, manobras de combate."},{"nome":"Aura Tangível","descricao":"Quem toca nela sofre 20d12 dano de Conhecimento (Fortitude DT 42 reduz à metade; 0 PV = desintegração instantânea; só 1x/turno por ser/item)."},{"nome":"Conhecimento Verdadeiro","descricao":"+25 em testes de Intelecto/Presença, +20 nos demais."}]',
  '[{"tipo":"Livre","nome":"Reescrever a Realidade","descricao":"Enquanto se desloca, transforma objetos em alcance curto em outros objetos (mesmo tamanho); seres vivos e o que vestem/portam não são afetados."},{"tipo":"Padrão","nome":"Toque Devastador","descricao":"Toca até 2 seres/objetos, causando o dano da Aura Tangível."}]',
  null, 33
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Vulto', 40,
  'Em ambientes com a Membrana danificada, pode ser difícil discernir fatos da paranoia do próprio cérebro — sons inexistentes, temperatura inconstante, vultos em movimento. É nessa paranoia que um vulto pode nascer: criatura que sequer estava presente, mas o Medo do delírio de um observador cria uma casca física através da imaginação assustada, dando forma a uma criatura humanoide de névoa sólida capaz de causar estragos reais.',
  '{Conhecimento}', 'Médio', 15, '3d6 mental', 30, '+5 (2◯, Percepção às Cegas)', '+5 (4◯)', 19, '+0', '+5 (4◯)', '+5 (2◯)', 60, 30, 'Balístico, corte e perfuração 5, Conhecimento 10', 'Sangue',
  '{"agi":4,"for":2,"int":2,"pre":2,"vig":1}', 'Furtividade +10 (4◯)', '12m | 8',
  '[{"nome":"Aura Tangível","descricao":"Ataques contra alguém sob condição de medo causam +2d6 dano de Conhecimento."}]',
  '[{"tipo":"Padrão","nome":"Agredir (Toque Macabro, corpo a corpo x2)","teste":"+10 (4◯)","dano":"2d6 Conhecimento"},{"tipo":"Completa","nome":"Plantar Paranoia","descricao":"Chacoalha a Membrana; todos em alcance médio ficam abalados (Vontade DT 15 evita; já abalado vira apavorado); -◯ no teste se o vulto estiver escondido ao usar."}]',
  null, 34
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Máscara do Desespero', 400,
  'Também conhecida como a Relíquia do Conhecimento — uma das manifestações mais antigas na Realidade, talvez anterior à própria civilização humana. Máscara indestrutível contendo toda a verdade do Outro Lado. Quem a porta lembra e sabe tudo, mas saber tudo é perder tudo — a mente do usuário é soterrada e seu ego é inexistido; o portador vira a "Magistrada", executora das regras, com um único objetivo: proteger o equilíbrio na Realidade. (Chefe único, Relíquia.)',
  '{Conhecimento}', 'Minúsculo', 45, '10d8 mental', null, '+35 (6◯, Percepção às Cegas)', '+25 (4◯)', 55, '+35 (5◯)', '+25 (4◯)', '+35 (6◯)', 1200, 600, null, 'Sangue',
  '{"agi":4,"for":4,"int":6,"pre":6,"vig":5}', 'Ciência +35 (6◯), Ocultismo +35 (6◯), Religião +35 (6◯)', 'Voo 12m | 8',
  '[{"nome":"Imunidades","descricao":"Condições, dano."},{"nome":"Destronar o Anfitrião","descricao":"É a única capaz de resolver o Enigma de Medo do Anfitrião."},{"nome":"Potência do Conhecimento","descricao":"+35 em testes de Intelecto/Presença/Vigor, +25 nos demais."}]',
  '[{"tipo":"Livre","nome":"Conjuração Verdadeira","descricao":"1x/turno, conjura qualquer ritual de Conhecimento à escolha, de qualquer círculo (execução máxima ação completa, custo máximo 20 PE); DT pra resistir 45."},{"tipo":"Movimento","nome":"Onipresença","descricao":"Desloca-se pra qualquer lugar da Realidade com sombra/escuridão, qualquer distância; sabe tudo que acontece na Realidade ao mesmo tempo; ignora necessidade de ver/ouvir."},{"tipo":"Padrão","nome":"Reescrever Realidade","descricao":"Altera propriedades de seres/objetos em alcance médio. Objetos (até 1 tonelada): muda composição/posição/estado da matéria. Seres: 10d6 dano de Conhecimento + 10d6 dano mental + uma condição qualquer (exceto morrendo/enlouquecendo) — Vontade DT 45 reduz cada dano à metade e evita a condição."}]',
  'Indestrutível, assim como o portador — mas há dois registros de possibilidades: abalar diretamente o Equilíbrio quebrando as regras da Realidade através do Medo, ou devastar a razão do portador através da brutalidade da Relíquia de Sangue (o Diabo). Ao resolver, perde a imunidade a dano e a Onipresença.', 35
);
