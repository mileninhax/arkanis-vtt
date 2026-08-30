import { useEffect, useMemo, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { computeDerivedStats } from '../../lib/rules'
import { getClassExtras, type ClassPower, type ClassProgression, type ClassTrackTier } from '../../lib/content'
import type { CharacterRecord } from './index'

const NEX_LEVELS = [...Array.from({ length: 19 }, (_, i) => (i + 1) * 5), 99]
const NEX_OPTIONS = NEX_LEVELS

type Pick = { kind: 'poder_classe' | 'poder_paranormal' | 'trilha' | 'atributo' | 'outro'; label: string; ref_id: string | null }
type PickRow = { id: string; nex_percent: number; note: string; picks: Pick[] }

const ATTR_OPTIONS = [
  { key: 'forca', label: 'Força' },
  { key: 'agilidade', label: 'Agilidade' },
  { key: 'intelecto', label: 'Intelecto' },
  { key: 'vigor', label: 'Vigor' },
  { key: 'presenca', label: 'Presença' },
]

export default function ProgressaoTab({ character, onUpdated }: { character: CharacterRecord; onUpdated: () => void }) {
  const [lembreteGeral, setLembreteGeral] = useState('')
  const [classRow, setClassRow] = useState<any>(null)
  const [progression, setProgression] = useState<ClassProgression[]>([])
  const [powers, setPowers] = useState<ClassPower[]>([])
  const [tiers, setTiers] = useState<ClassTrackTier[]>([])
  const [paranormalPowers, setParanormalPowers] = useState<{ id: string; name: string }[]>([])
  const [selectedNex, setSelectedNex] = useState(NEX_LEVELS[0])
  const [pickRows, setPickRows] = useState<Record<number, PickRow>>({})

  useEffect(() => {
    supabase.from('characters').select('progressao_lembrete').eq('id', character.id).single().then(({ data }) => setLembreteGeral(data?.progressao_lembrete ?? ''))
    loadPicks()
  }, [character.id])

  useEffect(() => {
    if (!character.class_id) return
    supabase.from('classes').select('*').eq('id', character.class_id).single().then(({ data }) => setClassRow(data))
    getClassExtras(character.class_id).then((extras) => {
      setProgression(extras.progression)
      setPowers(extras.powers.filter((p: any) => !p.is_base_ability))
      setTiers(extras.tiers)
    })
    supabase.from('paranormal_powers').select('id, name').order('name').then(({ data }) => setParanormalPowers(data ?? []))
  }, [character.class_id])

  async function loadPicks() {
    const { data } = await supabase.from('character_progression_picks').select('id, nex_percent, note, picks').eq('character_id', character.id)
    const map: Record<number, PickRow> = {}
    for (const row of data ?? []) map[row.nex_percent] = row as PickRow
    setPickRows(map)
  }

  async function updateField(field: string, value: number) {
    await supabase.from('characters').update({ [field]: value }).eq('id', character.id)
    onUpdated()
  }

  async function saveLembreteGeral(value: string) {
    setLembreteGeral(value)
    await supabase.from('characters').update({ progressao_lembrete: value }).eq('id', character.id)
  }

  async function saveRow(nex: number, patch: Partial<PickRow>) {
    const current = pickRows[nex] ?? { id: '', nex_percent: nex, note: '', picks: [] }
    const next = { ...current, ...patch }
    setPickRows((m) => ({ ...m, [nex]: next }))
    await supabase.from('character_progression_picks').upsert({ character_id: character.id, nex_percent: nex, note: next.note, picks: next.picks }, { onConflict: 'character_id,nex_percent' })
  }

  async function addPick(nex: number, pick: Pick) {
    const current = pickRows[nex] ?? { id: '', nex_percent: nex, note: '', picks: [] }
    await saveRow(nex, { picks: [...current.picks, pick] })
  }

  async function removePick(nex: number, index: number) {
    const current = pickRows[nex]
    if (!current) return
    await saveRow(nex, { picks: current.picks.filter((_, i) => i !== index) })
  }

  const isNexExperiencia = character.optional_rules.nex_experiencia

  const statsAtSelected = useMemo(() => {
    if (!classRow) return null
    return computeDerivedStats(classRow, character.attributes, selectedNex)
  }, [classRow, character.attributes, selectedNex])

  const currentGain = progression.find((p) => p.nex_percent === selectedNex)
  const gainText = currentGain?.gain_text ?? ''
  const isClassPower = gainText.toLowerCase().includes('poder de');
  const isTrilha = gainText.toLowerCase().includes('trilha');
  const isAtributo = gainText.toLowerCase().includes('aumento de atributo');
  const isTranscender = gainText.toLowerCase().includes('transcender') || gainText.toLowerCase().includes('escolhido pelo outro lado');
  const tiersAtLevel = tiers.filter((t) => t.nex_percent === selectedNex);
  const currentRow = pickRows[selectedNex];

  return (
    <div>
      <section>
        <h2>Progressão</h2>
        {isNexExperiencia ? (
          <>
            <label>NEX <input type="number" value={character.nex_percent} onChange={(e) => updateField('nex_percent', Number(e.target.value))} />%</label>
            <label>
              Experiência
              <select value={character.experience ?? 0} onChange={(e) => updateField('experience', Number(e.target.value))}>
                {Array.from({ length: 21 }, (_, i) => i).map((n) => <option key={n} value={n}>{n}</option>)}
              </select>
            </label>
          </>
        ) : (
          <label>
            NEX
            <select value={character.nex_percent} onChange={(e) => updateField('nex_percent', Number(e.target.value))}>
              <option value={0}>Nenhum</option>
              {NEX_OPTIONS.map((n) => <option key={n} value={n}>{n}%</option>)}
            </select>
          </label>
        )}
      </section>

      <div style={{ display: 'flex', gap: '2em' }}>
        <section>
          <h3>Planejar nível</h3>
          <label>
            Ver NEX
            <select value={selectedNex} onChange={(e) => setSelectedNex(Number(e.target.value))}>
              {NEX_LEVELS.map((n) => <option key={n} value={n}>{n}%</option>)}
            </select>
          </label>

          <p><strong>Ganho neste nível:</strong> {gainText || '—'}</p>

          {isClassPower && (
            <label>
              Escolher poder de classe
              <select onChange={(e) => {
                const power = powers.find((p) => p.id === e.target.value)
                if (power) addPick(selectedNex, { kind: 'poder_classe', label: power.name, ref_id: power.id })
              }}>
                <option value="">—</option>
                {powers.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
              </select>
            </label>
          )}

          {isTranscender && (
            <label>
              Escolher poder paranormal
              <select onChange={(e) => {
                const power = paranormalPowers.find((p) => p.id === e.target.value)
                if (power) addPick(selectedNex, { kind: 'poder_paranormal', label: power.name, ref_id: power.id })
              }}>
                <option value="">—</option>
                {paranormalPowers.map((p) => <option key={p.id} value={p.id}>{p.name}</option>)}
              </select>
            </label>
          )}

          {isTrilha && tiersAtLevel.length > 0 && (
            <label>
              Escolher habilidade de trilha
              <select onChange={(e) => {
                const tier = tiersAtLevel.find((t) => t.id === e.target.value)
                if (tier) addPick(selectedNex, { kind: 'trilha', label: tier.name, ref_id: tier.id })
              }}>
                <option value="">—</option>
                {tiersAtLevel.map((t) => <option key={t.id} value={t.id}>{t.name}</option>)}
              </select>
            </label>
          )}

          {isAtributo && (
            <label>
              Escolher atributo
              <select onChange={(e) => {
                const attr = ATTR_OPTIONS.find((a) => a.key === e.target.value)
                if (attr) addPick(selectedNex, { kind: 'atributo', label: attr.label, ref_id: null })
              }}>
                <option value="">—</option>
                {ATTR_OPTIONS.map((a) => <option key={a.key} value={a.key}>{a.label}</option>)}
              </select>
            </label>
          )}

          <ul>
            {(currentRow?.picks ?? []).map((p, i) => (
              <li key={i}>[{p.kind}] {p.label} <button type="button" onClick={() => removePick(selectedNex, i)}>x</button></li>
            ))}
          </ul>

          <label>
            Nota livre
            <textarea value={currentRow?.note ?? ''} onChange={(e) => saveRow(selectedNex, { note: e.target.value })} />
          </label>

          {statsAtSelected && (
            <p>
              Nesse NEX: Vida {statsAtSelected.maxPv} · Sanidade {statsAtSelected.maxSanity} · PE {statsAtSelected.maxPe} · PD {statsAtSelected.maxPd}
              <br /><em>(fórmula padrão — não considera "Jogando sem Sanidade" nem "Evolução por Patente" ainda)</em>
            </p>
          )}
        </section>

        <section>
          <h3>Tabela de progressão</h3>
          <table>
            <thead><tr><th>NEX</th><th>Ganho</th><th>Vida</th><th>Sanidade</th><th>PE</th><th>PD</th><th>Planejado</th></tr></thead>
            <tbody>
              {progression.map((row) => {
                const stats = classRow ? computeDerivedStats(classRow, character.attributes, row.nex_percent) : null
                const planned = pickRows[row.nex_percent]
                return (
                  <tr key={row.nex_percent} style={row.nex_percent === character.nex_percent ? { fontWeight: 'bold' } : undefined}>
                    <td>{row.nex_percent}%</td>
                    <td>{row.gain_text}</td>
                    <td>{stats?.maxPv}</td>
                    <td>{stats?.maxSanity}</td>
                    <td>{stats?.maxPe}</td>
                    <td>{stats?.maxPd}</td>
                    <td>{planned ? (planned.picks.map((p) => p.label).join(', ') || planned.note) : ''}</td>
                  </tr>
                )
              })}
            </tbody>
          </table>
        </section>
      </div>

      <section>
        <h3>Lembrete geral</h3>
        <textarea rows={4} value={lembreteGeral} onChange={(e) => saveLembreteGeral(e.target.value)} />
      </section>
    </div>
  )
}
