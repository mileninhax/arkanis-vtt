import { useState } from 'react'
import { createPortal } from 'react-dom'
import frameMorte from '../../assets/frame-morte.png'
import frameAnarquico from '../../assets/frame-anarquico.png'
import frameAnfitriao from '../../assets/frame-anfitriao.png'
import frameAnjo from '../../assets/frame-anjo.png'
import frameAracnasita from '../../assets/frame-aracnasita.png'
import frameBichoPapao from '../../assets/frame-bicho-papao.png'
import frameCeifador from '../../assets/frame-ceifador.png'
import frameConhecimento from '../../assets/frame-conhecimento.png'
import frameDamaDeSangue from '../../assets/frame-dama-de-sangue.png'
import frameDeusDaMorte from '../../assets/frame-deus-da-morte.png'
import frameDiabo from '../../assets/frame-diabo.png'
import frameEstrangeiro from '../../assets/frame-estrangeiro.png'
import frameNidere from '../../assets/frame-nidere.png'
import frameOcioso from '../../assets/frame-ocioso.png'
import frameSereia from '../../assets/frame-sereia.png'
import frameTelopsia from '../../assets/frame-telopsia.png'

type FrameOption = { key: string; label: string; icon?: string }

const FRAME_OPTIONS: FrameOption[] = [
  { key: 'none', label: 'Sem moldura' },
  { key: frameMorte, label: 'Morte', icon: frameMorte },
  { key: frameConhecimento, label: 'Conhecimento', icon: frameConhecimento },
  { key: frameAnarquico, label: 'Anárquico Descontrolado', icon: frameAnarquico },
  { key: frameAnfitriao, label: 'Anfitrião', icon: frameAnfitriao },
  { key: frameAnjo, label: 'Anjo', icon: frameAnjo },
  { key: frameAracnasita, label: 'Aracnasita', icon: frameAracnasita },
  { key: frameBichoPapao, label: 'Bicho-Papão', icon: frameBichoPapao },
  { key: frameCeifador, label: 'Ceifador Espiral', icon: frameCeifador },
  { key: frameDamaDeSangue, label: 'Dama de Sangue', icon: frameDamaDeSangue },
  { key: frameDeusDaMorte, label: 'O Deus da Morte', icon: frameDeusDaMorte },
  { key: frameDiabo, label: 'O Diabo', icon: frameDiabo },
  { key: frameEstrangeiro, label: 'Estrangeiro', icon: frameEstrangeiro },
  { key: frameNidere, label: 'Nidere', icon: frameNidere },
  { key: frameOcioso, label: 'Ocioso', icon: frameOcioso },
  { key: frameSereia, label: 'Sereia', icon: frameSereia },
  { key: frameTelopsia, label: 'Telopsia', icon: frameTelopsia },
]

export default function FrameModal({
  currentFrame,
  onClose,
  onSave,
}: {
  currentFrame: string | null
  onClose: () => void
  onSave: (frame: string | null) => void
}) {
  const [selected, setSelected] = useState<string>(currentFrame ?? 'none')

  return createPortal(
    <div className="frame-modal-backdrop" onClick={onClose}>
      <div className="frame-modal" onClick={(e) => e.stopPropagation()}>
        <h3>Selecione uma moldura</h3>

        <div className="frame-modal-grid">
          {FRAME_OPTIONS.map((opt) => (
            <button
              key={opt.key}
              type="button"
              className={`frame-modal-option${selected === opt.key ? ' active' : ''}`}
              onClick={() => setSelected(opt.key)}
            >
              <span className="frame-modal-option-preview">
                {opt.icon ? <img src={opt.icon} alt="" /> : (
                  <svg viewBox="0 0 24 24" className="frame-modal-none-icon">
                    <circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" strokeWidth="2" />
                    <line x1="5.5" y1="18.5" x2="18.5" y2="5.5" stroke="currentColor" strokeWidth="2" />
                  </svg>
                )}
              </span>
              <span className="frame-modal-option-label">{opt.label}</span>
            </button>
          ))}
        </div>

        <div className="frame-modal-actions">
          <button type="button" className="frame-modal-save" onClick={() => onSave(selected === 'none' ? null : selected)}>
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
