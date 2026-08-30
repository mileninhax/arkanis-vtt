export function hexToRgba(hex: string, alpha: number): string {
  const clean = hex.replace('#', '')
  const full = clean.length === 3 ? clean.split('').map((c) => c + c).join('') : clean
  const int = parseInt(full, 16)
  const r = (int >> 16) & 255
  const g = (int >> 8) & 255
  const b = int & 255
  return `rgba(${r}, ${g}, ${b}, ${alpha})`
}

const FALLBACK_AVATAR_COLORS = ['#7a3fc9', '#c93f7a', '#3f7ac9', '#3fc98f', '#c9a13f', '#c9503f', '#8f3fc9', '#3f9fc9']

export function fallbackAvatarColor(seed: string): string {
  let hash = 0
  for (let i = 0; i < seed.length; i++) {
    hash = (hash * 31 + seed.charCodeAt(i)) | 0
  }
  return FALLBACK_AVATAR_COLORS[Math.abs(hash) % FALLBACK_AVATAR_COLORS.length]
}
