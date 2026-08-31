-- Perigos (regras ambientais) — Livro Base, Cap. 7, p.290-293. Riscos que não são
-- seres, úteis pra Cenas/Mapas e Combate na mesa (ácido, armadilhas, clima, doenças,
-- eletricidade, fogo, fome/sede, fumaça, lava, queda, sono, sufocamento, venenos).

create table hazards (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references sources(id),
  name text not null,
  description text not null,
  sort_order int not null default 0
);

alter table hazards enable row level security;
create policy "hazards: leitura pública" on hazards for select using (true);

insert into hazards (source_id, name, description, sort_order)
values
(
  (select id from sources where slug = 'ordem_paranormal'), 'Ácido',
  '1d6 dano químico/rodada de exposição; imersão total 10d6/rodada + 1 rodada extra após sair.', 1
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Armadilhas',
  'Cada uma tem Efeito, Resistência e DT de Investigação/Crime pra achar/desarmar. Exemplos: Alarme (DT 20); Arame Farpado (terreno difícil + 1d6+2 corte, DT 20); Armadilha de Caça (4d6 corte + lenta + imóvel até soltar, Reflexos DT 20 reduz/evita, soltar-se Força DT 15, falha = 1d6 corte, DT 20 achar); Fosso Camuflado (queda 3m = 2d6, Reflexos DT 20 evita, DT 20 achar); Descarga Elétrica (6d6 elétrico em 3m, Reflexos DT 20, DT 25 achar).', 2
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Clima',
  'Calor 50°C+/frio -10°C+ exige Fortitude por dia (DT 5+5 por teste anterior) ou 1d6 dano de fogo/frio; extremos (60°C+/-20°C) por minuto. Neblina espessa = camuflagem leve a 1,5m, total além disso. Chuva: -5 Percepção + efeitos de vento forte. Granizo: como chuva + 1 dano de impacto/rodada. Neve: como chuva + terreno difícil. Tempestade: -2d20 Percepção + vendaval; 1d10 por rodada, resultado 1 = raio aleatório (8d12 elétrico). Vento Forte: -1d20 ataque à distância, 50%/rodada apaga chamas/névoas. Vendaval: -2d20 ataque à distância, sempre apaga. Furacão: ataque à distância impossível; Médio ou menor faz Fortitude DT 15/rodada ou cai e é arrastado (1d6 dano/1,5m). Tornado: idem mas DT 25, afeta até Grande, 1d12x1,5m arrastado.', 3
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Doenças',
  'Contato = teste de resistência (geralmente Fortitude); falhar = infectado estágio I; ao fim de cada cena repete o teste (falhar avança estágio, 2 sucessos seguidos cura). Febre Hemorrágica (mordida de ratos, Fortitude DT 15: I fraco, II debilitado, III+ sangra ao sofrer corte/balístico/perfuração). Mente Embaralhada (implantação mental, Vontade DT 20: I -1 Intelecto, II esquece curto prazo/Intelecto DT15 ou perde movimento, III+ mente parcialmente controlada). Putrefação Acelerada (inalação, Fortitude DT 20: I -1 Vigor, II -2 Vigor total + metade deslocamento, III Vigor 0 + desloc. 1,5m + lesão permanente). Sangue Quente (contato, Fortitude DT 15: I +1 For/Agi, II confuso, III confuso + vulnerabilidade a todo dano). Vírus do Infecticídio (contato, Fortitude DT 30, só cura em temperatura <0°C: I -2d10 PV máx, II mais -2d10, III+ mais -2d10 + transmite por contato; 0 PV máx = morte instantânea).', 4
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Eletricidade',
  'Dano/rodada por tensão — Mínima 1d6 (bateria), Baixa 2d8 (fusível), Média 4d10 (cerca elétrica), Alta 8d12 (raio).', 5
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Fogo',
  'Exposto a chamas, Reflexos DT 15 ou pega fogo (1d6/turno; apaga com ação padrão ou água).', 6
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Fome e Sede',
  '1 dia sem problema; depois Fortitude/dia (DT 15+1 por teste anterior) — falha 1 fraco, falha 2 debilitado, falha 3 inconsciente, falha 4 morte. Só cura comendo/bebendo.', 7
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Fumaça',
  'Densa exige Fortitude no início do turno (DT 10+1 por anterior) ou perde o turno tossindo; 2 falhas seguidas = 1d6 dano. Fornece camuflagem leve.', 8
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Lava',
  '2d6 dano de fogo/rodada de exposição; imersão total 20d6/rodada + 1 rodada extra.', 9
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Queda',
  '1d6 dano de impacto por 1,5m, máximo 40d6 (60m); água reduz 4d6. Objeto pesado caindo: 1d6/1,5m (dobra se muito pesado).', 10
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Sono',
  '1 noite sem dormir ok; depois Fortitude/dia (DT 15+1 por anterior) — falha 1 fatigado, falha 2 exausto, falha 3 inconsciente até dormir 8h.', 11
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Sufocamento',
  'Prende respiração por rodadas = Vigor; depois Fortitude/rodada (DT 5+5 por anterior) ou inconsciente + 1d6 PV/rodada até respirar ou morrer.', 12
),
(
  (select id from sources where slug = 'ordem_paranormal'), 'Venenos',
  'Exposição exige Fortitude (DT do veneno); métodos de inoculação — Contato, Ferimento (1+ dano), Inalação (frasco quebra em cubo de 3m), Ingestão. Arsênico (Ingestão, DT15, 1d12/rodada por 1d4); Beladona (Ferimento, DT20, fraco); Clorofórmio (Inalação, DT25, inconsciente/enjoado 1 rodada); Curare (Ferimento, DT20, imóvel/lento 1d6 rodadas); Estricnina (Ferimento, DT25, 2d12/rodada por 2d4, metade se passar); Inseticida (Inalação, DT15, enjoado); Lixo Químico (Contato, DT20, debilitado/fraco); Peçonha Fraca (Ferimento, DT15, 1d12/metade); Peçonha Mortal (Ferimento, DT25, 0 PV/10d6); Peçonha Potente (Ferimento, DT20, 1d12/rodada por 1d4/metade); Sonífero (Ingestão, DT20, inconsciente/enjoado 1 rodada).', 13
);
