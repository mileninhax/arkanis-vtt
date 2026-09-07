import { useEffect, useState } from 'react'
import { createPortal } from 'react-dom'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../lib/AuthContext'
import { Die, formulaSegments, totalColorForDice, type RollCardDie } from './RollResult'
import type { CharacterRecord } from './index'

type RollRow = {
  id: string
  character_id: string
  character_name: string | null
  user_id: string
  label: string
  total: number
  detail: string
  dice: RollCardDie[] | null
  bonus: number
  created_at: string
  characters: { avatar_url: string | null } | { avatar_url: string | null }[] | null
}

function formatTimestamp(iso: string) {
  const d = new Date(iso)
  const date = d.toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit', year: '2-digit' })
  const time = d.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' })
  return `${date} ${time}`
}

function firstName(name: string) {
  return name.trim().split(/\s+/)[0] ?? name
}

function avatarOf(r: RollRow): string | null {
  const c = r.characters
  if (!c) return null
  return Array.isArray(c) ? c[0]?.avatar_url ?? null : c.avatar_url
}

function HistoryEntry({ row, playerName }: { row: RollRow; playerName: string }) {
  const [revealed, setRevealed] = useState(false)
  const [flipping, setFlipping] = useState(false)
  const dice = row.dice ?? []

  function toggle() {
    if (!dice.length || flipping) return
    setFlipping(true)
    setTimeout(() => {
      setRevealed((v) => !v)
      setFlipping(false)
    }, 150)
  }

  const totalColor = totalColorForDice(dice)
  const avatar = avatarOf(row)

  return (
    <div className="historico-entry">
      <p className="historico-timestamp">{formatTimestamp(row.created_at)}</p>
      <div className="historico-who">
        <div className="historico-avatar">
          {avatar ? <img src={avatar} alt="" /> : <span className="historico-avatar-fallback" />}
        </div>
        <p className="historico-names">
          <span className="historico-charname">{row.character_name ?? '?'}</span>
          <span className="historico-playername">({playerName})</span>
        </p>
      </div>

      <button
        type="button"
        className={`historico-card${flipping ? ' flipping' : ''}${dice.length ? ' clickable' : ''}`}
        onClick={toggle}
      >
        {!revealed ? (
          <span className="roll-card-total-backdrop" style={{ color: totalColor }}>{row.total}</span>
        ) : (
          <div className="historico-card-detail">
            <div className="roll-card-formula">
              {formulaSegments(dice, row.bonus).map((s, i, arr) => (
                <span key={i}>
                  <span className="roll-card-formula-chip" style={{ color: s.color }}>{s.text}</span>
                  {i < arr.length - 1 && <span className="roll-card-formula-plus">+</span>}
                </span>
              ))}
            </div>
            <div className="roll-card-dice">
              {dice.map((d, i) => (
                <div key={i} className="roll-card-die-slot">
                  <Die sides={d.sides} value={d.value} discarded={d.discarded} />
                  {i < dice.length - 1 && <span className="roll-card-die-plus">+</span>}
                </div>
              ))}
            </div>
          </div>
        )}
      </button>
    </div>
  )
}

export default function HistoricoRolagens({ character, onClose }: { character: CharacterRecord; onClose: () => void }) {
  const { session } = useAuth()
  const [rows, setRows] = useState<RollRow[] | null>(null)
  const [names, setNames] = useState<Record<string, string>>({})

  useEffect(() => {
    if (!session) return
    let query = supabase
      .from('character_rolls')
      .select('id, character_id, character_name, user_id, label, total, detail, dice, bonus, created_at, characters(avatar_url)')
      .order('created_at', { ascending: false })
      .limit(50)

    query = character.campaign_id
      ? query.or(`user_id.eq.${session.user.id},campaign_id.eq.${character.campaign_id}`)
      : query.eq('user_id', session.user.id)

    query.then(async ({ data }) => {
      setRows((data as unknown as RollRow[]) ?? [])
      const userIds = [...new Set((data ?? []).map((r) => r.user_id))]
      if (userIds.length) {
        const { data: profiles } = await supabase.from('profiles').select('id, display_name').in('id', userIds)
        setNames(Object.fromEntries((profiles ?? []).map((p) => [p.id, p.display_name ?? 'Sem nome'])))
      }
    })
  }, [session, character.campaign_id])

  return createPortal(
    <aside className="historico-panel" role="dialog" aria-label="Histórico de Rolagens">
      <header className="historico-header">
        <h2>Histórico de rolagens</h2>
        <button type="button" className="historico-close" onClick={onClose} aria-label="Fechar">×</button>
      </header>

      <div className="historico-list">
        {rows === null && <p className="historico-empty">Carregando…</p>}
        {rows?.length === 0 && <p className="historico-empty">Nenhuma rolagem ainda.</p>}
        {rows?.map((r) => (
          <HistoryEntry key={r.id} row={r} playerName={firstName(names[r.user_id] ?? '…')} />
        ))}
      </div>
    </aside>,
    document.body,
  )
}
