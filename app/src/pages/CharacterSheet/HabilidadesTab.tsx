import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import type { CharacterRecord } from './index'

type AbilityEntry = {
  id: string
  name: string
  description: string
}

type Category = 'Combatente' | 'Especialista' | 'Ocultista' | 'Sobrevivente' | 'Mundano' | 'Poderes Paranormais' | 'Poderes Gerais' | 'Origens'

const CLASS_SLUGS: Record<string, string> = {
  Combatente: 'combatente',
  Especialista: 'especialista',
  Ocultista: 'ocultista',
  Sobrevivente: 'sobrevivente',
  Mundano: 'mundano',
}

type CustomAbilityDraft = {
  name: string
  hasElement: boolean
  element: string
  description: string
  proficiencyGranted: string
}

const emptyCustom: CustomAbilityDraft = { name: '', hasElement: false, element: '', description: '', proficiencyGranted: '' }

export default function HabilidadesTab({ character }: { character: CharacterRecord }) {
  const [current, setCurrent] = useState<AbilityEntry[]>([])
  const [adding, setAdding] = useState(false)
  const [category, setCategory] = useState<Category>('Combatente')
  const [options, setOptions] = useState<AbilityEntry[]>([])
  const [search, setSearch] = useState('')
  const [creatingCustom, setCreatingCustom] = useState(false)
  const [customDraft, setCustomDraft] = useState<CustomAbilityDraft>(emptyCustom)
  const [tempBonuses, setTempBonuses] = useState<{ id: string; source: string; attribute_group: string; dice: string; remaining: number }[]>([])

  useEffect(() => {
    supabase.from('character_temp_bonuses').select('id, source, attribute_group, dice, remaining').eq('character_id', character.id).gt('remaining', 0).then(({ data }) => setTempBonuses(data ?? []))
  }, [character.id])

  async function loadCurrent() {
    const { data } = await supabase
      .from('character_abilities')
      .select('id, class_power_id, paranormal_power_id, general_power_id, origin_power_of, custom_ability, class_powers(name, description), paranormal_powers(name, description), general_powers(name, description), origins(power_name, power_description)')
      .eq('character_id', character.id)

    const entries: AbilityEntry[] = (data ?? []).map((row: any) => {
      if (row.custom_ability) return { id: row.id, name: row.custom_ability.name, description: row.custom_ability.description }
      if (row.class_powers) return { id: row.id, name: row.class_powers.name, description: row.class_powers.description }
      if (row.paranormal_powers) return { id: row.id, name: row.paranormal_powers.name, description: row.paranormal_powers.description }
      if (row.general_powers) return { id: row.id, name: row.general_powers.name, description: row.general_powers.description }
      if (row.origins) return { id: row.id, name: row.origins.power_name, description: row.origins.power_description }
      return { id: row.id, name: '(desconhecida)', description: '' }
    })
    setCurrent(entries)
  }

  useEffect(() => { loadCurrent() }, [character.id])

  useEffect(() => {
    if (!adding) return
    if (category === 'Poderes Gerais') {
      supabase.from('general_powers').select('id, name, description').order('name').then(({ data }) => setOptions(data ?? []))
      return
    }
    if (category === 'Poderes Paranormais') {
      supabase.from('paranormal_powers').select('id, name, description').order('name').then(({ data }) => setOptions(data ?? []))
      return
    }
    if (category === 'Origens') {
      supabase.from('origins').select('id, power_name, power_description').order('sort_order').then(({ data }) =>
        setOptions((data ?? []).map((o) => ({ id: o.id, name: o.power_name, description: o.power_description }))))
      return
    }
    const slug = CLASS_SLUGS[category]
    supabase
      .from('classes')
      .select('id')
      .eq('slug', slug)
      .single()
      .then(({ data: cls }) => {
        if (!cls) return setOptions([])
        return supabase
          .from('class_powers')
          .select('id, name, description')
          .eq('class_id', cls.id)
          .eq('is_base_ability', false)
          .order('sort_order')
          .then(({ data }) => setOptions(data ?? []))
      })
  }, [adding, category])

  async function addAbility(option: AbilityEntry, sourceCategory: Category) {
    const patch: Record<string, string> = {}
    if (sourceCategory === 'Poderes Paranormais') patch.paranormal_power_id = option.id
    else if (sourceCategory === 'Poderes Gerais') patch.general_power_id = option.id
    else if (sourceCategory === 'Origens') patch.origin_power_of = option.id
    else patch.class_power_id = option.id

    await supabase.from('character_abilities').insert({ character_id: character.id, ...patch })
    await loadCurrent()
  }

  async function saveCustom() {
    if (!customDraft.name || !customDraft.description) return
    await supabase.from('character_abilities').insert({
      character_id: character.id,
      custom_ability: {
        name: customDraft.name,
        hasElement: customDraft.hasElement,
        element: customDraft.hasElement ? customDraft.element : null,
        description: customDraft.description,
        proficiencyGranted: customDraft.proficiencyGranted || null,
      },
    })
    setCustomDraft(emptyCustom)
    setCreatingCustom(false)
    setAdding(false)
    await loadCurrent()
  }

  async function removeAbility(id: string) {
    await supabase.from('character_abilities').delete().eq('id', id)
    await loadCurrent()
  }

  const filteredOptions = options.filter((o) => o.name.toLowerCase().includes(search.toLowerCase()))

  return (
    <div>
      {tempBonuses.length > 0 && (
        <div>
          <p><strong>Lembrete — bônus de interlúdio disponíveis:</strong></p>
          <ul>
            {tempBonuses.map((b) => (
              <li key={b.id}>{b.source}: {b.remaining}x {b.dice} em testes de {b.attribute_group === 'fisico' ? 'Agilidade/Força/Vigor' : b.attribute_group === 'mental' ? 'Intelecto/Presença' : 'qualquer teste'} (use em Interlúdio)</li>
            ))}
          </ul>
        </div>
      )}

      <input placeholder="Buscar Habilidades" value={search} onChange={(e) => setSearch(e.target.value)} />
      <button type="button" onClick={() => setAdding((a) => !a)}>Adicionar Habilidade</button>

      <ul>
        {current.map((a) => (
          <li key={a.id}>
            <strong>{a.name}</strong>: {a.description}
            <button type="button" onClick={() => removeAbility(a.id)}>Remover</button>
          </li>
        ))}
      </ul>

      {adding && (
        <div>
          <nav>
            {(['Combatente', 'Especialista', 'Ocultista', 'Sobrevivente', 'Mundano', 'Poderes Paranormais', 'Poderes Gerais', 'Origens'] as Category[]).map((c) => (
              <button key={c} type="button" onClick={() => { setCategory(c); setCreatingCustom(false) }} disabled={category === c && !creatingCustom}>{c}</button>
            ))}
          </nav>

          <button type="button" onClick={() => setCreatingCustom(true)}>Criar Nova Habilidade</button>

          {creatingCustom ? (
            <div>
              <label>Nome <input value={customDraft.name} onChange={(e) => setCustomDraft((d) => ({ ...d, name: e.target.value }))} /></label>
              <fieldset>
                <legend>Paranormal</legend>
                <label>Possui elemento?
                  <select value={customDraft.hasElement ? 'sim' : 'nao'} onChange={(e) => setCustomDraft((d) => ({ ...d, hasElement: e.target.value === 'sim' }))}>
                    <option value="nao">Não</option>
                    <option value="sim">Sim</option>
                  </select>
                </label>
                {customDraft.hasElement && (
                  <label>Elemento
                    <select value={customDraft.element} onChange={(e) => setCustomDraft((d) => ({ ...d, element: e.target.value }))}>
                      <option value="">—</option>
                      <option value="sangue">Sangue</option>
                      <option value="morte">Morte</option>
                      <option value="conhecimento">Conhecimento</option>
                      <option value="energia">Energia</option>
                    </select>
                  </label>
                )}
              </fieldset>
              <label>Descrição <textarea value={customDraft.description} onChange={(e) => setCustomDraft((d) => ({ ...d, description: e.target.value }))} /></label>
              <label>Proficiência concedida <input value={customDraft.proficiencyGranted} onChange={(e) => setCustomDraft((d) => ({ ...d, proficiencyGranted: e.target.value }))} /></label>
              <button type="button" onClick={saveCustom}>Adicionar Habilidade</button>
            </div>
          ) : filteredOptions.length === 0 ? (
            <p>Sem conteúdo cadastrado ainda nessa categoria.</p>
          ) : (
            <ul>
              {filteredOptions.map((o) => (
                <li key={o.id}>
                  <strong>{o.name}</strong>: {o.description}
                  <button type="button" onClick={() => addAbility(o, category)}>Adicionar Habilidade</button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  )
}
