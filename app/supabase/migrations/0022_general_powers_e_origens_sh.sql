-- Sobrevivendo ao Horror (SH), parte 1: tabela de Poderes Gerais (faltava no schema —
-- resolve a pendência já sinalizada em 11.6 do Livro Base) + as 20 novas origens.

create table general_powers (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  description text not null,
  prerequisites text
);

alter table general_powers enable row level security;
create policy "general_powers: leitura pública" on general_powers for select using (true);

insert into general_powers (source_id, name, description, prerequisites)
select (select id from sources where slug = 'sobrevivendo_ao_horror'), v.name, v.description, v.prereq
from (values
  ('Acrobático', 'Treina (ou +2) Acrobacia; terreno difícil não reduz deslocamento nem impede investidas.', 'Agi 2'),
  ('Ás do Volante', '1x/rodada, veículo que pilota sofre dano, testa Pilotagem (DT = teste de ataque/efeito) pra evitar o dano.', 'Agi 2'),
  ('Atlético', 'Treina (ou +2) Atletismo; +3m deslocamento.', 'For 2'),
  ('Atraente', '+5 em Artes/Diplomacia/Enganação/Intimidação contra quem pode se sentir atraído fisicamente por você.', 'Pre 2'),
  ('Dedos Ágeis', 'Treina (ou +2) Crime; arromba como ação padrão, furta como ação livre (1x/rodada), sabota como ação completa.', 'Agi 2'),
  ('Detector de Mentiras', 'Treina (ou +2) Intuição; outros sofrem -10 em Enganação pra mentir pra você.', 'Pre 2'),
  ('Especialista em Emergências', 'Treina (ou +2) Medicina; aplica cicatrizantes/medicamentos como ação de movimento; 1x/rodada saca um desses itens como ação livre.', 'Int 2'),
  ('Estigmado', 'Dano mental de efeitos de medo pode ser convertido em perda de PV equivalente.', null),
  ('Foco em Perícia', 'Escolhe uma perícia (exceto Luta/Pontaria); +◯ nela; pode escolher de novo pra perícias diferentes.', 'Treinado na perícia'),
  ('Inventário Organizado', 'Soma Intelecto no limite de espaços de carga; itens de 0,5 espaço passam a ocupar 0,25.', 'Int 2'),
  ('Informado', 'Treina (ou +2) Atualidades; usa Atualidades no lugar de qualquer perícia pra testes envolvendo informação (a critério do mestre).', 'Int 2'),
  ('Interrogador', 'Treina (ou +2) Intimidação; testa Intimidação pra coagir como ação padrão, 1x/cena por pessoa.', 'For 2'),
  ('Mentiroso Nato', 'Treina (ou +2) Enganação; penalidade por mentiras implausíveis cai pra -◯.', 'Pre 2'),
  ('Observador', 'Treina (ou +2) Investigação; soma Intelecto em Intuição.', 'Int 2'),
  ('Pai de Pet', 'Treina (ou +2) Adestramento; tem animal de estimação = aliado com +2 em 2 perícias à escolha (exceto Luta/Pontaria).', 'Pre 2'),
  ('Palavras de Devoção', 'Treina (ou +2) Religião; 1x/cena, 3 PE + ação completa, oração pra até 2x Presença pessoas; resistência a dano mental 5 até o fim da cena.', 'Pre 2'),
  ('Parceiro', 'Tem um aliado de tipo à escolha que te acompanha nas missões; perder o parceiro exige gastar uma folga da Ordem pra conseguir outro.', 'Treinado em Diplomacia, NEX 30%'),
  ('Pensamento Tático', 'Treina (ou +2) Tática; passar em Tática pra analisar terreno dá ação de movimento extra a você e aliados em alcance médio na 1ª rodada do próximo combate ali (até o fim do dia).', 'Int 2'),
  ('Personalidade Esotérica', '+3 PE; treina (ou +2) Ocultismo.', 'Int 2'),
  ('Persuasivo', 'Treina (ou +2) Diplomacia; penalidade por pedidos custosos/perigosos cai em -5.', 'Pre 2'),
  ('Pesquisador Científico', 'Treina (ou +2) Ciências; usa Ciências no lugar de Ocultismo/Sobrevivência pra identificar criaturas/animais.', 'Int 2'),
  ('Proativo', 'Treina (ou +2) Iniciativa; tirar 19-20 num dado de Iniciativa dá ação padrão extra no primeiro turno.', 'Agi 2'),
  ('Provisões de Emergência', 'Tem um esconderijo de suprimentos; 1x/missão, ação de interlúdio recupera equipamento novo equivalente à patente, como nova fase de preparação.', null),
  ('Racionalidade Inflexível', 'Usa Intelecto no lugar de Presença como atributo-chave de Vontade e pra cálculo de PE.', 'Int 3'),
  ('Rato de Computador', 'Treina (ou +2) Tecnologia; hackear/localizar arquivo/operar dispositivo como ação completa; 1x/cena de investigação com acesso a computador, testa Tecnologia pra procurar pistas sem gastar rodada.', 'Int 2'),
  ('Resposta Rápida', 'Treina (ou +2) Reflexos; falhar em Percepção pra evitar desprevenido, gasta 2 PE pra rerrolar usando Reflexos.', 'Agi 2'),
  ('Talentoso', 'Treina (ou +2) Artes; teste de Artes pra impressionar, bônus sobe +1 a cada 5 pontos que o resultado passar a DT.', 'Pre 2'),
  ('Teimosia Obstinada', 'Treina (ou +2) Vontade; teste de Vontade contra condição mental/mudança de atitude, gasta 2 PE pra +5.', 'Pre 2'),
  ('Tenacidade', 'Morrendo mas consciente (1+ PV), testa Fortitude (DT 20+10 por teste anterior na cena) como ação livre pra encerrar a condição.', 'Vig 2'),
  ('Sentidos Aguçados', 'Treina (ou +2) Percepção; não fica desprevenido contra quem não vê; errar por camuflagem permite rerrolar a chance de falha.', 'Pre 2'),
  ('Sobrevivencialista', 'Treina (ou +2) Sobrevivência; +2 em resistência a clima; terreno difícil natural não reduz deslocamento nem impede investidas.', 'Int 2'),
  ('Sorrateiro', 'Treina (ou +2) Furtividade; sem penalidade por mover no deslocamento normal furtivo, nem por seguir alguém em ambiente sem esconderijo/movimento.', 'Agi 2'),
  ('Vitalidade Reforçada', '+1 PV a cada 5% de NEX (ou por nível); +2 Fortitude.', 'Vig 2'),
  ('Vontade Inabalável', '+1 PE a cada 10% de NEX (ou a cada 2 níveis); +2 Vontade.', 'Pre 2')
) as v(name, description, prereq);

insert into origins (source_id, name, skill_1_id, skill_2_id, skills_text, power_name, power_description, description, sort_order)
select
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  v.name,
  (select id from skills where name = v.skill_1),
  (select id from skills where name = v.skill_2),
  v.skills_text, v.power_name, v.power_description, v.description, v.ord
from (values
  ('Amigo dos Animais', 'Adestramento', 'Percepção', null,
   'Companheiro Animal', 'Entende intenções/sentimentos de animais, pode usar Adestramento pra mudar a atitude deles. Tem um animal de estimação que conta como aliado, dando +2 numa perícia à escolha (aprovada pelo mestre); em NEX 35% também dá o bônus de um tipo de aliado à escolha; em NEX 70% dá a habilidade desse tipo de aliado. Se o animal morrer, perde 10 Sanidade permanente + fica perturbado até o fim da cena.',
   'Você desenvolveu uma conexão muito forte com animais, levando sua vida ao lado de um melhor amigo de quatro patas, aprendendo com a natureza perceptiva deles.', 1),

  ('Astronauta', 'Ciências', 'Fortitude', null,
   'Acostumado ao Extremo', 'Ao sofrer dano de fogo, frio ou mental, gasta 1 PE pra reduzir 5 desse dano (custo sobe +1 PE a cada uso na mesma cena).',
   'Explorador espacial acostumado à pressão de ser responsável por vidas e experimentos caros; foi no espaço que descobriu que não estamos sozinhos.', 2),

  ('Chef do Outro Lado', 'Ocultismo', null, 'Ocultismo e Profissão (cozinheiro)',
   'Fome do Outro Lado', 'No início de cada missão, pode obter partes de criaturas derrotadas como ingredientes (item categoria I, 0,5 espaço; cada criatura Pequena+ dá 1 ingrediente). Ação de interlúdio + 1 ingrediente + Profissão (cozinheiro) DT 15 +1d20 prepara um prato: se passar, dá RD 10 contra o tipo de dano do elemento da criatura até o fim da próxima cena; se falhar, dá vulnerabilidade a esse dano. Cada refeição consumida custa 1 Sanidade permanente (e +3% NEX se usando a regra opcional de Experiência).',
   'Descobriu o tabu de cozinhar e ingerir entidades do Outro Lado; acredita ser uma arte gastronômica esotérica.', 3),

  ('Colegial', 'Atualidades', 'Tecnologia', null,
   'Poder da Amizade', 'Escolhe um "melhor amigo" entre outro personagem — enquanto em alcance médio e puderem trocar olhares, +2 em todos os testes de perícia. Se o amigo morrer, -1 PE por cada 5% de NEX até o fim da missão; pode escolher novo amigo na próxima missão.',
   'Aluno que se uniu à Ordem com mentalidade juvenil; descobriu que sua força está nos amigos.', 4),

  ('Cosplayer', 'Artes', 'Vontade', null,
   'Não é fantasia, é cosplay!', 'Testes de disfarce usam Artes em vez de Enganação; ao testar perícia usando um cosplay relacionado, +2.',
   'Dedica a vida à arte do cosplay; colocou essa resiliência a serviço da Ordem.', 5),

  ('Diplomata', 'Atualidades', 'Diplomacia', null,
   'Conexões', '+2 Diplomacia. Se puder contatar um NPC capaz de ajudar, gasta 10 min + 2 PE pra substituir um teste de perícia relacionada ao conhecimento desse NPC por um teste de Diplomacia (até o fim da cena).',
   'Atuava em área de habilidades sociais/políticas; hoje usa seus contatos contra o Outro Lado.', 6),

  ('Explorador', 'Fortitude', 'Sobrevivência', null,
   'Manual do Sobrevivente', 'Teste de resistência contra armadilhas, clima, doenças, fome, sede, fumaça, sono, sufocamento ou veneno (mesmo paranormal), gasta 2 PE pra +5. Em interlúdio, condições de sono precário contam como normais.',
   'Interessado em história/geografia, corpo endurecido por trilhas e expedições.', 7),

  ('Experimento', 'Atletismo', 'Fortitude', null,
   'Mutação', 'Resistência a dano 2, +2 numa perícia baseada em Força/Agilidade/Vigor à escolha; mas -1d20 em Diplomacia.',
   'Cobaia (voluntária ou não) de experimentos físicos/científicos/paranormais, com alterações permanentes no corpo.', 8),

  ('Fanático por Criaturas', 'Investigação', 'Ocultismo', null,
   'Conhecimento Oculto', 'Testa Ocultismo pra identificar criatura a partir de imagem/rastros/indícios; passando, descobre características (não identidade/tipo exato) e ganha +2 em todos os testes contra ela até o fim da missão.',
   'Obcecado pelo sobrenatural, "caçador de monstros" antes mesmo de ser recrutado.', 9),

  ('Fotógrafo', 'Artes', 'Percepção', null,
   'Através da Lente', 'Teste de Investigação/Percepção (inclusive pra pistas) através de câmera/fotos, gasta 2 PE pra +5 (mover-se olhando pela lente reduz deslocamento à metade).',
   'Artista visual movido pela paixão de capturar imagens; achou o paranormal através da lente.', 10),

  ('Inventor Paranormal', null, 'Vontade', 'Profissão (engenheiro) e Vontade',
   'Invenção Paranormal', 'Escolhe um ritual de 1º círculo; tem um invento (item categoria 0, 1 espaço) que executa o efeito do ritual. Ativar: ação padrão (ou a do ritual, o que for maior) + Profissão (engenheiro) DT 15+5 por ativação na mesma missão; passando, conjura o ritual básico sem PE; falhando, enguiça. Ação de interlúdio conserta e reseta a DT. Pode trocar o ritual no início de cada missão.',
   '"Cientista louco" que usa o desconhecido em suas invenções.', 11),

  ('Jovem Místico', 'Ocultismo', 'Religião', null,
   'A Culpa é das Estrelas', 'Escolhe um número da sorte (1-6). No início da cena, gasta 1 PE + rola 1d6; acertando o número, +2 em testes de perícia até o fim da cena; errando, adiciona mais um número da sorte (volta a 1 número quando acerta).',
   'Conexão profunda com espiritualidade/universo, mais suscetível ao paranormal.', 12),

  ('Legista do Turno da Noite', 'Ciências', 'Medicina', null,
   'Luto Habitual', 'Metade do dano mental por cenas relacionadas à rotina de legista. Teste de Medicina pra primeiros socorros/necropsia, gasta 2 PE pra +5.',
   'Trabalha no necrotério à noite; descobriu que a morte nem sempre é o fim.', 13),

  ('Mateiro', 'Percepção', 'Sobrevivência', null,
   'Mapa Celeste', 'Vendo o céu, sempre sabe pontos cardeais e não se perde em lugar já visitado. Teste de Sobrevivência, gasta 2 PE pra rolar de novo e ficar com o melhor resultado. Em interlúdio, sono precário conta como normal.',
   'Conhece áreas rurais/selvagens; a natureza foi sua porta pro Outro Lado.', 14),

  ('Mergulhador', 'Atletismo', 'Fortitude', null,
   'Fôlego de Nadador', '+5 PV; prende respiração por rodadas = 2x Vigor. Teste de Atletismo pra natação bem-sucedido avança deslocamento normal (em vez de metade).',
   'Aventureiro subaquático; no dia em que olhou pro abismo, ele olhou de volta.', 15),

  ('Motorista', 'Pilotagem', 'Reflexos', null,
   'Mãos no Volante', 'Sem penalidade em testes de ataque em veículo em movimento; pilotando, teste de Pilotagem ou resistência, gasta 2 PE pra +5.',
   'Condutor profissional (caminhoneiro, motorista de app, piloto) cujas viagens cruzaram o Outro Lado.', 16),

  ('Nerd Entusiasta', 'Ciências', 'Tecnologia', null,
   'O Inteligentão', 'Bônus da ação de interlúdio "ler" sobe de +1d6 pra +2d6.',
   'Obcecado por videogames/RPG/ficção científica; sua capacidade analítica chamou atenção paranormal.', 17),

  ('Profetizado', 'Vontade', null, 'Vontade e mais uma à escolha',
   'Luta ou Fuga', '+2 Vontade. Quando surge referência à sua premonição, +2 PE temporários até o fim da cena (além do bônus de Vontade).',
   'Sabe como vai morrer, por premonições/pesadelos/visões — o mestre define a "cena de morte" (detalhada ou só sinais).', 18),

  ('Psicólogo', 'Intuição', null, 'Intuição e Profissão (psicólogo)',
   'Terapia', 'Usa Profissão (psicólogo) como Diplomacia. 1x/rodada, você ou aliado em alcance curto falha em resistência contra dano mental, gasta 2 PE pra testar Profissão (psicólogo) no lugar do teste de resistência falho.',
   'Especializado em saúde mental; descobriu origens sombrias em algumas aflições.', 19),

  ('Repórter Investigativo', 'Atualidades', 'Investigação', null,
   'Encontrar a Verdade', 'Usa Investigação no lugar de Diplomacia pra persuadir/mudar atitude; teste de Investigação, gasta 2 PE pra +5.',
   'Busca a verdade por trás dos acontecimentos; o ofício o levou ao indescritível.', 20)
) as v(name, skill_1, skill_2, skills_text, power_name, power_description, description, ord);
