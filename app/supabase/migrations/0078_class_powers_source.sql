-- O modal de Adicionar Habilidade (aba Habilidades) filtra por fonte (Livro Base/
-- Sobrevivendo ao Horror/Arquivos Secretos), mas class_powers nunca guardou de qual
-- livro cada poder de Combatente/Especialista/Ocultista veio (só paranormal_powers/
-- general_powers/origins tinham source_id). Preenche isso retroativamente, cruzando
-- com o que cada migration de fato inseriu (0002=base, 0024=SH, 0029=AS01/AS02,
-- 0031=AS04, 0032=AS05, 0033=AS06).

alter table class_powers add column if not exists source_id uuid references sources(id);

-- Livro Base (0002) — Combatente
update class_powers set source_id = (select id from sources where slug = 'ordem_paranormal')
where class_id = (select id from classes where slug = 'combatente')
and name in (
  'Armamento Pesado', 'Artista Marcial', 'Ataque de Oportunidade', 'Combater com Duas Armas', 'Combate Defensivo',
  'Golpe Demolidor', 'Golpe Pesado', 'Incansável', 'Presteza Atlética', 'Proteção Pesada', 'Reflexos Defensivos',
  'Saque Rápido', 'Segurar o Gatilho', 'Sentido Tático', 'Tanque de Guerra', 'Tiro Certeiro', 'Tiro de Cobertura',
  'Transcender', 'Treinamento em Perícia'
);

-- Livro Base (0002) — Especialista
update class_powers set source_id = (select id from sources where slug = 'ordem_paranormal')
where class_id = (select id from classes where slug = 'especialista')
and name in (
  'Artista Marcial', 'Balística Avançada', 'Conhecimento Aplicado', 'Hacker', 'Mãos Rápidas', 'Mochila de Utilidades',
  'Movimento Tático', 'Na Trilha Certa', 'Nerd', 'Ninja Urbano', 'Pensamento Ágil', 'Perito em Explosivos',
  'Primeira Impressão', 'Transcender', 'Treinamento em Perícia'
);

-- Livro Base (0002) — Ocultista
update class_powers set source_id = (select id from sources where slug = 'ordem_paranormal')
where class_id = (select id from classes where slug = 'ocultista')
and name in (
  'Camuflar Ocultismo', 'Criar Selo', 'Envolto em Mistério', 'Especialista em Elemento', 'Ferramentas Paranormais',
  'Fluxo de Poder', 'Guiado pelo Paranormal', 'Identificação Paranormal', 'Improvisar Componentes',
  'Intuição Paranormal', 'Mestre em Elemento', 'Ritual Potente', 'Ritual Predileto', 'Tatuagem Ritualística',
  'Transcender', 'Treinamento em Perícia'
);

-- Sobrevivendo ao Horror (0024) — Combatente
update class_powers set source_id = (select id from sources where slug = 'sobrevivendo_ao_horror')
where class_id = (select id from classes where slug = 'combatente')
and name in (
  'Apego Angustiado', 'Caminho para Forca', 'Ciente das Cicatrizes', 'Correria Desesperada', 'Engolir o Choro',
  'Instinto de Fuga', 'Mochileiro', 'Paranoia Defensiva', 'Sacrificar os Joelhos', 'Sem Tempo, Irmão', 'Valentão'
);

-- Sobrevivendo ao Horror (0024) — Especialista
update class_powers set source_id = (select id from sources where slug = 'sobrevivendo_ao_horror')
where class_id = (select id from classes where slug = 'especialista')
and name in (
  'Acolher o Terror', 'Contatos Oportunos', 'Disfarce Sutil', 'Esconderijo Desesperado', 'Especialista Diletante',
  'Flashback', 'Leitura Fria', 'Mãos Firmes', 'Plano de Fuga', 'Remoer Memórias', 'Resistir à Pressão'
);

-- Sobrevivendo ao Horror (0024) — Ocultista
update class_powers set source_id = (select id from sources where slug = 'sobrevivendo_ao_horror')
where class_id = (select id from classes where slug = 'ocultista')
and name in (
  'Deixe os Sussurros Guiarem', 'Domínio Esotérico', 'Estalos Macabros', 'Minha Dor me Impulsiona',
  'Nos Olhos do Monstro', 'Olhar Sinistro', 'Sentido Premonitório', 'Sincronia Paranormal', 'Traçado Conjuratório'
);

-- Sobrevivendo ao Horror (0024) — classe inteira de Sobrevivente e Mundano (introduzidas nesse livro)
update class_powers set source_id = (select id from sources where slug = 'sobrevivendo_ao_horror')
where class_id in (select id from classes where slug in ('sobrevivente', 'mundano'));

-- Arquivos Secretos 01 (0029) — Ocultista
update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_01')
where class_id = (select id from classes where slug = 'ocultista')
and name in ('Acostumado à Maldição de <Elemento>', 'Reter Ritual de Combate', 'Ritual Intenso', 'Saúde Sobrenatural');

-- Arquivos Secretos 02 (0029) — Combatente/Especialista/Ocultista
update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_02')
where class_id = (select id from classes where slug = 'combatente') and name in ('Predador Perfeito', 'Golpes de Arena');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_02')
where class_id = (select id from classes where slug = 'especialista') and name in ('Assassinato Furtivo', 'Especialista em Matar');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_02')
where class_id = (select id from classes where slug = 'ocultista') and name = 'Liturgia de Fortalecimento Ritualístico';

-- Arquivos Secretos 04 (0031)
update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_04')
where class_id = (select id from classes where slug = 'combatente')
and name in ('Chuva de Balas', 'Combatente Esforçado', 'Treinamento Militarizado');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_04')
where class_id = (select id from classes where slug = 'especialista')
and name in ('Análise Conturbada', 'Profissão Perigo', 'Quase Novo');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_04')
where class_id = (select id from classes where slug = 'ocultista')
and name in ('Explorador da Névoa', 'Sinestesia Paranormal');

-- Arquivos Secretos 05 (0032)
update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_05')
where class_id = (select id from classes where slug = 'combatente')
and name in ('Aura de Confiança', 'Fôlego de Emergência', 'Parede de Carne');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_05')
where class_id = (select id from classes where slug = 'especialista')
and name in ('Adepto do Escuro', 'Saudosista Hi-Tech', 'Treinado nas Telas');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_05')
where class_id = (select id from classes where slug = 'ocultista')
and name in ('Catálogo de Criaturas Ambulante', 'Meditação Ocultista', 'Ruído de Comunicação');

-- Arquivos Secretos 06 (0033)
update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_06')
where class_id = (select id from classes where slug = 'combatente')
and name in ('Análise Combativa', 'Especialista em Proteção Leve');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_06')
where class_id = (select id from classes where slug = 'especialista')
and name in ('Doutor em Emergências', 'Farmacêutico de Campo', 'Médico da Salvação', 'Resgatar da Morte', 'Veterano da Equipe de Trauma');

update class_powers set source_id = (select id from sources where slug = 'arquivos_secretos_06')
where class_id = (select id from classes where slug = 'ocultista')
and name in ('Barreira do Oculto', 'Grão-Mestre em Elemento');

-- Habilidades base (NEX 5%, ganhas automaticamente) também são todas do Livro Base
update class_powers set source_id = (select id from sources where slug = 'ordem_paranormal')
where is_base_ability = true and source_id is null;
