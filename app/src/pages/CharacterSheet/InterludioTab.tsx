import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../lib/AuthContext'
import { recordRoll } from '../../lib/rollHistory'
import { attrValue, nexSteps, rollAttributeTest, rollDiceFormula, trainingBonus, type Training } from '../../lib/rules'
import type { CharacterRecord } from './index'
import RollResult, { type RollResultData } from './RollResult'

type ActionKey = 'alimentar' | 'dormir' | 'exercitar' | 'ler' | 'manutencao' | 'relaxar' | 'revisar_caso' | 'resolver_problema'

const INTERESSES = ['Relacionamento', 'Trabalho', 'Lazer'] as const

const ACTIONS: { key: ActionKey; label: string; description: string }[] = [
  { key: 'alimentar', label: 'Alimentar-se', description: 'Escolha um prato especial (Favorito, Nutritivo, Energético ou Rápido) e receba o benefício dele. Só uma refeição por interlúdio.' },
  { key: 'dormir', label: 'Dormir', description: 'Recupera PV e PE iguais ao seu limite de PE, multiplicado pela condição de descanso (Precária x0,5, Normal x1, Confortável x2, Luxuosa x3). Só pode dormir uma vez por interlúdio.' },
  { key: 'exercitar', label: 'Exercitar-se', description: 'Recebe +1d6 num teste futuro baseado em Agilidade, Força ou Vigor (até o fim da missão). Acumula até um número de cargas igual ao seu Vigor.' },
  { key: 'ler', label: 'Ler', description: 'Recebe +1d6 num teste futuro baseado em Intelecto ou Presença (até o fim da missão). Acumula até um número de cargas igual ao seu Intelecto.' },
  { key: 'manutencao', label: 'Manutenção', description: 'Conserta um item quebrado, recuperando os PV dele ao máximo (registro manual — ainda não há sistema de durabilidade de item).' },
  { key: 'relaxar', label: 'Relaxar', description: 'Funciona como Dormir, mas recupera Sanidade em vez de PV/PE. Cada outro personagem que também relaxar no mesmo interlúdio dá +1 Sanidade adicional pra todos. Só pode relaxar uma vez por interlúdio.' },
  { key: 'revisar_caso', label: 'Revisar Caso', description: 'Escolhe uma página de investigação e uma perícia, testa contra a DT da cena; se passar, ganha uma pista complementar. Pode repetir na mesma cena.' },
  { key: 'resolver_problema', label: 'Resolver Problema (Folga)', description: 'Resolve o problema pendente de uma Folga malsucedida, liberando a ação Relaxar de novo.' },
]

const CONDICOES = [
  { key: 'precaria', label: 'Precária (x0,5)', mult: 0.5 },
  { key: 'normal', label: 'Normal (x1)', mult: 1 },
  { key: 'confortavel', label: 'Confortável (x2)', mult: 2 },
  { key: 'luxuosa', label: 'Luxuosa (x3)', mult: 3 },
]

const PRATOS = [
  { key: 'favorito', label: 'Prato Favorito', description: 'Se relaxar neste interlúdio, recupera 2 de Sanidade adicionais.' },
  { key: 'nutritivo', label: 'Prato Nutritivo', description: 'Se dormir neste interlúdio, aumenta a recuperação de PV em um passo.' },
  { key: 'energetico', label: 'Prato Energético', description: 'Se dormir neste interlúdio, aumenta a recuperação de PE em um passo.' },
  { key: 'rapido', label: 'Prato Rápido', description: 'Se revisar caso neste interlúdio, +5 no teste de perícia.' },
]

export default function InterludioTab({ character, onUpdated }: { character: CharacterRecord & { class_id: string | null }; onUpdated: () => void }) {
  const { session } = useAuth()
  const [selectedActions, setSelectedActions] = useState<ActionKey[]>([])
  const [condicao, setCondicao] = useState<'precaria' | 'normal' | 'confortavel' | 'luxuosa'>('normal')
  const [prato, setPrato] = useState<string | null>(null)
  const [pages, setPages] = useState<{ id: string; title: string; clues: string }[]>([])
  const [selectedPageId, setSelectedPageId] = useState<string | null>(null)
  const [skills, setSkills] = useState<{ id: string; name: string; default_attribute: string | null }[]>([])
  const [selectedSkillId, setSelectedSkillId] = useState<string | null>(null)
  const [charSkills, setCharSkills] = useState<Record<string, { training: Training; extra_bonus: number; attribute_override: string | null }>>({})
  const [roll, setRoll] = useState<RollResultData | null>(null)
  const [foundClue, setFoundClue] = useState('')
  const [manutencaoNote, setManutencaoNote] = useState('')
  const [confirmed, setConfirmed] = useState<string | null>(null)
  const [tempBonuses, setTempBonuses] = useState<{ id: string; source: string; attribute_group: string; dice: string; remaining: number }[]>([])
  const [paixaoChecked, setPaixaoChecked] = useState(false)
  const [parceiroNome, setParceiroNome] = useState('')
  const [vinculo, setVinculo] = useState<{ vinculo_parceiro: string | null; vinculo_pv_pe_bonus: number; problema_folga: string | null } | null>(null)
  const [interesse, setInteresse] = useState<(typeof INTERESSES)[number]>('Relacionamento')
  const [folgaSkill1, setFolgaSkill1] = useState<string | null>(null)
  const [folgaSkill2, setFolgaSkill2] = useState<string | null>(null)
  const [folgaResult, setFolgaResult] = useState<{ successes: number; nat20: boolean } | null>(null)

  async function loadVinculo() {
    const { data } = await supabase.from('characters').select('vinculo_parceiro, vinculo_pv_pe_bonus, problema_folga').eq('id', character.id).single()
    setVinculo(data)
  }

  useEffect(() => {
    loadVinculo()
    supabase.from('character_investigation_pages').select('id, title, clues').eq('character_id', character.id).then(({ data }) => setPages(data ?? []))
    supabase.from('skills').select('id, name, default_attribute').order('sort_order').then(({ data }) => setSkills(data ?? []))
    supabase.from('character_skills').select('skill_id, training, extra_bonus, attribute_override').eq('character_id', character.id).then(({ data }) => {
      const map: Record<string, { training: Training; extra_bonus: number; attribute_override: string | null }> = {}
      for (const row of data ?? []) map[row.skill_id] = row
      setCharSkills(map)
    })
    loadTempBonuses()
  }, [character.id])

  async function loadTempBonuses() {
    const { data } = await supabase.from('character_temp_bonuses').select('id, source, attribute_group, dice, remaining').eq('character_id', character.id).gt('remaining', 0)
    setTempBonuses(data ?? [])
  }

  function toggleAction(key: ActionKey) {
    setSelectedActions((prev) => {
      if (prev.includes(key)) return prev.filter((k) => k !== key)
      if (key !== 'revisar_caso' && prev.length >= 2) return prev
      return [...prev, key]
    })
  }

  const limitePE = Math.max(1, nexSteps(character.nex_percent))

  async function confirmar() {
    const patches: Record<string, number | string | null> = {}

    const semSanidade = character.optional_rules.sem_sanidade

    if (selectedActions.includes('dormir')) {
      const base = CONDICOES.find((c) => c.key === condicao)!.mult
      const pvMult = base + (prato === 'nutritivo' ? 1 : 0)
      patches.current_pv = (character.current_pv ?? 0) + Math.round(limitePE * pvMult)
      // "Jogando sem Sanidade": dormir só recupera PV (PE não existe nessa regra).
      if (!semSanidade) {
        const peMult = base + (prato === 'energetico' ? 1 : 0)
        patches.current_pe = (character.current_pe ?? 0) + Math.round(limitePE * peMult)
      }

      if (paixaoChecked && parceiroNome) {
        const rolled = rollDiceFormula('1d8')!
        patches.vinculo_parceiro = parceiroNome
        patches.vinculo_pv_pe_bonus = rolled.total
        patches.current_pv = Number(patches.current_pv) + rolled.total
        if (!semSanidade) patches.current_pe = Number(patches.current_pe) + rolled.total
      }
    }

    if (selectedActions.includes('resolver_problema')) {
      patches.problema_folga = null
    }

    if (selectedActions.includes('relaxar')) {
      const base = CONDICOES.find((c) => c.key === condicao)!.mult
      const bonus = prato === 'favorito' ? 2 : 0
      // "Jogando sem Sanidade": relaxar recupera PD em vez de Sanidade.
      if (semSanidade) {
        patches.current_pd = (character.current_pd ?? 0) + Math.round(limitePE * base) + bonus
      } else {
        patches.current_sanity = (character.current_sanity ?? 0) + Math.round(limitePE * base) + bonus
      }
    }

    if (Object.keys(patches).length) {
      await supabase.from('characters').update(patches).eq('id', character.id)
    }

    if (selectedActions.includes('exercitar')) {
      await supabase.from('character_temp_bonuses').insert({ character_id: character.id, source: 'Exercitar-se', attribute_group: 'fisico', dice: '1d6', remaining: character.attributes.vigor })
    }
    if (selectedActions.includes('ler')) {
      await supabase.from('character_temp_bonuses').insert({ character_id: character.id, source: 'Ler', attribute_group: 'mental', dice: '1d6', remaining: character.attributes.intelecto })
    }

    if (selectedActions.includes('revisar_caso') && selectedPageId && foundClue) {
      const page = pages.find((p) => p.id === selectedPageId)
      if (page) {
        await supabase.from('character_investigation_pages').update({ clues: `${page.clues}\n${foundClue}`.trim() }).eq('id', selectedPageId)
      }
    }

    setConfirmed(`Interlúdio resolvido: ${selectedActions.map((a) => ACTIONS.find((x) => x.key === a)?.label).join(', ')}.`)
    setSelectedActions([])
    setPrato(null)
    setFoundClue('')
    setManutencaoNote('')
    setPaixaoChecked(false)
    setParceiroNome('')
    await loadVinculo()
    onUpdated()
    await loadTempBonuses()
  }

  async function useTempBonus(id: string) {
    const bonus = tempBonuses.find((b) => b.id === id)
    if (!bonus) return
    if (bonus.remaining <= 1) await supabase.from('character_temp_bonuses').delete().eq('id', id)
    else await supabase.from('character_temp_bonuses').update({ remaining: bonus.remaining - 1 }).eq('id', id)
    await loadTempBonuses()
  }

  const canConfirm = selectedActions.length > 0

  return (
    <div>
      <p><em>Cenas onde os personagens não estão investigando/combatendo — descansar, planejar, refletir. Até 2 ações por interlúdio (Revisar Caso pode repetir).</em></p>

      {confirmed && <p role="status">{confirmed}</p>}

      {vinculo?.vinculo_parceiro && (
        <section>
          <p><strong>Vínculo Romântico:</strong> {vinculo.vinculo_parceiro} (+{vinculo.vinculo_pv_pe_bonus} PV e PE, máx. e atual)</p>
          <p><em>Condição Apaixonado: penalidade de -{vinculo.vinculo_pv_pe_bonus} em testes contra {vinculo.vinculo_parceiro}.</em></p>
          <button
            type="button"
            onClick={async () => {
              await supabase.from('characters').update({ vinculo_parceiro: null, vinculo_pv_pe_bonus: 0 }).eq('id', character.id)
              await loadVinculo()
              onUpdated()
            }}
          >
            Parceiro morreu (perde o vínculo — condição Trêmulo: -1d20 Força/Vigor por 3 rodadas)
          </button>
        </section>
      )}

      {vinculo?.problema_folga && <p><strong>Problema pendente (Folga):</strong> {vinculo.problema_folga} — bloqueia Relaxar até resolvido.</p>}

      <ul>
        {ACTIONS.filter((a) => a.key !== 'resolver_problema' || vinculo?.problema_folga).map((a) => (
          <li key={a.key}>
            <label>
              <input
                type="checkbox"
                checked={selectedActions.includes(a.key)}
                disabled={a.key === 'relaxar' && Boolean(vinculo?.problema_folga)}
                onChange={() => toggleAction(a.key)}
              />
              <strong>{a.label}</strong>
            </label>
            {selectedActions.includes(a.key) && <p>{a.description}</p>}
          </li>
        ))}
      </ul>

      {(selectedActions.includes('dormir') || selectedActions.includes('relaxar')) && (
        <label>
          Condição de descanso
          <select value={condicao} onChange={(e) => setCondicao(e.target.value as typeof condicao)}>
            {CONDICOES.map((c) => <option key={c.key} value={c.key}>{c.label}</option>)}
          </select>
        </label>
      )}

      {selectedActions.includes('dormir') && !vinculo?.vinculo_parceiro && (
        <fieldset>
          <legend>Regra da Paixão (opcional)</legend>
          <p><em>Envolvimento romântico com outro personagem — combinado com a mesa/mestre antes de usar.</em></p>
          <label><input type="checkbox" checked={paixaoChecked} onChange={(e) => setPaixaoChecked(e.target.checked)} /> Envolver-se romanticamente</label>
          {paixaoChecked && (
            <label>Nome do parceiro <input value={parceiroNome} onChange={(e) => setParceiroNome(e.target.value)} /></label>
          )}
        </fieldset>
      )}

      {selectedActions.includes('alimentar') && (
        <fieldset>
          <legend>Escolha o prato</legend>
          {PRATOS.map((p) => (
            <label key={p.key}>
              <input type="radio" name="prato" checked={prato === p.key} onChange={() => setPrato(p.key)} />
              <strong>{p.label}</strong>: {p.description}
            </label>
          ))}
        </fieldset>
      )}

      {selectedActions.includes('manutencao') && (
        <label>Item consertado (registro) <input value={manutencaoNote} onChange={(e) => setManutencaoNote(e.target.value)} /></label>
      )}

      {selectedActions.includes('revisar_caso') && (
        <fieldset>
          <legend>Revisar Caso</legend>
          <label>
            Página de investigação
            <select value={selectedPageId ?? ''} onChange={(e) => setSelectedPageId(e.target.value || null)}>
              <option value="">—</option>
              {pages.map((p) => <option key={p.id} value={p.id}>{p.title || '(sem título)'}</option>)}
            </select>
          </label>
          <label>
            Perícia
            <select value={selectedSkillId ?? ''} onChange={(e) => setSelectedSkillId(e.target.value || null)}>
              <option value="">—</option>
              {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
            </select>
          </label>
          {prato === 'rapido' && <p>+5 no teste (Prato Rápido).</p>}
          <button
            type="button"
            disabled={!selectedSkillId}
            onClick={() => {
              const skill = skills.find((s) => s.id === selectedSkillId)
              if (!skill) return
              const cs = charSkills[skill.id] ?? { training: 'nenhum' as const, extra_bonus: 0, attribute_override: null }
              const attr = cs.attribute_override ?? skill.default_attribute
              const score = attrValue(character.attributes, attr)
              const { rolls, kept } = rollAttributeTest(score)
              const bonus = trainingBonus(cs.training) + cs.extra_bonus + (prato === 'rapido' ? 5 : 0)
              const label = `Revisar Caso — Teste de ${skill.name}`
              setRoll({ label, rolls, kept, bonus })
              if (session) {
                recordRoll({
                  characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
                  label, total: kept + bonus, detail: `d20 mantido: ${kept} (rolados: ${rolls.join(', ')}) + bônus ${bonus}`,
                })
              }
            }}
          >
            Rolar teste
          </button>
          <label>Pista encontrada (se passar no teste) <textarea value={foundClue} onChange={(e) => setFoundClue(e.target.value)} /></label>
        </fieldset>
      )}

      {roll && <RollResult result={roll} onClose={() => setRoll(null)} />}

      <button type="button" onClick={confirmar} disabled={!canConfirm}>Confirmar Interlúdio</button>

      <section>
        <h3>Bônus temporários acumulados</h3>
        {tempBonuses.length === 0 ? <p>Nenhum.</p> : (
          <ul>
            {tempBonuses.map((b) => (
              <li key={b.id}>
                {b.source}: {b.remaining}x {b.dice} ({b.attribute_group === 'fisico' ? 'Agilidade/Força/Vigor' : b.attribute_group === 'mental' ? 'Intelecto/Presença' : 'qualquer teste'})
                <button type="button" onClick={() => useTempBonus(b.id)}>Usar 1</button>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section>
        <h3>Folga da Ordem / Vida Além da Ordem (entre missões)</h3>
        <p><em>1 folga por missão. Escolha um interesse pessoal e 2 perícias temáticas — cada uma é testada contra DT 20.</em></p>
        <label>
          Interesse
          <select value={interesse} onChange={(e) => setInteresse(e.target.value as typeof interesse)}>
            {INTERESSES.map((i) => <option key={i} value={i}>{i}</option>)}
          </select>
        </label>
        <label>
          Perícia 1
          <select value={folgaSkill1 ?? ''} onChange={(e) => setFolgaSkill1(e.target.value || null)}>
            <option value="">—</option>
            {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
          </select>
        </label>
        <label>
          Perícia 2
          <select value={folgaSkill2 ?? ''} onChange={(e) => setFolgaSkill2(e.target.value || null)}>
            <option value="">—</option>
            {skills.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
          </select>
        </label>

        <button
          type="button"
          disabled={!folgaSkill1 || !folgaSkill2}
          onClick={() => {
            let successes = 0
            let nat20 = false
            const parts: string[] = []
            for (const skillId of [folgaSkill1, folgaSkill2]) {
              const skill = skills.find((s) => s.id === skillId)
              if (!skill) continue
              const cs = charSkills[skill.id] ?? { training: 'nenhum' as const, extra_bonus: 0, attribute_override: null }
              const attr = cs.attribute_override ?? skill.default_attribute
              const score = attrValue(character.attributes, attr)
              const { rolls, kept } = rollAttributeTest(score)
              if (rolls.includes(20)) nat20 = true
              const bonus = trainingBonus(cs.training) + cs.extra_bonus
              const total = kept + bonus
              if (total >= 20) successes += 1
              parts.push(`${skill.name}: ${total} (d20 mantido ${kept} + bônus ${bonus})`)
            }
            setFolgaResult({ successes, nat20 })
            if (session) {
              recordRoll({
                characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
                label: `Folga da Ordem (${interesse})`, total: successes, detail: parts.join(' · '),
              })
            }
          }}
        >
          Testar Folga
        </button>

        {folgaResult && (
          <div>
            <p>{folgaResult.successes} sucesso(s) de 2.</p>
            <button
              type="button"
              onClick={async () => {
                if (folgaResult.successes === 2) {
                  const rolled = rollDiceFormula(folgaResult.nat20 ? '3d6' : '1d6')!
                  await supabase.from('character_temp_bonuses').insert({ character_id: character.id, source: 'Folga da Ordem', attribute_group: 'geral', dice: `${rolled.total} (fixo)`, remaining: 1 })
                } else if (folgaResult.successes === 0) {
                  await supabase.from('characters').update({ problema_folga: `Problema em ${interesse} (folga sem sucesso)` }).eq('id', character.id)
                  await loadVinculo()
                }
                setFolgaResult(null)
                await loadTempBonuses()
              }}
            >
              Aplicar resultado
            </button>
          </div>
        )}
      </section>
    </div>
  )
}
