import React, { useState } from 'react';
import '../css/style.css';
import '../css/chat.css';
import ChatImage from '../assets/chat.jpg';
import { IoIosSend } from "react-icons/io";

const Chat = () => {
  const [text, setText] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();
  };

  return (
    <div className="split-page">
      <div className="left-side left-color">
        <img src={ChatImage} alt="Chat" className='w-35'/>
      </div>
      <div className="right-side right-style">
        <div><h2 className='green-color'>Worrying about your health?</h2>
        <h4>Click here to start conversation</h4></div>
        <div className="msg">
        <p>Hi</p>
        <p>Hey what's up dude !</p>
        <p>Are struggling with your ancestors?</p>
        <p>I will tell you about your health state</p>
        </div>
        <form onSubmit={handleSubmit} className='chat-form w-100'>
        <input value={text} onChange={(e) => setText(e.target.value)}  className='chat-input w-80'/> 
        <button type="submit" className='send-button'><IoIosSend />        </button>
      </form>
      </div>
    </div>
  );
};

export default Chat;


        