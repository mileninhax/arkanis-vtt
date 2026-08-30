import { useState, type FormEvent } from 'react'
import { useNavigate } from 'react-router-dom'
import type { Provider } from '@supabase/supabase-js'
import { supabase } from '../lib/supabase'

export default function Login() {
  const [mode, setMode] = useState<'login' | 'signup'>('login')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [message, setMessage] = useState<string | null>(null)
  const [submitting, setSubmitting] = useState(false)
  const navigate = useNavigate()

  async function handleOAuth(provider: Provider) {
    setError(null)
    const { error } = await supabase.auth.signInWithOAuth({
      provider,
      options: { redirectTo: `${window.location.origin}/jogar` },
    })
    if (error) setError(error.message)
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault()
    setError(null)
    setMessage(null)
    setSubmitting(true)

    if (mode === 'login') {
      const { error } = await supabase.auth.signInWithPassword({ email, password })
      setSubmitting(false)
      if (error) {
        setError(error.message)
        return
      }
      navigate('/jogar')
    } else {
      const { error } = await supabase.auth.signUp({ email, password })
      setSubmitting(false)
      if (error) {
        setError(error.message)
        return
      }
      setMessage('Cadastro criado! Confirma seu e-mail antes de fazer login.')
    }
  }

  return (
    <main>
      <h1>{mode === 'login' ? 'Entrar' : 'Criar conta'}</h1>

      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="email">E-mail</label>
          <input id="email" type="email" required value={email} onChange={(e) => setEmail(e.target.value)} />
        </div>
        <div>
          <label htmlFor="password">Senha</label>
          <input id="password" type="password" required minLength={6} value={password} onChange={(e) => setPassword(e.target.value)} />
        </div>

        {error && <p role="alert">{error}</p>}
        {message && <p role="status">{message}</p>}

        <button type="submit" disabled={submitting}>
          {mode === 'login' ? 'Entrar' : 'Cadastrar'}
        </button>
      </form>

      <button type="button" onClick={() => setMode(mode === 'login' ? 'signup' : 'login')}>
        {mode === 'login' ? 'Não tem conta? Cadastre-se' : 'Já tem conta? Entrar'}
      </button>

      <div>
        <p>ou continue com</p>
        <button type="button" onClick={() => handleOAuth('google')}>Google</button>
        <button type="button" onClick={() => handleOAuth('discord')}>Discord</button>
      </div>
    </main>
  )
}
