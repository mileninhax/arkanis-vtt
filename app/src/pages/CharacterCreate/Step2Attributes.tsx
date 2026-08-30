import CreationLetterhead from './CreationLetterhead'
import type { Attributes, CharacterDraft } from './types'
import stepArrow from '../../assets/criacao/step-arrow.svg'
import papelTextura from '../../assets/criacao/papel-textura.png'
import forcaIcon from '../../assets/criacao/forca-icon.png'
import agilidadeIcon from '../../assets/criacao/agilidade-icon.png'
import intelectoIcon from '../../assets/criacao/intelecto-icon.png'
import vigorIcon from '../../assets/criacao/vigor-icon.png'
import presencaIcon from '../../assets/criacao/presenca-icon.png'

const NODES: { key: keyof Attributes; abbr: string; name: string; icon: string; top: string; left: string; labelSide: 'left' | 'right' | 'top' }[] = [
  { key: 'agilidade', abbr: 'AGI', name: 'agilidade', icon: agilidadeIcon, top: '10%', left: '50%', labelSide: 'top' },
  { key: 'intelecto', abbr: 'INT', name: 'intelecto', icon: intelectoIcon, top: '37.6%', left: '88%', labelSide: 'right' },
  { key: 'vigor', abbr: 'VIG', name: 'vigor', icon: vigorIcon, top: '82.4%', left: '73.5%', labelSide: 'right' },
  { key: 'presenca', abbr: 'PRE', name: 'presença', icon: presencaIcon, top: '82.4%', left: '26.5%', labelSide: 'left' },
  { key: 'forca', abbr: 'FOR', name: 'força', icon: forcaIcon, top: '37.6%', left: '12%', labelSide: 'left' },
]

const ABOUT = [
  { abbr: 'FOR', name: 'Força', icon: forcaIcon, description: 'Determina sua potência muscular e habilidade atlética.' },
  { abbr: 'AGI', name: 'Agilidade', icon: agilidadeIcon, description: 'Define sua coordenação motora, velocidade de reação e destreza manual.' },
  { abbr: 'INT', name: 'Intelecto', icon: intelectoIcon, description: 'Mede seu raciocínio, memória e educação geral.' },
  { abbr: 'VIG', name: 'Vigor', icon: vigorIcon, description: 'Determina sua saúde e resistência física.' },
  { abbr: 'PRE', name: 'Presença', icon: presencaIcon, description: 'Define seus sentidos, força de vontade, habilidades sociais e concede pontos de esforço (PE) adicionais.' },
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
  const paperStyle = { backgroundImage: `url(${papelTextura})` }

  function setValue(key: keyof Attributes, raw: number) {
    if (Number.isNaN(raw)) return
    const next = Math.max(0, Math.min(3, Math.round(raw)))
    onChange({ ...attributes, [key]: next })
  }

  return (
    <div className="creation-spread">
      <div className="creation-paper-slot">
        <div className="creation-paper-shadow" style={paperStyle} />
        <div className="creation-paper creation-paper-tilt-l" style={paperStyle}>
          <CreationLetterhead docNumber={draft.docNumber} />

          <div className="creation-section-title">Atributos</div>

          <div className="attr-radar">
            <svg className="attr-radar-grid" viewBox="0 0 300 300">
              <polygon points="150,30 264.12,112.92 220.56,247.08 79.44,247.08 35.88,112.92" />
              <polygon points="150,60 235.59,122.19 202.92,222.81 97.08,222.81 64.41,122.19" />
              <polygon points="150,90 207.06,131.46 185.28,198.54 114.72,198.54 92.94,131.46" />
              <polygon points="150,120 178.53,140.73 167.64,174.27 132.36,174.27 121.47,140.73" />
              <line x1="150" y1="150" x2="150" y2="30" />
              <line x1="150" y1="150" x2="264.12" y2="112.92" />
              <line x1="150" y1="150" x2="220.56" y2="247.08" />
              <line x1="150" y1="150" x2="79.44" y2="247.08" />
              <line x1="150" y1="150" x2="35.88" y2="112.92" />
            </svg>

            {NODES.map((node) => (
              <div key={node.key} className={`attr-node attr-node-${node.labelSide}`} style={{ top: node.top, left: node.left }}>
                <div className="attr-node-label">
                  <span className="attr-node-abbr">{node.abbr}</span>
                  <span className="attr-node-name">{node.name}</span>
                </div>
                <div className="attr-node-circle" style={{ '--icon': `url(${node.icon})` } as React.CSSProperties}>
                  <input
                    type="number"
                    min={0}
                    max={3}
                    value={attributes[node.key]}
                    onChange={(e) => setValue(node.key, Number(e.target.value))}
                  />
                </div>
              </div>
            ))}
          </div>

          <p>Todos os seus atributos começam em 1 e você recebe 4 pontos para distribuir entre eles como quiser.</p>
          <p>Você também pode reduzir um atributo para 0 para receber 1 ponto adicional. O valor máximo inicial que você pode ter em cada atributo é 3.</p>
          <p className="creation-footnote">Pontos restantes: {remaining}</p>
        </div>
      </div>

      <div className="creation-paper-slot">
        <div className="creation-paper-shadow" style={paperStyle} />
        <div className="creation-paper creation-paper-tilt-r" style={paperStyle}>
          <CreationLetterhead docNumber={draft.docNumber} />

          <div className="creation-section-title">Sobre Atributos</div>

          <ul className="attr-about-list">
            {ABOUT.map((a, i) => (
              <li key={a.abbr}>
                <img className="attr-about-icon" src={a.icon} alt="" />
                <div>
                  <span className="creation-rule-title"><span className="creation-rule-num">{i + 1}.</span> {a.name.toUpperCase()} ({a.abbr})</span>
                  <p>{a.description}</p>
                </div>
              </li>
            ))}
          </ul>
        </div>
      </div>

      <button type="button" className="creation-back-arrow" onClick={onBack} aria-label="Voltar">
        <img src={stepArrow} alt="" />
      </button>
      <button type="button" className="creation-next-arrow" onClick={onNext} disabled={!isValid} aria-label="Avançar">
        <img src={stepArrow} alt="" />
      </button>
    </div>
  )
}
