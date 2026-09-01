import { useEffect, useState } from 'react'
import { createPortal } from 'react-dom'
import { supabase } from '../../lib/supabase'
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

const EFFECTS_CATEGORY: Partial<Record<CategoryKey, string>> = {
  conditions: 'condicao',
  'enemy-effects': 'efeito_inimigo',
  skills: 'habilidade',
  extra: 'extra',
}

type CatalogItem = { id: string; name: string; description: string }

export default function ConditionsModal({
  onClose,
  onAddCondition,
}: {
  onClose: () => void
  onAddCondition: (name: string) => void
}) {
  const [active, setActive] = useState<CategoryKey | 'custom'>('conditions')
  const [customName, setCustomName] = useState('')
  const [items, setItems] = useState<CatalogItem[]>([])
  const [loading, setLoading] = useState(false)
  const [search, setSearch] = useState('')
  const [selectedId, setSelectedId] = useState<string | null>(null)
  const activeCategory = CATEGORIES.find((c) => c.key === active)

  useEffect(() => {
    if (active === 'custom') return
    setLoading(true)
    setSelectedId(null)

    if (active === 'rituals') {
      supabase
        .from('rituals')
        .select('id, name, effect')
        .order('name')
        .then(({ data }) => {
          setItems((data ?? []).map((r) => ({ id: r.id, name: r.name, description: r.effect })))
          setLoading(false)
        })
      return
    }

    const category = EFFECTS_CATEGORY[active]
    supabase
      .from('effects_catalog')
      .select('id, name, description')
      .eq('category', category)
      .order('name')
      .then(({ data }) => {
        setItems(data ?? [])
        setLoading(false)
      })
  }, [active])

  const filteredItems = items.filter((item) => item.name.toLowerCase().includes(search.toLowerCase()))
  const selectedItem = items.find((item) => item.id === selectedId) ?? null

  function submitCustom() {
    if (!customName.trim()) return
    onAddCondition(customName.trim())
    setCustomName('')
  }

  return createPortal(
    <div className="conditions-modal-backdrop" onClick={onClose}>
      <div className="conditions-modal-shell" onClick={(e) => e.stopPropagation()}>
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

          <button
            type="button"
            className={`conditions-modal-nav-btn conditions-modal-custom${active === 'custom' ? ' active' : ''}`}
            onClick={() => setActive('custom')}
          >
            <span className="conditions-modal-custom-icon">!</span>
            <span>Personalizado</span>
          </button>
        </nav>

        {active === 'custom' ? (
          <div className="conditions-modal">
            <div className="conditions-modal-texture" />

            <div className="conditions-modal-content">
              <h3>Personalizado</h3>
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
            </div>

            <button type="button" className="conditions-modal-close" onClick={onClose} aria-label="Fechar">×</button>
          </div>
        ) : (
          <>
            <div className="conditions-modal conditions-modal-list-panel">
              <div className="conditions-modal-texture" />
              <div className="conditions-modal-search">
                <input
                  value={search}
                  onChange={(e) => setSearch(e.target.value)}
                  placeholder={`Buscar em ${activeCategory?.label}`}
                />
              </div>
              <div className="conditions-modal-list">
                {loading && <p className="conditions-modal-placeholder">Carregando...</p>}
                {!loading && filteredItems.length === 0 && (
                  <p className="conditions-modal-placeholder">Em breve.</p>
                )}
                {!loading && filteredItems.map((item) => (
                  <button
                    key={item.id}
                    type="button"
                    className={`conditions-modal-list-item${selectedId === item.id ? ' active' : ''}`}
                    onClick={() => setSelectedId(item.id)}
                  >
                    {item.name}
                  </button>
                ))}
              </div>
            </div>

            <div className="conditions-modal conditions-modal-detail-panel">
              <div className="conditions-modal-texture" />
              <div className="conditions-modal-content">
                {selectedItem ? (
                  <>
                    <h3>{selectedItem.name}</h3>
                    <p className="conditions-modal-detail-text">{selectedItem.description}</p>
                    <button type="button" className="conditions-modal-add-btn" onClick={() => onAddCondition(selectedItem.name)}>
                      Adicionar
                    </button>
                  </>
                ) : (
                  <>
                    <h3>{activeCategory?.label}</h3>
                    <p className="conditions-modal-placeholder">Selecione um item na lista.</p>
                  </>
                )}
              </div>

              <button type="button" className="conditions-modal-close" onClick={onClose} aria-label="Fechar">×</button>
            </div>
          </>
        )}
      </div>
    </div>,
    document.body,
  )
}
