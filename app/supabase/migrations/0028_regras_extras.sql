-- Aba "Regras Extras" (5.10): conteúdo de referência que não altera cálculo nenhum da
-- ficha — só documenta como resolver situações de jogo específicas (Perseguição,
-- Furtividade, Medo em Jogo, Combate Narrativo, Conjuração Complexa etc.), pra consulta
-- rápida sem sair da ficha. Categorizado por tipo de mecânica (decisão de design 5.10).

create table extra_rules (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  category text not null, -- 'mecanicas_de_cena' | 'combate_alternativo' | 'equipamento_especial' | 'campanha'
  title text not null,
  content text not null,
  sort_order int not null default 0
);

alter table extra_rules enable row level security;
create policy "extra_rules: leitura pública" on extra_rules for select using (true);

insert into extra_rules (source_id, category, title, content, sort_order)
values
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'mecanicas_de_cena', 'Medo em Jogo',
  'Mecânica central de Sobrevivendo ao Horror — medo causa dano mental, reduzido/evitado com teste de Vontade (DT e dano definidos pelo mestre conforme a fonte). Dano mental de medo é sempre no mínimo 1, mesmo com resistência a dano mental.

Exemplos de fontes de medo (dano · DT Vontade):
- Visão inquietante — 1d4 mental · DT 15 anula
- Visão perturbadora — 1d6 mental · DT 20 reduz à metade
- Visão assustadora — 2d6 mental · DT 25 reduz à metade
- Visão sinistra — 4d4 mental · DT 30 reduz à metade
- Visão macabra — 4d8 mental · DT 35 reduz à metade
- Visão aterrorizante — 4d12 mental · DT 40 reduz à metade
- Ambiente horripilante — 1 dano mental/rodada (2 ou 5 pra lugares mais pavorosos)
- Dano mental de Presença Perturbadora de criaturas e de criaturas de Medo conta como efeito de medo pra todas essas regras.

Efeitos de Medo: Sanidade reduzida a 0 por dano mental (ou sofrer dano mental já em Sanidade 0) causa um efeito de medo — rola 2d10 na tabela; dura até recuperar 1+ Sanidade. Sofrer mais de um efeito na mesma cena soma +1 na rolagem por vez adicional; rolar um efeito que já tem avança pro próximo da tabela.

Tabela de Efeitos de Medo (2d10):
2 Encorajamento — recupera 1 SAN a cada 5% NEX; +1d20 num teste à escolha até o fim da cena.
3 Surto de adrenalina — +5 ataque/dano até o fim da cena; qualquer ação que não seja agredir exige Vontade DT 20 ou perde a ação.
4 Hesitação — atordoado 1 rodada.
5 Fraqueza — fica fraco.
6 Lapso — fica frustrado.
7 Ansiedade — falha automática no próximo teste (ou perde ação padrão fazendo algo "inútil" pra evitar).
8 Desorientação — fica desprevenido.
9 Desespero — falha automática em testes de Vontade.
10 Histeria — ri/chora 1d4 rodadas; -1d20 em todos os testes.
11 Abalo — fica abalado.
12 Alucinação — testa; se o maior 1d20 sair ímpar, falha automática.
13 Susto — fica apavorado.
14 Confusão — fica confuso.
15 Paralisia — paralisado 1d4 rodadas, depois abalado.
16 Pavor — gasta todas ações fugindo; ações de concentração têm 50% de falha; se não conseguir fugir, encolhido sem agir; se conseguir, volta a agir mas abalado.
17 Desmaio — cai inconsciente.
18 Trauma — paralisado (como 15); 1d6: 1-5 perde 1 ponto permanente de atributo, 6 nada.
19 Loucura — fica enlouquecendo.
20+ Choque sistêmico — 0 PV e morrendo.

Nota: essas regras substituem Insanidade & Loucura e Sanidade do Livro Base pra campanhas de sobrevivência/horror (conectam com "Jogando sem Sanidade").

Ações contra o medo:
- Acalmar: treinado em Diplomacia/Profissão (psicólogo)/Religião, ação padrão + teste na perícia, personagem adjacente com Sanidade 0 recupera 1 Sanidade; DT +5 por vez que a pessoa já foi acalmada na cena.
- Se Entregar ao Medo: personagem em Sanidade 0 pode escolher isso — rola um 2º efeito de medo com +5 (interpretado de forma exagerada); recupera 1d4 Sanidade por nível na rodada seguinte e sai de paralisia/inconsciência; só 1x/sessão.',
  1
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'mecanicas_de_cena', 'Perseguições',
  'Resolvida com teste estendido de Atletismo: 3 sucessos antes de 3 falhas. Caçador que vence alcança a presa (pode atacar); presa que vence escapa. DT conforme velocidade do oponente: pessoas comuns 15, pessoas velozes/animais ou criaturas comuns 20, animais/criaturas velozes 25+. Outras perícias podem substituir Atletismo se justificadas narrativamente (cada uma só 1x por perseguição; Atletismo sem esse limite). Perseguição motorizada: usa Pilotagem (ou Adestramento pra montaria) no lugar de Atletismo.

Ações em perseguição:
- Cortar Caminho: -2d20 no teste; passando, ganha 2 sucessos (em vez de 1).
- Esforço Extra: +1d20 no teste; perde 1d4 PV (2d4 na 2ª vez na mesma cena, 3d4 na 3ª...).
- Criar Obstáculo (só presa): -1d20 no teste + teste de Força DT 15; passando, reduz a DT do teste de Atletismo em -5 pra todos nessa rodada; só 1 personagem por rodada.
- Despistar (só presa, precisa já ter 1+ sucesso): substitui Atletismo por Furtividade; passando, ganha 2 sucessos; falhando, sofre 2 falhas.
- Sacrifício: falha automática no Atletismo da rodada, mas dá +1d20 no teste dos outros.
- Atrapalhar (só presa): -1d20 no próprio Atletismo + Luta oposto a Luta/Reflexos da vítima; vencendo, -2d20 no Atletismo dela.

Perseguições menores/maiores: mestre pode exigir 2 sucessos/2 falhas (curtas) ou 5-7 sucessos/3 falhas (longas).

Eventos de Perseguição (d20): 1-8 nenhum · 9-10 Obstáculo (entulho, Força DT 15) · 11-12 Obstáculo (piso escorregadio, Acrobacia DT 20) · 13-14 Obstáculo (entulho rolando, Reflexos DT 20) · 15 Obstáculo (multidão, Intimidação DT 20) · 16-17 Obstáculo (caminho bloqueado, Força DT 15) · 18 Atalho (vias labirínticas, Percepção DT 20) · 19 Atalho (porta trancada, Crime DT 25) · 20 Atalho (vegetação, Sobrevivência DT 20). Obstáculo: falhar dá -2d20 no Atletismo da rodada. Atalho: passar dá +2d20; falhar dá -2d20.',
  2
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'mecanicas_de_cena', 'Furtividade',
  'Cenas simples: teste oposto único (Furtividade vs. Percepção). Cenas complexas: regra de Visibilidade — número de 0 (escondido) a 3+ (completamente exposto). Todos começam em 0. Visibilidade do grupo (opcional): soma das visibilidades individuais; grupo com 5+ no fim da rodada expõe todos com visibilidade 1+.

Ações e efeito na visibilidade:
- Ação comum (falar normal, andar, investigar): sem alteração de visibilidade.
- Ação discreta (+0 visibilidade): anda na metade do deslocamento, sussurra; qualquer teste feito sofre -1d20.
- Ação chamativa (+2 visibilidade): correr, gritar, atacar, conjurar.
- Esconder-se: teste de Furtividade DT 15; passando, -1 visibilidade.
- Distrair: teste de Enganação DT 15; passando, -1 na sua visibilidade ou de aliado próximo; falhando, +1 na própria; só 1 personagem por rodada; DT +5 a cada uso na mesma cena.
- Chamar Atenção: +2 na própria visibilidade, -1 na de aliado próximo.

Eventos de Furtividade (d20, alvo sorteado aleatoriamente): 1-2 algoz chega perto (ficar imóvel evita ser visto mas causa 1d6 dano mental ou metade da Presença Perturbadora, o que for maior) · 3-5 todos +2 visibilidade · 6-8 um personagem +2 visibilidade · 9-15 todos +1 visibilidade · 16-17 um personagem +1 visibilidade · 18-19 nada · 20 um personagem -1 visibilidade.',
  3
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'equipamento_especial', 'Fabricação em Campo',
  'Treinado numa Profissão específica, usa ações de interlúdio pra fabricar: 1 ação de manutenção pra munições/explosivos/consumíveis, 2 ações de manutenção (não precisam ser consecutivas) pra armas/proteções/gerais (itens modificados/paranormais não fabricáveis em campo). Profissão conforme o item: Armeiro (armas/munições/proteções), Químico (explosivos/munições/consumíveis), Engenheiro (demais gerais). Precisa de kit de perícia da Profissão (sem ele, -5 no teste).

DT de Fabricação por Categoria: Categoria 0 → DT 15 · I → 20 · II → 25 · III → 30 · IV → 35.

Itens improvisados: DT -5, mas só dura 1 cena (depois quebra/para de funcionar).',
  4
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'combate_alternativo', 'Combate Narrativo',
  'Substitui grade/mapa tático por resolução narrativa: Sem Mapa de Batalha (posicionamento abstrato), Sem Rolagens de Dano (dano calculado previamente por média, sem rolar dados a cada acerto), Ações Simples/Complexas/Narrativas (categorizam ações por duração dramática), e Coreografia de Luta (guia de como narrar combates de forma cinematográfica usando essas ações).',
  5
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'combate_alternativo', 'Conjuração Complexa',
  'Ritual passa a ser conjurado em 3 rodadas (não instantâneo), com etapas narrativas (símbolo, sangue/componente, palavras de poder) — cada etapa bem-sucedida (teste de Ocultismo) dá um pequeno benefício extra (ex.: ação de movimento extra no próximo turno).

Variante — Conjurando Rituais Desconhecidos: teste de Ocultismo contra DT 20 + custo em PE do ritual; passar conjura normalmente, falhar não funciona mas ainda paga os custos.',
  6
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'mecanicas_de_cena', 'Os Limites da Compreensão Humana',
  'Regras alternativas pra como ocultistas aprendem rituais (em vez do padrão "aprende ao subir NEX"), incluindo uma opção de Aprendizado em Campo, onde o mestre controla quais rituais ficam disponíveis conforme a narrativa.',
  7
),
(
  (select id from sources where slug = 'sobrevivendo_ao_horror'),
  'campanha', 'Desastres Paranormais',
  'Regras pra eventos de larga escala — mestre usa pra cenários de catástrofe envolvendo o paranormal (não detalhado em profundidade nas fontes processadas até agora).',
  8
);
