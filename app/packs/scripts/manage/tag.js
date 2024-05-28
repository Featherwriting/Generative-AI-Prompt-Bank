import React, { useState, Component, useEffect } from "react";
import ReactDOM from "react-dom";
import Select from 'react-select';
import CreatableSelect from 'react-select/creatable';
import axios from 'axios';
import { AnimatedMultiTag } from "./basic";

export const getTagOption = (setTagList) => {
    axios.get('/tags/api').then(response => {
        const tagsdata = response.data.map(item => ({
            id: item.id,
            name: item.name
        }));
        setTagList(tagsdata);
    });
};

export const MakeTagSelect = ({ item }) => {
    return (
        < div className="col-md-6" >
            <label className="form-label" htmlFor="inputTag">Tags</label>
            <AnimatedMultiTag id={item.id} data={item.tag} key={Math.random()} />
            <input id={`hiddenInputTag-${item.id}`} name="prompt[tag]" type="hidden" />
        </div >)
};
