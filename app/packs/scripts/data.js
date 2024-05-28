import ReactDOM from "react-dom";
import { Carousel } from "bootstrap";
import React, { useState, Component, useEffect } from "react";
import axios from 'axios';

/**
 * changeCategoryFilter - Changes the filter category
 * 
 */
export const changeCategoryFilter = ({itemid, event, list, setList}) => {
  const filtercategory = document.getElementById('hiddenInputCategory');
  filtercategory.value = itemid;
  handleCategorySubmit({event, list, setList}); 
};

/**
 * handleCategorySubmit - 
 * event - 
 */
const handleCategorySubmit = ({event, list, setList}) =>{
  if (event)
  event.preventDefault();
  let filtercategory = document.getElementById('hiddenInputCategory').value;
  axios.get('/pages/filter_prompt?' + "categoryid=" + filtercategory.toString())
  .then(response => {
    const data = response.data.map(item => ({
      id: item.id,
      name: item.prompt_content,
      status: 0,
      use_count: item.use_count,
      example: item.examples,
      tag: item.tags,
      issue: item.issues
    }));
    setList(data);
  })
  .catch(error => {
    console.error('Error fetching data:', error);
  });
const myCarouselElement = document.querySelector('#carouselExample');
const carousel = new Carousel(myCarouselElement, {});
carousel.to(0);
}


/**handleFormSubmit -
 * 
**/
export const handleFormSubmit = ({event, list, setList}) => {
  if (event)
    event.preventDefault();
  let form = document.getElementById('filterForm');
  let formData = new FormData(form);
  let queryString = new URLSearchParams(formData).toString();
  let filtercategory = document.getElementById('hiddenInputCategory').value;

  axios.get('/pages/filter_prompt?' + queryString + "&categoryid=" + filtercategory.toString())
    .then(response => {
      const data = response.data.map(item => ({
        id: item.id,
        name: item.prompt_content,
        status: 0,
        use_count: item.use_count,
        example: item.examples,
        tag: item.tags,
        issue: item.issues
      }));
      setList(data);
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });

  const myCarouselElement = document.querySelector('#carouselExample');
  const carousel = new Carousel(myCarouselElement, {});
  carousel.to(0);
};
/**
 * getData - grabs filtered list data from the filter_prompt page 
 * 
 */
export const getData = ({list, setList}) => {
  axios.get('/pages/filter_prompt')
    .then(response => {
      const data = response.data.map(item => ({
        id: item.id,
        name: item.prompt_content,
        status: 0,
        use_count: item.use_count,
        example: item.examples,
        tag: item.tags,
        issue: item.issues
      }));
      setList(data);
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
};

