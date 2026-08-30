import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'

type CharacterListItem = {
  id: string
  name: string | null
  avatar_url: string | null
  historico: string | null
}

export default function MeusPersonagens() {
  const { session } = useAuth()
  const [characters, setCharacters] = useState<CharacterListItem[] | null>(null)
  const [expanded, setExpanded] = useState<string | null>(null)

  useEffect(() => {
    if (!session) return
    supabase
      .from('characters')
      .select('id, name, avatar_url, historico')
      .eq('user_id', session.user.id)
      .order('created_at', { ascending: false })
      .then(({ data }) => setCharacters(data ?? []))
  }, [session])

  return (
    <section>
      <div className="character-list-header">
        <h2>Meus Personagens</h2>
        <Link to="/personagem/criar">+ Criar Personagem</Link>
      </div>

      {characters === null && <p>Carregando…</p>}
      {characters?.length === 0 && <p>Nenhum personagem ainda.</p>}

      <div className="character-list">
        {characters?.map((c) => (
          <div key={c.id} className="character-card">
            <Link to={`/personagem/${c.id}`}>
              <img className="character-card-avatar" src={c.avatar_url ?? undefined} alt="" />
            </Link>
            <div className="character-card-body">
              <button
                type="button"
                className="character-card-name"
                onClick={() => setExpanded((e) => (e === c.id ? null : c.id))}
              >
                {c.name || 'Sem nome'}
              </button>
              <p className="character-card-game">Ordem Paranormal</p>
              {expanded === c.id && (
                <p className="character-card-historia">{c.historico || 'Sem história definida ainda.'}</p>
              )}
            </div>
          </div>
        ))}
      </div>
    </section>
  )
}
