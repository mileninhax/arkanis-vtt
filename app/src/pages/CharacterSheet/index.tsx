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

export type CharacterRecord = {
  id: string
  campaign_id: string | null
  name: string
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

  return (
    <main>
      <header>
        {editMode ? (
          <input
            value={character.name}
            onChange={async (e) => {
              const name = e.target.value
              setCharacter((c) => (c ? { ...c, name } : c))
              await supabase.from('characters').update({ name }).eq('id', character.id)
            }}
          />
        ) : (
          <h1>{character.name}</h1>
        )}
        <p>{originName} — {className}</p>
        <button type="button" onClick={() => setShowDice((v) => !v)}>Dados</button>
        <button type="button" onClick={() => setEditMode((v) => !v)}>{editMode ? 'Modo de Jogo' : 'Modo de Edição'}</button>
        <button type="button" aria-label="Configurações" onClick={() => setShowConfig((v) => !v)}>⚙</button>
        <button type="button" aria-label="Histórico de Rolagens" onClick={() => setShowHistory((v) => !v)}>📖🕓</button>
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

      <nav>
        {TABS.map((t) => (
          <button key={t} type="button" onClick={() => setTab(t)} disabled={tab === t}>{t}</button>
        ))}
      </nav>

      {tab === 'Agente' && (
        <AgenteTab character={character} onUpdated={() => setRefreshKey((k) => k + 1)} editMode={editMode} />
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
