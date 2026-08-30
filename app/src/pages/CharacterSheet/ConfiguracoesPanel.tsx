import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import type { CharacterRecord } from './index'

const RULES: { key: string; label: string }[] = [
  { key: 'nex_experiencia', label: 'NEX & Experiência' },
  { key: 'contagem_municao', label: 'Contagem de Munição' },
  { key: 'sem_sanidade', label: 'Jogando sem Sanidade' },
  { key: 'evolucao_patente', label: 'Evolução por Patente' },
  { key: 'ferimentos_debilitantes', label: 'Ferimentos Debilitantes' },
]

const CONFIG_TABS = ['Aparência', 'Mecânicas', 'Preferências'] as const

function BannerPicker({
  label,
  value,
  elemento,
  onSave,
}: {
  label: string
  value: string
  elemento: string | null
  onSave: (v: string) => void
}) {
  const [open, setOpen] = useState(false)
  const [choice, setChoice] = useState(value)

  return (
    <div>
      <p>{label}: {value === 'padrao' ? 'Padrão' : value}</p>
      <button type="button" onClick={() => { setChoice(value); setOpen(true) }}>Mudar {label}</button>
      {open && (
        <div role="dialog">
          <p>Selecione um {label.toLowerCase()}</p>
          <label>
            <input type="radio" name={label} checked={choice === 'padrao'} onChange={() => setChoice('padrao')} />
            Padrão (preto)
          </label>
          <label>
            <input type="radio" name={label} disabled={!elemento} checked={choice === 'tema_afinidade'} onChange={() => setChoice('tema_afinidade')} />
            Tema da Afinidade ({elemento ?? 'escolha uma Afinidade primeiro'}) — visual ainda não definido
          </label>
          <button type="button" onClick={() => { onSave(choice); setOpen(false) }}>Salvar</button>
          <button type="button" onClick={() => setOpen(false)}>Cancelar</button>
        </div>
      )}
    </div>
  )
}

export default function ConfiguracoesPanel({
  character,
  onUpdated,
  onClose,
}: {
  character: CharacterRecord
  onUpdated: () => void
  onClose: () => void
}) {
  const [configTab, setConfigTab] = useState<(typeof CONFIG_TABS)[number]>('Aparência')
  const [volume, setVolume] = useState(100)
  const [muted, setMuted] = useState(false)

  useEffect(() => {
    const stored = localStorage.getItem('vtt_volume')
    if (stored) setVolume(Number(stored))
    setMuted(localStorage.getItem('vtt_muted') === 'true')
  }, [])

  async function updateField(patch: Partial<CharacterRecord>) {
    await supabase.from('characters').update(patch).eq('id', character.id)
    onUpdated()
  }

  function toggleRule(key: string) {
    updateField({ optional_rules: { ...character.optional_rules, [key]: !character.optional_rules[key] } })
  }

  function setVolumeAndStore(v: number) {
    setVolume(v)
    localStorage.setItem('vtt_volume', String(v))
  }

  function toggleMuted() {
    const next = !muted
    setMuted(next)
    localStorage.setItem('vtt_muted', String(next))
  }

  return (
    <aside role="dialog" aria-label="Configurações">
      <header>
        <h2>Configurações</h2>
        <button type="button" onClick={onClose}>Fechar</button>
      </header>

      <nav>
        {CONFIG_TABS.map((t) => (
          <button key={t} type="button" onClick={() => setConfigTab(t)} disabled={configTab === t}>{t}</button>
        ))}
      </nav>

      {configTab === 'Aparência' && (
        <section>
          <BannerPicker
            label="Banner"
            value={character.sheet_banner}
            elemento={character.afinidade_elemento}
            onSave={(v) => updateField({ sheet_banner: v })}
          />
          <BannerPicker
            label="Bandeja de Dados"
            value={character.dice_tray}
            elemento={character.afinidade_elemento}
            onSave={(v) => updateField({ dice_tray: v })}
          />
        </section>
      )}

      {configTab === 'Mecânicas' && (
        <section>
          <h3>Regras Opcionais</h3>
          {RULES.map(({ key, label }) => (
            <label key={key}>
              <input
                type="checkbox"
                checked={Boolean(character.optional_rules[key])}
                onChange={() => toggleRule(key)}
              />
              {label}
            </label>
          ))}

          {character.optional_rules.evolucao_patente && (
            <div>
              <p>Patente ajustável na aba Agente.</p>
              <label>
                Pontos de Prestígio:
                <input
                  type="number"
                  value={character.prestigio}
                  onChange={(e) => updateField({ prestigio: Number(e.target.value) })}
                />
              </label>
            </div>
          )}
        </section>
      )}

      {configTab === 'Preferências' && (
        <section>
          <h3>Privacidade</h3>
          <label>
            <input
              type="checkbox"
              checked={character.editable_by_others}
              onChange={(e) => updateField({ editable_by_others: e.target.checked })}
            />
            Editável para outros jogadores
          </label>
          <label>
            <input
              type="checkbox"
              checked={character.hidden_from_others}
              onChange={(e) => updateField({ hidden_from_others: e.target.checked })}
            />
            Oculta para outros jogadores
          </label>

          <h3>Som</h3>
          <label>
            Volume
            <input
              type="range"
              min={0}
              max={100}
              value={volume}
              disabled={muted}
              onChange={(e) => setVolumeAndStore(Number(e.target.value))}
            />
          </label>
          <button type="button" onClick={toggleMuted}>{muted ? 'Ligar Som' : 'Desligar Som'}</button>
        </section>
      )}
    </aside>
  )
}
