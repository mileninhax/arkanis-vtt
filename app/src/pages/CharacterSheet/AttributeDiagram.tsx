import type { Attributes, AttributeKey } from '../../lib/rules'
import attributesDiagram from '../../assets/attributes-diagram.png'

const ATTRS: { key: AttributeKey; abbr: string; top: string; left: string }[] = [
  { key: 'agilidade', abbr: 'AGI', top: '16%', left: '50.2%' },
  { key: 'forca', abbr: 'FOR', top: '38%', left: '18.8%' },
  { key: 'intelecto', abbr: 'INT', top: '38%', left: '81.6%' },
  { key: 'presenca', abbr: 'PRE', top: '77%', left: '27%' },
  { key: 'vigor', abbr: 'VIG', top: '77%', left: '72.4%' },
]

export default function AttributeDiagram({
  attributes,
  nexPercent,
  onRoll,
}: {
  attributes: Attributes
  nexPercent: number
  onRoll: (key: AttributeKey, abbr: string) => void
}) {
  return (
    <div className="attr-diagram">
      <img src={attributesDiagram} alt="Atributos" />
      <div className="attr-value-badge attr-nex-badge">{nexPercent}%</div>
      {ATTRS.map(({ key, abbr, top, left }) => (
        <button
          key={key}
          type="button"
          className="attr-value-badge"
          style={{ top, left }}
          onClick={() => onRoll(key, abbr)}
          aria-label={`Rolar ${abbr}`}
        >
          {attributes[key]}
        </button>
      ))}
    </div>
  )
}
