import React, { Component } from 'react';
import ReactDOM from "react-dom";
import CreatableSelect from 'react-select/creatable';

const components = {
  DropdownIndicator: null,
};

const createOption = (label) => ({
  label,
  value: label,
});

class ExampleInput extends Component {
  state = {
    inputValue: '',
    value: [],
  };

  handleKeyDown = (event) => {
    const { inputValue } = this.state;
    if (!inputValue) return;
    switch (event.key) {
      case 'Enter':
      case 'Tab':
        this.setState((prevState) => ({
          value: [...prevState.value, createOption(inputValue)],
          inputValue: '',
        }));
        event.preventDefault();
        break;
      default:
        // It's generally a good idea to handle default case even if you do nothing.
        break;
    }
  };

  render() {
    const { inputValue, value } = this.state;
    const hiddenInputValue = JSON.stringify(value.map(item => item.value));
    return (
    <>
      <CreatableSelect
        components={components}
        inputValue={inputValue}
        isClearable
        isMulti
        menuIsOpen={false}
        onChange={(newValue) => this.setState({ value: newValue || [] })}
        onInputChange={(newValue) => this.setState({ inputValue: newValue })}
        onKeyDown={this.handleKeyDown}
        placeholder="Type link and press enter..."
        value={value}
      />
      <input
          type="hidden"
          name='prompt[link]'
          value={hiddenInputValue}
      />
    </>
    );
  }
}
ReactDOM.render(<ExampleInput />, document.querySelector("#inputExample"));