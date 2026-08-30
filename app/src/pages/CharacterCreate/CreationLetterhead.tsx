import brasaoSm from '../../assets/criacao/brasao-ordo-realitas-sm.png'

export default function CreationLetterhead({ docNumber }: { docNumber: string }) {
  return (
    <header className="creation-letterhead">
      <div>
        <h2 className="creation-title">ORDO REALITAS</h2>
        <p className="creation-underline">Documento oficial n: {docNumber}</p>
        <p className="creation-underline">Termo de boas-vindas</p>
      </div>
      <img className="creation-crest-sm" src={brasaoSm} alt="" />
    </header>
  )
}
