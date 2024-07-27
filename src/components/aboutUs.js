import React from 'react';
import '../css/aboutUs.css';
import { CiLocationArrow1 } from "react-icons/ci";

const AboutUs = () => {
  return (
    <div className="about-us">
      <header className="header-about">
        <div className="header-content">
          <h1>About Us</h1>
        </div>
      </header>
<section className="mission">
        <div className="mission-content">
          <h2>AptosAncestry</h2>
          <p>
          We are a revolutionary blockchain-based platform that transforms the way individuals manage their family health histories and genetic information.          </p>
          <div className="quote">
          "Manage your health securely with AptosAncestry on the Aptos blockchain."
            <footer>
              <p>NOVA Team. <br /> Founder, AptosAncestry</p>
            </footer>
            </div>
          <button className='join-button'><div>Join Us</div> <CiLocationArrow1 className='join-icon'/></button>
        </div>
        <div className="testimonial">
            <ul>
              <li>Built on the innovative and highly efficient Aptos blockchain, our app offers a secure, transparent, and user-centric approach to health data management.</li>
              <li>This innovative platform leverages the Aptos blockchain to create a secure, decentralized solution for managing family health histories, genetic data, and personal medical records.</li>
              <li>It addresses two key problems: the lack of ancestral health information leading to unawareness of hereditary diseases, and the challenges faced by frequent travelers in maintaining continuous healthcare.</li>
            </ul>
        </div>
      </section>
      <section className="values">
        <h1>Our Values</h1>
        <div className="value-cards">
          <div className="card">
            <h3>Comprehensive Health View</h3>
            <p>Understand your health in the context of your family history and genetic makeup.</p>
          </div>
          <div className="card">
            <h3>Data Ownership</h3>
            <p>You control your health data – no third-party can access it without your permission.</p>
          </div>
          <div className="card">
            <h3>Continuous Care</h3>
            <p>Ensure healthcare providers have access to your complete health history, wherever you are.</p>
          </div>
          <div className="card">
            <h3>Future-Proof Health Management</h3>
            <p>Contribute to and benefit from advancing genetic research securely.</p>
          </div>
        </div>
      </section>
    </div>
  );
};

export default AboutUs;
