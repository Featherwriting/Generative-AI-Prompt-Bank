import React, { useState, useEffect, Component } from "react";
import ReactDOM from "react-dom";
import { Flipper, Flipped } from "react-flip-toolkit";
import axios from 'axios';

//shouldFlip - determines if two elements in the Flipper should change places.
const shouldFlip = index => (prev, current) => {
  return index === prev || index === current;
}

const ListCategory = ({ index, item, onClick }) => {
  return (
    <Flipped
      flipId={`category-${index}`}
      shouldInvert={shouldFlip(index)}
    >
      <div className="listCategory" onClick={(event) => onClick(event, index, item.name)}>
        <Flipped inverseFlipId={`category-${index}`}>
          <div className="individual-drag-item">
            <Flipped
              flipId={`category-name-${index}`}
              shouldFlip={shouldFlip(index)}
              delayUntil={`category-${index}`}
            >
              <p>{item.name}</p>
            </Flipped>
          </div>
        </Flipped>
      </div>
    </Flipped>
  );
};  


const ExpandedListCategory = ({ index, item, onClick }) => {
return (
  <Flipped
    flipId={`category-${index}`}
  >
    <div className="expandedListCategory" onClick={(event) => onClick(event, index, item.name)}>
      <Flipped inverseFlipId={`category-${index}`}>
        <div className="category">
          <Flipped
            flipId={`category-name-${index}`}
            delayUntil={`category-${index}`}
          >
            <div className="category-header">
              <h4>{item.name}</h4>
            </div>
            
            
          </Flipped>
          <Flipped
            flipId={`category-purpose-${index}`}
            delayUntil={`category-${index}`}
          >
            <p className="category-body">{item.purpose}</p>
          </Flipped>
        </div>
      </Flipped>
    </div>
  </Flipped>
);
};

export const CategoriesList = ({ filterOnClick }) => {
  const [change, setChange] = useState(-1);
  const [categoryList, setcategoryList] = useState([]);

  const setcategory = () => {
      axios.get('/categories/api')
          .then(response => {
              const data = response.data.map(item => ({
                  id: item.id,
                  name: item.name,
                  purpose: item.purpose
              }));
              setcategoryList(data);
          })
          .catch(error => {
          console.error('Error fetching data:', error);
          });
  };

  useEffect(() => {
    setcategory();
  }, []);
  

 const onClick = (event, index, name) => {
    if (change != index) {
      setChange(index);
      document.getElementById("topic2").textContent = "Prompts related to..." + name;
      filterOnClick(event, index);
    }     
    else {
      setChange(-1);
      document.getElementById("topic2").textContent = "Prompts related to...";
      filterOnClick(event, -1);
    }
    
  }

  return (
    <Flipper
          flipKey={change}
          className="categoryList"
          spring="gentle"
        >
          <div class="three-boxes-div">
            <div class="category-box-items">
            {categoryList.map(item => {
              return (
                <div>
                  {item.id === change ? (
                    <ExpandedListCategory
                      index={change}
                      item={item}
                      onClick={onClick}
                    />
                  ) : (
                    <ListCategory index={item.id} item={item} onClick={onClick} />
                  )}
                </div>
                
              );
            })}
            </div>
          </div>
        </Flipper>
  )
}