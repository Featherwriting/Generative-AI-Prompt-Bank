import React, { useState, Component, useEffect } from "react";
import axios from 'axios';
import { CatchCSRF, PopularShowPlace, VisiableCheckbox } from "./basic";
import { MakeCategorySelect } from "./category";
import { makeFormOption } from "./basic";
import { MakeTagSelect } from "./tag";
import { MakeExample } from "./example";
import { MakeIssue } from "./Issue";
import { handleDeleteButtonClick } from "./basic";

export const getDefaultPrompts = (setpromptList) => {
    axios.get('/pages/getDefaultPrompt').then(response => {
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
        setpromptList(data);
        let PC = document.getElementById('PromptCount')
        if (PC) {
            PC.dataset.data = data.length;
        }
        else {
        };
    });
};

export const getPopularPrompts = (setpromptList) => {
    axios.get('/pages/getPopularPrompt').then(response => {
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
        setpromptList(data);
        let PC = document.getElementById('PromptCount')
        if (PC) {
            PC.dataset.data = data.length;
        }
        else {
        };
    });
}

export const getPendingPrompts = (setpromptList) => {
    axios.get('/pages/getPendingPrompt').then(response => {
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
        setpromptList(data);
        let PC = document.getElementById('PromptCount')
        if (PC) {
            PC.dataset.data = data.length;
        }
        else {
        };
    });
}

export const makePromptList = (item, id_counter, categoryList, setOnChange, onChange) => {
    let collapse_id = `collapse-${id_counter}`;
    return (
        <>
            <PromptLine id_counter={id_counter} item={item} collapse_id={collapse_id} />
            <tr>
                <td className="collapse container" id={collapse_id} colSpan="4" data-prompt_id={item.id}>
                    <form className="row g-3 m-2" action="/prompts/submit_prompt_visible" method="post">
                        <NormalManage item={item} categoryList={categoryList} setOnChange={setOnChange} onChange={onChange} />
                        <div className="col-md-12">
                            <button type="submit" className="btn btn-primary">Submit</button>
                            <button className="btn btn-danger" onClick={(event) => handleDeleteButtonClick(event, item.id)}>Delete</button>
                        </div>
                    </form>
                </td>
            </tr>
        </>
    );
};

export const makePendingPromptList = (item, id_counter, categoryList, setOnChange, onChange) => {
    let collapse_id = `collapse-${id_counter}`;
    let targetid = "#rejectModal" + item.id.toString();
    return (
        <>
            <PromptLine id_counter={id_counter} item={item} collapse_id={collapse_id} />
            <tr>
                <td className="collapse container" id={collapse_id} colSpan="4" data-prompt_id={item.id}>
                    <form className="row g-3 m-2" action="/prompts/approve_prompt" method="post">
                        <NormalManage item={item} categoryList={categoryList} setOnChange={setOnChange} onChange={onChange} />
                        <input type="hidden" name="prompt[email]" value={item.submitter_email} />
                        <div className="col-md-12">
                            <div className="col-md-12">
                                <button className="btn btn-success" type="submit">Approve</button>
                                <button className="btn btn-danger" data-bs-target={targetid} data-bs-toggle="modal" type="button">Decline</button>
                            </div>
                        </div>
                    </form>
                    <ApprovePromptModle item={item} />
                </td>
            </tr>
        </>
    );
};

const NormalManage = ({ item, categoryList, setOnChange, onChange }) => {
    return (
        <>
            <CatchCSRF />
            <input id="hiddenInputId" name="prompt[id]" type="hidden" value={item.id} />
            <MakeCategorySelect categoryList={categoryList} makeFormOption={makeFormOption} item={item} />
            <MakeTagSelect item={item} />
            <MakePromptContent item={item} />
            <PopularShowPlace item={item} setOnChange={setOnChange} onChange={onChange} />  
            <MakeIssue item={item} />
            <MakeExample item={item} />
            <VisiableCheckbox item={item} setOnChange={setOnChange} onChange={onChange} />
        </>
    )
};

function itemState(item) {
    return (
        <td>
            {item.status === 0 && (
                <button className="btn btn-danger">Invisible</button>
            )}
            {item.status === 1 && (
                <button className="btn btn-success">Visible</button>
            )}
            {item.status !== 0 && item.status !== 1 && (
                <button className="btn btn-warning">Pending</button>
            )}
        </td>
    )
};

const PromptLine = ({ id_counter, item, collapse_id }) => {
    return (
        <tr>
            <th scope="row">{id_counter}</th>
            {itemState(item)}
            <td>
                {item.name}
            </td>
            <td>
                <i
                    className="col-1 bi bi-caret-down-fill"
                    data-bs-target={`#${collapse_id}`}
                    data-bs-toggle="collapse"
                    data-bs-parent="#table" />
            </td>
        </tr>
    )

};

const MakePromptContent = ({ item }) => {
    return (
        <div className="col-md-12">
            <label className="form-label" htmlFor="inputPrompt">Prompt</label>
            <input id="inputPrompt" className="form-control" type="text" name="prompt[text]" defaultValue={item.name} />
        </div>
    )
};

const ApprovePromptModle = ({ item }) => {
    let targetid = "rejectModal" + item.id.toString()
    let csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    return (
        <div className="col-md-12">
            <div id={targetid} className="modal fade" aria-hidden="true" aria-labelledby="rejectModalLabel" role="dialog" tabIndex="-1">
                <div className="modal-dialog modal-lg" role="document">
                    <div className="modal-content">
                        <form action="/prompts/reject_prompt" method="post">
                            <div className="modal-header">
                                <h5 id="rejectModalLabel" className="modal-title">Reject This Prompt</h5>
                                <button type="button" className="btn-close" aria-label="Close" data-bs-dismiss="modal"></button>
                                <span aria-hidden="true"></span>
                            </div>
                            <div className="modal-body">
                                <input type="hidden" name="authenticity_token" value={csrfToken} />
                                <input id="hiddenInputId" type="hidden" name="prompt[id]" value={item.id} />
                                <div className="mb-3">
                                    <label htmlFor="submitterEmail" className="form-label">Submitter's email</label>
                                    <input id="submitterEmail" type="text" value={item.submitter_email} className="form-control" disabled="disabled" />
                                    <input type="hidden" name="prompt[email]" value={item.submitter_email} />
                                </div>
                                <div className="mb-3">
                                    <label htmlFor="rejectReason">Reasons for rejection</label>
                                    <textarea id="rejectReason" name="prompt[reason]" placeholder="Reason for rejection will be automatically sent to the submitter via email" style={{ height: '100px' }} className="form-control"></textarea>
                                </div>
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" className="btn btn-primary">Confirm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>)
};
