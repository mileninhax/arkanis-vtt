import { Link } from 'react-router-dom'
import { useAuth } from '../lib/AuthContext'

export default function Home() {
  const { session, loading } = useAuth()

  return (
    <main>
      <h1>VTT — Ordem Paranormal</h1>
      {loading ? null : session ? (
        <>
          <p>Bem-vindo(a) de volta.</p>
          <Link to="/jogar">Jogar</Link>
          {' · '}
          <Link to="/personagem/criar">Criar Personagem</Link>
        </>
      ) : (
        <>
          <p>Bem-vindo(a).</p>
          <Link to="/login">Entrar</Link>
        </>
      )}
    </main>
  )
}
