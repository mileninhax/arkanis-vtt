-- Arquivos Secretos 06 (tema Indústrias Panacea). Doenças/venenos novos e modificações/
-- maldições de medicamentos ficam de fora — exigiriam tabelas novas de baixo uso sem um
-- sistema de doença/veneno mais amplo já modelado (o Livro Base ainda não tem esse
-- catálogo geral).

insert into origins (source_id, name, skill_1_id, skill_2_id, power_name, power_description, description, sort_order)
values
((select id from sources where slug = 'arquivos_secretos_06'), 'Cientista Ex-Panacea', (select id from skills where name = 'Atualidades'), (select id from skills where name = 'Ciências'), 'Existe uma Explicação', 'Teste de Ocultismo, 2 PE pra usar Ciências em vez dela.', null, 1),
((select id from sources where slug = 'arquivos_secretos_06'), 'Cobaia Sobrevivente', (select id from skills where name = 'Fortitude'), (select id from skills where name = 'Vontade'), 'Forças para Enfrentar', 'Narra trauma como ex-cobaia; em cena relacionada fica abalado, mas 2 PE dá imunidade a medo (inclusive esse abalado) até fim da cena.', null, 2),
((select id from sources where slug = 'arquivos_secretos_06'), 'Segurança Ex-Panacea', (select id from skills where name = 'Luta'), (select id from skills where name = 'Pontaria'), 'Técnicas de Contenção', 'Manobra de combate, 2 PE pra +5 no teste.', null, 3);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'combatente'), v.name, v.description, v.prereq, v.ord from (values
  ('Análise Combativa', '+5 em testes de Ciente das Cicatrizes; +2 vs. ameaça já investigada com sucesso via essa habilidade.', 'Ciente das Cicatrizes', 39),
  ('Especialista em Proteção Leve', 'Usando proteção leve, +2 Defesa e Reflexos.', null, 40)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'especialista'), v.name, v.description, v.prereq, v.ord from (values
  ('Doutor em Emergências', 'Cicatrizante/medicamento que cura PV/PV temp +1d8 adicional; +5 Medicina pra tratamento, sucesso dá +10 (em vez de +5) no próximo Fortitude do paciente.', 'Especialista em Emergências', 35),
  ('Farmacêutico de Campo', 'Cena de interlúdio com kit medicina, 2 PE + 2 PE/categoria cria cicatrizante/medicamento; kit usado 3x assim é consumido.', 'Treinado em Medicina e Profissão (químico)', 36),
  ('Médico da Salvação', 'Paramédico usa d12 em vez de d10; 3 PE 1x/rodada pra usar como ação de movimento.', 'Paramédico', 37),
  ('Resgatar da Morte', 'Primeiros socorros, 2 PE pra sucesso automático, 1x/cena por pessoa.', 'Veterano em Medicina', 38),
  ('Veterano da Equipe de Trauma', 'Equipe de Trauma remove até 3 condições (exceto morrendo) em vez de 1.', 'Paramédico e Equipe de Trauma', 39)
) as v(name, description, prereq, ord);

insert into class_powers (class_id, name, description, prerequisites, sort_order)
select (select id from classes where slug = 'ocultista'), v.name, v.description, v.prereq, v.ord from (values
  ('Barreira do Oculto', 'Ritual do elemento escolhido, PE→Defesa (1 PE=+2 Defesa até seu limite), dura 1 rodada.', 'Especialista em Elemento nesse elemento, NEX 30%', 37),
  ('Grão-Mestre em Elemento', 'Ritual do elemento, 1 PE pra efeito extra em 1 alvo até fim da cena (ignora imunidades): Sangue(aliado+2d4 dano/inimigo debilitado 1 rodada), Morte(aliado+3d8+3 PV temp/inimigo enjoado 1 rodada), Conhecimento(aliado+2 perícia/inimigo esmorecido 1 rodada), Energia(aliado+6m deslocamento/inimigo desprevenido 1 rodada). Substitui "Dominador de Elemento", removido oficialmente na errata v1.1.', 'Mestre em Elemento nesse elemento, NEX 60%', 38)
) as v(name, description, prereq, ord);

insert into general_powers (source_id, name, description, prerequisites)
select (select id from sources where slug = 'arquivos_secretos_06'), v.name, v.description, v.prereq from (values
  ('Adaptação Climática', '+2 Fortitude; imune a dano por clima quente/frio/extremo.', 'Vig 2'),
  ('Especialista em Armas Improvisadas', 'Sem penalidade de ataque com arma improvisada; +1 dado de dano extra.', 'For 2 ou Agi 2, treinado em Luta'),
  ('Muito Sorrateiro', 'Cena de furtividade, -1d4 na visibilidade inicial; +3 Furtividade.', 'Sorrateiro')
) as v(name, description, prereq);

insert into paranormal_powers (source_id, elemento, name, description, affinity_description, prerequisites)
values
((select id from sources where slug = 'arquivos_secretos_06'), 'morte', 'Escudo Espiral Temporal', 'Reação 2 PE, arma/munição que vai te atingir — munição: RD20+projétil vira cinzas; arma corpo a corpo: RD10+arma sofre 10 dano químico (não funciona vs Energia).', 'Múltiplas vezes/rodada, químico vira 20.', 'Morte 2'),
((select id from sources where slug = 'arquivos_secretos_06'), 'morte', 'Grilhões de Lodo', '2 PE, área 9m raio grilhões até fim da cena; quem entra (exceto você/criaturas Morte) sofre 3d6 Morte + lento (Fortitude DT maior atributo reduz metade/evita, 1 rodada).', '6d6, condição vira enredado.', null),
((select id from sources where slug = 'arquivos_secretos_06'), 'energia', 'Salto de Dados', 'Ação completa 2 PE marca símbolo (dura 1 dia/até consumir); reação 3 PE consome e reverte PV/PE/condições/tudo pro momento da marca, mas perde memória do que houve depois (alquebrado+frustrado até fim cena, pasmo 1d4+1 rodadas).', 'Símbolo dura 1 ano.', 'Energia 2');

insert into rituals (source_id, name, elemento, circle, execution, range, target, duration, resistance, effect, discente_cost, discente_effect, discente_requires_circle, verdadeiro_cost, verdadeiro_effect, verdadeiro_requires_circle, verdadeiro_requires_affinity)
values
((select id from sources where slug = 'arquivos_secretos_06'), 'Hesitação Forçada', 'conhecimento', 1, 'padrão', 'curto', '1 pessoa', 'sustentada', 'Vontade parcial',
 'Alvo testa Vontade no início de cada turno; falhar = rerrola o MAIOR dado de qualquer teste no turno; 2 sucessos seguidos encerra. (Influência mínima de Sangue removida na errata v1.1.)',
 2, 'Alvo "1 ser"; quem não resistiu não pode agir hostil contra o conjurador. Requer 2º círculo.', 2,
 5, 'Resistência vira "Vontade anula"; efeito inverte (rerrola o MENOR dado, mantém); aliado adjacente do alvo sofrendo ataque força o alvo a se colocar no lugar dele (reação). Requer 3º círculo e afinidade.', 3, true);

insert into equipment_items (source_id, type, name, category, spaces, description, stats)
values
((select id from sources where slug = 'arquivos_secretos_06'), 'geral', 'Aplicador de Adrenalina', 'I', 1, 'Conta como medicamento. Ação padrão, 2d8+2 PV temp + 3m deslocamento + 2 Força/Agi/Vig até fim da cena; depois fica fatigado 1 cena.', '{}'),
((select id from sources where slug = 'arquivos_secretos_06'), 'arma', 'Lança-Nitrogênio', 'III', 2, 'Arma pesada de fogo, duas mãos, alcance curto; 6d6 frio, crítico 20/x2; linha 1,5m largura (1 teste vs todos na área); atingidos enredados até quebrar gelo (ação padrão) — ou Fortitude DT Agi vira lento; usa combustível como munição.', '{"dano":"6d6","critico":"20/x2","tipo_dano":"frio","proficiencia":"pesadas","empunhadura":"duas_maos","natureza":"fogo","alcance":"curto","tipo_municao":"Combustível"}');

insert into cursed_items_special (source_id, name, description, category, spaces)
values
((select id from sources where slug = 'arquivos_secretos_06'), 'Anel Invertido', 'Morte. Sofrendo dano de nidere, reação + 2 PE pra RD 4d10.', 'II', 0.5);

insert into extra_rules (source_id, category, title, content, sort_order)
values
(
  (select id from sources where slug = 'arquivos_secretos_06'), 'combate_alternativo', 'Evolução Modular',
  'Regra opcional, não-oficial. Substitui a habilidade "Poder" (de Combatente/Especialista/Ocultista) por progressão a cada NEX (não só nos níveis padrão): NEX10%+par = Poder de Utilidade da classe; NEX15%+ímpar = Poder de Combate da classe. Versatilidade muda: em NEX50%, ganha o 1º poder de uma trilha de outra (não a sua) da mesma classe.

Poderes de Combate: melhoram enfrentar adversidade (proficiências ofensivas/defensivas, teste ataque/resistência/Defesa/dano/DT, ignorar penalidades de combate, ataques extras).
Poderes de Utilidade: tudo que não é geral/paranormal/combate (bônus em pistas, furtividade, testes sociais etc.).
Sempre pode escolher Poder Geral no lugar de qualquer um dos dois grupos.

Exemplo: personagem NEX99% (nível 20) que teria só 7 poderes na regra padrão, tem aqui 9 de combate + 10 de utilidade.',
  11
);
