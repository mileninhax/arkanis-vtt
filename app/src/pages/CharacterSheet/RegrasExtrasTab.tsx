import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'

type Rule = { id: string; category: string; title: string; content: string }

const CATEGORY_LABELS: Record<string, string> = {
  mecanicas_de_cena: 'Mecânicas de Cena',
  combate_alternativo: 'Regras de Combate Alternativas',
  equipamento_especial: 'Equipamento Especial',
  campanha: 'Campanha',
}

export default function RegrasExtrasTab() {
  const [rules, setRules] = useState<Rule[]>([])
  const [expanded, setExpanded] = useState<string | null>(null)
  const [search, setSearch] = useState('')

  useEffect(() => {
    supabase.from('extra_rules').select('id, category, title, content').order('category').order('sort_order').then(({ data }) => setRules(data ?? []))
  }, [])

  const filtered = rules.filter((r) => r.title.toLowerCase().includes(search.toLowerCase()))
  const categories = Array.from(new Set(filtered.map((r) => r.category)))

  return (
    <div>
      <p><em>Conteúdo de referência — não altera nenhum cálculo da ficha, só documenta como resolver situações de jogo específicas sem precisar abrir o livro.</em></p>
      <input placeholder="Buscar Regras Extras" value={search} onChange={(e) => setSearch(e.target.value)} />

      {categories.map((cat) => (
        <section key={cat}>
          <h3>{CATEGORY_LABELS[cat] ?? cat}</h3>
          <ul>
            {filtered.filter((r) => r.category === cat).map((r) => (
              <li key={r.id}>
                <button type="button" onClick={() => setExpanded(expanded === r.id ? null : r.id)}>{r.title}</button>
                {expanded === r.id && <p style={{ whiteSpace: 'pre-wrap' }}>{r.content}</p>}
              </li>
            ))}
          </ul>
        </section>
      ))}
    </div>
  )
}
