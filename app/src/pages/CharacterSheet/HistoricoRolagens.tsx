import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../lib/AuthContext'
import type { CharacterRecord } from './index'

type RollRow = {
  id: string
  character_name: string | null
  user_id: string
  label: string
  total: number
  detail: string
  created_at: string
}

export default function HistoricoRolagens({ character, onClose }: { character: CharacterRecord; onClose: () => void }) {
  const { session } = useAuth()
  const [rows, setRows] = useState<RollRow[] | null>(null)
  const [names, setNames] = useState<Record<string, string>>({})
  const [expanded, setExpanded] = useState<string | null>(null)

  useEffect(() => {
    if (!session) return
    let query = supabase
      .from('character_rolls')
      .select('id, character_name, user_id, label, total, detail, created_at')
      .order('created_at', { ascending: false })
      .limit(50)

    query = character.campaign_id
      ? query.or(`user_id.eq.${session.user.id},campaign_id.eq.${character.campaign_id}`)
      : query.eq('user_id', session.user.id)

    query.then(async ({ data }) => {
      setRows(data ?? [])
      const userIds = [...new Set((data ?? []).map((r) => r.user_id))]
      if (userIds.length) {
        const { data: profiles } = await supabase.from('profiles').select('id, display_name').in('id', userIds)
        setNames(Object.fromEntries((profiles ?? []).map((p) => [p.id, p.display_name ?? 'Sem nome'])))
      }
    })
  }, [session, character.campaign_id])

  return (
    <aside role="dialog" aria-label="Histórico de Rolagens">
      <header>
        <h2>Histórico de Rolagens</h2>
        <button type="button" onClick={onClose}>Fechar</button>
      </header>

      {rows === null && <p>Carregando…</p>}
      {rows?.length === 0 && <p>Nenhuma rolagem ainda.</p>}

      <ul>
        {rows?.map((r) => {
          const isOpen = expanded === r.id
          return (
            <li key={r.id}>
              <button type="button" onClick={() => setExpanded(isOpen ? null : r.id)}>
                {new Date(r.created_at).toLocaleString('pt-BR')} — {r.character_name ?? '?'} ({names[r.user_id] ?? '...'}): {r.label} = {r.total}
              </button>
              {isOpen && <p>{r.detail}</p>}
            </li>
          )
        })}
      </ul>
    </aside>
  )
}
