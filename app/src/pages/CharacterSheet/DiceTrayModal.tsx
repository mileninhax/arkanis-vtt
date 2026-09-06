import { useState } from 'react'
import { createPortal } from 'react-dom'
import trayCthulhu from '../../assets/dice-trays/tray-cthulhu-desperta.png'
import trayCybercity from '../../assets/dice-trays/tray-cybercity.png'
import trayGatinhos from '../../assets/dice-trays/tray-gatinhos-aventureiros.png'
import trayMelanina from '../../assets/dice-trays/tray-melanina.png'
import trayNickie from '../../assets/dice-trays/tray-nickie-assis.png'
import trayRequintes from '../../assets/dice-trays/tray-requintes-vampiricos.webp'
import traySapinhos from '../../assets/dice-trays/tray-sapinhos.png'
import trayGoblins from '../../assets/dice-trays/tray-too-many-goblins.png'
import trayViajante from '../../assets/dice-trays/tray-viajante.png'

type TrayOption = { key: string; label: string; icon?: string }

const TRAY_OPTIONS: TrayOption[] = [
  { key: 'padrao', label: 'Padrão' },
  { key: trayCthulhu, label: 'Cthulhu Desperta', icon: trayCthulhu },
  { key: trayCybercity, label: 'Cybercity', icon: trayCybercity },
  { key: trayGatinhos, label: 'Gatinhos Aventureiros', icon: trayGatinhos },
  { key: trayMelanina, label: 'Melanina', icon: trayMelanina },
  { key: trayNickie, label: 'Nickie Assis', icon: trayNickie },
  { key: trayRequintes, label: 'Requintes Vampíricos', icon: trayRequintes },
  { key: traySapinhos, label: 'Sapinhos', icon: traySapinhos },
  { key: trayGoblins, label: 'Too Many Goblins', icon: trayGoblins },
  { key: trayViajante, label: 'Viajante', icon: trayViajante },
]

export default function DiceTrayModal({
  currentTray,
  onClose,
  onSave,
}: {
  currentTray: string
  onClose: () => void
  onSave: (tray: string) => void
}) {
  const [selected, setSelected] = useState(currentTray)

  return createPortal(
    <div className="frame-modal-backdrop" onClick={onClose}>
      <div className="frame-modal dice-tray-modal" onClick={(e) => e.stopPropagation()}>
        <h3>Selecione uma bandeja de dados</h3>

        <div className="dice-tray-modal-grid">
          {TRAY_OPTIONS.map((opt) => (
            <button
              key={opt.key}
              type="button"
              className={`dice-tray-modal-option${selected === opt.key ? ' active' : ''}`}
              onClick={() => setSelected(opt.key)}
            >
              <span className="dice-tray-modal-option-preview">
                {opt.icon ? <img src={opt.icon} alt="" /> : <span className="dice-tray-modal-none">RPGPédia</span>}
              </span>
              <span className="frame-modal-option-label">{opt.label}</span>
            </button>
          ))}
        </div>

        <div className="frame-modal-actions">
          <button type="button" className="frame-modal-save" onClick={() => onSave(selected)}>
            <span>✓</span> Salvar
          </button>
          <button type="button" className="frame-modal-cancel" onClick={onClose}>
            <span>×</span> Cancelar
          </button>
        </div>
      </div>
    </div>,
    document.body,
  )
}
