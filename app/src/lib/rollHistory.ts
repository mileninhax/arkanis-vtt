import { supabase } from './supabase'

export async function recordRoll(params: {
  characterId: string
  userId: string
  campaignId: string | null
  characterName: string
  label: string
  total: number
  detail: string
  dice?: { sides: number; value: number; discarded?: boolean }[]
  bonus?: number
}) {
  await supabase.from('character_rolls').insert({
    character_id: params.characterId,
    user_id: params.userId,
    campaign_id: params.campaignId,
    character_name: params.characterName,
    label: params.label,
    total: params.total,
    detail: params.detail,
    dice: params.dice ?? null,
    bonus: params.bonus ?? 0,
  })
}
