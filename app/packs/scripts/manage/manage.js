import React, { useState, Component, useEffect } from "react";
import ReactDOM from "react-dom";
import Select from 'react-select';
import CreatableSelect from 'react-select/creatable';
import axios from 'axios';
import { Header, PopularOrder, setDefault, setPending } from "./basic";
import { Filter, Pending_Filter } from "./filter";
import { makePromptList, makePendingPromptList } from "./prompts";


export const Manage_page = () => {
    const [categoryList, setcategoryList] = useState([]);
    const [tagList, settagList] = useState([]);
    const [promptList, setpromptList] = useState([]);
    const [onChange, setOnChange] = useState(true);
    const [isPopularOrder, setPopularOrder] = useState(false);
    var id_counter = 0;

    useEffect(() => {
        setDefault(settagList, setpromptList, setcategoryList)
        id_counter = 0;
    }, []);

    const promptMaps = (item) => {
        id_counter = id_counter + 1;
        return (makePromptList(item, id_counter, categoryList, setOnChange, onChange));
    }

    return (
        <>
            <Header />
            <Filter categoryList={categoryList} tagList={tagList} setpromptList={setpromptList} />
            <PopularOrder isPopularOrder={isPopularOrder} setPopularOrder={setPopularOrder} setpromptList={setpromptList} setOnChange={setOnChange} onChange={onChange} />
            <table className="container table mt-5" id="table">
                <thead>
                    <tr>
                        <th scope="col"> # </th>
                        <th scope="col"> Status </th>
                        <th scope="col"> Prompt </th>
                        <th scope="col">  </th>
                    </tr>
                </thead>

                <tbody>
                    <div id="PromptCount" data-data={promptList.length}></div>
                    {promptList.map((item) => promptMaps(item))}
                </tbody>
            </table>
        </>
    );
}

export const Pending_Manage_page = () => {
    const [categoryList, setcategoryList] = useState([]);
    const [tagList, settagList] = useState([]);
    const [promptList, setpromptList] = useState([]);
    const [onChange, setOnChange] = useState(true);
    var id_counter = 0;

    useEffect(() => {
        setPending(settagList, setpromptList, setcategoryList)
        id_counter = 0;
    }, []);

    const promptMaps = (item) => {
        id_counter = id_counter + 1;
        return (makePendingPromptList(item, id_counter, categoryList, setOnChange, onChange));
    }

    return (
        <>
            <Header />
            <Pending_Filter categoryList={categoryList} tagList={tagList} setpromptList={setpromptList} />
            <table className="container table mt-5" id="table">
                <thead>
                    <tr>
                        <th scope="col"> # </th>
                        <th scope="col"> Status </th>
                        <th scope="col"> Prompt </th>
                        <th scope="col">  </th>
                    </tr>
                </thead>

                <tbody>
                    <div id="PromptCount" data-data={promptList.length}></div>
                    {promptList.map((item) => promptMaps(item))}
                </tbody>
            </table>
        </>
    );
}