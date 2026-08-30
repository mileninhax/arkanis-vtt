import { Link } from 'react-router-dom'

const SYSTEMS = [
  { slug: 'ordem-paranormal', name: 'Ordem Paranormal', description: 'Investigadores da Ordo Realitas contra o Outro Lado.' },
]

export default function SystemSelect() {
  return (
    <main>
      <h1>Criar Novo Personagem</h1>
      <p>Escolha o sistema:</p>

      <ul>
        {SYSTEMS.map((s) => (
          <li key={s.slug}>
            <h2>{s.name}</h2>
            <p>{s.description}</p>
            <Link to={`/personagem/criar/${s.slug}`}>Criar Personagem</Link>
          </li>
        ))}
      </ul>
    </main>
  )
}
