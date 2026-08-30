import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import type { CharacterRecord } from './index'

const ELEMENTOS = [
  { key: 'sangue', name: 'Sangue', description: 'Vitalidade, fúria, o corpo levado ao extremo.' },
  { key: 'morte', name: 'Morte', description: 'Entropia, decadência, o fim de todas as coisas.' },
  { key: 'conhecimento', name: 'Conhecimento', description: 'Segredos proibidos, mente e percepção além do véu.' },
  { key: 'energia', name: 'Energia', description: 'Caos, eletricidade, o acaso que rege o universo.' },
] as const

export default function AfinidadeTab({ character, onUpdated }: { character: CharacterRecord & { afinidade_elemento?: string | null }; onUpdated: () => void }) {
  const [elemento, setElemento] = useState<string | null>(null)
  const [confirming, setConfirming] = useState<string | null>(null)
  const [rituais, setRituais] = useState<{ id: string; name: string; circle: number }[]>([])
  const [poderes, setPoderes] = useState<{ id: string; name: string; description: string }[]>([])

  useEffect(() => {
    supabase.from('characters').select('afinidade_elemento').eq('id', character.id).single().then(({ data }) => setElemento(data?.afinidade_elemento ?? null))
  }, [character.id])

  useEffect(() => {
    if (!elemento) return
    supabase.from('rituals').select('id, name, circle').eq('elemento', elemento).order('circle').then(({ data }) => setRituais(data ?? []))
    supabase.from('paranormal_powers').select('id, name, description').eq('elemento', elemento).order('name').then(({ data }) => setPoderes(data ?? []))
  }, [elemento])

  async function confirmElemento(key: string) {
    await supabase.from('characters').update({ afinidade_elemento: key }).eq('id', character.id)
    setElemento(key)
    setConfirming(null)
    onUpdated()
  }

  if (!elemento) {
    return (
      <div>
        <h2>Afinidade</h2>
        <p>Escolha um elemento. Essa escolha é definitiva.</p>
        <ul>
          {ELEMENTOS.map((e) => (
            <li key={e.key}>
              <strong>{e.name}</strong>: {e.description}
              {confirming === e.key ? (
                <>
                  <span> Tem certeza? Essa escolha não pode ser desfeita.</span>
                  <button type="button" onClick={() => confirmElemento(e.key)}>Confirmar</button>
                  <button type="button" onClick={() => setConfirming(null)}>Cancelar</button>
                </>
              ) : (
                <button type="button" onClick={() => setConfirming(e.key)}>Escolher {e.name}</button>
              )}
            </li>
          ))}
        </ul>
      </div>
    )
  }

  const current = ELEMENTOS.find((e) => e.key === elemento)!

  return (
    <div>
      <h2>Afinidade: {current.name}</h2>
      <p>{current.description}</p>

      <section>
        <h3>Rituais de {current.name}</h3>
        {rituais.length === 0 ? <p>Nenhum cadastrado ainda.</p> : (
          <ul>{rituais.map((r) => <li key={r.id}>{r.circle}º — {r.name}</li>)}</ul>
        )}
      </section>

      <section>
        <h3>Poderes Paranormais de {current.name}</h3>
        {poderes.length === 0 ? <p>Nenhum cadastrado ainda.</p> : (
          <ul>{poderes.map((p) => <li key={p.id}><strong>{p.name}</strong>: {p.description}</li>)}</ul>
        )}
      </section>
    </div>
  )
}
