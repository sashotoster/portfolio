import React, { Component } from 'react';
import Navigation from './components/Navigation';
import Projects from './components/Projects';
import './css/App.css';
import Grid from '@material-ui/core/Grid';

function NameTitle (props) {
    return <div className="name-title"><h1>{props.name}</h1></div>
}

function AboutMe (props) {
    return (
        <div className="about-me">
            <Grid container spacing={24} alignItems={"flex-start"}>
                <Grid item container md={6}>
                    <img src={props.photo}/>
                </Grid>
                <Grid item container md={6} alignContent={"flex-start"}>
                    <div>{props.text.repeat(50)}</div>
                </Grid>
            </Grid>
        </div>
    );
}

class App extends Component {
  render() {
    return (
      <div className="App">
        <NameTitle name="Alexandra Rys"/>
        <AboutMe photo="https://cdn.cnn.com/cnnnext/dam/assets/141230145304-one-square-meter---logo-large-169.png" text="here goes the text "/>
        <Navigation/>
        <Projects/>
      </div>
    );
  }
}

export default App;
