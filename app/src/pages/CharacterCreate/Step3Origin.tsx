import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { getOriginsBySource, getSkills, type Origin, type Skill } from '../../lib/content'
import type { CharacterDraft, CustomOrigin } from './types'
import CreationLetterhead from './CreationLetterhead'
import stepArrow from '../../assets/criacao/step-arrow.svg'
import papelTextura from '../../assets/criacao/papel-textura.png'
import papelTexturaClara from '../../assets/criacao/papel-textura-clara.png'
import papelTexturaMarrom from '../../assets/criacao/papel-textura-marrom.png'

type Tab = 'ordem_paranormal' | 'sobrevivendo_ao_horror' | 'arquivos_secretos' | 'custom'

const TABS: { key: Tab; label: string }[] = [
  { key: 'ordem_paranormal', label: 'Ordem Paranormal' },
  { key: 'sobrevivendo_ao_horror', label: 'Sobrevivendo ao Horror' },
  { key: 'arquivos_secretos', label: 'Arquivos Secretos' },
  { key: 'custom', label: 'Sua Origem' },
]

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
  const paperStyle = { backgroundImage: `url(${papelTextura})` }
  const claraStyle = { backgroundImage: `url(${papelTexturaClara})` }
  const marromStyle = { backgroundImage: `url(${papelTexturaMarrom})` }

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
  const customSkillsText = draft.customOrigin
    ? [skills.find((s) => s.id === draft.customOrigin?.skill1Id)?.name, skills.find((s) => s.id === draft.customOrigin?.skill2Id)?.name].filter(Boolean).join(' e ')
    : ''

  function selectOrigin(origin: Origin) {
    onChange({ originId: origin.id, customOrigin: null })
  }

  function updateCustom(patch: Partial<CustomOrigin>) {
    const base: CustomOrigin = draft.customOrigin ?? { name: '', skill1Id: null, skill2Id: null, powerName: '', powerDescription: '' }
    onChange({ originId: null, customOrigin: { ...base, ...patch } })
  }

  const canProceed = Boolean(draft.originId || (draft.customOrigin && draft.customOrigin.name && draft.customOrigin.powerName))

  return (
    <div className="creation-spread">
      <div className="creation-paper-slot">
        <div className="creation-paper-shadow" style={paperStyle} />
        <div className="creation-paper creation-paper-tilt-l" style={paperStyle}>
          <CreationLetterhead docNumber={draft.docNumber} />

          <div className="creation-section-title">Origem</div>

          <p>O que você fazia antes de se envolver com o paranormal e ingressar na Ordem da Realidade? A origem representa como a vida pregressa influencia sua carreira de investigador.</p>

          <div className="creation-stencil">Ao escolher uma origem, você recebe duas perícias treinadas e um poder da origem.</div>

          <p>Cada origem apresentada a seguir é intencionalmente vaga, apenas uma ideia por onde começar. Você pode usá-la como está, para jogar rapidamente, ou colorir com quantos detalhes quiser, conforme o conceito de seu agente.</p>
          <p>Perícias concedidas serão adicionadas automaticamente. Perícias opcionais podem ser adicionadas ao agente após sua criação.</p>
        </div>
      </div>

      <div className="creation-paper-slot">
        <div className="creation-paper-shadow" style={marromStyle} />
        <div className="creation-paper-split creation-paper-tilt-r">
          <div className="origin-status-panel" style={claraStyle}>
            {selectedName ? (
              <>
                <div className="creation-section-title">Origem selecionada: {selectedName}</div>
                {selected && (
                  <div className="origin-selected-info">
                    <p>
                      <strong>Perícias:</strong> {selected.skills_text ?? [skills.find((s) => s.id === selected.skill_1_id)?.name, skills.find((s) => s.id === selected.skill_2_id)?.name].filter(Boolean).join(' e ')}
                    </p>
                    <p><strong>{selected.power_name}:</strong> {selected.power_description}</p>
                    {selected.description && <p>{selected.description}</p>}
                  </div>
                )}
                {draft.customOrigin && (
                  <div className="origin-selected-info">
                    {customSkillsText && <p><strong>Perícias:</strong> {customSkillsText}</p>}
                    {draft.customOrigin.powerName && (
                      <p><strong>{draft.customOrigin.powerName}:</strong> {draft.customOrigin.powerDescription}</p>
                    )}
                  </div>
                )}
              </>
            ) : (
              <>
                <div className="creation-section-title">[Origem não selecionada]</div>
                <p className="origin-status-empty">Selecione uma origem abaixo, ou crie a sua na aba "Sua Origem".</p>
              </>
            )}
          </div>

          <div className="origin-list-panel" style={marromStyle}>
            <nav className="origin-tabs">
              {TABS.map((t) => (
                <button
                  key={t.key}
                  type="button"
                  className={`origin-tab${tab === t.key ? ' active' : ''}`}
                  onClick={() => setTab(t.key)}
                >
                  {t.label}
                </button>
              ))}
            </nav>

            <div className="origin-content">
              {tab === 'custom' ? (
                <div className="origin-form">
                  <label className="creation-field-block">
                    Nome da Origem
                    <input value={draft.customOrigin?.name ?? ''} onChange={(e) => updateCustom({ name: e.target.value })} placeholder="Nome da Origem." />
                  </label>

                  <div className="creation-section-title">Perícias Treinadas</div>
                  <div className="origin-form-row">
                    <select className="origin-select-box" value={draft.customOrigin?.skill1Id ?? ''} onChange={(e) => updateCustom({ skill1Id: e.target.value || null })}>
                      <option value="">Nenhuma</option>
                      {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
                    </select>
                    <select className="origin-select-box" value={draft.customOrigin?.skill2Id ?? ''} onChange={(e) => updateCustom({ skill2Id: e.target.value || null })}>
                      <option value="">Nenhuma</option>
                      {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
                    </select>
                  </div>

                  <div className="creation-section-title">Poder de Origem</div>
                  <label className="creation-field-block">
                    Nome do poder
                    <input value={draft.customOrigin?.powerName ?? ''} onChange={(e) => updateCustom({ powerName: e.target.value })} placeholder="Nome do poder." />
                  </label>
                  <label className="creation-field-block">
                    Descrição
                    <textarea value={draft.customOrigin?.powerDescription ?? ''} onChange={(e) => updateCustom({ powerDescription: e.target.value })} placeholder="Descrição aqui." />
                  </label>
                </div>
              ) : loading ? (
                <p>Carregando…</p>
              ) : origins.length === 0 ? (
                <p>Sem origens cadastradas ainda pra essa fonte.</p>
              ) : (
                <ul className="origin-list">
                  {origins.map((o) => (
                    <li key={o.id}>
                      <button type="button" className={draft.originId === o.id ? 'active' : ''} onClick={() => selectOrigin(o)}>
                        {o.name}
                      </button>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </div>
        </div>
      </div>

      <button type="button" className="creation-back-arrow" onClick={onBack} aria-label="Voltar">
        <img src={stepArrow} alt="" />
      </button>
      <button type="button" className="creation-next-arrow" onClick={onNext} disabled={!canProceed} aria-label="Avançar">
        <img src={stepArrow} alt="" />
      </button>
    </div>
  )
}
