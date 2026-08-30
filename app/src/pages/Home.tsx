import { Link } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'
import bgHome from '../assets/backgrounds/bg-home.png'

export default function Home() {
  const { session, loading } = useAuth()

  return (
    <main className="font-ashigea home-hero" style={{ backgroundImage: `url(${bgHome})` }}>
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
    </main>
  )
}
