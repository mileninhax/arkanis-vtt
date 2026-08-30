-- Suporte a ameaças mundanas (não-paranormais): agentes da lei, cultistas, animais.
-- Fichas mais simples — sem Presença Perturbadora nem elemento — mas reutilizam a
-- mesma tabela `creatures`. Precisamos apenas diferenciar categoria e tipo de criatura.

alter table creatures add column categoria text not null default 'paranormal'; -- 'paranormal' | 'mundana'
alter table creatures add column tipo_criatura text; -- 'Pessoa', 'Animal', 'Animal (Enxame)', etc.
