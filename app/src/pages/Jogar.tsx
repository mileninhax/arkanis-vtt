import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'
import MeusPersonagens from '../components/MeusPersonagens'
import MinhasCampanhas from '../components/MinhasCampanhas'

export default function Jogar() {
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
      <h1>Jogar</h1>

      <div className="jogar-section">
        <MeusPersonagens variant="jogar" />
      </div>
      <div className="jogar-section">
        <MinhasCampanhas />
      </div>
    </main>
  )
}
