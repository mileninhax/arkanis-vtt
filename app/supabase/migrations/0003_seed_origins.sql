-- Seed: origens (Livro Base, 11.4). Fonte: docs/VTT_Conteudo_Ordem_Paranormal.md

insert into origins (source_id, name, roll_range, skill_1_id, skill_2_id, skills_text, power_name, power_description, description, sort_order)
select
  (select id from sources where slug = 'ordem_paranormal'),
  v.name, v.roll_range,
  (select id from skills where name = v.skill_1),
  (select id from skills where name = v.skill_2),
  v.skills_text, v.power_name, v.power_description, v.description, v.ord
from (values
  ('Acadêmico', '2-8', 'Ciências', 'Investigação', null,
   'Saber é Poder', 'Quando faz um teste usando Intelecto, você pode gastar 2 PE para receber +5 nesse teste.',
   'Você era um pesquisador ou professor universitário. De forma proposital ou não, seus estudos tocaram em assuntos misteriosos e chamaram a atenção da Ordo Realitas.', 1),

  ('Agente de Saúde', '9-10', 'Intuição', 'Medicina', null,
   'Técnica Medicinal', 'Sempre que cura um personagem, você adiciona seu Intelecto no total de PV curados.',
   'Você era um profissional da saúde, como um enfermeiro, farmacêutico, médico, psicólogo ou socorrista, treinado no atendimento e cuidado de pessoas. Você pode ter sido surpreendido por um evento paranormal durante o trabalho ou mesmo cuidado de um agente da Ordem em uma emergência, que ficou surpreso com o quão bem você lidou com a situação.', 2),

  ('Amnésico', '11', null, null, 'Duas à escolha do mestre',
   'Vislumbres do Passado', 'Uma vez por sessão, você pode fazer um teste de Intelecto (DT 10) para reconhecer pessoas ou lugares familiares, que tenha encontrado antes de perder a memória. Se passar, recebe 1d4 PE temporários e, a critério do mestre, uma informação útil.',
   'Você perdeu a maior parte da memória. Sabe apenas o próprio nome, ou nem isso. Sua amnésia pode ser resultado de um trauma paranormal ou mesmo de um ritual. Talvez você tenha sido vítima de cultistas? Talvez você tenha sido um cultista? Seja como for, hoje a Ordem é a única família que conhece.', 3),

  ('Artista', '12-13', 'Artes', 'Enganação', null,
   'Magnum Opus', 'Você é famoso por uma de suas obras. Uma vez por missão, pode determinar que uma pessoa envolvida em uma cena de interação o reconheça. Você recebe +5 em testes de Presença e de perícias baseadas em Presença contra aquela pessoa.',
   'Você era um ator, músico, escritor, dançarino, influenciador… Seu trabalho pode ter sido inspirado por uma experiência paranormal do passado.', 4),

  ('Atleta', '14-15', 'Acrobacia', 'Atletismo', null,
   '110%', 'Quando faz um teste de perícia usando Força ou Agilidade (exceto Luta e Pontaria) você pode gastar 2 PE para receber +5 nesse teste.',
   'Você competia em um esporte individual ou coletivo, como natação ou futebol. Seu desempenho pode ser fruto de uma influência paranormal que nem mesmo você conhecia.', 5),

  ('Chef', '16', 'Fortitude', null, 'Fortitude e Profissão (cozinheiro)',
   'Ingrediente Secreto', 'Em cenas de interlúdio, você pode fazer a ação alimentar-se para cozinhar um prato especial. Você, e todos os membros do grupo que fizeram a ação alimentar-se, recebem o benefício de dois pratos (efeitos se acumulam se escolhido duas vezes).',
   'Você é um cozinheiro amador ou profissional. Como sua comida fez com que você se envolvesse com o paranormal? Ninguém sabe.', 6),

  ('Criminoso', '17', 'Crime', 'Furtividade', null,
   'O Crime Compensa', 'No final de uma missão, escolha um item encontrado na missão. Em sua próxima missão, você pode incluir esse item em seu inventário sem que ele conte em seu limite de itens por patente.',
   'Você vivia uma vida fora da lei, seja como mero batedor de carteiras, seja como membro de uma facção criminosa. Em algum momento, você se envolveu em um assunto da Ordem.', 7),

  ('Cultista Arrependido', '18', 'Ocultismo', 'Religião', null,
   'Traços do Outro Lado', 'Você possui um poder paranormal à sua escolha. Porém, começa o jogo com metade da Sanidade normal para sua classe.',
   'Você fez parte de um culto paranormal. Talvez fossem ignorantes iludidos, talvez soubessem exatamente o que estavam fazendo. Algo abriu seus olhos e agora você luta pelo lado certo.', 8),

  ('Desgarrado', '19', 'Fortitude', 'Sobrevivência', null,
   'Calejado', 'Você recebe +1 PV para cada 5% de NEX.',
   'Você não vivia de acordo com as normas da sociedade. Podia ser um eremita, uma pessoa em situação de rua ou simplesmente alguém que descobriu o paranormal e abandonou sua rotina.', 9),

  ('Engenheiro', '20', 'Profissão', 'Tecnologia', null,
   'Ferramenta Favorita', 'Um item a sua escolha (exceto armas) conta como uma categoria abaixo (por exemplo, um item de categoria II conta como categoria I para você).',
   'Enquanto os acadêmicos estão preocupados com teorias, você coloca a mão na massa, seja como engenheiro profissional, seja como inventor de garagem.', 10),

  ('Executivo', '21', 'Diplomacia', 'Profissão', null,
   'Processo Otimizado', 'Sempre que faz um teste de perícia durante um teste estendido, ou uma ação para revisar documentos (físicos ou digitais), pode pagar 2 PE para receber +5 nesse teste.',
   'Você possuía um trabalho de escritório em uma grande empresa, banco ou corporação. Sua vida era bastante normal, até que você descobriu algo que não devia.', 11),

  ('Investigador', '22-23', 'Investigação', 'Percepção', null,
   'Faro para Pistas', 'Uma vez por cena, quando fizer um teste para procurar pistas, você pode gastar 1 PE para receber +5 nesse teste.',
   'Você era um investigador do governo, como um perito forense ou policial federal, ou privado, como um detetive particular.', 12),

  ('Lutador', '24', 'Luta', 'Reflexos', null,
   'Mão Pesada', 'Você recebe +2 em rolagens de dano com ataques corpo a corpo.',
   'Você pratica uma arte marcial ou esporte de luta, ou cresceu em um bairro perigoso onde aprendeu briga de rua.', 13),

  ('Magnata', '25', 'Diplomacia', 'Pilotagem', null,
   'Patrocinador da Ordem', 'Seu limite de crédito é sempre considerado um acima do atual.',
   'Você possui muito dinheiro ou patrimônio. Pode ser o herdeiro de uma família antiga ligada ao oculto, ou ter criado e vendido uma empresa.', 14),

  ('Mercenário', '26', 'Iniciativa', 'Intimidação', null,
   'Posição de Combate', 'No primeiro turno de cada cena de ação, você pode gastar 2 PE para receber uma ação de movimento adicional.',
   'Você é um soldado de aluguel, que trabalha sozinho ou como parte de alguma organização que vende serviços militares.', 15),

  ('Militar', '27', 'Pontaria', 'Tática', null,
   'Para Bellum', 'Você recebe +2 em rolagens de dano com armas de fogo.',
   'Você serviu em uma força militar, como o exército ou a marinha. Passou muito tempo treinando com armas de fogo, até se tornar um perito no uso delas.', 16),

  ('Operário', '28', 'Fortitude', 'Profissão', null,
   'Ferramenta de Trabalho', 'Escolha uma arma simples ou tática que, a critério do mestre, poderia ser usada como ferramenta em sua profissão. Você sabe usar a arma escolhida e recebe +1 em testes de ataque, rolagens de dano e margem de ameaça com ela.',
   'Pedreiro, industriário, operador de máquinas em uma fábrica… Você passou uma parte de sua vida em um emprego braçal.', 17),

  ('Policial', '29-30', 'Percepção', 'Pontaria', null,
   'Patrulha', 'Você recebe +2 em Defesa.',
   'Você fez parte de uma força de segurança pública, civil ou militar. Em alguma patrulha ou chamado se deparou com um caso paranormal e sobreviveu para contar a história.', 18),

  ('Religioso', '31', 'Religião', 'Vontade', null,
   'Acalentar', 'Você recebe +5 em testes de Religião para acalmar. Além disso, quando acalma uma pessoa, ela recebe um número de pontos de Sanidade igual a 1d6 + a sua Presença.',
   'Você é devoto ou sacerdote de uma fé. Independentemente da religião que pratica, se dedica a auxiliar as pessoas com problemas espirituais.', 19),

  ('Servidor Público', '32', 'Intuição', 'Vontade', null,
   'Espírito Cívico', 'Sempre que faz um teste para ajudar, você pode gastar 1 PE para aumentar o bônus concedido em +2.',
   'Você possuía carreira em um órgão do governo, lidando com burocracia e atendendo pessoas. Sua rotina foi quebrada quando você viu que o prefeito era um cultista.', 20),

  ('Teórico da Conspiração', '33', 'Investigação', 'Ocultismo', null,
   'Eu Já Sabia', 'Você não se abala tanto com entidades ou anomalias. Afinal, sempre soube que isso tudo existia. Você recebe resistência a dano mental igual ao seu Intelecto.',
   'A humanidade nunca pisou na lua. Reptilianos ocupam importantes cargos públicos. Quando sua pesquisa esbarrou no paranormal, você foi recrutado.', 21),

  ('T.I.', '34', 'Investigação', 'Tecnologia', null,
   'Motor de Busca', 'A critério do mestre, sempre que tiver acesso a internet, você pode gastar 2 PE para substituir um teste de perícia qualquer por um teste de Tecnologia.',
   'Programador, engenheiro de software ou simplesmente "o cara da T.I.", você tem treinamento e experiência para lidar com sistemas informatizados.', 22),

  ('Trabalhador Rural', '35', 'Adestramento', 'Sobrevivência', null,
   'Desbravador', 'Quando faz um teste de Adestramento ou Sobrevivência, você pode gastar 2 PE para receber +5 nesse teste. Além disso, você não sofre penalidade em deslocamento por terreno difícil.',
   'Você trabalhava no campo ou em áreas isoladas, como fazendeiro, pescador, biólogo, veterinário…', 23),

  ('Trambiqueiro', '36', 'Crime', 'Enganação', null,
   'Impostor', 'Uma vez por cena, você pode gastar 2 PE para substituir um teste de perícia qualquer por um teste de Enganação.',
   'Uma vida digna exige muito trabalho, então é melhor nem tentar. Você vivia de pequenos golpes, jogatina ilegal e falcatruas.', 24),

  ('Universitário', '37-38', 'Atualidades', 'Investigação', null,
   'Dedicação', 'Você recebe +1 PE, e mais 1 PE adicional a cada NEX ímpar (15%, 25%…). Além disso, seu limite de PE por turno aumenta em 1 (isso não afeta a DT de seus efeitos).',
   'Você era aluno de uma faculdade. Em sua rotina de estudos, provas e festas, acabou descobrindo algo — talvez um livro amaldiçoado na antiga biblioteca do campus?', 25),

  ('Vítima', '39-40', 'Reflexos', 'Vontade', null,
   'Cicatrizes Psicológicas', 'Você recebe +1 de Sanidade para cada 5% de NEX.',
   'Em algum momento de sua vida você encontrou o paranormal… E a experiência não foi nada boa. A experiência foi traumática, mas você não se abateu; em vez disso, decidiu lutar para impedir que outros inocentes passem pelo mesmo.', 26)
) as v(name, roll_range, skill_1, skill_2, skills_text, power_name, power_description, description, ord);
