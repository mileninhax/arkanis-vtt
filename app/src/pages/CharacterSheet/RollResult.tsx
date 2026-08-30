export type DamageRollDetail =
  | { label: string; rolls: number[]; modifier: number; total: number; manualFormula?: undefined }
  | { label: string; manualFormula: string; rolls?: undefined; modifier?: undefined; total?: undefined }

export type RollContextModifier = { kind: 'modificacao' | 'maldicao'; name: string; effect: string; elemento: string | null; origem: 'Arma' | 'Munição' }

export type RollResultData = {
  label: string
  rolls: number[]
  kept: number
  bonus: number
  damage?: DamageRollDetail[]
  municao?: string | null
  modificadores?: RollContextModifier[]
}

export default function RollResult({ result, onClose }: { result: RollResultData; onClose: () => void }) {
  return (
    <div role="status">
      <button type="button" onClick={onClose}>x</button>
      <p>{result.label}</p>
      {result.municao && <p>Munição: {result.municao}</p>}
      <p>Total: {result.kept + result.bonus}</p>
      <p>d20 mantido: {result.kept} (rolados: {result.rolls.join(', ')}) + bônus {result.bonus}</p>
      {result.damage?.map((d, i) => (
        <p key={i}>
          {d.manualFormula !== undefined
            ? `${d.label}: não foi possível rolar automaticamente (fórmula "${d.manualFormula}") — role manualmente.`
            : `${d.label}: ${d.total} (rolados: ${d.rolls.join(', ')}${d.modifier ? `, modificador ${d.modifier}` : ''})`}
        </p>
      ))}
      {result.modificadores && result.modificadores.length > 0 && (
        <div>
          <p>Modificadores ativos (aplique manualmente o que não foi calculado acima):</p>
          <ul>
            {result.modificadores.map((m, i) => (
              <li key={i}>
                [{m.origem} · {m.kind === 'modificacao' ? 'Modificação' : 'Maldição'}] <strong>{m.name}</strong>{m.elemento ? ` (${m.elemento})` : ''}: {m.effect}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}
