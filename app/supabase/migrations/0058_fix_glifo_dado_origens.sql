-- Corrige um glifo residual ("◯") deixado na transcrição do material original nas
-- descrições de origem — ele representa o ícone de dado de bônus/penalidade do
-- sistema (1d20 extra), então vira texto "1d20" em vez do círculo sem sentido.

update origins set power_description = replace(replace(power_description, '-◯', '-1d20'), '+◯', '+1d20');
update origins set description = replace(replace(description, '-◯', '-1d20'), '+◯', '+1d20');
update origins set skills_text = replace(replace(skills_text, '-◯', '-1d20'), '+◯', '+1d20');
