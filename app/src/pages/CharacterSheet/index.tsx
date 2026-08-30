import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import type { Attributes } from '../../lib/rules'
import AgenteTab from './AgenteTab'
import InvestigacaoTab from './InvestigacaoTab'
import DiceRoller from './DiceRoller'
import ProgressaoTab from './ProgressaoTab'
import AfinidadeTab from './AfinidadeTab'
import InterludioTab from './InterludioTab'
import RegrasExtrasTab from './RegrasExtrasTab'
import ConfiguracoesPanel from './ConfiguracoesPanel'
import HistoricoRolagens from './HistoricoRolagens'
import bgPadrao from '../../assets/backgrounds/bg-padrao.webp'
import bgSangue from '../../assets/backgrounds/bg-sangue.webp'
import bgMorte from '../../assets/backgrounds/bg-morte.webp'
import bgConhecimento from '../../assets/backgrounds/bg-conhecimento.webp'
import bgEnergia from '../../assets/backgrounds/bg-energia.webp'

const ELEMENT_BACKGROUNDS: Record<string, string> = {
  sangue: bgSangue,
  morte: bgMorte,
  conhecimento: bgConhecimento,
  energia: bgEnergia,
}

export type CharacterRecord = {
  id: string
  campaign_id: string | null
  name: string
  avatar_url: string | null
  doc_number: string
  attributes: Attributes
  nex_percent: number
  nex_mode: string
  experience: number | null
  current_pv: number | null
  temp_pv: number
  max_pv_override: number | null
  current_sanity: number | null
  temp_sanity: number
  max_sanity_override: number | null
  current_pe: number | null
  current_pd: number | null
  patente: string
  prestigio: number
  optional_rules: Record<string, boolean>
  afinidade_elemento: string | null
  sheet_banner: string
  dice_tray: string
  editable_by_others: boolean
  hidden_from_others: boolean
  origin_id: string | null
  custom_origin: { name: string; skill1Id: string | null; skill2Id: string | null; powerName: string; powerDescription: string } | null
  class_id: string | null
  custom_class: {
    name: string
    pvInitial: number | null
    pvPerNex: number | null
    peInitial: number | null
    pePerNex: number | null
    sanityInitial: number | null
    sanityPerNex: number | null
    pdInitial: number | null
    pdPerNex: number | null
    trainedSkillsText: string
    proficienciesText: string
  } | null
}

const TABS = ['Agente', 'Investigação', 'Afinidade', 'Progressão', 'Interlúdio', 'Regras Extras'] as const

export default function CharacterSheet() {
  const { id } = useParams()
  const [character, setCharacter] = useState<CharacterRecord | null>(null)
  const [originName, setOriginName] = useState<string | null>(null)
  const [className, setClassName] = useState<string | null>(null)
  const [tab, setTab] = useState<(typeof TABS)[number]>('Agente')
  const [refreshKey, setRefreshKey] = useState(0)
  const [showDice, setShowDice] = useState(false)
  const [editMode, setEditMode] = useState(false)
  const [showConfig, setShowConfig] = useState(false)
  const [showHistory, setShowHistory] = useState(false)

  useEffect(() => {
    if (!id) return
    supabase
      .from('characters')
      .select('*')
      .eq('id', id)
      .single()
      .then(async ({ data }) => {
        setCharacter(data)
        if (data?.origin_id) {
          const { data: origin } = await supabase.from('origins').select('name').eq('id', data.origin_id).single()
          setOriginName(origin?.name ?? null)
        } else if (data?.custom_origin) {
          setOriginName(data.custom_origin.name)
        }
        if (data?.class_id) {
          const { data: cls } = await supabase.from('classes').select('name').eq('id', data.class_id).single()
          setClassName(cls?.name ?? null)
        } else if (data?.custom_class) {
          setClassName(data.custom_class.name)
        }
      })
  }, [id, refreshKey])

  if (!character) return <main>Carregando…</main>

  const elemento = character.afinidade_elemento
  const bgImage = (elemento && ELEMENT_BACKGROUNDS[elemento]) ?? bgPadrao
  const bgClass = elemento && ELEMENT_BACKGROUNDS[elemento] ? `bg-${elemento}` : 'bg-padrao'

  return (
    <main className="sheet-root">
      <div
        className={`sheet-bg ${bgClass}`}
        style={{ backgroundImage: `linear-gradient(rgba(19,17,24,0.4), rgba(19,17,24,0.4)), url(${bgImage})` }}
      />
      <header className="vtt-topbar">
        <nav className="vtt-tabs">
          {TABS.map((t) => (
            <button key={t} type="button" onClick={() => setTab(t)} disabled={tab === t}>{t}</button>
          ))}
        </nav>
        <div style={{ display: 'flex', gap: '0.5em', alignItems: 'center' }}>
          <button type="button" className="vtt-icon-btn" aria-label="Dados" onClick={() => setShowDice((v) => !v)}>🎲</button>
          <button type="button" onClick={() => setEditMode((v) => !v)}>{editMode ? 'Modo de Jogo' : 'Modo de Edição'}</button>
          <button type="button" className="vtt-icon-btn" aria-label="Configurações" onClick={() => setShowConfig((v) => !v)}>⚙</button>
          <button type="button" className="vtt-icon-btn" aria-label="Histórico de Rolagens" onClick={() => setShowHistory((v) => !v)}>📖</button>
        </div>
      </header>

      {showDice && <DiceRoller character={character} onClose={() => setShowDice(false)} />}
      {showConfig && (
        <ConfiguracoesPanel
          character={character}
          onUpdated={() => setRefreshKey((k) => k + 1)}
          onClose={() => setShowConfig(false)}
        />
      )}
      {showHistory && <HistoricoRolagens character={character} onClose={() => setShowHistory(false)} />}

      {tab === 'Agente' && (
        <AgenteTab
          character={character}
          onUpdated={() => setRefreshKey((k) => k + 1)}
          editMode={editMode}
          originName={originName}
          className={className}
          onNameChange={async (name) => {
            setCharacter((c) => (c ? { ...c, name } : c))
            await supabase.from('characters').update({ name }).eq('id', character.id)
          }}
        />
      )}
      {tab === 'Investigação' && (
        <InvestigacaoTab character={character} originName={originName} className={className} />
      )}
      {tab === 'Progressão' && (
        <ProgressaoTab character={character} onUpdated={() => setRefreshKey((k) => k + 1)} />
      )}
      {tab === 'Afinidade' && (
        <AfinidadeTab character={character} onUpdated={() => setRefreshKey((k) => k + 1)} />
      )}
      {tab === 'Interlúdio' && (
        <InterludioTab character={character} onUpdated={() => setRefreshKey((k) => k + 1)} />
      )}
      {tab === 'Regras Extras' && <RegrasExtrasTab />}
    </main>
  )
}
