import axios from "axios";
import React, { useState, Component, useEffect } from "react";
import Select from 'react-select';
import CreatableSelect from 'react-select/creatable';
import { getTagOption } from "./tag";
import { getCategoryOption } from "./category";
import { getDefaultPrompts, getPendingPrompts, getPopularPrompts } from "./prompts";

export const makeFilterOption = (item) => {
    return (
        <option value={item.id}>{item.name}</option>
    )
};

export const makeFormOption = (item, category) => {
    const isSelected = item.category_id == category.id;
    return (
        <option value={category.id} selected={isSelected}>{category.name}</option>
    );
};

export const CatchCSRF = () => {
    var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    return (<input type='hidden' name='authenticity_token' value={csrfToken} />)
};

export const setDefault = (setTagList, setpromptList, setCategoryList) => {
    getTagOption(setTagList);
    getCategoryOption(setCategoryList);
    getDefaultPrompts(setpromptList);
};

export const setPending = (setTagList, setpromptList, setCategoryList) => {
    getTagOption(setTagList);
    getCategoryOption(setCategoryList);
    getPendingPrompts(setpromptList)
}

export const Header = () => {
    return (
        <>
            <div className="banner">
                <div className="banner-centered">
                    <p className="banner-title">Manage</p>
                </div>
            </div>

            <div className="after-banner">
                <div className="after-banner-centered banner-centered-flex">
                    <a href="/manage">Manage</a>
                    <a href="/prompt_review">Prompt review</a>
                    <a href="/manage_category">Categories</a>
                    <a href="/manage_issue">Issues</a>
                    <a href="/manage_tag">Tags</a>
                </div>
            </div>
        </>
    )
};

export const handleDeleteButtonClick = (event, itemid) => {
    var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    event.preventDefault();
    const data = {
        id: itemid
    }
    fetch(`/prompts/delete_prompt`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(data)
    })
        .then(response => {
            window.location.reload();
        })
        .catch(error => {
            console.error('There was a problem with your fetch operation:', error);
        });
};


export class AnimatedMultiTag extends React.Component {
    constructor(props) {
        super(props);
        this.state = { selectedOption: "" };
        options: [];
    }

    componentDidMount() {
        this.fetchOptions();
        this.nameId = "#inputTagcollapse-" + this.props.id;
        this.props.data
        const el2 = document.querySelector(this.nameId)
        let tagsDate = this.props.data;
        this.dealWithInputTagsData(tagsDate);
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
        document.getElementById('hiddenInputTag-' + this.props.id).value = selectedValues;
    };

    dealWithInputTagsData = (tagsData) => {
        if (tagsData) {
            const defaultTagsOptions = tagsData.map(tag => ({
                value: tag.id,
                label: tag.name
            }))
            this.setState({ selectedOption: defaultTagsOptions });
            const selectedValues = defaultTagsOptions.map(option => option.value).join(',');
            document.getElementById('hiddenInputTag-' + this.props.id).value = selectedValues;
        }
    }

    render() {
        return (
            <Select
                isMulti
                value={this.state.selectedOption}
                onChange={this.handleChange}
                options={this.state.options}
            />
        );
    }
};

export class AnimatedMultiIssue extends React.Component {
    constructor(props) {
        super(props);
        this.state = { selectedOption: "" };
        this.options = [];
    }

    componentDidMount() {
        this.fetchOptions();
        this.nameId = "#inputIssuecollapse-" + this.props.id;
        const el = document.querySelector(this.nameId)
        let issuesData = this.props.data;
        this.dealWithInputIssuesData(issuesData);
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
        document.getElementById('hiddenInputIssue-' + this.props.id).value = selectedValues;
    };

    dealWithInputIssuesData = (issuesData) => {
        if (issuesData) {
            const defaultOptions = issuesData.map(issue => ({
                value: issue.id,
                label: issue.name
            }));
            this.setState({ selectedOption: defaultOptions });
            const selectedValues = defaultOptions.map(option => option.value).join(',');
            document.getElementById('hiddenInputIssue-' + this.props.id).value = selectedValues;
        }
    };

    render() {
        return (
            <Select
                isMulti
                value={this.state.selectedOption}
                onChange={this.handleChange}
                options={this.state.options}
            />
        );
    }
};

const components = {
    DropdownIndicator: null,
};

const createOption = (label) => ({
    label,
    value: label,
});

export class ExampleInput extends Component {
    state = {
        inputValue: '',
        value: [],
    };

    componentDidMount() {
        this.nameId = "#inputExamplecollapse-" + this.props.id;
        const el = document.querySelector(this.nameId)
        let exampleData = this.props.data;
        this.dealWithInputExamplesData(exampleData);
    }

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

    dealWithInputExamplesData = (examplesData) => {
        if (examplesData) {
            const defaultOptions = examplesData.map(example => ({
                value: example.link,
                label: example.link
            }));
            this.setState({ value: defaultOptions });
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
};

export const VisiableCheckbox = ({ item, setOnChange, onChange }) => {
    return (<div className="col-md-6">
        {(item.status == 1 || item.status == true) && <input id={"exampleCheck1" + item.id} className="form-check-input" type="checkbox" name="prompt[stat]" checked onChange={() => { item.status = 0; setOnChange(!onChange) }} />}
        {(item.status !== 1 || item.status == false) && <input id={"exampleCheck1" + item.id} className="form-check-input" type="checkbox" name="prompt[stat]" onChange={() => { item.status = 1; setOnChange(!onChange) }} />}
        <label className="form-check-label" htmlFor="exampleCheck1">Is visible</label>
    </div>)
}


export const PopularShowPlace = ({ item, setOnChange, onChange }) => {
    return (
        <div className="col-md-4">
            <label className="form-label" htmlFor="popular">Popularity</label>
            <input id="popular" type="text" class="form-control" aria-label="Sizing example input" name="prompt[use_count]" defaultValue={item.use_count} aria-describedby="inputGroup-sizing-sm" />
        </div>
    )
}
//no more used
// function changeUseCount(item, method) {
//     if (method == 'decrease') {
//         if (item.use_count >= 2000) {
//             decreaseUseCount(item);
//         }
//     }
//     else if (method == "increase") {
//         increaseUseCount(item)
//     }
//     console.log(item.use_count)
// }

// function decreaseUseCount(item) {
//     item.use_count = item.use_count - 2000;
//     axios.get('/prompts/decrease_use_count?id=' + item.id);
// }
// function increaseUseCount(item) {
//     item.use_count = item.use_count + 2000;
//     axios.get('/prompts/increase_use_count?id=' + item.id);
// }

export const PopularOrder = ({ isPopularOrder, setPopularOrder, setpromptList, setOnChange, onChange }) => {
    return (
        <div className="container">
            <div className="col">
                {isPopularOrder && <input id={"exampleCheck3"} className="form-check-input" type="checkbox" checked onChange={() => { getDefaultPrompts(setpromptList); setOnChange(!onChange); setPopularOrder(false) }} />}
                {!isPopularOrder && <input id={"exampleCheck3"} className="form-check-input" type="checkbox" onChange={() => { getPopularPrompts(setpromptList); setOnChange(!onChange); setPopularOrder(true) }} />}
                <label className="form-check-label" htmlFor="exampleCheck3">Sort in Popularity</label>
            </div>
        </div>
    )

}