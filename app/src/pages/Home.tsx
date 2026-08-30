import { Link } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'
import bgHome from '../assets/backgrounds/bg-home.png'
import arkanisLogo from '../assets/icons/arkanis-logo.png'

export default function Home() {
  const { session, loading } = useAuth()

  return (
    <main className="font-ashigea home-hero">
      <div className="home-hero-bg" style={{ backgroundImage: `url(${bgHome})` }} />
      <div className="home-hero-row">
        <div className="home-hero-logo">
          <img src={arkanisLogo} alt="Arkanis" />
        </div>
        <div className="home-hero-content">
          <h1>Arkanis</h1>
          <p>Seja bem-vindo(a) à sua mesa de RPG.</p>
          {!loading && (
            session ? (
              <div className="character-list-actions">
                <Link to="/jogar" className="btn-pill">Jogar</Link>
                <Link to="/personagem/criar" className="btn-pill btn-pill-neutral">Criar Personagem</Link>
              </div>
            ) : (
              <Link to="/login" className="btn-pill">Crie já a sua conta</Link>
            )
          )}
        </div>
      </div>
    </main>
  )
}
