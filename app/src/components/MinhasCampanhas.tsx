import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'

type CampaignItem = {
  id: string
  name: string
  description: string | null
  invite_code: string
  owner_id: string
}

export default function MinhasCampanhas() {
  const { session } = useAuth()
  const [campaigns, setCampaigns] = useState<CampaignItem[] | null>(null)
  const [showCreate, setShowCreate] = useState(false)
  const [newName, setNewName] = useState('')
  const [newDescription, setNewDescription] = useState('')
  const [joinCode, setJoinCode] = useState('')
  const [error, setError] = useState<string | null>(null)

  async function loadCampaigns() {
    if (!session) return
    const { data } = await supabase
      .from('campaign_members')
      .select('campaigns(id, name, description, invite_code, owner_id)')
      .eq('user_id', session.user.id)
    setCampaigns((data ?? []).map((row) => row.campaigns as unknown as CampaignItem).filter(Boolean))
  }

  useEffect(() => {
    loadCampaigns()
  }, [session])

  async function handleCreate() {
    if (!session || !newName.trim()) return
    const { data, error: createError } = await supabase
      .from('campaigns')
      .insert({ name: newName, description: newDescription || null, owner_id: session.user.id })
      .select('id')
      .single()
    if (createError) {
      setError(createError.message)
      return
    }
    await supabase.from('campaign_members').insert({ campaign_id: data.id, user_id: session.user.id, role: 'mestre' })
    setNewName('')
    setNewDescription('')
    setShowCreate(false)
    setError(null)
    loadCampaigns()
  }

  async function handleJoin() {
    if (!joinCode.trim()) return
    const { error: joinError } = await supabase.rpc('join_campaign_by_code', { p_invite_code: joinCode.trim() })
    if (joinError) {
      setError(joinError.message)
      return
    }
    setJoinCode('')
    setError(null)
    loadCampaigns()
  }

  return (
    <section>
      <div className="character-list-header">
        <h2>Minhas Campanhas</h2>
      </div>
      {error && <p role="alert">{error}</p>}

      {campaigns === null && <p>Carregando…</p>}
      {campaigns?.length === 0 && <p>Nenhuma campanha ainda.</p>}

      <div className="character-list">
        {campaigns?.map((c) => (
          <div key={c.id} className="character-card campaign-card">
            <div className="character-card-body">
              <strong className="character-card-name">{c.name}</strong>
              {c.owner_id === session?.user.id && <span className="campaign-role-badge">Mestre</span>}
              {c.description && <p className="character-card-game">{c.description}</p>}
              <p className="campaign-invite-code">Código de convite: {c.invite_code}</p>
            </div>
          </div>
        ))}
      </div>

      {showCreate ? (
        <div className="campaign-form">
          <label className="editperfil-field">
            Nome
            <input value={newName} onChange={(e) => setNewName(e.target.value)} />
          </label>
          <label className="editperfil-field">
            Descrição
            <textarea value={newDescription} onChange={(e) => setNewDescription(e.target.value)} />
          </label>
          <button type="button" onClick={handleCreate}>Criar</button>
          <button type="button" onClick={() => setShowCreate(false)}>Cancelar</button>
        </div>
      ) : (
        <button type="button" className="btn-pill btn-pill-neutral" onClick={() => setShowCreate(true)} style={{ marginTop: '0.8em' }}>+ Criar Campanha</button>
      )}

      <div className="campaign-join-row">
        <label className="editperfil-field">
          Código de convite
          <input value={joinCode} onChange={(e) => setJoinCode(e.target.value)} />
        </label>
        <button type="button" onClick={handleJoin}>Entrar</button>
      </div>
    </section>
  )
}
