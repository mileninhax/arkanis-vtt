import { useEffect, useState } from 'react'
import { getClassExtras, getClasses, type ClassPower, type ClassProgression, type ClassRow, type ClassTrack, type ClassTrackTier } from '../../lib/content'
import type { CharacterDraft, CustomClass } from './types'

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
  const [rightTab, setRightTab] = useState<'progressao' | 'habilidades' | 'trilhas'>('progressao')
  const [extras, setExtras] = useState<{ progression: ClassProgression[]; powers: ClassPower[]; tracks: ClassTrack[]; tiers: ClassTrackTier[] } | null>(null)

  useEffect(() => {
    getClasses().then(setClasses)
  }, [])

  const isCustom = draft.classId === null && draft.customClass !== null
  const selected = classes.find((c) => c.id === draft.classId)

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

  return (
    <div>
      <section>
        <h2>CLASSE SELECIONADA: {isCustom ? (draft.customClass?.name || '[Sua Classe]') : (selected?.name ?? '')}</h2>
        <p><strong>Sua classe indica o treinamento que você deseja receber na Ordem para enfrentar os perigos do Outro Lado.</strong></p>
        <p>Essa será sua característica mais importante, pois define o que você faz e qual é o seu papel no grupo de investigadores.</p>

        <nav>
          {classes.map((c) => (
            <button key={c.id} type="button" onClick={() => selectClass(c)} disabled={draft.classId === c.id}>{c.name}</button>
          ))}
          <button type="button" onClick={startCustom} disabled={isCustom}>Sua Classe</button>
        </nav>

        {isCustom ? (
          <div>
            <label>Nome. <input value={draft.customClass?.name ?? ''} onChange={(e) => updateCustom({ name: e.target.value })} /></label>
            <label>Descrição aqui. <textarea value={draft.customClass?.description ?? ''} onChange={(e) => updateCustom({ description: e.target.value })} /></label>

            <fieldset>
              <legend>CARACTERÍSTICAS</legend>
              <label>Pontos de Vida Iniciais (+VIGOR) <input type="number" value={draft.customClass?.pvInitial ?? ''} onChange={(e) => updateCustom({ pvInitial: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>A cada novo nível de exposição (PV, +VIG) <input type="number" value={draft.customClass?.pvPerNex ?? ''} onChange={(e) => updateCustom({ pvPerNex: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>Pontos de Esforço Iniciais (+PRESENÇA) <input type="number" value={draft.customClass?.peInitial ?? ''} onChange={(e) => updateCustom({ peInitial: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>A cada novo nível de exposição (PE, +PRE) <input type="number" value={draft.customClass?.pePerNex ?? ''} onChange={(e) => updateCustom({ pePerNex: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>Sanidade Inicial <input type="number" value={draft.customClass?.sanityInitial ?? ''} onChange={(e) => updateCustom({ sanityInitial: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>A cada novo nível de exposição (SAN) <input type="number" value={draft.customClass?.sanityPerNex ?? ''} onChange={(e) => updateCustom({ sanityPerNex: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>Pontos de Determinação Iniciais (+PRESENÇA) <input type="number" value={draft.customClass?.pdInitial ?? ''} onChange={(e) => updateCustom({ pdInitial: e.target.value ? Number(e.target.value) : null })} /></label>
              <label>A cada novo nível de exposição (+PRESENÇA) <input type="number" value={draft.customClass?.pdPerNex ?? ''} onChange={(e) => updateCustom({ pdPerNex: e.target.value ? Number(e.target.value) : null })} /></label>
            </fieldset>

            <label>Perícias Treinadas <textarea placeholder="Escreva aqui." value={draft.customClass?.trainedSkillsText ?? ''} onChange={(e) => updateCustom({ trainedSkillsText: e.target.value })} /></label>
            <label>Proficiências <textarea placeholder="Escreva aqui." value={draft.customClass?.proficienciesText ?? ''} onChange={(e) => updateCustom({ proficienciesText: e.target.value })} /></label>
          </div>
        ) : selected ? (
          <div>
            <p>{selected.description}</p>
            <fieldset>
              <legend>CARACTERÍSTICAS</legend>
              <p>Pontos de Vida: {selected.pv_initial ?? '—'} {selected.pv_initial_attr ? `+${selected.pv_initial_attr}` : ''} (+{selected.pv_per_nex ?? '—'} por NEX)</p>
              <p>Pontos de Esforço: {selected.pe_initial ?? '—'} {selected.pe_initial_attr ? `+${selected.pe_initial_attr}` : ''} (+{selected.pe_per_nex ?? '—'} por NEX)</p>
              <p>Sanidade: {selected.sanity_initial ?? '—'} (+{selected.sanity_per_nex ?? '—'} por NEX)</p>
              <p>Pontos de Determinação: {selected.pd_initial ?? '—'} {selected.pd_initial_attr ? `+${selected.pd_initial_attr}` : ''} (+{selected.pd_per_nex ?? '—'} por NEX)</p>
            </fieldset>
            <p><strong>Perícias Treinadas:</strong> {selected.trained_skills_text}</p>
            <p><strong>Proficiências:</strong> {selected.proficiencies_text}</p>
          </div>
        ) : (
          <p>Selecione uma classe.</p>
        )}
      </section>

      <section>
        <nav>
          <button type="button" onClick={() => setRightTab('progressao')} disabled={rightTab === 'progressao'}>Progressão</button>
          <button type="button" onClick={() => setRightTab('habilidades')} disabled={rightTab === 'habilidades'}>Habilidades</button>
          <button type="button" onClick={() => setRightTab('trilhas')} disabled={rightTab === 'trilhas'}>Trilhas</button>
        </nav>

        {!extras ? (
          <p>Selecione uma classe pra ver progressão, habilidades e trilhas.</p>
        ) : rightTab === 'progressao' ? (
          extras.progression.length === 0 ? <p>Sem progressão cadastrada ainda pra essa classe.</p> : (
            <table>
              <thead><tr><th>NEX</th><th>Progressão</th><th>PE</th></tr></thead>
              <tbody>
                {extras.progression.map((p) => (
                  <tr key={p.nex_percent}><td>{p.nex_percent}%</td><td>{p.gain_text}</td><td>{p.pe_sequential}</td></tr>
                ))}
              </tbody>
            </table>
          )
        ) : rightTab === 'habilidades' ? (
          extras.powers.length === 0 ? <p>Sem poderes cadastrados ainda pra essa classe.</p> : (
            <ul>
              {extras.powers.map((p) => (
                <li key={p.id}><strong>{p.name}</strong>: {p.description}{p.prerequisites ? ` (Pré-requisito: ${p.prerequisites})` : ''}</li>
              ))}
            </ul>
          )
        ) : extras.tracks.length === 0 ? <p>Sem trilhas cadastradas ainda pra essa classe.</p> : (
          <div>
            {extras.tracks.map((t) => (
              <div key={t.id}>
                <h3>{t.name}</h3>
                <p>{t.description}</p>
                <ul>
                  {extras.tiers.filter((tier) => tier.track_id === t.id).map((tier) => (
                    <li key={tier.id}>NEX {tier.nex_percent}% — <strong>{tier.name}</strong>: {tier.description}</li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        )}
      </section>

      <button type="button" onClick={onBack}>← Voltar</button>
      <button type="button" onClick={onNext} disabled={!canProceed}>Avançar →</button>
    </div>
  )
}
