import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './components/homePage';
import SignIn from './components/signIn';
import Chat from './components/chat';
import AboutUs from './components/aboutUs';

function App() {
  return (
    <Router>
      <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/signIn" element={<SignIn />} />
      <Route path="/chat" element={<Chat />} />
      <Route path="/aboutUs" element={<AboutUs />} />
      </Routes>
    </Router>
  );
}

export default App;
