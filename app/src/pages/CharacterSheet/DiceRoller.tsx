import { useState } from 'react'
import { useAuth } from '../../lib/AuthContext'
import { recordRoll } from '../../lib/rollHistory'
import type { CharacterRecord } from './index'

const DICE = [4, 6, 8, 10, 12, 20]

type Term = { sides: number; count: number }

function rollDie(sides: number) {
  return 1 + Math.floor(Math.random() * sides)
}

function parseManual(input: string): { terms: Term[]; modifier: number } | null {
  const cleaned = input.replace(/\s/g, '')
  const termRegex = /([+-]?)(\d+)d(\d+)/gi
  const terms: Term[] = []
  let match: RegExpExecArray | null
  let lastIndex = 0
  while ((match = termRegex.exec(cleaned))) {
    const sign = match[1] === '-' ? -1 : 1
    terms.push({ sides: Number(match[3]), count: sign * Number(match[2]) })
    lastIndex = termRegex.lastIndex
  }
  if (terms.length === 0) return null
  const rest = cleaned.slice(lastIndex)
  const modMatch = rest.match(/^([+-]\d+)$/)
  const modifier = modMatch ? Number(modMatch[1]) : 0
  return { terms, modifier }
}

export default function DiceRoller({ character, onClose }: { character: CharacterRecord; onClose: () => void }) {
  const { session } = useAuth()
  const [selected, setSelected] = useState<Record<number, number>>({})
  const [manual, setManual] = useState('')
  const [result, setResult] = useState<{ total: number; detail: { sides: number; value: number }[] } | null>(null)

  function persist(label: string, total: number, detail: { sides: number; value: number }[]) {
    if (!session) return
    recordRoll({
      characterId: character.id, userId: session.user.id, campaignId: character.campaign_id, characterName: character.name,
      label, total, detail: detail.map((d) => `d${d.sides}: ${d.value}`).join(' · '),
    })
  }

  function addDie(sides: number) {
    setSelected((s) => ({ ...s, [sides]: (s[sides] ?? 0) + 1 }))
  }

  function rollSelected() {
    const detail: { sides: number; value: number }[] = []
    for (const [sidesStr, count] of Object.entries(selected)) {
      const sides = Number(sidesStr)
      for (let i = 0; i < count; i++) detail.push({ sides, value: rollDie(sides) })
    }
    const total = detail.reduce((sum, d) => sum + d.value, 0)
    setResult({ total, detail })
    persist('Rolagem manual', total, detail)
  }

  function rollManual() {
    const parsed = parseManual(manual)
    if (!parsed) return
    const detail: { sides: number; value: number }[] = []
    let total = parsed.modifier
    for (const term of parsed.terms) {
      const count = Math.abs(term.count)
      const sign = term.count < 0 ? -1 : 1
      for (let i = 0; i < count; i++) {
        const value = rollDie(term.sides)
        detail.push({ sides: term.sides, value: sign * value })
        total += sign * value
      }
    }
    setResult({ total, detail })
    persist(`Rolagem: ${manual}`, total, detail)
  }

  return (
    <div role="dialog">
      <button type="button" onClick={onClose}>Fechar Dados</button>

      {!result ? (
        <div>
          <div>
            {DICE.map((sides) => (
              <button key={sides} type="button" onClick={() => addDie(sides)}>
                d{sides} {selected[sides] ? `x${selected[sides]}` : ''}
              </button>
            ))}
          </div>
          <button type="button" onClick={rollSelected} disabled={Object.keys(selected).length === 0}>Rolar</button>

          <div>
            <input placeholder="ex.: 2d4+3" value={manual} onChange={(e) => setManual(e.target.value)} />
            <button type="button" onClick={rollManual}>Rolar fórmula</button>
          </div>
        </div>
      ) : (
        <div>
          <p>Total: {result.total}</p>
          <p>{result.detail.map((d) => `d${d.sides}: ${d.value}`).join(' · ')}</p>
          <button type="button" onClick={() => { setResult(null); setSelected({}) }}>Voltar</button>
        </div>
      )}
    </div>
  )
}
