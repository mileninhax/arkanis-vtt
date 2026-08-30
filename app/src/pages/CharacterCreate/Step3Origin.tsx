import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { getOriginsBySource, getSkills, type Origin, type Skill } from '../../lib/content'
import type { CharacterDraft, CustomOrigin } from './types'

type Tab = 'ordem_paranormal' | 'sobrevivendo_ao_horror' | 'arquivos_secretos' | 'custom'

const ARQUIVOS_SECRETOS_SLUGS = Array.from({ length: 7 }, (_, i) => `arquivos_secretos_0${i + 1}`)

async function getOriginsArquivosSecretos(): Promise<Origin[]> {
  const { data, error } = await supabase
    .from('origins')
    .select('id, name, roll_range, skill_1_id, skill_2_id, skills_text, power_name, power_description, description, sources!inner(slug)')
    .in('sources.slug', ARQUIVOS_SECRETOS_SLUGS)
    .order('sort_order')
  if (error) throw error
  return data as unknown as Origin[]
}

export default function Step3Origin({
  draft,
  onChange,
  onNext,
  onBack,
}: {
  draft: CharacterDraft
  onChange: (patch: Partial<Pick<CharacterDraft, 'originId' | 'customOrigin'>>) => void
  onNext: () => void
  onBack: () => void
}) {
  const [tab, setTab] = useState<Tab>('ordem_paranormal')
  const [origins, setOrigins] = useState<Origin[]>([])
  const [skills, setSkills] = useState<Skill[]>([])
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    getSkills().then(setSkills)
  }, [])

  useEffect(() => {
    if (tab === 'custom') return
    setLoading(true)
    const fetcher = tab === 'arquivos_secretos' ? getOriginsArquivosSecretos() : getOriginsBySource(tab)
    fetcher.then((data) => {
      setOrigins(data)
      setLoading(false)
    })
  }, [tab])

  const selected = origins.find((o) => o.id === draft.originId)
  const selectedName = draft.customOrigin ? draft.customOrigin.name : selected?.name

  function selectOrigin(origin: Origin) {
    onChange({ originId: origin.id, customOrigin: null })
  }

  function updateCustom(patch: Partial<CustomOrigin>) {
    const base: CustomOrigin = draft.customOrigin ?? { name: '', skill1Id: null, skill2Id: null, powerName: '', powerDescription: '' }
    onChange({ originId: null, customOrigin: { ...base, ...patch } })
  }

  const canProceed = Boolean(draft.originId || (draft.customOrigin && draft.customOrigin.name && draft.customOrigin.powerName))

  return (
    <div>
      <section>
        <h2>ORIGEM SELECIONADA: {selectedName ?? '[ORIGEM NÃO SELECIONADA]'}</h2>
        <p>O que você fazia antes de se envolver com o paranormal e ingressar na Ordem da Realidade? A origem representa como a vida pregressa influencia sua carreira de investigador.</p>
        <p><strong>Ao escolher uma origem, você recebe duas perícias treinadas e um poder da origem.</strong></p>
        {selected && (
          <div>
            <p>Perícias: {selected.skills_text ?? [skills.find((s) => s.id === selected.skill_1_id)?.name, skills.find((s) => s.id === selected.skill_2_id)?.name].filter(Boolean).join(' e ')}</p>
            <p><strong>{selected.power_name}</strong>: {selected.power_description}</p>
            {selected.description && <p>{selected.description}</p>}
          </div>
        )}
      </section>

      <section>
        <nav>
          <button type="button" onClick={() => setTab('ordem_paranormal')} disabled={tab === 'ordem_paranormal'}>Ordem Paranormal</button>
          <button type="button" onClick={() => setTab('sobrevivendo_ao_horror')} disabled={tab === 'sobrevivendo_ao_horror'}>Sobrevivendo ao Horror</button>
          <button type="button" onClick={() => setTab('arquivos_secretos')} disabled={tab === 'arquivos_secretos'}>Arquivos Secretos</button>
          <button type="button" onClick={() => setTab('custom')} disabled={tab === 'custom'}>Sua Origem</button>
        </nav>

        {tab === 'custom' ? (
          <div>
            <label>
              Nome da Origem
              <input value={draft.customOrigin?.name ?? ''} onChange={(e) => updateCustom({ name: e.target.value })} />
            </label>
            <fieldset>
              <legend>Perícias Treinadas</legend>
              <select value={draft.customOrigin?.skill1Id ?? ''} onChange={(e) => updateCustom({ skill1Id: e.target.value || null })}>
                <option value="">Nenhuma</option>
                {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
              <select value={draft.customOrigin?.skill2Id ?? ''} onChange={(e) => updateCustom({ skill2Id: e.target.value || null })}>
                <option value="">Nenhuma</option>
                {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </fieldset>
            <fieldset>
              <legend>Poder de Origem</legend>
              <label>
                Nome do poder
                <input value={draft.customOrigin?.powerName ?? ''} onChange={(e) => updateCustom({ powerName: e.target.value })} />
              </label>
              <label>
                Descrição
                <textarea value={draft.customOrigin?.powerDescription ?? ''} onChange={(e) => updateCustom({ powerDescription: e.target.value })} />
              </label>
            </fieldset>
          </div>
        ) : loading ? (
          <p>Carregando…</p>
        ) : origins.length === 0 ? (
          <p>Sem origens cadastradas ainda pra essa fonte.</p>
        ) : (
          <ul>
            {origins.map((o) => (
              <li key={o.id}>
                <button type="button" onClick={() => selectOrigin(o)}>{o.name}</button>
              </li>
            ))}
          </ul>
        )}
      </section>

      <button type="button" onClick={onBack}>← Voltar</button>
      <button type="button" onClick={onNext} disabled={!canProceed}>Avançar →</button>
    </div>
  )
}
