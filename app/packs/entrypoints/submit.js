
import React, { useState, useEffect } from "react";
import ReactDOM from "react-dom";
import Select from 'react-select';
import makeAnimated from 'react-select/animated';
import axios from 'axios';

const animatedComponents = makeAnimated();


class AnimatedMultiTag extends React.Component {
    constructor(props) {
        super(props);

        this.state = { selectedOption: "" };
        options: [];
    }
    componentDidMount() {
        this.fetchOptions();
    }

    fetchOptions = async () => {
        try {
            const response = await axios.get('/tags/api');
            const options = response.data.map(option => ({
                value: option.id,
                label: option.name
            }));
            this.setState({ options });
        } catch (error) {
            console.error('Failed to fetch options:', error);
        }
    };

    handleChange = selectedOption => {
        this.setState({ selectedOption });
        const selectedValues = selectedOption.map(option => option.value).join(',');
        document.getElementById('hiddenInputTag').value = selectedValues;
    };

    render() {
        return (
            <Select
                isMulti
                value={this.state.selectedOption}
                onChange={this.handleChange}
                options={this.state.options}
                components={animatedComponents}
            />
        );
    }
}

class AnimatedMultiIssue extends React.Component {
    constructor(props) {
        super(props);

        this.state = { selectedOption: "" };
        options: [];
    }
    componentDidMount() {
        this.fetchOptions();
    }

    fetchOptions = async () => {
        try {
            const response = await axios.get('/issues/api');
            const options = response.data.map(option => ({
                value: option.id,
                label: option.name
            }));
            this.setState({ options });
        } catch (error) {
            console.error('Failed to fetch options:', error);
        }
    };

    handleChange = selectedOption => {
        this.setState({ selectedOption });
        const selectedValues = selectedOption.map(option => option.value).join(',');
        document.getElementById('hiddenInputIssue').value = selectedValues;
    };

    render() {
        return (
            <Select
                isMulti
                value={this.state.selectedOption}
                onChange={this.handleChange}
                options={this.state.options}
                components={animatedComponents}
            />
        );
    }
}

ReactDOM.render(<AnimatedMultiTag />, document.querySelector("#inputTag"));
ReactDOM.render(<AnimatedMultiIssue />, document.querySelector("#inputIssue"));
