import type { CharacterDraft, OptionalRules } from './types'

const NEX_OPTIONS = [...Array.from({ length: 19 }, (_, i) => (i + 1) * 5), 99]

const RULES: { key: keyof OptionalRules; label: string }[] = [
  { key: 'nex_experiencia', label: 'NEX & Experiência' },
  { key: 'contagem_municao', label: 'Contagem de Munição' },
  { key: 'sem_sanidade', label: 'Jogando sem Sanidade' },
  { key: 'evolucao_patente', label: 'Evolução por Patente' },
  { key: 'ferimentos_debilitantes', label: 'Ferimentos Debilitantes' },
]

export default function Step5Auth({
  draft,
  onChange,
  onBack,
  onFinish,
  finishing,
}: {
  draft: CharacterDraft
  onChange: (patch: Partial<CharacterDraft>) => void
  onBack: () => void
  onFinish: () => void
  finishing: boolean
}) {
  const canFinish = Boolean(draft.name.trim())

  function toggleRule(key: keyof OptionalRules) {
    onChange({ optionalRules: { ...draft.optionalRules, [key]: !draft.optionalRules[key] } })
  }

  return (
    <div>
      <section>
        <h2>REGRAS OPCIONAIS</h2>
        {RULES.map(({ key, label }) => (
          <label key={key}>
            <input type="checkbox" checked={draft.optionalRules[key]} onChange={() => toggleRule(key)} />
            {label}
          </label>
        ))}
      </section>

      <section>
        <label>
          Nome:
          <input value={draft.name} onChange={(e) => onChange({ name: e.target.value })} />
        </label>

        {draft.optionalRules.nex_experiencia ? (
          <>
            <label>
              NEX:
              <input type="number" value={draft.nexPercent} onChange={(e) => onChange({ nexPercent: Number(e.target.value) })} />
              %
            </label>
            <label>
              EXPERIÊNCIA:
              <select value={draft.experience ?? 0} onChange={(e) => onChange({ experience: Number(e.target.value) })}>
                {Array.from({ length: 21 }, (_, i) => i).map((n) => <option key={n} value={n}>{n}</option>)}
              </select>
            </label>
          </>
        ) : (
          <label>
            NEX:
            <select value={draft.nexPercent} onChange={(e) => onChange({ nexPercent: Number(e.target.value) })}>
              <option value={0}>Nenhum</option>
              {NEX_OPTIONS.map((n) => <option key={n} value={n}>{n}%</option>)}
            </select>
          </label>
        )}
      </section>

      <button type="button" onClick={onBack}>← Voltar</button>
      <button type="button" onClick={onFinish} disabled={!canFinish || finishing}>
        {finishing ? 'Assinando…' : 'Assine aqui para finalizar'}
      </button>
    </div>
  )
}
