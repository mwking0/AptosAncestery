import React from 'react';
import { Link } from 'react-router-dom';
import '../css/style.css';
import familyImage from '../assets/family.jpg';
import backgroundImage from '../assets/Logo.png';

const homePage = () => {
  return (
    <div className="home-page" style={{ backgroundImage: `url(${familyImage})` }}>
      <header className="header">
        <div><img src={backgroundImage} alt="Family" className='logo'/>
        </div>
        <nav className="nav">
          <a href="/">Home</a>
          <a href="/welcome">Welcome</a>
          <a href="/aboutUs">About Us</a>
          <Link to="/signIn">Sign In</Link>
          <a href="#signUp">Sign Up</a>
        </nav>
      </header>
      <div className="content">
        <h1>APTOSANCESTRY</h1>
        <p>Empowering your future roots</p>
      </div>
    </div>
  );
};

export default homePage;
