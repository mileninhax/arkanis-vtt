import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'

export type Modifier = {
  id: string
  name: string
  dice_bonus: number
  value_bonus: number
  threat_margin_bonus: number
  multiplier_bonus: number
  damage_type: string | null
  is_active: boolean
}

export default function ModifiersPanel({
  characterId,
  scope,
  showThreatAndMultiplier,
  onChange,
  onDraftChange,
}: {
  characterId: string
  scope: 'teste' | 'ataque' | 'dano'
  showThreatAndMultiplier?: boolean
  onChange?: (modifiers: Modifier[]) => void
  onDraftChange?: (draft: { diceBonus: number; valueBonus: number }) => void
}) {
  const [modifiers, setModifiers] = useState<Modifier[]>([])
  const [open, setOpen] = useState(false)
  const [name, setName] = useState('')
  const [diceBonus, setDiceBonus] = useState(0)
  const [valueBonus, setValueBonus] = useState(0)
  const [threatBonus, setThreatBonus] = useState(0)
  const [multiplierBonus, setMultiplierBonus] = useState(0)
  const [damageType, setDamageType] = useState('')

  async function load() {
    const { data } = await supabase
      .from('character_modifiers')
      .select('id, name, dice_bonus, value_bonus, threat_margin_bonus, multiplier_bonus, damage_type, is_active')
      .eq('character_id', characterId)
      .eq('scope', scope)
    setModifiers(data ?? [])
    onChange?.(data ?? [])
  }

  useEffect(() => { load() }, [characterId, scope])

  useEffect(() => { onDraftChange?.({ diceBonus, valueBonus }) }, [diceBonus, valueBonus])

  async function addModifier() {
    if (!name) return
    await supabase.from('character_modifiers').insert({
      character_id: characterId,
      scope,
      name,
      dice_bonus: diceBonus,
      value_bonus: valueBonus,
      threat_margin_bonus: threatBonus,
      multiplier_bonus: multiplierBonus,
      damage_type: damageType || null,
    })
    setName(''); setDiceBonus(0); setValueBonus(0); setThreatBonus(0); setMultiplierBonus(0); setDamageType('')
    await load()
  }

  async function toggleActive(m: Modifier) {
    await supabase.from('character_modifiers').update({ is_active: !m.is_active }).eq('id', m.id)
    await load()
  }

  async function remove(id: string) {
    await supabase.from('character_modifiers').delete().eq('id', id)
    await load()
  }

  return (
    <div>
      <button type="button" onClick={() => setOpen((o) => !o)}>Modificadores ({open ? 'ocultar' : 'mostrar'})</button>
      {open && (
        <div>
          <ul>
            {modifiers.map((m) => (
              <li key={m.id}>
                <label>
                  <input type="checkbox" checked={m.is_active} onChange={() => toggleActive(m)} />
                  {m.name} (dados {m.dice_bonus >= 0 ? '+' : ''}{m.dice_bonus}, valor {m.value_bonus >= 0 ? '+' : ''}{m.value_bonus}
                  {showThreatAndMultiplier ? `, margem ${m.threat_margin_bonus >= 0 ? '+' : ''}${m.threat_margin_bonus}, mult. ${m.multiplier_bonus >= 0 ? '+' : ''}${m.multiplier_bonus}` : ''})
                </label>
                <button type="button" onClick={() => remove(m.id)}>x</button>
              </li>
            ))}
          </ul>

          <div>
            <label>Nome do Modificador <input value={name} onChange={(e) => setName(e.target.value)} /></label>
            <label>
              Dados Bônus
              <button type="button" onClick={() => setDiceBonus((v) => v - 1)}>-</button>
              <input type="number" value={diceBonus} onChange={(e) => setDiceBonus(Number(e.target.value))} />
              <button type="button" onClick={() => setDiceBonus((v) => v + 1)}>+</button>
            </label>
            <label>
              Valor Bônus
              <button type="button" onClick={() => setValueBonus((v) => v - 1)}>-</button>
              <input type="number" value={valueBonus} onChange={(e) => setValueBonus(Number(e.target.value))} />
              <button type="button" onClick={() => setValueBonus((v) => v + 1)}>+</button>
            </label>
            {showThreatAndMultiplier && (
              <>
                <label>Margem Crítica Bônus <input type="number" value={threatBonus} onChange={(e) => setThreatBonus(Number(e.target.value))} /></label>
                <label>Multiplicador Crítico Bônus <input type="number" value={multiplierBonus} onChange={(e) => setMultiplierBonus(Number(e.target.value))} /></label>
              </>
            )}
            {scope === 'dano' && (
              <label>Tipo de Dano <input value={damageType} onChange={(e) => setDamageType(e.target.value)} /></label>
            )}
            <button type="button" onClick={addModifier}>Adicionar</button>
          </div>
        </div>
      )}
    </div>
  )
}
