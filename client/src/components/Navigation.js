import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import Paper from '@material-ui/core/Paper';
import Tabs from '@material-ui/core/Tabs';
import Tab from '@material-ui/core/Tab';

const styles = {
    navmain: {
        flexGrow: 1,
        backgroundColor: '#37474F',
    },
    navtabs: {
        color: "#CFD8DC",
    }
};

class Navigation extends Component {

    state = {
        value: 0,
    };

    handleChange = (event, value) => {
        this.setState({ value });
    };

    render() {
        return (
            <Paper className="navigation" className={this.props.classes.navmain}>
                <Tabs className={this.props.classes.navtabs}
                    value={this.state.value}
                    onChange={this.handleChange}
                    indicatorColor="primary"
                    centered
                >
                    <Tab label="Item One" />
                    <Tab label="Item Two" />
                    <Tab label="Item Three" />
                </Tabs>
            </Paper>
        );
    }
}

export default withStyles(styles)(Navigation);