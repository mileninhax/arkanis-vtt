-- Corrige o enum de treino de perícia: são 4 graus (Destreinado 0 / Treinado +5 / Veterano +10 / Expert +15),
-- não 3. O que estava chamado "perito" vira "veterano", e "expert" é adicionado como 4º grau.

alter type skill_training rename value 'perito' to 'veterano';
alter type skill_training add value 'expert' after 'veterano';
