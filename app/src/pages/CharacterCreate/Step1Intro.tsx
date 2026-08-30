import type { CharacterDraft } from './types'
import brasao from '../../assets/criacao/brasao-ordo-realitas.png'
import brasaoSm from '../../assets/criacao/brasao-ordo-realitas-sm.png'
import stepArrow from '../../assets/criacao/step-arrow.svg'
import papelTextura from '../../assets/criacao/papel-textura.png'

const RULES = [
  {
    title: 'Eliminar ameaças sobrenaturais',
    text: 'Se for perigoso, instável ou tentar romper a Membrana, lide com isso com eficiência e sem hesitar.',
  },
  {
    title: 'Apoiar as equipes de campo',
    text: 'Trabalhamos em conjunto, logo, ofereça suporte e cobertura em combate aos outros membros.',
  },
  {
    title: 'Registrar tudo*',
    text: 'Nenhum caso deve desaparecer sem registro. Seus relatórios vão ajudar a Ordem em operações futuras.',
  },
  {
    title: 'Desmantelar grupos ocultistas',
    text: 'Eles são grandes ameaças à Membrana, interfira sempre que possível.',
  },
  {
    title: 'Proteger civis',
    text: 'A população não precisa saber o que está acontecendo.',
  },
]

export default function Step1Intro({ draft, onNext }: { draft: CharacterDraft; onNext: () => void }) {
  const today = new Date().toLocaleDateString('pt-BR')

  return (
    <div className="creation-spread">
      <div className="creation-paper creation-paper-left" style={{ backgroundImage: `url(${papelTextura})` }}>
        <img className="creation-crest" src={brasao} alt="Ordo Realitas" />
        <h2 className="creation-title">Ficha do Agente</h2>
        <p>Este documento é estritamente confidencial e não pode deixar a base sob nenhuma circunstância.</p>

        <div className="creation-fields">
          <label className="creation-field">Doc.No:<span>{draft.docNumber}</span></label>
          <label className="creation-field">Data:<span>{today}</span></label>
        </div>
      </div>

      <div className="creation-paper creation-paper-right" style={{ backgroundImage: `url(${papelTextura})` }}>
        <header className="creation-letterhead">
          <div>
            <h2 className="creation-title">ORDO REALITAS</h2>
            <p className="creation-underline">Documento oficial n: {draft.docNumber}</p>
            <p className="creation-underline">Termo de boas-vindas</p>
          </div>
          <img className="creation-crest-sm" src={brasaoSm} alt="" />
        </header>

        <p>Bem-Vindo, Agente.</p>
        <p>A partir de agora, você faz parte da Ordo Realitas, uma organização dedicada a proteger a Membrana, a barreira que separa o nosso mundo do outro lado.</p>
        <p>O que esperamos de você:</p>

        <ol className="creation-rules">
          {RULES.map((rule, i) => (
            <li key={rule.title}>
              <span className="creation-rule-title"><span className="creation-rule-num">{i + 1}.</span> {rule.title}</span>
              <p>{rule.text}</p>
            </li>
          ))}
        </ol>

        <p>Antes de terminarmos, precisamos apenas de algumas informações sobre você. Continue lendo o documento e insira as informações necessárias.</p>
        <p className="creation-footnote">*Não gravar o combate</p>
      </div>

      <button type="button" className="creation-next-arrow" onClick={onNext} aria-label="Avançar">
        <img src={stepArrow} alt="" />
      </button>
    </div>
  )
}
