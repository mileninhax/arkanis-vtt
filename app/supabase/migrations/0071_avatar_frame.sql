-- Moldura da foto do personagem, escolhida no "Mudar moldura" da ficha.
-- null = sem moldura.

alter table characters add column avatar_frame text;
