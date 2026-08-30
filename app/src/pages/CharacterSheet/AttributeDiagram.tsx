import type { Attributes, AttributeKey } from '../../lib/rules'
import attributesDiagram from '../../assets/attributes-diagram.png'

const ATTRS: { key: AttributeKey; abbr: string; top: string; left: string }[] = [
  { key: 'agilidade', abbr: 'AGI', top: '15%', left: '50.5%' },
  { key: 'forca', abbr: 'FOR', top: '34%', left: '20%' },
  { key: 'intelecto', abbr: 'INT', top: '34%', left: '81%' },
  { key: 'presenca', abbr: 'PRE', top: '66%', left: '28%' },
  { key: 'vigor', abbr: 'VIG', top: '66%', left: '73%' },
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
    <div className="attr-diagram-wrap">
      <span className="hex-nex-badge">NEX {nexPercent}%</span>
      <div className="attr-diagram">
        <img src={attributesDiagram} alt="Atributos" />
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
    </div>
  )
}
