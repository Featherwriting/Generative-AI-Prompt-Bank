import React, { useState, Component, useEffect } from "react";
import ReactDOM from "react-dom";
import Select from 'react-select';
import CreatableSelect from 'react-select/creatable';
import axios from 'axios';

export const getCategoryOption = (setCategoryList) => {
    axios.get('/categories/api').then(response => {
        const categorydata = response.data.map(item => ({
            id: item.id,
            name: item.name,
            purpose: item.purpose
        }));
        setCategoryList(categorydata);
    });
};

export const MakeCategorySelect = ({ categoryList, makeFormOption, item }) => {
    return (
        <div className="col-md-6">
            <label className="form-label" htmlFor="selectCategory">Category</label>
            <select id="selectCategory" className="form-select" name="prompt[category]">
                <option value="" selected={!item.category_id}>Choose category...</option>
                {categoryList.map((category) => makeFormOption(item, category))}
            </select>
        </div>
    )
}