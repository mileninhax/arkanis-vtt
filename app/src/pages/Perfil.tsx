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
}

export default function Perfil() {
  const { session } = useAuth()
  const navigate = useNavigate()
  const [profile, setProfile] = useState<ProfileRow | null>(null)

  useEffect(() => {
    if (!session) return
    supabase
      .from('profiles')
      .select('display_name, description, avatar_url, banner_url, banner_position_y')
      .eq('id', session.user.id)
      .single()
      .then(({ data }) => setProfile(data))
  }, [session])

  async function handleSair() {
    await supabase.auth.signOut()
    navigate('/')
  }

  return (
    <main>
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
        <Link to="/jogar">Meus Personagens</Link>
        {' · '}
        <Link to="/perfil/editar">Editar Perfil</Link>
        {' · '}
        <button onClick={handleSair}>Sair</button>
      </nav>
    </main>
  )
}
