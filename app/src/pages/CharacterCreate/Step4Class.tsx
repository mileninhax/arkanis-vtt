import { useEffect, useState } from 'react'
import { getClassExtras, getClasses, type ClassPower, type ClassProgression, type ClassRow, type ClassTrack, type ClassTrackTier } from '../../lib/content'
import type { CharacterDraft, CustomClass } from './types'
import CreationLetterhead from './CreationLetterhead'
import stepArrow from '../../assets/criacao/step-arrow.svg'
import papelTextura from '../../assets/criacao/papel-textura.png'

const ATTR_NAME: Record<string, string> = {
  vigor: 'VIGOR',
  presenca: 'PRESENÇA',
  forca: 'FORÇA',
  agilidade: 'AGILIDADE',
  intelecto: 'INTELECTO',
}

const ATTR_ABBR: Record<string, string> = {
  vigor: 'VIG',
  presenca: 'PRE',
  forca: 'FOR',
  agilidade: 'AGI',
  intelecto: 'INT',
}

const PAGE_SIZE = 3

const emptyCustomClass: CustomClass = {
  name: '',
  description: '',
  pvInitial: null,
  pvPerNex: null,
  peInitial: null,
  pePerNex: null,
  sanityInitial: null,
  sanityPerNex: null,
  pdInitial: null,
  pdPerNex: null,
  trainedSkillsText: '',
  proficienciesText: '',
}

export default function Step4Class({
  draft,
  onChange,
  onNext,
  onBack,
}: {
  draft: CharacterDraft
  onChange: (patch: Partial<Pick<CharacterDraft, 'classId' | 'customClass'>>) => void
  onNext: () => void
  onBack: () => void
}) {
  const [classes, setClasses] = useState<ClassRow[]>([])
  const [page, setPage] = useState(0)
  const [rightTab, setRightTab] = useState<'progressao' | 'habilidades' | 'trilhas'>('progressao')
  const [extras, setExtras] = useState<{ progression: ClassProgression[]; powers: ClassPower[]; tracks: ClassTrack[]; tiers: ClassTrackTier[] } | null>(null)
  const paperStyle = { backgroundImage: `url(${papelTextura})` }

  useEffect(() => {
    getClasses().then(setClasses)
  }, [])

  const isCustom = draft.classId === null && draft.customClass !== null
  const selected = classes.find((c) => c.id === draft.classId)
  const selectedName = isCustom ? (draft.customClass?.name || '[Sua Classe]') : selected?.name

  useEffect(() => {
    if (!draft.classId) {
      setExtras(null)
      return
    }
    getClassExtras(draft.classId).then(setExtras)
  }, [draft.classId])

  function selectClass(c: ClassRow) {
    onChange({ classId: c.id, customClass: null })
  }

  function startCustom() {
    onChange({ classId: null, customClass: emptyCustomClass })
  }

  function updateCustom(patch: Partial<CustomClass>) {
    onChange({ classId: null, customClass: { ...(draft.customClass ?? emptyCustomClass), ...patch } })
  }

  const canProceed = Boolean(draft.classId || (draft.customClass && draft.customClass.name))

  const pageCount = Math.ceil((classes.length + 1) / PAGE_SIZE)
  const pageItems: Array<ClassRow | 'custom'> = [...classes, 'custom' as const].slice(page * PAGE_SIZE, page * PAGE_SIZE + PAGE_SIZE)

  return (
    <div className="creation-spread">
      <div className="creation-paper-slot">
        <div className="creation-paper-shadow" style={paperStyle} />
        <div className="creation-paper creation-paper-tilt-l" style={paperStyle}>
          <CreationLetterhead docNumber={draft.docNumber} />

          <div className="creation-section-title">Classe selecionada: <span className="creation-selected-name">{selectedName || 'nenhuma'}</span></div>

          <div className="creation-stencil">Sua classe indica o treinamento que você deseja receber na Ordem para enfrentar os perigos do Outro Lado.</div>

          <p>Essa será sua característica mais importante, pois define o que você faz e qual é o seu papel no grupo de investigadores.</p>
          <p>Perícias concedidas serão adicionadas automaticamente. Perícias opcionais podem ser adicionadas ao agente após sua criação.</p>

          <div className="class-picker">
            <nav className="class-tabs">
              {pageItems.map((item) =>
                item === 'custom' ? (
                  <button key="custom" type="button" className={`class-tab${isCustom ? ' active' : ''}`} onClick={startCustom}>
                    Sua Classe
                  </button>
                ) : (
                  <button key={item.id} type="button" className={`class-tab${draft.classId === item.id ? ' active' : ''}`} onClick={() => selectClass(item)}>
                    {item.name.toUpperCase()}
                  </button>
                )
              )}
              {pageCount > 1 && (
                <button type="button" className="class-tabs-more" onClick={() => setPage((p) => (p + 1) % pageCount)} aria-label="Ver mais classes">
                  ›
                </button>
              )}
            </nav>

            <div className="class-content" style={paperStyle}>
              {isCustom ? (
                <>
                  <label className="creation-field-block">
                    Nome
                    <input value={draft.customClass?.name ?? ''} onChange={(e) => updateCustom({ name: e.target.value })} placeholder="Nome da Classe." />
                  </label>
                  <label className="creation-field-block">
                    Descrição
                    <textarea value={draft.customClass?.description ?? ''} onChange={(e) => updateCustom({ description: e.target.value })} placeholder="Descrição aqui." />
                  </label>

                  <div className="creation-section-title">Características</div>

                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Pontos de Vida Iniciais</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.pvInitial ?? ''} onChange={(e) => updateCustom({ pvInitial: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo nível de exposição</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.pvPerNex ?? ''} onChange={(e) => updateCustom({ pvPerNex: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                  </div>
                  <div className="class-divider" />
                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Pontos de Esforço Iniciais</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.peInitial ?? ''} onChange={(e) => updateCustom({ peInitial: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo nível de exposição</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.pePerNex ?? ''} onChange={(e) => updateCustom({ pePerNex: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                  </div>
                  <div className="class-divider" />
                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Sanidade Inicial</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.sanityInitial ?? ''} onChange={(e) => updateCustom({ sanityInitial: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo nível de exposição</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.sanityPerNex ?? ''} onChange={(e) => updateCustom({ sanityPerNex: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                  </div>
                  <div className="class-divider" />
                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Pontos de Determinação Iniciais</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.pdInitial ?? ''} onChange={(e) => updateCustom({ pdInitial: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo nível de exposição</span>
                      <input type="number" className="class-stat-input" value={draft.customClass?.pdPerNex ?? ''} onChange={(e) => updateCustom({ pdPerNex: e.target.value ? Number(e.target.value) : null })} />
                    </div>
                  </div>
                  <div className="class-divider" />

                  <span className="class-stat-label">Perícias Treinadas</span>
                  <textarea className="class-text-input" value={draft.customClass?.trainedSkillsText ?? ''} onChange={(e) => updateCustom({ trainedSkillsText: e.target.value })} placeholder="Escreva aqui." />
                  <div className="class-divider" />
                  <span className="class-stat-label">Proficiências</span>
                  <textarea className="class-text-input" value={draft.customClass?.proficienciesText ?? ''} onChange={(e) => updateCustom({ proficienciesText: e.target.value })} placeholder="Escreva aqui." />
                </>
              ) : selected ? (
                <>
                  <p>{selected.description}</p>

                  <div className="creation-section-title">Características</div>

                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Pontos de<br />Vida Iniciais</span>
                      <span className="creation-rule-title">{selected.pv_initial}{selected.pv_initial_attr ? `+${ATTR_NAME[selected.pv_initial_attr] ?? selected.pv_initial_attr.toUpperCase()}` : ''}</span>
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo<br />nível de exposição</span>
                      <span className="creation-rule-title">{selected.pv_per_nex}PV{selected.pv_per_nex_attr ? `(+${ATTR_ABBR[selected.pv_per_nex_attr] ?? selected.pv_per_nex_attr.toUpperCase()})` : ''}</span>
                    </div>
                  </div>
                  <div className="class-divider" />

                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Pontos de<br />Esforço Iniciais</span>
                      <span className="creation-rule-title">{selected.pe_initial}{selected.pe_initial_attr ? `+${ATTR_NAME[selected.pe_initial_attr] ?? selected.pe_initial_attr.toUpperCase()}` : ''}</span>
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo<br />nível de exposição</span>
                      <span className="creation-rule-title">{selected.pe_per_nex}PE{selected.pe_per_nex_attr ? `(+${ATTR_ABBR[selected.pe_per_nex_attr] ?? selected.pe_per_nex_attr.toUpperCase()})` : ''}</span>
                    </div>
                  </div>
                  <div className="class-divider" />

                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Sanidade<br />Inicial</span>
                      <span className="creation-rule-title">{selected.sanity_initial}</span>
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo<br />nível de exposição</span>
                      <span className="creation-rule-title">{selected.sanity_per_nex}SAN</span>
                    </div>
                  </div>
                  <div className="class-divider" />

                  <div className="class-stat-row">
                    <div className="class-stat-col">
                      <span className="class-stat-label">Pontos de<br />Determinação Iniciais</span>
                      <span className="creation-rule-title">{selected.pd_initial}{selected.pd_initial_attr ? `+${ATTR_NAME[selected.pd_initial_attr] ?? selected.pd_initial_attr.toUpperCase()}` : ''}</span>
                    </div>
                    <div className="class-stat-col">
                      <span className="class-stat-label">A cada novo<br />nível de exposição</span>
                      <span className="creation-rule-title">{selected.pd_per_nex}{selected.pd_per_nex_attr ? `+${ATTR_NAME[selected.pd_per_nex_attr] ?? selected.pd_per_nex_attr.toUpperCase()}` : ''}</span>
                    </div>
                  </div>
                  <div className="class-divider" />

                  <span className="class-stat-label">Perícias Treinadas</span>
                  <div className="class-text-box">{selected.trained_skills_text}</div>
                  <div className="class-divider" />
                  <span className="class-stat-label">Proficiências</span>
                  <div className="class-text-box">{selected.proficiencies_text}</div>
                </>
              ) : (
                <p>Selecione uma classe.</p>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="creation-paper-slot">
        <div className="creation-paper-shadow" style={paperStyle} />
        <div className="creation-paper creation-paper-tilt-r" style={paperStyle}>
          <div className="class-right-tabs">
            <button type="button" className={`class-right-tab${rightTab === 'progressao' ? ' active' : ''}`} onClick={() => setRightTab('progressao')}>Progressão</button>
            <button type="button" className={`class-right-tab${rightTab === 'habilidades' ? ' active' : ''}`} onClick={() => setRightTab('habilidades')}>Habilidades</button>
            <button type="button" className={`class-right-tab${rightTab === 'trilhas' ? ' active' : ''}`} onClick={() => setRightTab('trilhas')}>Trilhas</button>
          </div>

          {!extras ? (
            <p>Selecione uma classe pra ver progressão, habilidades e trilhas.</p>
          ) : rightTab === 'progressao' ? (
            extras.progression.length === 0 ? <p>Sem progressão cadastrada ainda pra essa classe.</p> : (
              <div className="class-progress-table">
                <div className="class-progress-header">
                  <span className="class-progress-nex">NEX</span>
                  <span className="class-progress-text">Progressão: {selected?.name}</span>
                  <span className="class-progress-pe">PE</span>
                </div>
                {extras.progression.map((p) => (
                  <div className="class-progress-row" key={p.nex_percent}>
                    <span className="class-progress-nex">{p.nex_percent}%</span>
                    <span className="class-progress-text">{p.gain_text}</span>
                    <span className="class-progress-pe">{p.pe_sequential}</span>
                  </div>
                ))}
              </div>
            )
          ) : rightTab === 'habilidades' ? (
            <div className="class-power-list">
              {extras.powers.length === 0 ? <p>Sem poderes cadastrados ainda pra essa classe.</p> : extras.powers.map((p) => (
                <div className="class-power-item" key={p.id}>
                  <span className="creation-rule-title">{p.name}</span>
                  <p>{p.description}{p.prerequisites ? <span className="creation-footnote"> (Pré-requisito: {p.prerequisites})</span> : ''}</p>
                </div>
              ))}
            </div>
          ) : (
            <div className="class-track-list">
              {extras.tracks.length === 0 ? <p>Sem trilhas cadastradas ainda pra essa classe.</p> : extras.tracks.map((t) => (
                <div className="class-track-item" key={t.id}>
                  <div className="creation-section-title">{t.name}</div>
                  {t.description && <p>{t.description}</p>}
                  {extras.tiers.filter((tier) => tier.track_id === t.id).map((tier) => (
                    <p key={tier.id}><strong className="class-tier-label">NEX {tier.nex_percent}% — {tier.name}:</strong> {tier.description}</p>
                  ))}
                </div>
              ))}
            </div>
          )}
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
