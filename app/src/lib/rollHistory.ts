import { supabase } from './supabase'

export async function recordRoll(params: {
  characterId: string
  userId: string
  campaignId: string | null
  characterName: string
  label: string
  total: number
  detail: string
}) {
  await supabase.from('character_rolls').insert({
    character_id: params.characterId,
    user_id: params.userId,
    campaign_id: params.campaignId,
    character_name: params.characterName,
    label: params.label,
    total: params.total,
    detail: params.detail,
  })
}
