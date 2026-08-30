import { Link } from 'react-router-dom'
import cardOrdemParanormal from '../assets/backgrounds/card-ordem-paranormal.webp'
import bgSystemSelect from '../assets/backgrounds/bg-systemselect.png'

const SYSTEMS = [
  {
    slug: 'ordem-paranormal',
    name: 'Ordem Paranormal',
    description: 'Se torne um agente da Ordo Realitas, especializado em defender o nosso mundo das forças do Outro Lado.',
    version: 'Atualizado v0.1',
    image: cardOrdemParanormal,
  },
]

export default function SystemSelect() {
  return (
    <main className="profile-page font-ashigea">
      <div className="profile-vignette system-select-bg" style={{ backgroundImage: `url(${bgSystemSelect})` }} />
      <div className="jogar-content system-select-content">
        <div className="system-select-header">
          <h1>Novo Personagem</h1>
          <p>Escolha o jogo para criar seu novo personagem.</p>
        </div>

        <div className="system-card-grid">
          {SYSTEMS.map((s) => (
            <div key={s.slug} className="system-card-wrap">
              <span className="system-card-badge">{s.version}</span>
              <div className="system-card">
                <div className="system-card-left">
                  <h2>{s.name}</h2>
                  <p>{s.description}</p>
                  <Link to={`/personagem/criar/${s.slug}`} className="btn-pill btn-pill-danger">Criar Personagem</Link>
                </div>
                <div className="system-card-right" style={{ backgroundImage: `url(${s.image})` }} />
              </div>
            </div>
          ))}
        </div>
      </div>
    </main>
  )
}
