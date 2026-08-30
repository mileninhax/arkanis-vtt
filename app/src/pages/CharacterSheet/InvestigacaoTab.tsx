import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import type { CharacterRecord } from './index'

type Page = {
  id: string
  title: string
  objective: string
  summary: string
  questions: string
  clues: string
}

type PersonalFields = {
  aparencia: string | null
  personalidade: string | null
  objetivo: string | null
  historico: string | null
  lembrete_fechado: boolean
}

export default function InvestigacaoTab({ character, originName, className }: { character: CharacterRecord; originName: string | null; className: string | null }) {
  const [subTab, setSubTab] = useState<'pessoal' | 'investigacao'>('pessoal')
  const [personal, setPersonal] = useState<PersonalFields | null>(null)
  const [pages, setPages] = useState<Page[]>([])
  const [activePage, setActivePage] = useState<string | null>(null)

  useEffect(() => {
    supabase
      .from('characters')
      .select('aparencia, personalidade, objetivo, historico, lembrete_fechado')
      .eq('id', character.id)
      .single()
      .then(({ data }) => setPersonal(data))
    loadPages()
  }, [character.id])

  async function loadPages() {
    const { data } = await supabase
      .from('character_investigation_pages')
      .select('id, title, objective, summary, questions, clues')
      .eq('character_id', character.id)
      .order('sort_order')
    setPages(data ?? [])
    if (data?.length && !activePage) setActivePage(data[0].id)
  }

  async function savePersonalField(field: keyof PersonalFields, value: string | boolean) {
    setPersonal((p) => (p ? { ...p, [field]: value } : p))
    await supabase.from('characters').update({ [field]: value }).eq('id', character.id)
  }

  async function addPage() {
    const { data } = await supabase
      .from('character_investigation_pages')
      .insert({ character_id: character.id, sort_order: pages.length })
      .select('id')
      .single()
    await loadPages()
    if (data) setActivePage(data.id)
  }

  async function removePage(id: string) {
    await supabase.from('character_investigation_pages').delete().eq('id', id)
    if (activePage === id) setActivePage(null)
    await loadPages()
  }

  async function updatePage(id: string, patch: Partial<Page>) {
    setPages((ps) => ps.map((p) => (p.id === id ? { ...p, ...patch } : p)))
    await supabase.from('character_investigation_pages').update(patch).eq('id', id)
  }

  const current = pages.find((p) => p.id === activePage)

  return (
    <div>
      <nav>
        <button type="button" onClick={() => setSubTab('pessoal')} disabled={subTab === 'pessoal'}>Pessoal</button>
        <button type="button" onClick={() => setSubTab('investigacao')} disabled={subTab === 'investigacao'}>Investigação</button>
      </nav>

      {subTab === 'pessoal' && personal && (
        <div>
          <section>
            <p>Doc.No: {character.doc_number} — AGENTE</p>
            <p>{character.name}</p>
            <p>{originName} — {className}</p>
          </section>

          <label>Aparência <textarea value={personal.aparencia ?? ''} onChange={(e) => savePersonalField('aparencia', e.target.value)} /></label>
          <label>Personalidade <textarea value={personal.personalidade ?? ''} onChange={(e) => savePersonalField('personalidade', e.target.value)} /></label>
          <label>Objetivo <textarea value={personal.objetivo ?? ''} onChange={(e) => savePersonalField('objetivo', e.target.value)} /></label>
          <label>Histórico <textarea rows={6} value={personal.historico ?? ''} onChange={(e) => savePersonalField('historico', e.target.value)} /></label>

          {!personal.lembrete_fechado && (
            <div>
              <button type="button" onClick={() => savePersonalField('lembrete_fechado', true)}>x</button>
              <p><strong>Lembrete:</strong> Anote as perguntas que você tem ao longo da investigação, e responda-as à medida que encontra evidências.</p>
            </div>
          )}
        </div>
      )}

      {subTab === 'investigacao' && (
        <div>
          <nav>
            {pages.map((p) => (
              <span key={p.id}>
                <button type="button" onClick={() => setActivePage(p.id)} disabled={activePage === p.id}>{p.title || '(sem título)'}</button>
                <button type="button" onClick={() => removePage(p.id)}>Excluir</button>
              </span>
            ))}
            <button type="button" onClick={addPage}>Adicionar nova página</button>
          </nav>

          {current && (
            <div>
              <label>Título/Identificador <input value={current.title} onChange={(e) => updatePage(current.id, { title: e.target.value })} /></label>
              <label>Objetivo <input value={current.objective} onChange={(e) => updatePage(current.id, { objective: e.target.value })} /></label>
              <label>Resumo <textarea rows={6} value={current.summary} onChange={(e) => updatePage(current.id, { summary: e.target.value })} /></label>
              <label>Perguntas <textarea value={current.questions} onChange={(e) => updatePage(current.id, { questions: e.target.value })} /></label>
              <label>Pistas <textarea value={current.clues} onChange={(e) => updatePage(current.id, { clues: e.target.value })} /></label>
            </div>
          )}
        </div>
      )}
    </div>
  )
}
