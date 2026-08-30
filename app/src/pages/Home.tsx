import { useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'
import AuthForm from '../components/AuthForm'
import bgHome from '../assets/backgrounds/bg-home.png'
import arkanisLogo from '../assets/icons/arkanis-logo.png'

export default function Home() {
  const { session, loading } = useAuth()
  const [authMode, setAuthMode] = useState<'login' | 'signup' | null>(null)

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
              <>
                <div className="character-list-actions">
                  <button type="button" className="btn-pill" onClick={() => setAuthMode('signup')}>Crie já a sua conta</button>
                </div>
                <button type="button" className="auth-form-toggle" onClick={() => setAuthMode('login')}>Já tem conta? Entrar</button>
              </>
            )
          )}
        </div>
      </div>

      {authMode && (
        <div className="modal-backdrop" onClick={() => setAuthMode(null)}>
          <div onClick={(e) => e.stopPropagation()}>
            <AuthForm initialMode={authMode} onDone={() => setAuthMode(null)} />
          </div>
        </div>
      )}
    </main>
  )
}
