export default function StatBar({
  label,
  icon,
  current,
  max,
  temp,
  colorClass,
  note,
  onDecrement,
  onIncrement,
}: {
  label: string
  icon?: string
  current: number
  max: number
  temp?: number
  colorClass: 'pv' | 'sanidade' | 'esforco' | 'pd'
  note?: string
  onDecrement: () => void
  onIncrement: () => void
}) {
  const pct = max > 0 ? Math.max(0, Math.min(100, (current / max) * 100)) : 0

  return (
    <div className="stat-bar-row">
      {icon && <img src={icon} alt="" className="vtt-stat-icon" />}
      <div className="stat-bar-body">
        <div className="stat-bar-label-row">
          <span className="stat-bar-label">{label}</span>
          {temp !== undefined && <span className="stat-bar-temp">Temp. {temp}</span>}
        </div>
        <div className="stat-bar-track">
          <button type="button" className="stat-bar-arrow" onClick={onDecrement} aria-label={`-1 ${label}`}>‹</button>
          <div className="stat-bar-fill-wrap">
            <div className={`stat-bar-fill ${colorClass}`} style={{ width: `${pct}%` }} />
            <span className="stat-bar-value">{current}/{max}</span>
          </div>
          <button type="button" className="stat-bar-arrow" onClick={onIncrement} aria-label={`+1 ${label}`}>›</button>
        </div>
        {note && <p className="stat-bar-note">{note}</p>}
      </div>
    </div>
  )
}
