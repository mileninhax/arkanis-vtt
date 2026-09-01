import { useState } from 'react'
import conditionsIcon from '../../assets/condicoes/conditions.svg'
import enemyEffectsIcon from '../../assets/condicoes/enemy-effects.svg'
import ritualsIcon from '../../assets/condicoes/rituals.svg'
import skillsIcon from '../../assets/condicoes/skills.svg'
import extraIcon from '../../assets/condicoes/extra.svg'

type CategoryKey = 'conditions' | 'enemy-effects' | 'rituals' | 'skills' | 'extra'

const CATEGORIES: { key: CategoryKey; label: string; icon: string }[] = [
  { key: 'conditions', label: 'Condições', icon: conditionsIcon },
  { key: 'enemy-effects', label: 'Efeitos Inimigos', icon: enemyEffectsIcon },
  { key: 'rituals', label: 'Rituais', icon: ritualsIcon },
  { key: 'skills', label: 'Habilidades', icon: skillsIcon },
  { key: 'extra', label: 'Extras', icon: extraIcon },
]

export default function ConditionsModal({
  onClose,
  onAddCondition,
}: {
  onClose: () => void
  onAddCondition: (name: string) => void
}) {
  const [active, setActive] = useState<CategoryKey | 'custom'>('conditions')
  const [customName, setCustomName] = useState('')
  const activeCategory = CATEGORIES.find((c) => c.key === active)

  function submitCustom() {
    if (!customName.trim()) return
    onAddCondition(customName.trim())
    setCustomName('')
  }

  return (
    <div className="conditions-modal-backdrop" onClick={onClose}>
      <div className="conditions-modal" onClick={(e) => e.stopPropagation()}>
        <div className="conditions-modal-texture" />

        <nav className="conditions-modal-sidebar">
          {CATEGORIES.map((cat) => (
            <button
              key={cat.key}
              type="button"
              className={`conditions-modal-nav-btn${active === cat.key ? ' active' : ''}`}
              onClick={() => setActive(cat.key)}
            >
              <img src={cat.icon} alt="" />
              <span>{cat.label}</span>
            </button>
          ))}

          <div className="conditions-modal-sidebar-divider" />

          <button
            type="button"
            className={`conditions-modal-nav-btn conditions-modal-custom${active === 'custom' ? ' active' : ''}`}
            onClick={() => setActive('custom')}
          >
            <span>Personalizado</span>
          </button>
        </nav>

        <div className="conditions-modal-content">
          <h3>{active === 'custom' ? 'Personalizado' : activeCategory?.label}</h3>

          {active === 'custom' ? (
            <div className="conditions-modal-custom-form">
              <input
                autoFocus
                value={customName}
                onChange={(e) => setCustomName(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && submitCustom()}
                placeholder="Nome da condição"
              />
              <button type="button" onClick={submitCustom}>Adicionar</button>
            </div>
          ) : (
            <p className="conditions-modal-placeholder">Em breve.</p>
          )}
        </div>

        <button type="button" className="conditions-modal-close" onClick={onClose} aria-label="Fechar">×</button>
      </div>
    </div>
  )
}
