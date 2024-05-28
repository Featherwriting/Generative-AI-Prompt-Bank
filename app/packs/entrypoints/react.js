import { HomeDragger } from "../scripts/homedragger.js";
import { CategoriesList } from "../scripts/categories.js";
import { handleFormSubmit, changeCategoryFilter, getData } from "../scripts/data.js";
import { Filter } from "../scripts/filter.js";
import React, { useState, useEffect } from "react";
import ReactDOM from "react-dom";
import Select from 'react-select';
import makeAnimated from 'react-select/animated';
import axios from 'axios';


function App() {
    const [list1, setList1] = useState([]);
    const [list2, setList2] = useState([]);

    const handleFilterChange = (event) => {
        handleFormSubmit({ event: event, list: list1, setList: setList1 });
    }

    const handleCategoryChange = (event, id) => {
        changeCategoryFilter({ itemid: id, event: event, list: list1, setList: setList1 });
    }

    const handleClearFilter = () => {
        getData({ list: list1, setList: setList1 });
    }

    useEffect(() => {
        getData({ list: list1, setList: setList1 });
    }, []);

    return (
        <div class='bg-light-gray'>
            <Filter onFilterChange={handleFilterChange} onCategoryChange={handleCategoryChange} onClearFilter={handleClearFilter} />
            <HomeDragger list1={list1} setList1={setList1} list2={list2} setList2={setList2} />
        </div>
    )
}






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

ReactDOM.render(<App />, document.querySelector("#root"));

ReactDOM.render(<AnimatedMultiTag />, document.querySelector("#inputTag"));