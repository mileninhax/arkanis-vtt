import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../lib/AuthContext'
import { recordRoll } from '../../lib/rollHistory'
import { attrValue, rollAttributeTest, rollDiceFormula, trainingBonus, type AttributeKey, type Training } from '../../lib/rules'
import type { CharacterRecord } from './index'
import RollResult, { RollCard, type RollResultData, type RollCardDie } from './RollResult'
import { type Modifier } from './ModifiersPanel'
import CombateModifiersPanel from './CombateModifiersPanel'
import defenseRing from '../../assets/combate/border-defense-desktop.png'

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
  from_inventory_item_id: string | null
}

type InventoryAmmoInfo = {
  id: string
  linked_ammo_id: string | null
  ammo_current: number | null
  ammo_total: number | null
  ammo_label: string | null
}

type Skill = { id: string; name: string }

const ATTRS: AttributeKey[] = ['forca', 'agilidade', 'intelecto', 'vigor', 'presenca']

const emptyForm = { name: '', skillId: '', attribute: 'forca' as AttributeKey, d20Bonus: 0, threatMargin: 20, multiplier: 2, damage: '', damageType: '' }

export default function CombateTab({ character, onUpdated }: { character: CharacterRecord; onUpdated: () => void }) {
  const { session } = useAuth()
  const [attacks, setAttacks] = useState<Attack[]>([])
  const [skills, setSkills] = useState<Skill[]>([])
  const [charSkillBonus, setCharSkillBonus] = useState<Record<string, number>>({})
  const [equippedDefense, setEquippedDefense] = useState(0)
  const [equippedProtectionName, setEquippedProtectionName] = useState<string | null>(null)
  const [adding, setAdding] = useState(false)
  const [form, setForm] = useState(emptyForm)
  const [roll, setRoll] = useState<RollResultData | null>(null)
  const [attackMods, setAttackMods] = useState<Modifier[]>([])
  const [damageMods, setDamageMods] = useState<Modifier[]>([])
  const [testMods, setTestMods] = useState<Modifier[]>([])
  const [inventoryAmmo, setInventoryAmmo] = useState<InventoryAmmoInfo[]>([])
  const [defenseDetailsOpen, setDefenseDetailsOpen] = useState(false)
  const [attackSearch, setAttackSearch] = useState('')
  const [pendingAttack, setPendingAttack] = useState<{ attackId: string; isCrit: boolean } | null>(null)
  const [damageRoll, setDamageRoll] = useState<{ title: string; subtitle: string; total: number; dice: RollCardDie[]; extraLines?: string[]; bonus?: number } | null>(null)

  async function loadAttacks() {
    const { data } = await supabase
      .from('character_attacks')
      .select('id, name, skill_id, attribute, d20_bonus, threat_margin, multiplier, damage, general_info, from_inventory_item_id')
      .eq('character_id', character.id)
    setAttacks((data ?? []) as unknown as Attack[])
  }

  async function loadInventoryAmmo() {
    const { data } = await supabase
      .from('character_inventory')
      .select('id, linked_ammo_id, ammo_current, ammo_total, ammo_label')
      .eq('character_id', character.id)
    setInventoryAmmo((data ?? []) as InventoryAmmoInfo[])
  }

  function loadEquippedProtection() {
    supabase
      .from('character_inventory')
      .select('is_equipped, equipment_items(type, stats, name), custom_item')
      .eq('character_id', character.id)
      .eq('is_equipped', true)
      .then(({ data }) => {
        const protection = (data ?? []).find((i: any) => (i.equipment_items?.type ?? i.custom_item?.type) === 'protecao')
        const stats = (protection as any)?.equipment_items?.stats ?? (protection as any)?.custom_item?.stats ?? {}
        const name = (protection as any)?.equipment_items?.name ?? (protection as any)?.custom_item?.name ?? null
        setEquippedDefense(Number(stats.defesa ?? 0))
        setEquippedProtectionName(name)
      })
  }

  useEffect(() => { loadAttacks(); loadInventoryAmmo() }, [character.id])

  useEffect(() => {
    supabase.from('skills').select('id, name').order('sort_order').then(({ data }) => setSkills(data ?? []))
    supabase
      .from('character_modifiers')
      .select('id, name, dice_bonus, value_bonus, threat_margin_bonus, multiplier_bonus, damage_type, is_active')
      .eq('character_id', character.id)
      .eq('scope', 'teste')
      .then(({ data }) => setTestMods(data ?? []))
    supabase
      .from('character_skills')
      .select('skill_id, training, extra_bonus')
      .eq('character_id', character.id)
      .then(({ data }) => {
        const map: Record<string, number> = {}
        for (const row of data ?? []) map[row.skill_id] = trainingBonus(row.training as Training) + row.extra_bonus
        setCharSkillBonus(map)
      })
    loadEquippedProtection()
  }, [character.id])

  async function updateDefenseField(patch: Partial<Pick<CharacterRecord, 'defense_other_bonus' | 'bloqueio_bonus' | 'esquiva_bonus'>>) {
    await supabase.from('characters').update(patch).eq('id', character.id)
    onUpdated()
  }

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

  function ammoForAttack(attack: Attack): InventoryAmmoInfo | null {
    if (!character.optional_rules.contagem_municao || !attack.from_inventory_item_id) return null
    const sourceInv = inventoryAmmo.find((i) => i.id === attack.from_inventory_item_id)
    if (!sourceInv?.linked_ammo_id) return null
    const ammoInv = inventoryAmmo.find((i) => i.id === sourceInv.linked_ammo_id)
    if (!ammoInv || ammoInv.ammo_total === null) return null
    return ammoInv
  }

  async function consumeAmmo(ammoInv: InventoryAmmoInfo) {
    const next = Math.max(0, (ammoInv.ammo_current ?? 0) - 1)
    await supabase.from('character_inventory').update({ ammo_current: next }).eq('id', ammoInv.id)
    await loadInventoryAmmo()
  }

  function rollAttackTest(attack: Attack) {
    const ammoInv = ammoForAttack(attack)
    if (ammoInv && (ammoInv.ammo_current ?? 0) <= 0) {
      window.alert(`Sem ${ammoInv.ammo_label ?? 'munição'} — recarregue no Inventário antes de atacar.`)
      return
    }

    const activeAttackMods = attackMods.filter((m) => m.is_active)
    const activeTestMods = testMods.filter((m) => m.is_active)

    const attackDiceBonus = activeAttackMods.reduce((sum, m) => sum + m.dice_bonus, 0) + activeTestMods.reduce((sum, m) => sum + m.dice_bonus, 0)
    const attackValueBonus = activeAttackMods.reduce((sum, m) => sum + m.value_bonus, 0) + activeTestMods.reduce((sum, m) => sum + m.value_bonus, 0)
    const threatBonus = activeAttackMods.reduce((sum, m) => sum + m.threat_margin_bonus, 0)

    const score = attrValue(character.attributes, attack.attribute) + attackDiceBonus
    const { rolls, kept } = rollAttributeTest(score)
    const skillBonus = attack.skill_id ? (charSkillBonus[attack.skill_id] ?? 0) : 0
    const bonus = skillBonus + attack.d20_bonus + attackValueBonus

    const effectiveThreatMargin = attack.threat_margin - threatBonus
    const isCrit = kept >= effectiveThreatMargin

    const label = `Ataque: ${attack.name}${isCrit ? ' (crítico!)' : ''}`
    setRoll({
      label,
      rolls,
      kept,
      bonus,
      municao: attack.general_info?.municao ?? null,
      modificadores: attack.general_info?.modificadores ?? [],
      characterName: character.name,
      diceTray: character.dice_tray,
    })
    setPendingAttack({ attackId: attack.id, isCrit })

    if (ammoInv) consumeAmmo(ammoInv)

    if (session) {
      recordRoll({
        characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
        label,
        total: kept + bonus,
        detail: `d20 mantido: ${kept} (rolados: ${rolls.join(', ')}) + bônus ${bonus}`,
        dice: rolls.map((v) => ({ sides: 20, value: v, discarded: v !== kept })), bonus,
      })
    }
  }

  function rollDamage(attack: Attack, isCrit: boolean) {
    const activeAttackMods = attackMods.filter((m) => m.is_active)
    const activeDamageMods = damageMods.filter((m) => m.is_active)

    const multiplierBonus = activeAttackMods.reduce((sum, m) => sum + m.multiplier_bonus, 0)
    const damageValueBonus = activeDamageMods.reduce((sum, m) => sum + m.value_bonus, 0) + (attack.general_info?.damage_bonus_from_mods ?? 0)
    const critMultiplier = isCrit ? attack.multiplier + multiplierBonus : 1

    const dice: RollCardDie[] = []
    const extraLines: string[] = []
    let total = damageValueBonus

    attack.damage.forEach((d) => {
      const sidesMatch = d.formula.match(/d(\d+)/i)
      const sides = sidesMatch ? Number(sidesMatch[1]) : 6
      const rolled = rollDiceFormula(d.formula, 1)
      if (!rolled) {
        extraLines.push(`Dano${d.tipo ? ` (${d.tipo})` : ''}: role manualmente (${d.formula})`)
        return
      }
      rolled.rolls.forEach((v) => dice.push({ sides, value: v }))
      total += rolled.total * critMultiplier
      if (d.tipo) extraLines.push(`Tipo: ${d.tipo}`)
    })

    const label = isCrit ? `Dano Crítico: ${attack.name} (x${critMultiplier})` : `Dano: ${attack.name}`
    setDamageRoll({ title: character.name, subtitle: label, total, dice, extraLines, bonus: damageValueBonus })
    setPendingAttack(null)

    if (session) {
      recordRoll({
        characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
        label, total, detail: dice.map((d) => `d${d.sides}: ${d.value}`).join(' · '),
        dice, bonus: damageValueBonus,
      })
    }
  }

  const agilidade = character.attributes.agilidade
  const defenseTotal = equippedDefense + character.defense_other_bonus + agilidade + 10

  return (
    <div>
      {roll && <RollResult result={roll} onClose={() => setRoll(null)} />}
      {damageRoll && (
        <RollCard
          title={damageRoll.title}
          subtitle={damageRoll.subtitle}
          total={damageRoll.total}
          dice={damageRoll.dice}
          extraLines={damageRoll.extraLines}
          bonus={damageRoll.bonus}
          background={character.dice_tray && character.dice_tray !== 'padrao' ? character.dice_tray : undefined}
          onClose={() => setDamageRoll(null)}
        />
      )}

      <div className="combat-defense-frame">
       <div className="combat-defense-card">
        <div className="combat-defense-top">
          <div className="combat-defense-badge">
            <img src={defenseRing} alt="" className="combat-defense-ring" />
            <span className="combat-defense-value">{defenseTotal}</span>
          </div>

          <div className="combat-defense-main">
            <span className="combat-defense-label">Defesa</span>
            <div className="combat-defense-formula">
              <input
                className="combat-dotted-input"
                type="number"
                value={equippedDefense}
                readOnly
              />
              <span className="combat-defense-sub">Equip</span>
              <span className="combat-defense-plus">+</span>
              <input
                className="combat-dotted-input"
                type="number"
                value={character.defense_other_bonus}
                onChange={(e) => updateDefenseField({ defense_other_bonus: Number(e.target.value) })}
              />
              <span className="combat-defense-sub">Outros</span>
              <span className="combat-defense-fixed">+AGI({agilidade})+10</span>
            </div>
          </div>

          <div className="combat-defense-side">
            <div className="combat-defense-side-item">
              <input
                className="combat-dotted-input"
                type="number"
                value={character.bloqueio_bonus}
                onChange={(e) => updateDefenseField({ bloqueio_bonus: Number(e.target.value) })}
              />
              <span className="combat-defense-sub">Bloqueio</span>
            </div>
            <div className="combat-defense-side-item">
              <input
                className="combat-dotted-input"
                type="number"
                value={character.esquiva_bonus}
                onChange={(e) => updateDefenseField({ esquiva_bonus: Number(e.target.value) })}
              />
              <span className="combat-defense-sub">Esquiva</span>
            </div>
          </div>

          <button type="button" className="combat-defense-chevron" onClick={() => setDefenseDetailsOpen((v) => !v)} aria-label="Detalhes de defesa">
            {defenseDetailsOpen ? '▲' : '▾'}
          </button>
        </div>

        {defenseDetailsOpen && (
          <div className="combat-defense-details">
            <p><strong>Proteção:</strong> {equippedProtectionName ?? 'Nenhuma equipada'}</p>
            <p><strong>Resistência:</strong> Nenhuma</p>
          </div>
        )}
       </div>
      </div>

      <button type="button" className="combat-refresh-btn" onClick={loadEquippedProtection}>↺ Atualizar</button>

      <div className="combat-stats-row">
        <span><strong>PE / Turno:</strong> 1/1</span>
        <span><strong>Deslocamento:</strong> 9m (6q)</span>
      </div>

      <CombateModifiersPanel characterId={character.id} onAttackChange={setAttackMods} onDamageChange={setDamageMods} />

      {attacks.length === 0 && (
        <div className="vtt-warning-box">Você não possui ataques. Adicione a partir do seu inventário ou crie um abaixo.</div>
      )}
      {attacks.length > 0 && attacks.every((a) => !ammoForAttack(a)) && character.optional_rules.contagem_municao && (
        <div className="vtt-warning-box">Você não possui munição rastreada. Adicione a partir do seu inventário.</div>
      )}

      <div style={{ display: 'flex', gap: '0.5em', marginBottom: '0.8em' }}>
        <input placeholder="Buscar Ataques" value={attackSearch} onChange={(e) => setAttackSearch(e.target.value)} style={{ flex: 1 }} />
        <button type="button" onClick={() => setAdding((a) => !a)}>Adicionar Ataque</button>
      </div>

      {adding && (
        <div className="vtt-card">
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

      {attacks.filter((a) => a.name.toLowerCase().includes(attackSearch.toLowerCase())).map((a) => {
        const ammoInv = ammoForAttack(a)
        return (
          <div key={a.id} className="vtt-attack-card">
            <div className="vtt-attack-thumb">⚔</div>
            <div style={{ flex: 1 }}>
              <strong>{a.name}</strong>{a.general_info?.municao ? ` (${a.general_info.municao})` : ''}
              {ammoInv && <div style={{ fontSize: '0.85em', color: 'var(--text-dim)' }}>{ammoInv.ammo_current ?? 0}/{ammoInv.ammo_total} {ammoInv.ammo_label}</div>}
            </div>
            <div className="vtt-attack-stats">
              <div><span className="label">Ataque</span>{attrValue(character.attributes, a.attribute)}d20{a.d20_bonus ? `+${a.d20_bonus}` : ''}</div>
              <div><span className="label">Dano</span>{a.damage.map((d) => `${d.formula}${d.tipo ? ` ${d.tipo}` : ''}`).join(', ') || '—'}</div>
              <div><span className="label">Crítico</span>{a.threat_margin}/x{a.multiplier}</div>
            </div>
            <button type="button" onClick={() => rollAttackTest(a)}>Ataque</button>
            {pendingAttack?.attackId === a.id && (
              pendingAttack.isCrit
                ? <button type="button" onClick={() => rollDamage(a, true)}>Crítico</button>
                : <button type="button" onClick={() => rollDamage(a, false)}>Dano</button>
            )}
            <button type="button" onClick={() => removeAttack(a.id)}>Remover</button>
          </div>
        )
      })}
    </div>
  )
}
