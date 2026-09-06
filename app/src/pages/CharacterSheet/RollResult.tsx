import { createPortal } from 'react-dom'
import cardBg from '../../assets/dice-roll/card-bg.png'
import d6Icon from '../../assets/dice-roll/d6-icon.png'
import d8Icon from '../../assets/dice-roll/d8-icon.png'
import d10Icon from '../../assets/dice-roll/d10-icon.png'
import d12Icon from '../../assets/dice-roll/d12-icon.png'
import d20Icon from '../../assets/dice-roll/d20-icon.png'

const DIE_ICON: Record<number, string> = { 6: d6Icon, 8: d8Icon, 10: d10Icon, 12: d12Icon, 20: d20Icon }
const DIE_COLOR: Record<number, string> = { 4: '#3b6fd6', 6: '#12786a', 8: '#8a721f', 10: '#d1571f', 12: '#249c3d', 20: '#7c4fe0' }

export type DamageRollDetail =
  | { label: string; rolls: number[]; modifier: number; total: number; manualFormula?: undefined }
  | { label: string; manualFormula: string; rolls?: undefined; modifier?: undefined; total?: undefined }

export type RollContextModifier = { kind: 'modificacao' | 'maldicao'; name: string; effect: string; elemento: string | null; origem: 'Arma' | 'Munição' }

export type RollResultData = {
  label: string
  rolls: number[]
  kept: number
  bonus: number
  characterName: string
  damage?: DamageRollDetail[]
  municao?: string | null
  modificadores?: RollContextModifier[]
}

function Die({ sides, value, discarded }: { sides: number; value: number; discarded?: boolean }) {
  const color = DIE_COLOR[sides] ?? '#fff'
  return (
    <div className={`roll-card-die${discarded ? ' discarded' : ''}`}>
      <span className="roll-card-die-value" style={{ color }}>{value}</span>
      {DIE_ICON[sides] ? (
        <img src={DIE_ICON[sides]} alt={`d${sides}`} className="roll-card-die-icon" />
      ) : (
        <span className="roll-card-die-fallback" style={{ borderColor: color }}>d{sides}</span>
      )}
    </div>
  )
}

export default function RollResult({ result, onClose }: { result: RollResultData; onClose: () => void }) {
  const total = result.kept + result.bonus

  const extraLines: string[] = []
  if (result.bonus) extraLines.push(`Bônus: ${result.bonus >= 0 ? '+' : ''}${result.bonus}`)
  if (result.municao) extraLines.push(`Munição: ${result.municao}`)
  result.damage?.forEach((d) => {
    extraLines.push(
      d.manualFormula !== undefined
        ? `${d.label}: role manualmente (${d.manualFormula})`
        : `${d.label}: ${d.total} (${d.rolls.join(', ')}${d.modifier ? `, ${d.modifier >= 0 ? '+' : ''}${d.modifier}` : ''})`,
    )
  })
  result.modificadores?.forEach((m) => {
    extraLines.push(`[${m.origem} · ${m.kind === 'modificacao' ? 'Modificação' : 'Maldição'}] ${m.name}${m.elemento ? ` (${m.elemento})` : ''}: ${m.effect}`)
  })

  return createPortal(
    <div className="roll-card-wrap">
      <div className="roll-card" style={{ backgroundImage: `url(${cardBg})` }}>
        <div className="roll-card-header">
          <span className="roll-card-title">{result.characterName}</span>
          <span className="roll-card-subtitle">{result.label}</span>
        </div>

        <div className="roll-card-total">{total}</div>

        <div className="roll-card-divider" />

        <div className="roll-card-dice">
          {result.rolls.map((v, i) => (
            <div key={i} className="roll-card-die-slot">
              <Die sides={20} value={v} discarded={v !== result.kept} />
              {i < result.rolls.length - 1 && <span className="roll-card-die-plus">+</span>}
            </div>
          ))}
        </div>

        {extraLines.length > 0 && (
          <div className="roll-card-extra">
            {extraLines.map((l, i) => <p key={i}>{l}</p>)}
          </div>
        )}
      </div>

      <button type="button" className="roll-card-close" onClick={onClose} aria-label="Fechar">×</button>
    </div>,
    document.body,
  )
}
