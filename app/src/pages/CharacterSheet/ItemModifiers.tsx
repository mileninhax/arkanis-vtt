import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'

type AppliedModifier = { kind: 'modificacao' | 'maldicao'; name: string; effect: string; elemento: string | null }

type CatalogEntry = { id: string; name: string; effect: string; elemento?: string | null }

const WEAPON_MOD_SCOPE: Record<string, string[]> = {
  arma: ['corpo_a_corpo_disparo', 'armas_fogo'],
  municao: ['municao_balas'],
  protecao: ['protecoes'],
  geral: ['acessorios'],
}

const CURSE_SCOPE: Record<string, string> = {
  arma: 'arma',
  protecao: 'protecao',
  geral: 'acessorio',
}

export default function ItemModifiers({
  inventoryId,
  itemType,
  applied,
  onChanged,
}: {
  inventoryId: string
  itemType: 'arma' | 'municao' | 'protecao' | 'geral' | 'paranormal'
  applied: AppliedModifier[]
  onChanged: () => void
}) {
  const [adding, setAdding] = useState(false)
  const [tab, setTab] = useState<'modificacao' | 'maldicao'>('modificacao')
  const [catalog, setCatalog] = useState<CatalogEntry[]>([])
  const [creatingCustom, setCreatingCustom] = useState(false)
  const [customName, setCustomName] = useState('')
  const [customElement, setCustomElement] = useState('')
  const [customEffect, setCustomEffect] = useState('')

  useEffect(() => {
    if (!adding) return
    if (tab === 'modificacao') {
      const scopes = WEAPON_MOD_SCOPE[itemType] ?? []
      if (scopes.length === 0) { setCatalog([]); return }
      supabase.from('weapon_mods').select('id, name, effect').in('applies_to', scopes).order('name').then(({ data }) => setCatalog(data ?? []))
    } else {
      const scope = CURSE_SCOPE[itemType]
      if (!scope) { setCatalog([]); return }
      supabase.from('cursed_afflictions').select('id, name, effect, elemento').eq('applies_to', scope).order('name').then(({ data }) => setCatalog(data ?? []))
    }
  }, [adding, tab, itemType])

  async function persist(next: AppliedModifier[]) {
    await supabase.from('character_inventory').update({ applied_modifiers: next }).eq('id', inventoryId)
    onChanged()
  }

  async function addFromCatalog(entry: CatalogEntry) {
    await persist([...applied, { kind: tab, name: entry.name, effect: entry.effect, elemento: entry.elemento ?? null }])
  }

  async function addCustom() {
    if (!customName || !customEffect) return
    await persist([...applied, { kind: tab, name: customName, effect: customEffect, elemento: customElement || null }])
    setCustomName(''); setCustomElement(''); setCustomEffect(''); setCreatingCustom(false); setAdding(false)
  }

  async function removeApplied(index: number) {
    await persist(applied.filter((_, i) => i !== index))
  }

  return (
    <div>
      <p><strong>Modificadores e Maldições:</strong></p>
      <ul>
        {applied.map((m, i) => (
          <li key={i}>
            [{m.kind === 'modificacao' ? 'Modificação' : 'Maldição'}] <strong>{m.name}</strong>{m.elemento ? ` (${m.elemento})` : ''}: {m.effect}
            <button type="button" onClick={() => removeApplied(i)}>x</button>
          </li>
        ))}
      </ul>

      <button type="button" onClick={() => setAdding((a) => !a)}>Adicionar</button>

      {adding && (
        <div>
          <nav>
            <button type="button" onClick={() => { setTab('modificacao'); setCreatingCustom(false) }} disabled={tab === 'modificacao' && !creatingCustom}>Modificações</button>
            <button type="button" onClick={() => { setTab('maldicao'); setCreatingCustom(false) }} disabled={tab === 'maldicao' && !creatingCustom}>Maldições</button>
          </nav>

          <button type="button" onClick={() => setCreatingCustom(true)}>Criar Nova {tab === 'modificacao' ? 'Modificação' : 'Maldição'}</button>

          {creatingCustom ? (
            <div>
              <label>Nome <input value={customName} onChange={(e) => setCustomName(e.target.value)} /></label>
              <label>Elemento <input value={customElement} onChange={(e) => setCustomElement(e.target.value)} /></label>
              <label>Descrição <textarea value={customEffect} onChange={(e) => setCustomEffect(e.target.value)} /></label>
              <button type="button" onClick={() => setCreatingCustom(false)}>Voltar</button>
              <button type="button" onClick={addCustom}>Adicionar</button>
            </div>
          ) : catalog.length === 0 ? (
            <p>Sem {tab === 'modificacao' ? 'modificações' : 'maldições'} cadastradas ainda pra esse tipo de item.</p>
          ) : (
            <ul>
              {catalog.map((c) => (
                <li key={c.id}>
                  <strong>{c.name}</strong>{c.elemento ? ` (${c.elemento})` : ''}: {c.effect}
                  <button type="button" onClick={() => addFromCatalog(c)}>Adicionar</button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  )
}
