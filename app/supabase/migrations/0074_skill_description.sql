-- Descrição da perícia (texto do livro), pro modal que abre ao clicar no nome
-- da perícia na ficha. Preenchido depois via seed com o conteúdo real.

alter table skills add column description text;
