import type { CharacterDraft } from './types'

const EXPECTATIONS = [
  'Eliminar ameaças sobrenaturais',
  'Apoiar as equipes de campo',
  'Registrar tudo',
  'Desmantelar grupos ocultistas',
  'Proteger civis',
]

export default function Step1Intro({ draft, onNext }: { draft: CharacterDraft; onNext: () => void }) {
  const today = new Date().toLocaleDateString('pt-BR')

  return (
    <div>
      <section>
        <h2>Ficha do Agente</h2>
        <p>Este documento é estritamente confidencial e não pode deixar a base sob nenhuma circunstância.</p>
        <p>Doc.No: {draft.docNumber}</p>
        <p>Data: {today}</p>
      </section>

      <section>
        <header>
          <strong>ORDO REALITAS</strong>
          <p>Documento oficial n: {draft.docNumber}</p>
          <p>Termo de boas-vindas</p>
        </header>

        <ol>
          {EXPECTATIONS.map((title) => (
            <li key={title}>
              <strong>{title}</strong>
              {/* Parágrafo explicativo de cada expectativa: pendente do texto de referência da Millie. */}
            </li>
          ))}
        </ol>

        <p><em>*Não gravar o combate</em></p>
      </section>

      <button type="button" onClick={onNext}>Avançar →</button>
    </div>
  )
}
