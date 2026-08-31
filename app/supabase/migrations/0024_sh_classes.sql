-- Sobrevivendo ao Horror, parte 2: novos poderes/trilhas de Combatente/Especialista/
-- Ocultista, e a classe Sobrevivente completa (progride por Estágio 1-5, não por NEX% —
-- ver nota abaixo).

-- ============================================================
-- Novos Poderes de Combatente
-- ============================================================
insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'combatente'), v.name, v.description, v.prereq, v.ord from (values
  ('Apego Angustiado', 'Não fica inconsciente por estar morrendo; toda rodada terminada morrendo e consciente, perde 2 Sanidade.', null, 20),
  ('Caminho para Forca', 'Ação sacrifício (cena de perseguição), gasta 1 PE pra +1d20 extra (total +2d20) nos testes dos outros; ação chamar atenção (cena de furtividade), gasta 1 PE pra reduzir visibilidade dos aliados em -2 (em vez de -1).', null, 21),
  ('Ciente das Cicatrizes', 'Teste pra achar pista relacionada a armas/ferimentos usa Luta ou Pontaria no lugar da perícia original.', 'Treinado em Luta ou Pontaria', 22),
  ('Correria Desesperada', '+3m deslocamento; +1d20 em perícia pra fugir em perseguição.', null, 23),
  ('Engolir o Choro', 'Sem penalidade de condições em testes de perícia pra fugir e em Furtividade.', null, 24),
  ('Instinto de Fuga', 'Início de cena de perseguição, +2 em todos os testes de perícia na cena.', 'Treinado em Intuição', 25),
  ('Mochileiro', '+5 espaços de carga; +1 vestimenta simultânea.', 'Vig 2', 26),
  ('Paranoia Defensiva', '1x/cena, gasta 1 rodada + 3 PE; você e cada aliado presente escolhe +5 Defesa contra o próximo ataque ou +5 num teste de perícia até o fim da cena.', null, 27),
  ('Sacrificar os Joelhos', '1x/cena de perseguição, na ação esforço extra, gasta 2 PE pra passar automaticamente no teste.', 'Treinado em Atletismo', 28),
  ('Sem Tempo, Irmão', '1x/cena de investigação, ação facilitar investigação passa automaticamente + rolagem adicional na tabela de eventos de investigação.', null, 29),
  ('Valentão', 'Usa Força no lugar de Presença pra Intimidação; 1x/cena, gasta 1 PE pra Intimidação (assustar) como ação livre.', null, 30)
) as v(name, description, prereq, ord);

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'combatente'), v.slug, v.name, v.description, v.ord from (values
  ('agente_secreto', 'Agente Secreto', 'Treinado pra trabalhar disfarçado a serviço de uma agência em conjunto com a Ordem.', 6),
  ('cacador', 'Caçador', 'Reúne informações sobre como caçar predadores sobrenaturais.', 7),
  ('monstruoso', 'Monstruoso', 'Combatente que desfigura o próprio corpo pra ser invadido pelas Entidades; caminho perigoso que costuma terminar em traição da Ordem. Usa a "Progressão de NEX" da regra opcional Nível de Experiência mesmo sem estar em uso.', 8)
) as v(slug, name, description, ord);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'agente_secreto' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Carteirada', 'Treina (ou +2 se já treinado) em Diplomacia ou Enganação à escolha; recebe documentos com privilégios jurídicos no início de cada missão (itens operacionais sem espaço; pessoas comuns não percebem que são falsos, mas agências/veteranos em Crime podem desconfiar).'),
  (40, 'O Sorriso', '+2 Diplomacia e Enganação; falhar num teste dessas, gasta 2 PE pra rerrolar (aceita o novo resultado); 1x/cena, testa Diplomacia pra acalmar a si mesmo.'),
  (65, 'Método Investigativo', 'Urgência de cena de investigação em que está presente +1 rodada; ao mestre rolar na tabela de eventos de investigação, gasta 2 PE pra virar "sem evento" (pode repetir na mesma cena, +2 PE por uso adicional).'),
  (99, 'Multifacetado', '1x/cena, gasta 5 Sanidade pra receber todas as habilidades até NEX 65% de uma trilha de combatente ou especialista à escolha (cumprindo pré-requisitos) até o fim da cena; não repete a mesma trilha na mesma missão; Sanidade só recupera no fim da missão.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'cacador' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Rastrear o Paranormal', 'Treina (ou +2) em Sobrevivência; usa essa perícia no lugar de Ocultismo pra identificar criaturas e no lugar de Investigação/Percepção pra rastros/pistas/criaturas com traços paranormais.'),
  (40, 'Estudar Fraquezas', 'Ação de interlúdio + pista ligada a um ser específico → informação útil sobre ele + acumula +1 em testes de perícia contra ele até o fim da missão (por pista).'),
  (65, 'Atacar das Sombras', 'Sem penalidade -1d20 em Furtividade por se mover no deslocamento normal; atacar com arma silenciosa na mesma rodada reduz a penalidade pra -1d20; visibilidade inicial em furtividade sempre 1 ponto abaixo (pode ficar negativa).'),
  (99, 'Estudar a Presa', 'Usando Estudar Fraquezas contra criatura/cultista, pode marcá-lo como "presa" — contra o tipo, +1d20 em testes de perícia, +1 margem de ameaça e multiplicador de crítico, resistência a dano 5. Só uma presa por vez.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'monstruoso' and class_id = (select id from classes where slug = 'combatente')), v.nex, v.name, v.description from (values
  (10, 'Ser Amaldiçoado', 'Treina (ou +2) em Ocultismo; escolhe um elemento (Sangue/Morte/Conhecimento/Energia). 1x/dia precisa executar uma "etapa ritualística" do elemento (ex.: beber sangue humano) ou sofre fome/sede nesse dia; cumprindo, ganha efeitos do elemento até o fim do dia (resistência a dano 5 + bônus/penalidade específicos por elemento — ver descrição completa no documento de conteúdo).'),
  (40, 'Ser Macabro', 'Resistência da etapa ritualística sobe pra 10, penalidade em perícias sobe pra -2d20; ganha efeitos adicionais por elemento (ver descrição completa no documento de conteúdo).'),
  (65, 'Ser Assustador', 'Resistência da etapa ritualística sobe pra 15, Presença cai -1 permanente; efeitos adicionais por elemento (ver descrição completa no documento de conteúdo).'),
  (99, 'Ser Aterrorizante', 'Efeitos da etapa ritualística tornam-se permanentes; passa a ser criatura paranormal pra efeitos de itens/habilidades; resistência sobe pra 20; efeitos finais por elemento, incluindo mutações de atributo e aprendizado de um ritual específico (ver descrição completa no documento de conteúdo). Ao chegar a NEX 75%, fica permanentemente perturbado e é banido/caçado pela Ordem; ao chegar a NEX 99%, Sanidade cai pra 1 e pode virar permanentemente criatura do Outro Lado ao enlouquecer.')
) as v(nex, name, description);

-- ============================================================
-- Novos Poderes de Especialista
-- ============================================================
insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'especialista'), v.name, v.description, v.prereq, v.ord from (values
  ('Acolher o Terror', 'Pode se entregar ao medo 1x adicional por sessão.', null, 16),
  ('Contatos Oportunos', 'Ação de interlúdio pra acionar contato local — recebe um aliado de tipo à escolha até o fim da missão (só 1 por vez; mestre decide disponibilidade).', 'Treinado em Crime', 17),
  ('Disfarce Sutil', 'Disfarçar a si mesmo com Enganação, gasta 1 PE pra fazer como ação completa sem kit (com kit, +5 no teste).', 'Pre 2, treinado em Enganação', 18),
  ('Esconderijo Desesperado', 'Sem penalidade -1d20 em Furtividade ao mover no deslocamento normal; em cena de furtividade, sucesso ao esconder reduz visibilidade em -2 (em vez de -1).', null, 19),
  ('Especialista Diletante', 'Aprende um poder de outra classe (não trilha nem paranormal) cumprindo pré-requisitos.', 'NEX 30%', 20),
  ('Flashback', 'Escolhe uma origem que não a sua; recebe o poder dela.', null, 21),
  ('Leitura Fria', '1x por interlúdio, interagindo/observando um NPC por minutos, faz 3 perguntas pessoais; cada não respondida dá 2 PE temporários até o fim da missão; só 1x por pessoa, só em NPCs.', 'Treinado em Intuição', 22),
  ('Mãos Firmes', 'Teste de Furtividade pra esconder ou ação discreta manipulando objeto, gasta 2 PE pra +1d20.', 'Treinado em Furtividade', 23),
  ('Plano de Fuga', 'Usa Intelecto no lugar de Força pra ação criar obstáculos em perseguição; 1x/cena, gasta 2 PE pra dispensar o teste e ter sucesso automático.', null, 24),
  ('Remoer Memórias', '1x/cena, teste de perícia baseado em Int/Pre, gasta 2 PE pra substituir por teste de Intelecto DT 15.', 'Int 1', 25),
  ('Resistir à Pressão', '1x/cena de investigação, gasta 5 PE; urgência +1 rodada, todos (incluindo você) +2 em testes de perícia nessa rodada extra.', 'Treinado em Investigação', 26)
) as v(name, description, prereq, ord);

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'especialista'), v.slug, v.name, v.description, v.ord from (values
  ('bibliotecario', 'Bibliotecário', 'Conhecimento vasto como arma contra o desespero.', 6),
  ('perseverante', 'Perseverante', 'O sobrevivente clássico de filme de terror, o último de pé.', 7),
  ('muambeiro', 'Muambeiro', 'Talento pra produzir/encontrar equipamento na hora certa.', 8)
) as v(slug, name, description, ord);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'bibliotecario' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Conhecimento Prático', 'Teste de perícia (exceto Luta/Pontaria), gasta 2 PE pra trocar o atributo-base pra Int (custo -1 PE se já tem Conhecimento Aplicado).'),
  (40, 'Leitor Contumaz', 'Bônus da ação ler sobe pra 1d8 e aplica em teste de qualquer perícia; gasta 2 PE pra subir esse dado pra 2d8.'),
  (65, 'Rato de Biblioteca', 'Em ambiente cheio de livros, gasta minutos (ou 1 rodada em cena de investigação) pra replicar os benefícios de ler ou revisar caso; 1x/cena.'),
  (99, 'A Força do Saber', '+1 Intelecto, soma Intelecto no total de PE; escolhe uma perícia e troca o atributo-base dela pra Intelecto.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'perseverante' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Soluções Improvisadas', 'Gasta 2 PE pra rerrolar um dado de um teste recém-feito (1x por teste), fica com o melhor resultado.'),
  (40, 'Fuga Obstinada', '+1d20 em testes de perícia pra fugir de inimigo (perseguição ou não); sendo a presa numa perseguição, acumula até 4 falhas antes de ser pego (em vez do padrão).'),
  (65, 'Determinação Inquestionável', '1x/cena, gasta 5 PE + ação padrão pra remover uma condição de medo/mental/paralisia (algumas exceções a critério do mestre).'),
  (99, 'Só Mais um Passo...', '1x/rodada, ao sofrer dano que reduziria a 0 PV, gasta 5 PE pra ficar em 1 PV em vez disso (não funciona contra dano massivo).')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'muambeiro' and class_id = (select id from classes where slug = 'especialista')), v.nex, v.name, v.description from (values
  (10, 'Mascate', 'Treina numa Profissão à escolha (armeiro/engenheiro/químico); +5 capacidade de carga; fabricar item improvisado tem DT reduzida em -10 (em vez de -5).'),
  (40, 'Fabricação Própria', 'Metade do tempo pra fabricar itens mundanos — 1 ação de manutenção fabrica 2 munições/explosivos/consumíveis, ou 1 arma/proteção/geral (itens modificados/paranormais não afetados).'),
  (65, 'Laboratório de Campo', 'Treina (ou +5 se já treinado) numa Profissão à escolha (armeiro/engenheiro/químico); pode fabricar/consertar itens paranormais via fabricação em campo (3 ações de interlúdio não-consecutivas).'),
  (99, 'Achado Conveniente', 'Ação completa + 5 PE pra "produzir" um item até categoria III (exceto paranormal), justificado narrativamente; funciona até o fim da cena, depois para de funcionar permanentemente.')
) as v(nex, name, description);

-- ============================================================
-- Novos Poderes de Ocultista
-- ============================================================
insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Deixe os Sussurros Guiarem', '1x/cena, gasta 2 PE + 1 rodada pra +2 em perícias de investigação até o fim da cena; enquanto ativo, cada falha em teste de perícia custa 1 Sanidade.', null, 17),
  ('Domínio Esotérico', 'Ao lançar ritual, combina até 2 catalisadores ritualísticos diferentes ao mesmo tempo.', 'Int 3', 18),
  ('Estalos Macabros', 'Ação de atrapalhar/distrair/fintar, gasta 1 PE pra usar Ocultismo em vez da perícia original; alvo pessoa/animal dá +5 no teste.', null, 19),
  ('Minha Dor me Impulsiona', 'Teste de Acrobacia/Atletismo/Furtividade, gasta 1 PE pra +1d6 (só se já tiver sofrido 5+ de dano nos PV).', 'Vig 2', 20),
  ('Nos Olhos do Monstro', 'Em cena com criatura paranormal, gasta 1 rodada + 3 PE encarando os olhos/rosto dela pra +5 em testes contra ela (exceto ataque) até o fim da cena.', null, 21),
  ('Olhar Sinistro', 'Usa Presença no lugar de Intelecto pra Ocultismo; usa Ocultismo pra coagir (como Intimidação).', 'Pre 1', 22),
  ('Sentido Premonitório', 'Gasta 3 PE pra ativar sentido premonitório (déjà vu de 1 rodada) — sabe quando a urgência de investigação vai acabar, se/qual evento vai ocorrer, e as ações inimigas em furtividade/perseguição antes de decidir as próprias; sem efeito em combate; manter custa 1 PE/rodada.', null, 23),
  ('Sincronia Paranormal', 'Ação padrão + 2 PE estabelece sincronia mental com personagens em alcance médio que já sobreviveram a um encontro paranormal com você; no início de cada rodada, distribui 1d20 = Presença entre os participantes (usável em testes Int/Pre, some no fim da rodada); manter custa 1 PE/rodada.', 'Pre 2', 24),
  ('Traçado Conjuratório', '1 PE + ação completa traça símbolo num quadrado de 1,5m; dentro dele, +2 Ocultismo e resistência, DT dos seus rituais +2; dura até o fim da cena.', null, 25)
) as v(name, description, prereq, ord);

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'ocultista'), v.slug, v.name, v.description, v.ord from (values
  ('exorcista', 'Exorcista', 'Fé como escudo, palavras como espada contra o paranormal.', 6),
  ('possuido', 'Possuído', 'O paranormal escolheu você antes mesmo de nascer; mecânica própria de Pontos de Possessão (PP).', 7),
  ('parapsicologo', 'Parapsicólogo', 'Usa o paranormal pra curar a mente, não só perturbá-la. Pré-requisito pra escolher: treinado em Profissão (psicólogo).', 8)
) as v(slug, name, description, ord);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'exorcista' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Revelação do Mal', 'Treina (ou +2) em Religião; usa Religião no lugar de Investigação/Percepção pra notar/achar seres-rastros-pistas paranormais, e no lugar de Ocultismo.'),
  (40, 'Poder da Fé', 'Vira veterano (ou +1d20 se já veterano) em Religião; falha em teste de resistência, gasta 2 PE pra rerrolar usando Religião (aceita o novo resultado).'),
  (65, 'Parareligiosidade', 'Ao conjurar ritual, gasta +2 PE pra adicionar efeito de um catalisador ritualístico à escolha.'),
  (99, 'Chagas da Resistência', 'Sanidade reduzida a 0, gasta 10 PV pra ficar com Sanidade 1 em vez disso.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'possuido' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Poder Não Desejado', 'Todo novo poder de ocultista que receberia vira Transcender em vez disso. Ganha reserva de Pontos de Possessão (PP) = 3 + 2 por poder Transcender que possui; limite de PP gasto por turno = Presença; cada PP gasto recupera 10 PV ou 2 PE; recupera 1 PP por ação dormir.'),
  (40, 'As Sombras Dentro de Mim', 'Recuperação de PP sobe pra 2 por dormir. Gasta 2 PE pra deixar a Entidade controlar os músculos por 1 rodada: +1d20 em Acrobacia/Atletismo/Furtividade, e em cena de furtividade o aumento de visibilidade por qualquer ação nessa rodada é reduzido em -1.'),
  (65, 'Ele Me Ensina', 'Escolhe entre Transcender ou o primeiro poder de uma trilha de ocultista que não a sua (cumprindo pré-requisitos).'),
  (99, 'Tornamo-nos Um', 'Recebe um "Presente" conforme a Afinidade elemental (Sangue: recuperar 50 PV; Morte: turno adicional; Conhecimento: usar um poder qualquer temporariamente; Energia: teletransporte) — ver descrição completa no documento de conteúdo.')
) as v(nex, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'parapsicologo' and class_id = (select id from classes where slug = 'ocultista')), v.nex, v.name, v.description from (values
  (10, 'Terapia', 'Usa Profissão (psicólogo) como Diplomacia. 1x/rodada, você ou aliado em alcance curto falha resistência contra dano mental, gasta 2 PE pra testar Profissão (psicólogo) no lugar (se já tem a habilidade Terapia de origem/outra fonte, em vez disso custo -1 PE e +2 na perícia).'),
  (40, 'Palavras-chave', 'Ao passar em teste pra acalmar, gasta PE (até seu limite) — cada PE recupera 1 Sanidade (ou 1 PD, se Jogando sem Sanidade) na pessoa tratada.'),
  (65, 'Reprogramação Mental', '5 PE + ação de interlúdio (a pessoa alvo também gasta a dela) pra manipular mente de voluntário em alcance curto; até o próximo interlúdio, a pessoa recebe um poder geral, um poder da própria classe, ou o 1º poder de uma trilha que não a dela (à escolha dela, cumprindo pré-requisitos), acreditando que sempre foi seu.'),
  (99, 'A Sanidade Está Lá Fora', 'Ação de movimento + 5 PE remove todas as condições de medo/mentais de pessoa adjacente (incluindo você mesmo).')
) as v(nex, name, description);

-- ============================================================
-- Classe Sobrevivente — atualiza descrição/proficiências (stat block já batia com 11.5/4.5)
-- ============================================================
update classes set
  description = 'Muito mais fraco que Combatente, Especialista ou Ocultista — de propósito, pra oferecer uma experiência de jogo diferente, na pele de uma pessoa comum que precisa fugir ou se esconder diante do terror. Progride por Estágio (1 a 5), não por NEX% — ver character_progression_picks e nota de arquitetura pendente.',
  trained_skills_text = 'Escolha 1 + Intelecto',
  proficiencies_text = 'Armas simples',
  source_id = (select id from sources where slug = 'sobrevivendo_ao_horror')
where slug = 'sobrevivente';

-- Habilidades de classe do Sobrevivente (marcadas como base — concedidas conforme o Estágio, não escolhidas em NEX15+)
insert into class_powers (class_id, name, description, sort_order, is_base_ability)
select (select id from classes where slug = 'sobrevivente'), v.name, v.description, v.ord, true from (values
  ('Empenho', 'Teste de perícia, gasta 1 PE pra +2.', 1),
  ('Aumento de Atributo (Estágio 3)', '+1 num atributo à escolha (máx. 3). Vigor aumenta PV; Presença aumenta PE; Intelecto dá nova perícia treinada.', 2),
  ('Cicatrizado (Estágio 5)', 'Escolhe um tipo de perigo paranormal de elemento específico já enfrentado — sofre -1d20 em resistência contra ele, mas 1x/sessão pode, como reação, sacrificar 1 PV permanente pra ignorar dano mental/gasto de PE, ou sacrificar 1 PE permanente pra reduzir dano físico à metade.', 3)
) as v(name, description, ord);

insert into class_tracks (class_id, slug, name, description, sort_order)
select (select id from classes where slug = 'sobrevivente'), v.slug, v.name, v.description, v.ord from (values
  ('durao', 'Durão', 'Foco em força física.', 1),
  ('esperto', 'Esperto', 'Foco em conhecimento/persuasão.', 2),
  ('esoterico', 'Esotérico', 'Foco em espiritual/sexto sentido.', 3)
) as v(slug, name, description, ord);

-- Trilhas de Sobrevivente evoluem em Estágio 2 e 4 (não NEX%) — reaproveita a coluna nex_percent
-- pra guardar o estágio (2 ou 4), já sinalizado no nome/descrição pra não confundir na UI.
insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'durao' and class_id = (select id from classes where slug = 'sobrevivente')), v.estagio, v.name, v.description from (values
  (2, 'Durão (Estágio 2)', '+4 PV (mais +2 ao subir pro estágio 3).'),
  (4, 'Pancada Forte (Estágio 4)', 'Ataque, gasta 1 PE pra +1d20 no teste (se virar combatente, perde essa habilidade mas reduz custo de Ataque Especial em -1 PE).')
) as v(estagio, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'esperto' and class_id = (select id from classes where slug = 'sobrevivente')), v.estagio, v.name, v.description from (values
  (2, 'Esperto (Estágio 2)', 'Treina numa perícia adicional à escolha.'),
  (4, 'Entendido (Estágio 4)', 'Escolhe 2 perícias treinadas (exceto Luta/Pontaria); teste nelas, gasta 1 PE pra +1d4 (se virar especialista, perde mas reduz custo de Perito em -1 PE).')
) as v(estagio, name, description);

insert into class_track_tiers (track_id, nex_percent, name, description)
select (select id from class_tracks where slug = 'esoterico' and class_id = (select id from classes where slug = 'sobrevivente')), v.estagio, v.name, v.description from (values
  (2, 'Esotérico (Estágio 2)', 'Ação padrão + 1 PE sente energias paranormais em alcance curto (mestre define o que descobre).'),
  (4, 'Iniciado (Estágio 4)', 'Aprende e conjura 1 ritual de 1º círculo à escolha (se virar ocultista, soma esse ritual aos 3 de Escolhido pelo Outro Lado).')
) as v(estagio, name, description);
