import ReactDOM from "react-dom";
import React, { useState, Component, useEffect } from "react";
import { Flipper, Flipped } from "react-flip-toolkit";
import { CategoriesList } from "../scripts/categories.js";
import axios from 'axios';
export function Filter({ onFilterChange, onCategoryChange, onClearFilter }) {

    var showfilterDiv = true;

    const showfilterdiv = () => {
        const filterdiv = document.getElementById('filterdiv');
        if (showfilterDiv === false) {
            filterdiv.style.display = 'none';
            showfilterDiv = true;
        }
        else {
            filterdiv.style.display = 'block';
            showfilterDiv = false;
        }
    };

    const clearFilter = () => {
        const filterdiv = document.getElementById('filterdiv');
        filterdiv.style.display = 'none';
        onClearFilter();
        showfilterDiv = true;
    };

    useEffect(() => {
        showfilterDiv;
    }, []);



    return (
        <>
            <div class="banner">
                <div class="banner-centered">
                    <p class="banner-title">301 Skills | Generative AI Prompt Bank</p>
                </div>
            </div>
            <div class="after-banner">
                <div class="after-banner-centered">
                    <div class="row justify-content-between">
                        <div class='col-6'>
                            <p class="large-banner-text">Start by choosing a category</p>
                        </div>
                        <div class='col-4'>
                            <button type="button" class="btn transparent-button" onClick={() => clearFilter()}>Clear Filters</button>
                            <button type="button" class="btn transparent-button" onClick={() => showfilterdiv()}>More Filters</button>
                        </div>
                    </div>
                </div>
            </div>
            <CategoriesList filterOnClick={onCategoryChange} />
            <input type="hidden" id="hiddenInputCategory"></input>
            <div class='container mt-5 mb-5 bg-light-gray' id='filterdiv' style={{ display: 'none' }}>
                <form class='form-inline' onSubmit={(event) => onFilterChange(event)} id="filterForm">
                    <div class='row justify-content-md-center'>
                        <div class='col-6'>
                            <div class='input-group'>
                                <input name="prompt[content]" type="text" class="form-control" id="contextInput" placeholder="Content search..."></input>
                                <div class='input-group-append'></div>
                                <button class='input-group-text' type="submit">
                                    <i class='bi bi-search'></i>
                                </button>
                            </div>
                        </div>
                        <div class='col-3'>
                            <div id="inputTag">tags here</div>
                            <input name="prompt[tag]" type="hidden" id="hiddenInputTag"></input>
                        </div>
                    </div>
                </form>
            </div>

            <div class="banner">
                <div class="banner-centered"><i id="topic2">Prompts related to...</i>
                    <p>Potential issues:
                        <a href="https://www.sheffield.ac.uk/new-students/unfair-means">unfair means</a> and  <a href="https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#accuracy">accuracy</a>
                    </p>
                </div>
            </div>
        </>
    );
}