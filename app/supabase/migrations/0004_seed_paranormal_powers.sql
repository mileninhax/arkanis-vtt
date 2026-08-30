-- Seed: poderes paranormais (Livro Base, 11.6). Fonte: docs/VTT_Conteudo_Ordem_Paranormal.md

insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
select (select id from sources where slug = 'ordem_paranormal'), v.elemento::elemento, v.name, v.description, v.affinity, v.prereq
from (values
  (null, 'Aprender Ritual', 'Aprende um ritual de 1º círculo à escolha (ou substitui um já conhecido); a partir de NEX 45%, aprende ritual de até 2º círculo, e a partir de 75%, até 3º círculo. Pode escolher várias vezes (sujeito ao limite de rituais conhecidos). Conta como poder do elemento do ritual escolhido.', null, null),
  (null, 'Resistir a Elemento', 'Escolhe Conhecimento/Energia/Morte/Sangue; resistência 10 contra esse elemento.', 'Resistência sobe para 20.', null),

  ('conhecimento', 'Expansão de Conhecimento', 'Aprende um poder de classe de outra classe (cumprindo pré-requisitos).', 'Aprende um segundo poder de classe de fora da sua.', 'Conhecimento 1'),
  ('conhecimento', 'Percepção Paranormal', 'Em cena de investigação, ao testar procurar pistas, pode rerrolar um d20 com resultado menor que 10 (aceita o segundo resultado).', 'Pode rerrolar até dois dados.', null),
  ('conhecimento', 'Precognição', '+2 em Defesa e testes de resistência.', 'Imune à condição desprevenido.', 'Conhecimento 1'),
  ('conhecimento', 'Sensitivo', '+5 em Diplomacia, Intimidação e Intuição.', 'Em teste oposto com essas perícias, o oponente sofre -◯.', null),
  ('conhecimento', 'Visão do Oculto', '+5 em Percepção e enxerga no escuro.', 'Ignora camuflagem.', null),

  ('energia', 'Afortunado', '1x/rolagem, rerrola um resultado 1 em dado que não seja d20.', 'Também pode rerrolar um resultado 1 em d20, 1x/teste.', null),
  ('energia', 'Campo Protetor', 'Ao esquivar, gasta 1 PE pra +5 em Defesa.', 'Também +5 em Reflexos; se passar num teste de Reflexos que reduziria dano à metade, não sofre dano algum.', 'Energia 1'),
  ('energia', 'Causalidade Fortuita', 'Em cena de investigação, DT pra procurar pistas cai -5 até encontrar uma pista.', 'A redução de -5 é permanente.', null),
  ('energia', 'Golpe de Sorte', '+1 na margem de ameaça dos ataques.', '+1 no multiplicador de crítico.', 'Energia 1'),
  ('energia', 'Manipular Entropia', 'Quando ser em alcance curto testa perícia, gasta 2 PE pra fazê-lo rerrolar um dado.', 'O alvo rerrola todos os dados escolhidos.', 'Energia 1'),

  ('morte', 'Encarar a Morte', 'Em cenas de ação, limite de PE por turno +1 (não afeta DT).', '+2 (total +3).', null),
  ('morte', 'Escapar da Morte', '1x/cena, dano que reduziria a 0 PV deixa em 1 PV (não funciona com dano massivo).', 'Evita o dano por completo; com dano massivo, fica em 1 PV.', 'Morte 1'),
  ('morte', 'Potencial Aprimorado', '+1 PE por NEX (escala conforme sobe de NEX).', '+2 PE por NEX.', null),
  ('morte', 'Potencial Reaproveitado', '1x/rodada, ao passar num teste de resistência, ganha 2 PE temporários cumulativos (somem no fim da cena).', '3 PE temporários.', null),
  ('morte', 'Surto Temporal', '1x/cena, gasta 3 PE pra ação padrão adicional.', '1x/turno em vez de 1x/cena.', 'Morte 2'),

  ('sangue', 'Anatomia Insana', '50% de chance (par em 1d4) de ignorar dano adicional de crítico ou ataque furtivo.', 'Imune a esses danos adicionais.', 'Sangue 2'),
  ('sangue', 'Arma de Sangue', 'Ação de movimento + 2 PE pra criar arma simples corpo a corpo de Sangue (1d6 de dano); 1x/turno, ao agredir, gasta 1 PE pra ataque adicional com ela; some no fim da cena.', 'A arma vira permanente e dano sobe pra 1d10.', null),
  ('sangue', 'Sangue de Ferro', '+2 PV por NEX (escala).', '+5 em Fortitude e imune a venenos/doenças.', null),
  ('sangue', 'Sangue Fervente', 'Machucado, +1 em Agilidade ou Força à escolha.', 'Bônus sobe pra +2.', 'Sangue 2'),
  ('sangue', 'Sangue Vivo', 'Na primeira vez que fica machucado numa cena, recebe cura acelerada 2 (nunca cura acima da metade do PV máximo).', 'Cura acelerada sobe para 5.', 'Sangue 1')
) as v(elemento, name, description, affinity, prereq);
