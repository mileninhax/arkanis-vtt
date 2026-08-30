import { supabase } from './supabase'

export type Skill = {
  id: string
  name: string
  default_attribute: string | null
}

export type ClassRow = {
  id: string
  slug: string
  name: string
  description: string | null
  pv_initial: number | null
  pv_initial_attr: string | null
  pv_per_nex: number | null
  pv_per_nex_attr: string | null
  pe_initial: number | null
  pe_initial_attr: string | null
  pe_per_nex: number | null
  pe_per_nex_attr: string | null
  sanity_initial: number | null
  sanity_per_nex: number | null
  pd_initial: number | null
  pd_initial_attr: string | null
  pd_per_nex: number | null
  pd_per_nex_attr: string | null
  trained_skills_text: string | null
  proficiencies_text: string | null
}

export type Origin = {
  id: string
  name: string
  roll_range: string | null
  skill_1_id: string | null
  skill_2_id: string | null
  skills_text: string | null
  power_name: string
  power_description: string
  description: string | null
}

export type ClassPower = { id: string; name: string; description: string; prerequisites: string | null }
export type ClassTrack = { id: string; slug: string; name: string; description: string | null }
export type ClassTrackTier = { id: string; track_id: string; nex_percent: number; name: string; description: string }
export type ClassProgression = { nex_percent: number; gain_text: string; pe_sequential: number | null }

export async function getSkills(): Promise<Skill[]> {
  const { data, error } = await supabase.from('skills').select('id, name, default_attribute').order('sort_order')
  if (error) throw error
  return data
}

export async function getClasses(): Promise<ClassRow[]> {
  const { data, error } = await supabase.from('classes').select('*').order('sort_order')
  if (error) throw error
  return data
}

export async function getClassExtras(classId: string) {
  const [progression, powers, tracks] = await Promise.all([
    supabase.from('class_progression').select('nex_percent, gain_text, pe_sequential').eq('class_id', classId).order('nex_percent'),
    supabase.from('class_powers').select('id, name, description, prerequisites').eq('class_id', classId).order('sort_order'),
    supabase.from('class_tracks').select('id, slug, name, description').eq('class_id', classId).order('sort_order'),
  ])
  if (progression.error) throw progression.error
  if (powers.error) throw powers.error
  if (tracks.error) throw tracks.error

  const trackIds = tracks.data.map((t) => t.id)
  const { data: tiers, error: tiersError } = trackIds.length
    ? await supabase.from('class_track_tiers').select('id, track_id, nex_percent, name, description').in('track_id', trackIds).order('nex_percent')
    : { data: [] as ClassTrackTier[], error: null }
  if (tiersError) throw tiersError

  return {
    progression: progression.data as ClassProgression[],
    powers: powers.data as ClassPower[],
    tracks: tracks.data as ClassTrack[],
    tiers: tiers as ClassTrackTier[],
  }
}

export async function getOriginsBySource(sourceSlug: string): Promise<Origin[]> {
  const { data, error } = await supabase
    .from('origins')
    .select('id, name, roll_range, skill_1_id, skill_2_id, skills_text, power_name, power_description, description, sources!inner(slug)')
    .eq('sources.slug', sourceSlug)
    .order('sort_order')
  if (error) throw error
  return data as unknown as Origin[]
}
