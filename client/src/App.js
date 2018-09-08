import React, { Component } from 'react';
import Navigation from './components/Navigation';
import Projects from './components/Projects';
import './css/App.css';
import Grid from '@material-ui/core/Grid';

function NameTitle (props) {
    return <div className="name-title"><h1>{props.name}</h1></div>
}

function AboutMe (props) {

    const linkIcons = props.links.map((linkData) =>
        <a target="_blank" href={linkData.href} title={linkData.icon.charAt(0).toUpperCase() + linkData.icon.slice(1)}>
            <i className={"fab fa-2x fa-"+linkData.icon}></i>
        </a>
    );

    return (
        <div className="about-me">
            <Grid container spacing={24}>
                <Grid item container md={6} alignItems={"flex-start"}>
                    <Grid item>
                        <img src={props.photo}/>
                    </Grid>
                </Grid>
                <Grid item container md={6} direction={"column"} justify={"space-between"}>
                    <Grid item><div>{props.text}</div></Grid>
                    <Grid item style={{marginTop: 10}}>{linkIcons}</Grid>
                </Grid>
            </Grid>
        </div>
    );
}

class App extends Component {
  constructor() {
    super();
    this.state = this.getInitialState();
  }
  render() {
    return (
        <div className="App">
            <NameTitle name="Alexandra Rys"/>
            <AboutMe photo={this.state.photo} text={this.state.text} links={this.state.links}/>
            <Navigation/>
            <Projects/>
        </div>
    );
  }
  getInitialState() {
      return {
          photo: 'https://cdn.cnn.com/cnnnext/dam/assets/141230145304-one-square-meter---logo-large-169.png',
          text: 'here goes the text'.repeat(50),
          links: [
              {icon: 'github', href: 'https://github.com/sashotoster'},
              {icon: 'instagram', href: 'https://www.instagram.com/sashotoster'},
          ]
      }
  }
}

export default App;
