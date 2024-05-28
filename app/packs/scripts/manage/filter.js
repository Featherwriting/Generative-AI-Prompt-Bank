import React, { useState, Component, useEffect } from "react";
import { makeFilterOption } from "./basic";
import axios from "axios";


export const Filter = ({ categoryList, tagList, setpromptList }) => {

    useEffect(() => {


        const myButton = document.getElementById("manage_filter_submit_btn");
        const tagfilter = document.getElementById("manage_filter_tag");
        const categoryfilter = document.getElementById("manage_filter_category");
        const contentfilter = document.getElementById("manage_filter_input_text");

        if (myButton) {
            myButton.addEventListener("click", (event) => {
                event.preventDefault();
                let tag = tagfilter.value;
                let category = categoryfilter.value;
                let content = contentfilter.value;
                if (!content || content.trim() === '') {
                    content = "none";
                }
                axios.get('/pages/manage_filter?' + "tag=" + tag.toString() + "&category=" + category.toString() + "&content=" + content.toString())
                    .then(response => {
                        const data = response.data.map(item => ({
                            id: item.id,
                            name: item.prompt_content,
                            status: item.stat,
                            use_count: item.use_count,
                            example: item.examples,
                            tag: item.tags,
                            issue: item.issues,
                            category_id: item.category_id,
                            submitter_email: item.submitter_email,
                            use_count: item.use_count
                        }));
                        let PC = document.getElementById('PromptCount')
                        if (PC) {
                            PC.dataset.data = data.length;
                        }
                        else {
                        };
                        setpromptList(data);
                    })
                    .catch(error => {
                        console.error('Error fetching data:', error);
                    });
            });
        }
    }, []);

    return (
        <div className="container mt-5">
            <form id="manage_filter_form" method="get" role="search" target="_blank" className="form-inline row">
                <div className="input-group"><input id="manage_filter_input_text" name="KeyWord" placeholder="Search" type="text" className="form-control" />
                    <div className="input-group-append"></div><button type="submit" id="manage_filter_submit_btn" className="input-group-text"><i className="bi bi-search"></i></button>
                </div>
                <div className="col-auto">
                    <select id="manage_filter_category" className="form-select m-3">
                        <option selected value="none">Choose category...</option>
                        {categoryList.map((item, index) => makeFilterOption(item))}
                    </select>
                </div>
                <div className="col-auto">
                    <select id="manage_filter_tag" className="form-select m-3">
                        <option selected value="none">Choose tags...</option>
                        {tagList.map((item, index) => makeFilterOption(item))}
                    </select>
                </div>
            </form>
        </div>)
}

export const Pending_Filter = ({ categoryList, tagList, setpromptList }) => {

    useEffect(() => {


        const myButton = document.getElementById("manage_filter_submit_btn");
        const tagfilter = document.getElementById("manage_filter_tag");
        const categoryfilter = document.getElementById("manage_filter_category");
        const contentfilter = document.getElementById("manage_filter_input_text");

        if (myButton) {
            myButton.addEventListener("click", (event) => {
                event.preventDefault();
                let tag = tagfilter.value;
                let category = categoryfilter.value;
                let content = contentfilter.value;
                if (!content || content.trim() === '') {
                    content = "none";
                }
                axios.get('/pages/pending_manage_filter?' + "tag=" + tag.toString() + "&category=" + category.toString() + "&content=" + content.toString())
                    .then(response => {
                        const data = response.data.map(item => ({
                            id: item.id,
                            name: item.prompt_content,
                            status: item.stat,
                            use_count: item.use_count,
                            example: item.examples,
                            tag: item.tags,
                            issue: item.issues,
                            category_id: item.category_id,
                            submitter_email: item.submitter_email,
                            use_count: item.use_count
                        }));
                        let PC = document.getElementById('PromptCount')
                        if (PC) {
                            PC.dataset.data = data.length;
                        }
                        else {
                        };
                        setpromptList(data);
                    })
                    .catch(error => {
                        console.error('Error fetching data:', error);
                    });
            });
        }
    }, []);

    return (
        <div className="container mt-5">
            <form id="manage_filter_form" method="get" role="search" target="_blank" className="form-inline row">
                <div className="input-group"><input id="manage_filter_input_text" name="KeyWord" placeholder="Search" type="text" className="form-control" />
                    <div className="input-group-append"></div><button type="submit" id="manage_filter_submit_btn" className="input-group-text"><i className="bi bi-search"></i></button>
                </div>
                <div className="col-auto">
                    <select id="manage_filter_category" className="form-select m-3">
                        <option selected value="none">Choose category...</option>
                        {categoryList.map((item, index) => makeFilterOption(item))}
                    </select>
                </div>
                <div className="col-auto">
                    <select id="manage_filter_tag" className="form-select m-3">
                        <option selected value="none">Choose tags...</option>
                        {tagList.map((item, index) => makeFilterOption(item))}
                    </select>
                </div>
            </form>
        </div>)
}

