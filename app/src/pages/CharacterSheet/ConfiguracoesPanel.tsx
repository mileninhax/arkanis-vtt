import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import type { CharacterRecord } from './index'

const RULES: { key: string; label: string; locked?: boolean }[] = [
  { key: 'nex_experiencia', label: 'NEX & Experiência' },
  { key: 'evolucao_patente', label: 'Evolução por Patentes', locked: true },
  { key: 'sem_sanidade', label: 'Jogando sem Sanidade' },
  { key: 'contagem_municao', label: 'Contagem de Munição' },
]

const ELEMENTOS: { key: string | null; label: string; color: string }[] = [
  { key: null, label: 'Nenhum', color: '#1a1a1a' },
  { key: 'sangue', label: 'Sangue', color: '#a01f2e' },
  { key: 'energia', label: 'Energia', color: '#2452c9' },
  { key: 'conhecimento', label: 'Conhecimento', color: '#c98a1f' },
  { key: 'morte', label: 'Morte', color: '#6b3fa0' },
]

const CONFIG_TABS = ['Aparência', 'Mecânicas', 'Preferências'] as const

function Toggle({ checked, onChange }: { checked: boolean; onChange: () => void }) {
  return (
    <button type="button" className={`settings-toggle${checked ? ' on' : ''}`} onClick={onChange} role="switch" aria-checked={checked}>
      <span className="settings-toggle-knob">{checked ? '✓' : '×'}</span>
    </button>
  )
}

function BannerPicker({ label, value }: { label: string; value: string }) {
  return (
    <div className="settings-picker">
      <div className="settings-picker-preview" />
      <p className="settings-picker-value">{value === 'padrao' ? 'Padrão' : value}</p>
      <button type="button" className="settings-picker-btn">Mudar {label}</button>
    </div>
  )
}

export default function ConfiguracoesPanel({
  character,
  onUpdated,
  onClose,
}: {
  character: CharacterRecord
  onUpdated: () => void
  onClose: () => void
}) {
  const [configTab, setConfigTab] = useState<(typeof CONFIG_TABS)[number]>('Aparência')
  const [volume, setVolume] = useState(100)
  const [muted, setMuted] = useState(false)
  const [bgAnimated, setBgAnimated] = useState(true)

  useEffect(() => {
    const stored = localStorage.getItem('vtt_volume')
    if (stored) setVolume(Number(stored))
    setMuted(localStorage.getItem('vtt_muted') === 'true')
    setBgAnimated(localStorage.getItem('vtt_bg_animated') !== 'false')
  }, [])

  async function updateField(patch: Partial<CharacterRecord>) {
    await supabase.from('characters').update(patch).eq('id', character.id)
    onUpdated()
  }

  function toggleRule(key: string) {
    updateField({ optional_rules: { ...character.optional_rules, [key]: !character.optional_rules[key] } })
  }

  function setVolumeAndStore(v: number) {
    setVolume(v)
    localStorage.setItem('vtt_volume', String(v))
  }

  function toggleMuted() {
    const next = !muted
    setMuted(next)
    localStorage.setItem('vtt_muted', String(next))
  }

  function toggleBgAnimated() {
    const next = !bgAnimated
    setBgAnimated(next)
    localStorage.setItem('vtt_bg_animated', String(next))
    window.dispatchEvent(new Event('vtt-bg-animated-change'))
  }

  return (
    <aside role="dialog" aria-label="Configurações" className="settings-panel">
      <header className="settings-header">
        <h2>Configurações</h2>
        <button type="button" className="settings-close" onClick={onClose} aria-label="Fechar">×</button>
      </header>

      <nav className="settings-tabs">
        {CONFIG_TABS.map((t) => (
          <button
            key={t}
            type="button"
            className={`settings-tab${configTab === t ? ' active' : ''}`}
            onClick={() => setConfigTab(t)}
          >
            {t}
          </button>
        ))}
      </nav>

      <div className="settings-body">
        {configTab === 'Aparência' && (
          <section>
            <h3 className="settings-section-title">Editar aparência</h3>

            <p className="settings-label">Elemento em destaque</p>
            <div className="settings-elemento-row">
              {ELEMENTOS.map((e) => (
                <button
                  key={e.label}
                  type="button"
                  className={`settings-elemento-swatch${character.afinidade_elemento === e.key ? ' active' : ''}`}
                  style={{ background: e.color }}
                  onClick={() => updateField({ afinidade_elemento: e.key })}
                  aria-label={e.label}
                  title={e.label}
                >
                  {e.key === null && '×'}
                </button>
              ))}
            </div>

            <div className="settings-row">
              <Toggle checked={bgAnimated} onChange={toggleBgAnimated} />
              <span>Fundo animado</span>
            </div>

            <p className="settings-label settings-label-block">Banner de fundo</p>
            <BannerPicker label="Banner" value={character.sheet_banner} />

            <p className="settings-label settings-label-block">Bandeja de dados</p>
            <BannerPicker label="Bandeja" value={character.dice_tray} />
          </section>
        )}

        {configTab === 'Mecânicas' && (
          <section>
            <h3 className="settings-section-title">Regras Opcionais</h3>
            {RULES.map(({ key, label, locked }) => (
              <div key={key} className={`settings-row${locked ? ' settings-row-sub' : ''}`}>
                <Toggle checked={Boolean(character.optional_rules[key])} onChange={() => toggleRule(key)} />
                <span>{label}</span>
                {locked && <span className="settings-lock">🔒</span>}
              </div>
            ))}

            {character.optional_rules.evolucao_patente && (
              <div className="settings-subsection">
                <p>Patente ajustável na aba Agente.</p>
                <label className="settings-label-block">
                  Pontos de Prestígio
                  <input
                    type="number"
                    className="settings-input"
                    value={character.prestigio}
                    onChange={(e) => updateField({ prestigio: Number(e.target.value) })}
                  />
                </label>
              </div>
            )}
          </section>
        )}

        {configTab === 'Preferências' && (
          <section>
            <h3 className="settings-section-title">Opções de privacidade</h3>
            <div className="settings-row">
              <Toggle checked={character.editable_by_others} onChange={() => updateField({ editable_by_others: !character.editable_by_others })} />
              <span>Editável por outros jogadores</span>
            </div>
            <div className="settings-row">
              <Toggle checked={character.hidden_from_others} onChange={() => updateField({ hidden_from_others: !character.hidden_from_others })} />
              <span>Oculta para outros jogadores</span>
            </div>

            <h3 className="settings-section-title settings-section-title-spaced">Opções de som</h3>
            <p className="settings-label">Volume</p>
            <div className="settings-volume-row">
              <input
                type="range"
                min={0}
                max={100}
                value={volume}
                disabled={muted}
                onChange={(e) => setVolumeAndStore(Number(e.target.value))}
                className="settings-slider"
              />
              <span className="settings-volume-value">{volume}</span>
            </div>
            <div className="settings-row">
              <Toggle checked={muted} onChange={toggleMuted} />
              <span>Desligar sons</span>
            </div>

            <h3 className="settings-section-title settings-section-title-spaced">Navegação</h3>
            <div className="settings-nav-links">
              <Link to="/perfil">Perfil</Link>
              <Link to="/jogar">Jogar</Link>
            </div>
          </section>
        )}
      </div>
    </aside>
  )
}
