import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { attrValue, rollAttributeTest, rollDiceFormula, trainingBonus, type AttributeKey, type Training } from '../../lib/rules'
import type { CharacterRecord } from './index'
import RollResult, { type RollResultData } from './RollResult'
import ModifiersPanel, { type Modifier } from './ModifiersPanel'

type Attack = {
  id: string
  name: string
  skill_id: string | null
  attribute: AttributeKey | null
  d20_bonus: number
  threat_margin: number
  multiplier: number
  damage: { formula: string; tipo: string }[]
  general_info: {
    tipo?: string
    empunhadura?: string
    alcance?: string
    tipo_municao?: string
    municao?: string | null
    modificadores?: { kind: 'modificacao' | 'maldicao'; name: string; effect: string; elemento: string | null; origem: 'Arma' | 'Munição' }[]
    damage_bonus_from_mods?: number
  } | null
}

type Skill = { id: string; name: string }

const ATTRS: AttributeKey[] = ['forca', 'agilidade', 'intelecto', 'vigor', 'presenca']

const emptyForm = { name: '', skillId: '', attribute: 'forca' as AttributeKey, d20Bonus: 0, threatMargin: 20, multiplier: 2, damage: '', damageType: '' }

export default function CombateTab({ character }: { character: CharacterRecord }) {
  const [attacks, setAttacks] = useState<Attack[]>([])
  const [skills, setSkills] = useState<Skill[]>([])
  const [charSkillBonus, setCharSkillBonus] = useState<Record<string, number>>({})
  const [equippedDefense, setEquippedDefense] = useState(0)
  const [adding, setAdding] = useState(false)
  const [form, setForm] = useState(emptyForm)
  const [roll, setRoll] = useState<RollResultData | null>(null)
  const [attackMods, setAttackMods] = useState<Modifier[]>([])
  const [damageMods, setDamageMods] = useState<Modifier[]>([])

  async function loadAttacks() {
    const { data } = await supabase
      .from('character_attacks')
      .select('id, name, skill_id, attribute, d20_bonus, threat_margin, multiplier, damage, general_info')
      .eq('character_id', character.id)
    setAttacks((data ?? []) as unknown as Attack[])
  }

  useEffect(() => { loadAttacks() }, [character.id])

  useEffect(() => {
    supabase.from('skills').select('id, name').order('sort_order').then(({ data }) => setSkills(data ?? []))
    supabase
      .from('character_skills')
      .select('skill_id, training, extra_bonus')
      .eq('character_id', character.id)
      .then(({ data }) => {
        const map: Record<string, number> = {}
        for (const row of data ?? []) map[row.skill_id] = trainingBonus(row.training as Training) + row.extra_bonus
        setCharSkillBonus(map)
      })
    supabase
      .from('character_inventory')
      .select('is_equipped, equipment_items(type, stats), custom_item')
      .eq('character_id', character.id)
      .eq('is_equipped', true)
      .then(({ data }) => {
        const protection = (data ?? []).find((i: any) => (i.equipment_items?.type ?? i.custom_item?.type) === 'protecao')
        const stats = (protection as any)?.equipment_items?.stats ?? (protection as any)?.custom_item?.stats ?? {}
        setEquippedDefense(Number(stats.defesa ?? 0))
      })
  }, [character.id])

  async function addAttack() {
    if (!form.name) return
    await supabase.from('character_attacks').insert({
      character_id: character.id,
      name: form.name,
      skill_id: form.skillId || null,
      attribute: form.attribute,
      d20_bonus: form.d20Bonus,
      threat_margin: form.threatMargin,
      multiplier: form.multiplier,
      damage: form.damage ? [{ formula: form.damage, tipo: form.damageType }] : [],
    })
    setForm(emptyForm)
    setAdding(false)
    await loadAttacks()
  }

  async function removeAttack(id: string) {
    await supabase.from('character_attacks').delete().eq('id', id)
    await loadAttacks()
  }

  function rollAttack(attack: Attack) {
    const activeAttackMods = attackMods.filter((m) => m.is_active)
    const activeDamageMods = damageMods.filter((m) => m.is_active)

    const attackDiceBonus = activeAttackMods.reduce((sum, m) => sum + m.dice_bonus, 0)
    const attackValueBonus = activeAttackMods.reduce((sum, m) => sum + m.value_bonus, 0)
    const threatBonus = activeAttackMods.reduce((sum, m) => sum + m.threat_margin_bonus, 0)
    const damageValueBonus = activeDamageMods.reduce((sum, m) => sum + m.value_bonus, 0) + (attack.general_info?.damage_bonus_from_mods ?? 0)

    const score = attrValue(character.attributes, attack.attribute) + attackDiceBonus
    const { rolls, kept } = rollAttributeTest(score)
    const skillBonus = attack.skill_id ? (charSkillBonus[attack.skill_id] ?? 0) : 0
    const bonus = skillBonus + attack.d20_bonus + attackValueBonus

    const effectiveThreatMargin = attack.threat_margin - threatBonus
    const isCrit = kept >= effectiveThreatMargin

    const damage = attack.damage.map((d) => {
      const rolled = rollDiceFormula(d.formula, isCrit ? 2 : 1)
      if (!rolled) return { label: `Dano${d.tipo ? ` (${d.tipo})` : ''}${isCrit ? ' — CRÍTICO' : ''}`, manualFormula: d.formula || '—' }
      return { label: `Dano${d.tipo ? ` (${d.tipo})` : ''}${isCrit ? ' — CRÍTICO' : ''}`, rolls: rolled.rolls, modifier: rolled.modifier + damageValueBonus, total: rolled.total + damageValueBonus }
    })

    setRoll({
      label: `Ataque: ${attack.name}${isCrit ? ' (crítico!)' : ''}`,
      rolls,
      kept,
      bonus,
      damage,
      municao: attack.general_info?.municao ?? null,
      modificadores: attack.general_info?.modificadores ?? [],
    })
  }

  const agilidade = character.attributes.agilidade
  const defenseTotal = equippedDefense + agilidade + 10

  return (
    <div>
      {roll && <RollResult result={roll} onClose={() => setRoll(null)} />}

      <section>
        <p><strong>Defesa:</strong> {defenseTotal} (Equip {equippedDefense} + Agilidade {agilidade} + 10)</p>
      </section>

      <section>
        <h3>Modificador de Ataque</h3>
        <ModifiersPanel characterId={character.id} scope="ataque" showThreatAndMultiplier onChange={setAttackMods} />
        <h3>Modificador de Dano</h3>
        <ModifiersPanel characterId={character.id} scope="dano" onChange={setDamageMods} />
      </section>

      <section>
        <button type="button" onClick={() => setAdding((a) => !a)}>Adicionar Ataque</button>

        {adding && (
          <div>
            <label>Nome <input value={form.name} onChange={(e) => setForm((f) => ({ ...f, name: e.target.value }))} /></label>
            <label>Perícia
              <select value={form.skillId} onChange={(e) => setForm((f) => ({ ...f, skillId: e.target.value }))}>
                <option value="">—</option>
                {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
              </select>
            </label>
            <label>Atributo
              <select value={form.attribute} onChange={(e) => setForm((f) => ({ ...f, attribute: e.target.value as AttributeKey }))}>
                {ATTRS.map((a) => <option key={a} value={a}>{a}</option>)}
              </select>
            </label>
            <label>D20 Bônus de Ataque <input type="number" value={form.d20Bonus} onChange={(e) => setForm((f) => ({ ...f, d20Bonus: Number(e.target.value) }))} /></label>
            <label>Margem de Ameaça <input type="number" value={form.threatMargin} onChange={(e) => setForm((f) => ({ ...f, threatMargin: Number(e.target.value) }))} /></label>
            <label>Multiplicador <input type="number" value={form.multiplier} onChange={(e) => setForm((f) => ({ ...f, multiplier: Number(e.target.value) }))} /></label>
            <label>Dano (fórmula) <input value={form.damage} onChange={(e) => setForm((f) => ({ ...f, damage: e.target.value }))} placeholder="1d8" /></label>
            <label>Tipo de Dano <input value={form.damageType} onChange={(e) => setForm((f) => ({ ...f, damageType: e.target.value }))} /></label>
            <button type="button" onClick={addAttack}>Adicionar Ataque</button>
          </div>
        )}

        <ul>
          {attacks.map((a) => (
            <li key={a.id}>
              {a.name}{a.general_info?.municao ? ` (${a.general_info.municao})` : ''} — {attrValue(character.attributes, a.attribute)}d20 / {a.damage.map((d) => `${d.formula}${d.tipo ? ` ${d.tipo}` : ''}`).join(', ') || 'sem dano definido'} / x{a.multiplier}
              <button type="button" onClick={() => rollAttack(a)}>Rolar</button>
              <button type="button" onClick={() => removeAttack(a.id)}>Remover</button>
            </li>
          ))}
        </ul>
      </section>
    </div>
  )
}
