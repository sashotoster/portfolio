import React, { Component } from 'react';
import AboutMe from './components/AboutMe';
import Navigation from './components/Navigation';
import Projects from './components/Projects';
import './css/App.css';

function NameTitle (props) {
    return <div className="name-title"><h1>{props.name}</h1></div>
}

class App extends Component {
  render() {
    return (
      <div className="App">
        <NameTitle name="Alexandra Rys"/>
        <AboutMe/>
        <Navigation/>
        <Projects/>
      </div>
    );
  }
}

export default App;
