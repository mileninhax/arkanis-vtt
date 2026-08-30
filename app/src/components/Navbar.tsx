import { Link } from 'react-router-dom'
import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'

export default function Navbar() {
  const { session } = useAuth()
  const [avatarUrl, setAvatarUrl] = useState<string | null>(null)

  useEffect(() => {
    if (!session) return
    supabase
      .from('profiles')
      .select('avatar_url')
      .eq('id', session.user.id)
      .single()
      .then(({ data }) => setAvatarUrl(data?.avatar_url ?? null))
  }, [session])

  if (!session) return null

  return (
    <nav>
      <Link to="/perfil">Perfil</Link>
      <Link to="/jogar">Jogar</Link>
      <Link to="/perfil">
        {avatarUrl ? <img src={avatarUrl} alt="Avatar" width={32} height={32} /> : <span>(avatar)</span>}
      </Link>
    </nav>
  )
}
