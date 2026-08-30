import { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'

type ProfileRow = {
  display_name: string | null
  description: string | null
  avatar_url: string | null
  banner_url: string | null
  banner_position_y: number
  accent_color: string | null
  background_color: string | null
}

export default function Perfil() {
  const { session } = useAuth()
  const navigate = useNavigate()
  const [profile, setProfile] = useState<ProfileRow | null>(null)

  useEffect(() => {
    if (!session) return
    supabase
      .from('profiles')
      .select('display_name, description, avatar_url, banner_url, banner_position_y, accent_color, background_color')
      .eq('id', session.user.id)
      .single()
      .then(({ data }) => setProfile(data))
  }, [session])

  async function handleSair() {
    await supabase.auth.signOut()
    navigate('/')
  }

  const accent = profile?.accent_color || undefined
  const background = profile?.background_color || undefined

  return (
    <main style={{ backgroundColor: background, color: accent }}>
      <h1>Perfil</h1>

      {profile?.banner_url && (
        <div style={{ height: 150, overflow: 'hidden' }}>
          <img
            src={profile.banner_url}
            alt="Banner"
            style={{ width: '100%', height: '100%', objectFit: 'cover', objectPosition: `center ${profile.banner_position_y}%` }}
          />
        </div>
      )}

      {profile?.avatar_url && <img src={profile.avatar_url} alt="Avatar" width={96} height={96} />}
      <h2>{profile?.display_name || 'Sem nome definido'}</h2>
      {profile?.description && <p>{profile.description}</p>}

      <nav>
        <Link to="/jogar" style={{ color: accent }}>Meus Personagens</Link>
        {' · '}
        <Link to="/perfil/editar" style={{ color: accent }}>Editar Perfil</Link>
        {' · '}
        <button onClick={handleSair} style={{ color: accent, borderColor: accent }}>Sair</button>
      </nav>
    </main>
  )
}
