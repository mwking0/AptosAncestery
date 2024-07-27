import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import '../css/signIn.css';
import '../css/style.css';
import signInImage from '../assets/Frame.png';
import { IoMailOutline } from "react-icons/io5";
import { RiLockPasswordLine } from "react-icons/ri";


const SignIn = () => {
    const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();
  };

  return (
    <div className="split-page">
      <div className="left-side left-side-color ">
        <img src={signInImage} alt="SignIn" />
      </div>
      <div className="right-side">
        <h1>Sign in</h1>
        <form onSubmit={handleSubmit} className='form'>
            <div className='w-100'><IoMailOutline className='icon-form position-abs'/>
        <input type="email" value={email} className="w-85 signin-input" onChange={(event) => setEmail(event.target.value)} /></div>
        <div className='w-100'><RiLockPasswordLine className='icon-form position-abs'/>
        <input type="password" value={password} className="w-85 signin-input" onChange={(event) => setPassword(event.target.value)} /></div>
        
        <button type="submit" className='m-t-2 signin-button'>Sign In</button>
        <Link to="/signUp" className='m-t-2 B-color'>or Sign Up</Link>
        <p className='forgot m-t-2'>Forgot Password?</p>
      </form>
      </div>
    </div>
  );
};

export default SignIn;
