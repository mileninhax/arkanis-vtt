import type { Attributes, CharacterDraft } from './types'

const LABELS: { key: keyof Attributes; abbr: string; name: string; description: string }[] = [
  { key: 'forca', abbr: 'FOR', name: 'Força', description: 'Potência muscular e habilidade atlética.' },
  { key: 'agilidade', abbr: 'AGI', name: 'Agilidade', description: 'Coordenação motora, velocidade de reação e destreza manual.' },
  { key: 'intelecto', abbr: 'INT', name: 'Intelecto', description: 'Raciocínio, memória e educação geral.' },
  { key: 'vigor', abbr: 'VIG', name: 'Vigor', description: 'Saúde e resistência física.' },
  { key: 'presenca', abbr: 'PRE', name: 'Presença', description: 'Sentidos, força de vontade, habilidades sociais; concede Pontos de Esforço (PE) adicionais.' },
]

function computePool(attributes: Attributes) {
  const values = Object.values(attributes)
  const zeros = values.filter((v) => v === 0).length
  const spent = values.reduce((sum, v) => sum + Math.max(0, v - 1), 0)
  const pool = 4 + zeros
  return { pool, spent, remaining: pool - spent }
}

export default function Step2Attributes({
  draft,
  onChange,
  onNext,
  onBack,
}: {
  draft: CharacterDraft
  onChange: (attributes: Attributes) => void
  onNext: () => void
  onBack: () => void
}) {
  const { attributes } = draft
  const { remaining } = computePool(attributes)
  const isValid = remaining === 0

  function adjust(key: keyof Attributes, delta: number) {
    const current = attributes[key]
    const next = current + delta
    if (next < 0 || next > 3) return

    const projected = { ...attributes, [key]: next }
    const { remaining: projectedRemaining } = computePool(projected)
    if (delta > 0 && projectedRemaining < 0) return

    onChange(projected)
  }

  return (
    <div>
      <section>
        <h2>Atributos</h2>
        <p>Todos os seus atributos começam em 1 e você recebe 4 pontos para distribuir entre eles como quiser.</p>
        <p>Você também pode reduzir um atributo para 0 para receber 1 ponto adicional. O valor máximo inicial que você pode ter em cada atributo é 3.</p>
        <p>Pontos restantes: {remaining}</p>

        <ul>
          {LABELS.map(({ key, abbr, name }) => (
            <li key={key}>
              <span>{abbr} — {name}</span>
              <button type="button" onClick={() => adjust(key, -1)} disabled={attributes[key] <= 0}>-</button>
              <span>{attributes[key]}</span>
              <button type="button" onClick={() => adjust(key, 1)} disabled={attributes[key] >= 3}>+</button>
            </li>
          ))}
        </ul>
      </section>

      <section>
        <h2>Sobre Atributos</h2>
        <ol>
          {LABELS.map(({ abbr, name, description }) => (
            <li key={abbr}>
              <strong>{name} ({abbr})</strong>
              <p>{description}</p>
            </li>
          ))}
        </ol>
      </section>

      <button type="button" onClick={onBack}>← Voltar</button>
      <button type="button" onClick={onNext} disabled={!isValid}>Avançar →</button>
    </div>
  )
}
