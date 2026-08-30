export type DamageRollDetail =
  | { label: string; rolls: number[]; modifier: number; total: number; manualFormula?: undefined }
  | { label: string; manualFormula: string; rolls?: undefined; modifier?: undefined; total?: undefined }

export type RollResultData = {
  label: string
  rolls: number[]
  kept: number
  bonus: number
  damage?: DamageRollDetail[]
}

export default function RollResult({ result, onClose }: { result: RollResultData; onClose: () => void }) {
  return (
    <div role="status">
      <button type="button" onClick={onClose}>x</button>
      <p>{result.label}</p>
      <p>Total: {result.kept + result.bonus}</p>
      <p>d20 mantido: {result.kept} (rolados: {result.rolls.join(', ')}) + bônus {result.bonus}</p>
      {result.damage?.map((d, i) => (
        <p key={i}>
          {d.manualFormula !== undefined
            ? `${d.label}: não foi possível rolar automaticamente (fórmula "${d.manualFormula}") — role manualmente.`
            : `${d.label}: ${d.total} (rolados: ${d.rolls.join(', ')}${d.modifier ? `, modificador ${d.modifier}` : ''})`}
        </p>
      ))}
    </div>
  )
}
