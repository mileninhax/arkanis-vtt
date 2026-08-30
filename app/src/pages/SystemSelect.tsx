import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'
import cardOrdemParanormal from '../assets/backgrounds/card-ordem-paranormal.webp'

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
  const { session } = useAuth()
  const [backgroundColor, setBackgroundColor] = useState<string | undefined>(undefined)

  useEffect(() => {
    if (!session) return
    supabase.from('profiles').select('background_color').eq('id', session.user.id).single()
      .then(({ data }) => setBackgroundColor(data?.background_color ?? undefined))
  }, [session])

  return (
    <main className="profile-page font-ashigea" style={{ '--vignette-color': backgroundColor } as React.CSSProperties}>
      <div className="profile-vignette" />
      <div className="jogar-content">
        <div className="system-select-header">
          <h1>Novo Personagem</h1>
          <p>Escolha o jogo para criar seu novo personagem.</p>
        </div>

        <div className="system-card-grid">
          {SYSTEMS.map((s) => (
            <div key={s.slug} className="system-card" style={{ backgroundImage: `url(${s.image})` }}>
              <span className="system-card-badge">{s.version}</span>
              <div className="system-card-overlay">
                <h2>{s.name}</h2>
                <p>{s.description}</p>
                <Link to={`/personagem/criar/${s.slug}`} className="btn-pill">Criar Personagem</Link>
              </div>
            </div>
          ))}
        </div>
      </div>
    </main>
  )
}
