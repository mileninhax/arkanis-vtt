import type { Attributes, AttributeKey } from '../../lib/rules'

const ATTRS: { key: AttributeKey; abbr: string; cx: number; cy: number }[] = [
  { key: 'agilidade', abbr: 'AGI', cx: 120, cy: 44 },
  { key: 'forca', abbr: 'FOR', cx: 55, cy: 110 },
  { key: 'intelecto', abbr: 'INT', cx: 185, cy: 110 },
  { key: 'presenca', abbr: 'PRE', cx: 85, cy: 178 },
  { key: 'vigor', abbr: 'VIG', cx: 155, cy: 178 },
]

const HEX_R = 42

function hexPoints(cx: number, cy: number, r: number): string {
  return Array.from({ length: 6 }, (_, i) => {
    const angle = (Math.PI / 180) * (60 * i - 90)
    return `${(cx + r * Math.cos(angle)).toFixed(1)},${(cy + r * Math.sin(angle)).toFixed(1)}`
  }).join(' ')
}

export default function AttributeHexDiagram({
  attributes,
  nexPercent,
  onRoll,
}: {
  attributes: Attributes
  nexPercent: number
  onRoll: (key: AttributeKey, abbr: string) => void
}) {
  return (
    <div className="hex-diagram-wrap">
      <span className="hex-nex-badge">NEX {nexPercent}%</span>
      <svg viewBox="0 0 240 220" width="100%">
        <circle className="hex-center-circle" cx="120" cy="110" r="38" />
        <text className="hex-center-label" x="120" y="113">Atributos</text>
        {ATTRS.map(({ key, abbr, cx, cy }) => (
          <g key={key} className="hex-attr-group" onClick={() => onRoll(key, abbr)}>
            <polygon className="hex-attr-poly" points={hexPoints(cx, cy, HEX_R)} />
            <text className="hex-attr-value" x={cx} y={cy - 2}>{attributes[key]}</text>
            <text className="hex-attr-abbr" x={cx} y={cy + 16}>{abbr}</text>
          </g>
        ))}
      </svg>
    </div>
  )
}
