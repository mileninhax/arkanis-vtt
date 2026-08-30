import { useEffect, useRef, useState, type ChangeEvent } from 'react'
import { useNavigate } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import { useAuth } from '../lib/AuthContext'

export default function EditarPerfil() {
  const { session } = useAuth()
  const navigate = useNavigate()

  const [displayName, setDisplayName] = useState('')
  const [description, setDescription] = useState('')
  const [avatarUrl, setAvatarUrl] = useState<string | null>(null)
  const [bannerUrl, setBannerUrl] = useState<string | null>(null)
  const [bannerPositionY, setBannerPositionY] = useState(50)
  const [accentColor, setAccentColor] = useState('#888888')
  const [backgroundColor, setBackgroundColor] = useState('#1a1a1a')
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const draggingRef = useRef(false)
  const bannerBoxRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (!session) return
    supabase
      .from('profiles')
      .select('display_name, description, avatar_url, banner_url, banner_position_y, accent_color, background_color')
      .eq('id', session.user.id)
      .single()
      .then(({ data }) => {
        if (data) {
          setDisplayName(data.display_name ?? '')
          setDescription(data.description ?? '')
          setAvatarUrl(data.avatar_url)
          setBannerUrl(data.banner_url)
          setBannerPositionY(data.banner_position_y ?? 50)
          setAccentColor(data.accent_color ?? '#888888')
          setBackgroundColor(data.background_color ?? '#1a1a1a')
        }
        setLoading(false)
      })
  }, [session])

  async function uploadTo(bucket: 'avatars' | 'banners', file: File): Promise<string> {
    const path = `${session!.user.id}/${Date.now()}-${file.name}`
    const { error: uploadError } = await supabase.storage.from(bucket).upload(path, file, { upsert: true })
    if (uploadError) throw uploadError
    return supabase.storage.from(bucket).getPublicUrl(path).data.publicUrl
  }

  async function handleAvatarChange(e: ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0]
    if (!file || !session) return
    try {
      setAvatarUrl(await uploadTo('avatars', file))
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Erro ao enviar foto')
    }
  }

  async function handleBannerChange(e: ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0]
    if (!file || !session) return
    try {
      setBannerUrl(await uploadTo('banners', file))
      setBannerPositionY(50)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Erro ao enviar banner')
    }
  }

  function handleBannerPointerDown() {
    draggingRef.current = true
  }

  function handleBannerPointerMove(e: React.PointerEvent<HTMLDivElement>) {
    if (!draggingRef.current || !bannerBoxRef.current) return
    const rect = bannerBoxRef.current.getBoundingClientRect()
    const ratio = (e.clientY - rect.top) / rect.height
    setBannerPositionY(Math.min(100, Math.max(0, Math.round(ratio * 100))))
  }

  function handleBannerPointerUp() {
    draggingRef.current = false
  }

  async function handleSalvar() {
    if (!session) return
    setSaving(true)
    setError(null)
    const { error: updateError } = await supabase
      .from('profiles')
      .update({
        display_name: displayName,
        description,
        avatar_url: avatarUrl,
        banner_url: bannerUrl,
        banner_position_y: bannerPositionY,
        accent_color: accentColor,
        background_color: backgroundColor,
      })
      .eq('id', session.user.id)
    setSaving(false)
    if (updateError) {
      setError(updateError.message)
      return
    }
    navigate('/perfil')
  }

  if (loading) return null

  return (
    <main>
      <h1>Editar Perfil</h1>
      {error && <p role="alert">{error}</p>}

      <section>
        <label>
          Nome de usuário
          <input value={displayName} onChange={(e) => setDisplayName(e.target.value)} />
        </label>
      </section>

      <section>
        <label>
          Descrição
          <textarea value={description} onChange={(e) => setDescription(e.target.value)} />
        </label>
      </section>

      <section>
        <p>Foto de perfil</p>
        {avatarUrl && <img src={avatarUrl} alt="Avatar" width={96} height={96} />}
        <input type="file" accept="image/*" onChange={handleAvatarChange} />
      </section>

      <section>
        <p>Banner de perfil (arraste dentro da imagem pra reposicionar)</p>
        {bannerUrl && (
          <div
            ref={bannerBoxRef}
            style={{ height: 150, overflow: 'hidden', cursor: 'ns-resize', userSelect: 'none' }}
            onPointerDown={handleBannerPointerDown}
            onPointerMove={handleBannerPointerMove}
            onPointerUp={handleBannerPointerUp}
            onPointerLeave={handleBannerPointerUp}
          >
            <img
              src={bannerUrl}
              alt="Banner"
              draggable={false}
              style={{ width: '100%', height: '100%', objectFit: 'cover', objectPosition: `center ${bannerPositionY}%` }}
            />
          </div>
        )}
        <input type="file" accept="image/*" onChange={handleBannerChange} />
      </section>

      <section>
        <p>Prévia</p>
        <div style={{ border: '1px solid currentColor', padding: 8, maxWidth: 300 }}>
          {bannerUrl && (
            <div style={{ height: 60, overflow: 'hidden' }}>
              <img
                src={bannerUrl}
                alt=""
                style={{ width: '100%', height: '100%', objectFit: 'cover', objectPosition: `center ${bannerPositionY}%` }}
              />
            </div>
          )}
          {avatarUrl && <img src={avatarUrl} alt="" width={48} height={48} />}
          <p>{displayName || 'Sem nome definido'}</p>
          {description && <p>{description}</p>}
        </div>
      </section>

      <section>
        <label>
          Cor de destaque
          <input type="color" value={accentColor} onChange={(e) => setAccentColor(e.target.value)} />
        </label>
      </section>

      <section>
        <label>
          Cor de fundo
          <input type="color" value={backgroundColor} onChange={(e) => setBackgroundColor(e.target.value)} />
        </label>
      </section>

      <button onClick={handleSalvar} disabled={saving}>{saving ? 'Salvando...' : 'Salvar'}</button>
    </main>
  )
}
