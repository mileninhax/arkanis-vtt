import AuthForm from '../components/AuthForm'
import bgHome from '../assets/backgrounds/bg-home.png'

export default function Login() {
  return (
    <main className="font-ashigea home-hero">
      <div className="home-hero-bg" style={{ backgroundImage: `url(${bgHome})` }} />
      <div className="home-hero-row">
        <AuthForm />
      </div>
    </main>
  )
}
