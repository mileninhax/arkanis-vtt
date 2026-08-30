import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { AuthProvider } from './lib/AuthContext'
import ProtectedRoute from './lib/ProtectedRoute'
import Home from './pages/Home'
import Login from './pages/Login'
import Perfil from './pages/Perfil'
import Jogar from './pages/Jogar'
import SystemSelect from './pages/SystemSelect'
import CharacterCreate from './pages/CharacterCreate'
import CharacterSheet from './pages/CharacterSheet'

function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/login" element={<Login />} />
          <Route path="/perfil" element={<ProtectedRoute><Perfil /></ProtectedRoute>} />
          <Route path="/jogar" element={<ProtectedRoute><Jogar /></ProtectedRoute>} />
          <Route path="/personagem/criar" element={<ProtectedRoute><SystemSelect /></ProtectedRoute>} />
          <Route path="/personagem/criar/:system" element={<ProtectedRoute><CharacterCreate /></ProtectedRoute>} />
          <Route path="/personagem/:id" element={<ProtectedRoute><CharacterSheet /></ProtectedRoute>} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  )
}

export default App
