import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'

type CharacterListItem = {
  id: string
  name: string | null
  avatar_url: string | null
  nex_percent: number
  origin_id: string | null
  custom_origin: { name: string } | null
  class_id: string | null
  custom_class: { name: string } | null
}

export default function MeusPersonagens() {
  const { session } = useAuth()
  const [characters, setCharacters] = useState<CharacterListItem[] | null>(null)
  const [originNames, setOriginNames] = useState<Record<string, string>>({})
  const [classNames, setClassNames] = useState<Record<string, string>>({})

  useEffect(() => {
    if (!session) return
    supabase
      .from('characters')
      .select('id, name, avatar_url, nex_percent, origin_id, custom_origin, class_id, custom_class')
      .eq('user_id', session.user.id)
      .order('created_at', { ascending: false })
      .then(async ({ data }) => {
        setCharacters(data ?? [])
        const originIds = [...new Set((data ?? []).map((c) => c.origin_id).filter(Boolean))] as string[]
        const classIds = [...new Set((data ?? []).map((c) => c.class_id).filter(Boolean))] as string[]
        if (originIds.length) {
          const { data: origins } = await supabase.from('origins').select('id, name').in('id', originIds)
          setOriginNames(Object.fromEntries((origins ?? []).map((o) => [o.id, o.name])))
        }
        if (classIds.length) {
          const { data: classes } = await supabase.from('classes').select('id, name').in('id', classIds)
          setClassNames(Object.fromEntries((classes ?? []).map((c) => [c.id, c.name])))
        }
      })
  }, [session])

  return (
    <section>
      <h2>Meus Personagens</h2>
      <Link to="/personagem/criar">+ Criar Personagem</Link>

      {characters === null && <p>Carregando…</p>}
      {characters?.length === 0 && <p>Nenhum personagem ainda.</p>}
      {characters?.map((c) => {
        const origin = c.origin_id ? originNames[c.origin_id] : c.custom_origin?.name
        const className = c.class_id ? classNames[c.class_id] : c.custom_class?.name
        return (
          <div key={c.id}>
            {c.avatar_url && <img src={c.avatar_url} alt="" width={48} height={48} />}
            <Link to={`/personagem/${c.id}`}>{c.name || 'Sem nome'}</Link>
            <p>{origin} — {className} — NEX {c.nex_percent}%</p>
          </div>
        )
      })}
    </section>
  )
}
