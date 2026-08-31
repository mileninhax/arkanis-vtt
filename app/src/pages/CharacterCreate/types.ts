export type Attributes = {
  forca: number
  agilidade: number
  intelecto: number
  vigor: number
  presenca: number
}

export type CustomOrigin = {
  name: string
  skill1Id: string | null
  skill2Id: string | null
  powerName: string
  powerDescription: string
}

export type CustomClass = {
  name: string
  description: string
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
}

export type OptionalRules = {
  nex_experiencia: boolean
  contagem_municao: boolean
  sem_sanidade: boolean
  evolucao_patente: boolean
  ferimentos_debilitantes: boolean
}

export type CharacterDraft = {
  docNumber: string
  attributes: Attributes
  originId: string | null
  customOrigin: CustomOrigin | null
  classId: string | null
  customClass: CustomClass | null
  optionalRules: OptionalRules
  nexPercent: number
  experience: number | null
  name: string
  photoUrl: string | null
  appearance: string
  personality: string
  history: string
  objective: string
}

export const emptyDraft: CharacterDraft = {
  docNumber: String(Math.floor(100000 + Math.random() * 900000)),
  attributes: { forca: 1, agilidade: 1, intelecto: 1, vigor: 1, presenca: 1 },
  originId: null,
  customOrigin: null,
  classId: null,
  customClass: null,
  optionalRules: {
    nex_experiencia: false,
    contagem_municao: false,
    sem_sanidade: false,
    evolucao_patente: false,
    ferimentos_debilitantes: false,
  },
  nexPercent: 0,
  experience: null,
  name: '',
  photoUrl: null,
  appearance: '',
  personality: '',
  history: '',
  objective: '',
}
