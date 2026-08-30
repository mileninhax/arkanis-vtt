import { useEffect, useMemo, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../lib/AuthContext'
import { recordRoll } from '../../lib/rollHistory'
import { attrValue, computeDerivedStats, computePatentePd, rollAttributeTest, trainingBonus, type AttributeKey, type Training } from '../../lib/rules'
import type { CharacterRecord } from './index'
import RollResult, { type RollResultData } from './RollResult'
import HabilidadesTab from './HabilidadesTab'
import RituaisTab from './RituaisTab'
import InventarioTab from './InventarioTab'
import CombateTab from './CombateTab'
import ModifiersPanel, { type Modifier } from './ModifiersPanel'
import AttributeDiagram from './AttributeDiagram'
import StatBar from './StatBar'
import pvEmpty from '../../assets/pv-empty.svg'
import pvLow from '../../assets/pv-low.svg'
import pvHalf from '../../assets/pv-half.svg'
import pvFull from '../../assets/pv-full.svg'

function pvIconFor(pct: number): string {
  if (pct <= 0) return pvEmpty
  if (pct <= 33) return pvLow
  if (pct <= 66) return pvHalf
  return pvFull
}

type ClassRow = {
  pv_initial: number | null; pv_initial_attr: string | null; pv_per_nex: number | null; pv_per_nex_attr: string | null
  pe_initial: number | null; pe_initial_attr: string | null; pe_per_nex: number | null; pe_per_nex_attr: string | null
  sanity_initial: number | null; sanity_per_nex: number | null
  pd_initial: number | null; pd_initial_attr: string | null; pd_per_nex: number | null; pd_per_nex_attr: string | null
  pd_patente_initial: number | null; pd_patente_per_patente: number | null
}

type SkillRow = {
  id: string
  name: string
  default_attribute: string | null
}

type CharacterSkillRow = {
  skill_id: string
  training: Training
  attribute_override: string | null
  extra_bonus: number
}

const ATTR_LABELS: { key: AttributeKey; abbr: string }[] = [
  { key: 'forca', abbr: 'FOR' },
  { key: 'agilidade', abbr: 'AGI' },
  { key: 'intelecto', abbr: 'INT' },
  { key: 'vigor', abbr: 'VIG' },
  { key: 'presenca', abbr: 'PRE' },
]

export default function AgenteTab({
  character,
  onUpdated,
  editMode,
  originName,
  className,
  onNameChange,
}: {
  character: CharacterRecord
  onUpdated: () => void
  editMode: boolean
  originName: string | null
  className: string | null
  onNameChange: (name: string) => void
}) {
  const { session } = useAuth()
  const [classRow, setClassRow] = useState<ClassRow | null>(null)
  const [skills, setSkills] = useState<SkillRow[]>([])
  const [charSkills, setCharSkills] = useState<Record<string, CharacterSkillRow>>({})
  const [roll, setRoll] = useState<RollResultData | null>(null)
  const [skillFilter, setSkillFilter] = useState('')
  const [rightTab, setRightTab] = useState<'Combate' | 'Habilidades' | 'Rituais' | 'Inventário'>('Combate')
  const [testModifiers, setTestModifiers] = useState<Modifier[]>([])
  const [testDraft, setTestDraft] = useState({ diceBonus: 0, valueBonus: 0 })
  const [onlyTrained, setOnlyTrained] = useState(false)

  useEffect(() => {
    if (character.class_id) {
      supabase
        .from('classes')
        .select('pv_initial, pv_initial_attr, pv_per_nex, pv_per_nex_attr, pe_initial, pe_initial_attr, pe_per_nex, pe_per_nex_attr, sanity_initial, sanity_per_nex, pd_initial, pd_initial_attr, pd_per_nex, pd_per_nex_attr, pd_patente_initial, pd_patente_per_patente')
        .eq('id', character.class_id)
        .single()
        .then(({ data }) => setClassRow(data))
    } else if (character.custom_class) {
      const cc = character.custom_class
      setClassRow({
        pv_initial: cc.pvInitial, pv_initial_attr: 'vigor', pv_per_nex: cc.pvPerNex, pv_per_nex_attr: 'vigor',
        pe_initial: cc.peInitial, pe_initial_attr: 'presenca', pe_per_nex: cc.pePerNex, pe_per_nex_attr: 'presenca',
        sanity_initial: cc.sanityInitial, sanity_per_nex: cc.sanityPerNex,
        pd_initial: cc.pdInitial, pd_initial_attr: 'presenca', pd_per_nex: cc.pdPerNex, pd_per_nex_attr: 'presenca',
        pd_patente_initial: null, pd_patente_per_patente: null,
      })
    }
  }, [character.class_id, character.custom_class])

  useEffect(() => {
    supabase.from('skills').select('id, name, default_attribute').order('sort_order').then(({ data }) => setSkills(data ?? []))
    supabase
      .from('character_skills')
      .select('skill_id, training, attribute_override, extra_bonus')
      .eq('character_id', character.id)
      .then(({ data }) => {
        const map: Record<string, CharacterSkillRow> = {}
        for (const row of data ?? []) map[row.skill_id] = row
        setCharSkills(map)
      })
  }, [character.id])

  const derived = useMemo(() => {
    if (!classRow) return { maxPv: 0, maxPe: 0, maxSanity: 0, maxPd: 0 }
    return computeDerivedStats(classRow, character.attributes, character.nex_percent)
  }, [classRow, character.attributes, character.nex_percent])

  async function updateAttribute(key: keyof typeof character.attributes, value: number) {
    const attributes = { ...character.attributes, [key]: value }
    await supabase.from('characters').update({ attributes }).eq('id', character.id)
    onUpdated()
  }

  async function updateCharacterField(field: string, value: number | string) {
    await supabase.from('characters').update({ [field]: value }).eq('id', character.id)
    onUpdated()
  }

  function rollAttribute(key: AttributeKey, abbr: string) {
    const score = character.attributes[key]
    const { rolls, kept } = rollAttributeTest(score)
    const label = `Teste de ${abbr}`
    setRoll({ label, rolls, kept, bonus: 0 })
    if (session) {
      recordRoll({
        characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
        label, total: kept, detail: `d20 mantido: ${kept} (rolados: ${rolls.join(', ')})`,
      })
    }
  }

  async function setSkillField(skillId: string, patch: Partial<CharacterSkillRow>) {
    const current = charSkills[skillId] ?? { skill_id: skillId, training: 'nenhum', attribute_override: null, extra_bonus: 0 }
    const next = { ...current, ...patch }
    setCharSkills((m) => ({ ...m, [skillId]: next }))
    await supabase.from('character_skills').upsert({ character_id: character.id, skill_id: skillId, training: next.training, attribute_override: next.attribute_override, extra_bonus: next.extra_bonus })
  }

function cycleTraining(current: Training): Training {
    if (current === 'nenhum') return 'treinado'
    if (current === 'treinado') return 'veterano'
    if (current === 'veterano') return 'expert'
    return 'nenhum'
  }

  function trainingBadge(training: Training): string {
    if (training === 'treinado') return '5'
    if (training === 'veterano') return '10'
    if (training === 'expert') return '15'
    return '—'
  }

  const activeTestMods = testModifiers.filter((m) => m.is_active)
  const testDiceBonus = activeTestMods.reduce((sum, m) => sum + m.dice_bonus, 0) + testDraft.diceBonus
  const testValueBonus = activeTestMods.reduce((sum, m) => sum + m.value_bonus, 0) + testDraft.valueBonus

  function rollSkill(skill: SkillRow) {
    const cs = charSkills[skill.id] ?? { skill_id: skill.id, training: 'nenhum' as const, attribute_override: null, extra_bonus: 0 }
    const attr = cs.attribute_override ?? skill.default_attribute
    const score = attrValue(character.attributes, attr) + testDiceBonus
    const { rolls, kept } = rollAttributeTest(score)
    const bonus = trainingBonus(cs.training) + cs.extra_bonus + testValueBonus
    const label = `Teste de ${skill.name}`
    setRoll({ label, rolls, kept, bonus })
    if (session) {
      recordRoll({
        characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
        label, total: kept + bonus, detail: `d20 mantido: ${kept} (rolados: ${rolls.join(', ')}) + bônus ${bonus}`,
      })
    }
  }

  const visibleSkills = skills.filter((s) => {
    if (skillFilter && !s.name.toLowerCase().includes(skillFilter.toLowerCase())) return false
    if (onlyTrained && (charSkills[s.id]?.training ?? 'nenhum') === 'nenhum') return false
    return true
  })

  const maxPv = character.max_pv_override ?? derived.maxPv
  const maxSanity = character.max_sanity_override ?? derived.maxSanity
  const pct = (cur: number, max: number) => (max > 0 ? Math.max(0, Math.min(100, (cur / max) * 100)) : 0)
  const maxPdPatente = character.optional_rules.evolucao_patente && classRow
    ? computePatentePd(classRow.pd_patente_initial, classRow.pd_patente_per_patente, character.attributes.presenca, character.patente)
    : null

  return (
    <div className="vtt-columns">
      {roll && <RollResult result={roll} onClose={() => setRoll(null)} />}

      <div className="vtt-col-side">
        <div className="vtt-card" style={{ textAlign: 'center' }}>
          <img className="vtt-avatar" src={character.avatar_url ?? undefined} alt="" />
          {editMode && (
            <div>
              <button type="button">Mudar foto</button>
              <button type="button">Mudar moldura</button>
            </div>
          )}

          {editMode ? (
            <input value={character.name} onChange={(e) => onNameChange(e.target.value)} style={{ textAlign: 'center', width: '100%' }} />
          ) : (
            <h2>{character.name}</h2>
          )}
          <p style={{ color: 'var(--text-dim)' }}>{originName}</p>
          <p style={{ color: 'var(--text-dim)' }}>{className}</p>
          <p style={{ color: 'var(--text-dim)' }}>
            NEX {character.nex_percent}%{character.nex_mode === 'nex_experiencia' ? ` · Exp. ${character.experience ?? 0}` : ''}
          </p>
        </div>

        <div className="vtt-card">
          {editMode ? (
            <>
              <h3>Atributos</h3>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.5em' }}>
                {ATTR_LABELS.map(({ key, abbr }) => (
                  <label key={key}>
                    {abbr}
                    <input
                      type="number"
                      value={character.attributes[key]}
                      onChange={(e) => updateAttribute(key, Number(e.target.value))}
                      style={{ width: '3em' }}
                    />
                  </label>
                ))}
              </div>
            </>
          ) : (
            <AttributeDiagram attributes={character.attributes} nexPercent={character.nex_percent} onRoll={rollAttribute} />
          )}

          {character.optional_rules.evolucao_patente && (
            <label style={{ display: 'block', marginTop: '0.6em' }}>
              Patente
              <select value={character.patente} onChange={(e) => updateCharacterField('patente', e.target.value)}>
                {['sem_patente', 'recruta', 'operador', 'agente_especial', 'oficial_operacoes', 'agente_elite'].map((p) => (
                  <option key={p} value={p}>{p.replace(/_/g, ' ')}</option>
                ))}
              </select>
            </label>
          )}
        </div>

        <div className="vtt-card">
          <StatBar
            label="Vida"
            icon={pvIconFor(pct(character.current_pv ?? 0, maxPv))}
            current={character.current_pv ?? 0}
            max={maxPv}
            temp={character.temp_pv}
            colorClass="pv"
            onDecrement={() => updateCharacterField('current_pv', (character.current_pv ?? 0) - 1)}
            onIncrement={() => updateCharacterField('current_pv', (character.current_pv ?? 0) + 1)}
          />

          {character.optional_rules.sem_sanidade ? (
            <StatBar
              label="Determinação"
              current={character.current_pd ?? 0}
              max={derived.maxPd}
              colorClass="pd"
              note="Substitui Sanidade/Esforço"
              onDecrement={() => updateCharacterField('current_pd', (character.current_pd ?? 0) - 1)}
              onIncrement={() => updateCharacterField('current_pd', (character.current_pd ?? 0) + 1)}
            />
          ) : (
            <>
              <StatBar
                label="Sanidade"
                current={character.current_sanity ?? 0}
                max={maxSanity}
                temp={character.temp_sanity}
                colorClass="sanidade"
                onDecrement={() => updateCharacterField('current_sanity', (character.current_sanity ?? 0) - 1)}
                onIncrement={() => updateCharacterField('current_sanity', (character.current_sanity ?? 0) + 1)}
              />
              <StatBar
                label="Esforço"
                current={character.current_pe ?? 0}
                max={derived.maxPe}
                colorClass="esforco"
                onDecrement={() => updateCharacterField('current_pe', (character.current_pe ?? 0) - 1)}
                onIncrement={() => updateCharacterField('current_pe', (character.current_pe ?? 0) + 1)}
              />
            </>
          )}

          {character.optional_rules.evolucao_patente && !character.optional_rules.sem_sanidade && (
            maxPdPatente == null ? (
              <p style={{ fontSize: '0.85em', color: 'var(--text-dim)' }}>PD por Evolução de Patente ainda não confirmado pra essa classe.</p>
            ) : (
              <StatBar
                label="Determinação (Patente)"
                current={character.current_pd ?? 0}
                max={maxPdPatente}
                colorClass="pd"
                onDecrement={() => updateCharacterField('current_pd', (character.current_pd ?? 0) - 1)}
                onIncrement={() => updateCharacterField('current_pd', (character.current_pd ?? 0) + 1)}
              />
            )
          )}
        </div>
      </div>

      <div className="vtt-col-main">
        <div className="vtt-card">
          <h3>Modificador de Testes</h3>
          <ModifiersPanel characterId={character.id} scope="teste" onChange={setTestModifiers} onDraftChange={setTestDraft} />
        </div>

        <div className="vtt-card">
          <input placeholder="Busque Perícias" value={skillFilter} onChange={(e) => setSkillFilter(e.target.value)} />
          <label><input type="checkbox" checked={onlyTrained} onChange={(e) => setOnlyTrained(e.target.checked)} /> Apenas Treinadas</label>

          <table>
            <thead>
              <tr><th>Perícia</th><th>Treino</th><th>Atrib.</th><th>Extra</th><th>Total</th><th></th></tr>
            </thead>
            <tbody>
              {visibleSkills.map((skill) => {
                const cs = charSkills[skill.id] ?? { skill_id: skill.id, training: 'nenhum' as const, attribute_override: null, extra_bonus: 0 }
                const attr = cs.attribute_override ?? skill.default_attribute
                const total = trainingBonus(cs.training) + cs.extra_bonus + testValueBonus
                const diceCount = attr ? attrValue(character.attributes, attr) + testDiceBonus : null
                return (
                  <tr key={skill.id}>
                    <td>{skill.name} ({diceCount ?? '?'}d20{testDiceBonus ? ` (${testDiceBonus >= 0 ? '+' : ''}${testDiceBonus} de modificadores)` : ''})</td>
                    <td>
                      <button type="button" onClick={() => setSkillField(skill.id, { training: cycleTraining(cs.training) })}>
                        {trainingBadge(cs.training)}
                      </button>
                    </td>
                    <td>
                      <select value={attr ?? ''} onChange={(e) => setSkillField(skill.id, { attribute_override: e.target.value || null })}>
                        <option value="">—</option>
                        {ATTR_LABELS.map((a) => <option key={a.key} value={a.key}>{a.abbr}</option>)}
                      </select>
                    </td>
                    <td>
                      <input type="number" value={cs.extra_bonus} onChange={(e) => setSkillField(skill.id, { extra_bonus: Number(e.target.value) })} style={{ width: '3em' }} />
                    </td>
                    <td>{total}</td>
                    <td><button type="button" onClick={() => rollSkill(skill)} disabled={!attr}>Rolar</button></td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </div>
      </div>

      <div className="vtt-col-combat">
        <nav className="vtt-tabs" style={{ marginBottom: '0.8em' }}>
          {(['Combate', 'Habilidades', 'Rituais', 'Inventário'] as const).map((t) => (
            <button key={t} type="button" onClick={() => setRightTab(t)} disabled={rightTab === t}>{t}</button>
          ))}
        </nav>

        {rightTab === 'Habilidades' && <HabilidadesTab character={character} />}
        {rightTab === 'Rituais' && <RituaisTab character={character} />}
        {rightTab === 'Inventário' && <InventarioTab character={character} />}
        {rightTab === 'Combate' && <CombateTab character={character} />}
      </div>
    </div>
  )
}
