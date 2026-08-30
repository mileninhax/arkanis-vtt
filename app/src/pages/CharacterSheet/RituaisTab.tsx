import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import type { CharacterRecord } from './index'


type Ritual = {
  id: string
  name: string
  elemento: string | null
  circle: number
  execution: string | null
  range: string | null
  target: string | null
  duration: string | null
  resistance: string | null
  effect: string
  discente_cost: number | null
  discente_effect: string | null
  verdadeiro_cost: number | null
  verdadeiro_effect: string | null
}

type CharacterRitual = {
  id: string
  ritual_id: string | null
  custom_ritual: { name: string; elemento: string | null; circle: number | null; effect: string } | null
  rituals: Ritual | null
}

const ELEMENTOS = ['sangue', 'morte', 'conhecimento', 'energia', 'medo'] as const
const CIRCULOS = [1, 2, 3, 4]

type CustomRitualDraft = { name: string; elemento: string; circle: number; effect: string }
const emptyCustomRitual: CustomRitualDraft = { name: '', elemento: '', circle: 1, effect: '' }

export default function RituaisTab({ character }: { character: CharacterRecord }) {
  const [known, setKnown] = useState<CharacterRitual[]>([])
  const [expanded, setExpanded] = useState<string | null>(null)
  const [adding, setAdding] = useState(false)
  const [search, setSearch] = useState('')
  const [elementFilter, setElementFilter] = useState<string[]>([])
  const [circleFilter, setCircleFilter] = useState<number[]>([])
  const [catalog, setCatalog] = useState<Ritual[]>([])
  const [creatingCustom, setCreatingCustom] = useState(false)
  const [customDraft, setCustomDraft] = useState<CustomRitualDraft>(emptyCustomRitual)

  async function loadKnown() {
    const { data } = await supabase
      .from('character_rituals')
      .select('id, ritual_id, custom_ritual, rituals(id, name, elemento, circle, execution, range, target, duration, resistance, effect, discente_cost, discente_effect, verdadeiro_cost, verdadeiro_effect)')
      .eq('character_id', character.id)
    setKnown((data ?? []) as unknown as CharacterRitual[])
  }

  useEffect(() => { loadKnown() }, [character.id])

  useEffect(() => {
    if (!adding) return
    let query = supabase.from('rituals').select('id, name, elemento, circle, execution, range, target, duration, resistance, effect, discente_cost, discente_effect, verdadeiro_cost, verdadeiro_effect')
    if (elementFilter.length) query = query.in('elemento', elementFilter)
    if (circleFilter.length) query = query.in('circle', circleFilter)
    query.order('circle').then(({ data }) => setCatalog(data ?? []))
  }, [adding, elementFilter, circleFilter])

  function toggle<T>(list: T[], value: T): T[] {
    return list.includes(value) ? list.filter((v) => v !== value) : [...list, value]
  }

  async function addRitual(ritual: Ritual) {
    await supabase.from('character_rituals').insert({ character_id: character.id, ritual_id: ritual.id })
    await loadKnown()
  }

  async function removeRitual(id: string) {
    await supabase.from('character_rituals').delete().eq('id', id)
    await loadKnown()
  }

  async function saveCustomRitual() {
    if (!customDraft.name || !customDraft.effect) return
    await supabase.from('character_rituals').insert({
      character_id: character.id,
      custom_ritual: {
        name: customDraft.name,
        elemento: customDraft.elemento || null,
        circle: customDraft.circle,
        effect: customDraft.effect,
      },
    })
    setCustomDraft(emptyCustomRitual)
    setCreatingCustom(false)
    setAdding(false)
    await loadKnown()
  }

  const filteredCatalog = catalog.filter((r) => r.name.toLowerCase().includes(search.toLowerCase()))

  return (
    <div>
      <input placeholder="Buscar Rituais" value={search} onChange={(e) => setSearch(e.target.value)} />
      <nav>
        {ELEMENTOS.map((e) => (
          <button key={e} type="button" onClick={() => setElementFilter((f) => toggle(f, e))} aria-pressed={elementFilter.includes(e)}>{e}</button>
        ))}
      </nav>
      <nav>
        {CIRCULOS.map((c) => (
          <button key={c} type="button" onClick={() => setCircleFilter((f) => toggle(f, c))} aria-pressed={circleFilter.includes(c)}>{c}</button>
        ))}
        {(elementFilter.length > 0 || circleFilter.length > 0) && (
          <button type="button" onClick={() => { setElementFilter([]); setCircleFilter([]) }}>Limpar filtros</button>
        )}
      </nav>

      <button type="button" onClick={() => setAdding((a) => !a)}>Adicionar Ritual</button>

      <ul>
        {known.map((cr) => {
          const ritual = cr.rituals ?? cr.custom_ritual
          if (!ritual) return null
          const isExpanded = expanded === cr.id
          return (
            <li key={cr.id}>
              <button type="button" onClick={() => setExpanded(isExpanded ? null : cr.id)}>
                {ritual.circle ?? '?'}º — {ritual.name} ({ritual.elemento ?? 'multi-elemento'})
              </button>
              {isExpanded && (
                <div>
                  {cr.rituals && (
                    <>
                      <p>Execução: {cr.rituals.execution} · Alcance: {cr.rituals.range} · Alvo: {cr.rituals.target} · Duração: {cr.rituals.duration} · Resistência: {cr.rituals.resistance ?? '—'}</p>
                      <p>{cr.rituals.effect}</p>
                      {cr.rituals.discente_effect && <p><strong>Discente ({cr.rituals.discente_cost} PE):</strong> {cr.rituals.discente_effect}</p>}
                      {cr.rituals.verdadeiro_effect && <p><strong>Verdadeiro ({cr.rituals.verdadeiro_cost} PE):</strong> {cr.rituals.verdadeiro_effect}</p>}
                    </>
                  )}
                  {cr.custom_ritual && <p>{cr.custom_ritual.effect}</p>}
                  <button type="button" onClick={() => removeRitual(cr.id)}>Remover</button>
                </div>
              )}
            </li>
          )
        })}
      </ul>

      {adding && (
        <div>
          <button type="button" onClick={() => setCreatingCustom((c) => !c)}>Criar Ritual Personalizado</button>

          {creatingCustom ? (
            <div>
              <label>Nome <input value={customDraft.name} onChange={(e) => setCustomDraft((d) => ({ ...d, name: e.target.value }))} /></label>
              <label>Elemento
                <select value={customDraft.elemento} onChange={(e) => setCustomDraft((d) => ({ ...d, elemento: e.target.value }))}>
                  <option value="">Multi-elemento / nenhum</option>
                  {ELEMENTOS.map((el) => <option key={el} value={el}>{el}</option>)}
                </select>
              </label>
              <label>Círculo
                <select value={customDraft.circle} onChange={(e) => setCustomDraft((d) => ({ ...d, circle: Number(e.target.value) }))}>
                  {CIRCULOS.map((c) => <option key={c} value={c}>{c}º</option>)}
                </select>
              </label>
              <label>Efeito <textarea value={customDraft.effect} onChange={(e) => setCustomDraft((d) => ({ ...d, effect: e.target.value }))} /></label>
              <button type="button" onClick={saveCustomRitual}>Adicionar Ritual</button>
            </div>
          ) : filteredCatalog.length === 0 ? <p>Nenhum ritual encontrado com esses filtros.</p> : (
            <ul>
              {filteredCatalog.map((r) => (
                <li key={r.id}>
                  <strong>{r.circle}º — {r.name}</strong> ({r.elemento ?? 'multi-elemento'}): {r.effect}
                  <button type="button" onClick={() => addRitual(r)}>Adicionar Ritual</button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  )
}
