import ReactDOM from "react-dom";
import React, { useState, Component, useEffect } from "react";
import { Flipper, Flipped } from "react-flip-toolkit";
import { Carousel } from "bootstrap";
import axios from 'axios';
import "../styles/test.scss";
import "../styles/layout.scss";


function chunkArray(array, size) {
  const chunkedArr = [];
  for (let i = 0; i < array.length; i += size) {
    chunkedArr.push(array.slice(i, i + size));
  }
  return chunkedArr;
}


//main part
export const HomeDragger = ({ list1, setList1, list2, setList2 }) => {

  //variable to modified
  const [change, setChange] = useState(0);

  const stopPropagation = (event) => {
    event.stopPropagation();
  }

  const handleTagClick = (event, id) => {
    stopPropagation(event);
    axios.get('/pages/filter_prompt_only_tag?' + "tagid=" + id.toString())
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
        setList1(data);
        console.log(data);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
      });

    const myCarouselElement = document.querySelector('#carouselExample');
    const carousel = new Carousel(myCarouselElement, {});
    carousel.to(0);
  };


  //check if the index equals to prev or current
  const shouldFlip = (index) => (prev, current) =>
    index === prev || index === current;

  //transfer the id to list id
  const createCardFlipId = (index) => `listItem-${index}`;

  const moveItem = (id, sourceList, targetList) => {
    const index = sourceList.findIndex(item => item.id === id);//fetch the prompt id in target list
    if (index === -1) return [sourceList, targetList]; // If item is not found, return the lists unchanged
    const item = sourceList[index];
    const newSourceList = sourceList.filter(item => item.id !== id);//remove the source in current list
    const newTargetList = [...targetList, item];//move the source to new list
    return [newSourceList, newTargetList];//fresh the two list
  };

  //define the function for button to use
  const handleItemClick = (
    id,
    sourceList,
    setSourceList,
    targetList,
    setTargetList
  ) => {
    const [newSourceList, newTargetList] = moveItem(
      id,
      sourceList,
      targetList
    );
    setSourceList(newSourceList);
    setTargetList(newTargetList);
    setChange(change === 1 ? 0 : 1);
  };

  //used to record if the detail of the list is showed
  const toggleItemStatus1 = (id) => {
    setList1(prevList => prevList.map(item => {
      if (item.id === id) {
        return { ...item, status: item.status === 1 ? 0 : 1 };
      }
      return item;
    }));
    setChange(change === 1 ? 0 : 1);
  };



  const toggleItemStatus2 = (id) => {
    setList2(prevList => prevList.map(item => {
      if (item.id === id) {
        return { ...item, status: item.status === 1 ? 0 : 1 };
      }
      return item;
    }));
    setChange(change === 1 ? 0 : 1);
  };

  //used for detail information button
  const ListItem = ({ index, item, bool, onClick }) => {
    return (
      <Flipped flipId={createCardFlipId(index)} shouldInvert={shouldFlip}>
        <div className="individual-drag-container">
          <div className="individual-drag-item">
            <div class="d-flex flex-row-reverse">
              <i class="bi bi-info-lg" onClick={() => onClick(index)}></i>
            </div>
            <Flipped inverseFlipId={createCardFlipId(index)}>
              <div className="individual-drag-item-content"
                onClick={() =>
                  bool === 1
                    ? handleItemClick(index, list1, setList1, list2, setList2)
                    : bool === 2
                      ? handleItemClick(index, list2, setList2, list1, setList1)
                      : null
                }
              >
                <Flipped flipId={`${index}-content`} delayUntil={createCardFlipId(index)} shouldInvert={shouldFlip} scale={false}>
                  <p>{item.name}</p>
                </Flipped>

              </div>
            </Flipped>
          </div>
        </div>
      </Flipped>
    )
  };

  //used for detail information
  const ExpandedListItem = ({ index, item, bool, onClick }) => {
    return (
      <Flipped flipId={createCardFlipId(index)} shouldInvert={shouldFlip}>


        <div className="individual-drag-container">
          <div className="individual-drag-item">
            <div class="d-flex flex-row-reverse">
              <i class="bi bi-info-lg h5" onClick={() => onClick(index)}></i>
            </div>
            <Flipped inverseFlipId={createCardFlipId(index)}>
              <div className="individual-drag-item-content"
                onClick={() =>
                  bool === 1
                    ? handleItemClick(index, list1, setList1, list2, setList2)
                    : bool === 2
                      ? handleItemClick(index, list2, setList2, list1, setList1)
                      : null
                }
              >

                <Flipped flipId={`${index}-content`} delayUntil={createCardFlipId(index)} shouldInvert={shouldFlip}>
                  <p>{item.name}</p>
                </Flipped>
                <Flipped flipId={`${index}-detail`} delayUntil={createCardFlipId(index)} shouldInvert={shouldFlip}>
                  <div>
                    <p>Example:
                      {item.example.map((item) => (
                        <a class="link-limited" onClick={(event) => stopPropagation(event)} href={item.link}>{item.link}  </a>
                      ))}
                    </p>
                    <p>Issue:
                      {item.issue.map((item) => (
                        //item.name
                        <a onClick={(event) => stopPropagation(event)} class="badge text-bg-danger" href={item.link} target="_blank">{item.name}</a>
                      ))}
                    </p>
                    <p>Tag:
                      {item.tag.map((item) => (
                        //item.name
                        <a class="badge text-bg-secondary" key={item.id} href="javascript:void(0);" onClick={(event) => handleTagClick(event, item.id)}>
                          {item.name}
                        </a>
                      ))}
                    </p>
                  </div>
                </Flipped>
              </div>
            </Flipped>
          </div>
        </div>
      </Flipped>
    )
  };


  //edit prompt
  const handleEditButtonClick = () => {

    const names = list2.map(item => item.name);
    const namesString = names.join(' ');
    const textBox = document.getElementById('editTextBox');
    const originalBox = document.getElementById('original');

    let height = originalBox.offsetHeight;

    if (textBox.style.display == "none") {
      originalBox.style.display = "none";
      textBox.style.display = "block";
      textBox.style.height = height + 'px';
      textBox.style.width = '100%';
    }
    else {
      originalBox.style.display = "flex";
      textBox.style.display = "none";
    }

    textBox.value = namesString;
  };
  //copyToClipboard() - copies the text in the selection box to the clipboard. No arguments or returns.
  const copyToClipboard = () => {
    //select the textbox and send a popup to indicate whether the text was copied.
    let text = document.getElementById("editTextBox");
    if (!text) {
      alert("not copied");
    } else {
      alert("copied");
      text.select();
      navigator.clipboard.writeText(text.value);
      const ids = list2.map(item => item.id);
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const data = {
        id: ids
      }
      fetch(`/prompts/increase_clicks`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(data)
      });

    }
  }

  return ( //returns the elements of the site for which the dragging functionality is necessary.
    <>

      <div class="after-banner">
        <div class="after-banner-centered">
          <p>Click the "i" button for more information</p>
        </div>
      </div>

      <Flipper
        flipKey={change}
        className="staggered-list-content"
        spring="gentle"
      >
        <div id="carouselExample" class="prompt-carousel" className="carousel slide">
          {list1.length === 0 ? (
            <div className="carousel-inner">
              <div className="three-boxes-div">
                <div className="select-box-items">
                  <h5 className="text-center">No relevant prompt found</h5>
                </div>
              </div>
            </div>
          ) : ( //carousel containing the prompt components
            <div className="carousel-inner">
              {chunkArray(list1, 12).map((itemsChunk, index) => (
                <div className={`carousel-item ${index === 0 ? "active" : ""}`}>
                  <div className="three-boxes-div">
                    <div className="select-box-items">
                      {itemsChunk.map((item) => (
                        item.status === 1 ? (
                          <ExpandedListItem
                            key={item.id}
                            index={item.id}
                            item={item}
                            bool={1}
                            onClick={toggleItemStatus1}
                          />
                        ) : (
                          <ListItem
                            key={item.id}
                            index={item.id}
                            item={item}
                            bool={1}
                            onClick={toggleItemStatus1}
                          />
                        )
                      ))}
                    </div>
                  </div>
                  <div class="carousel-page-text">
                    <h5 class="carousel-page-text">Page {index + 1}</h5>
                  </div>
                </div>
              ))}
            </div>
          )}
          <button className="carousel-control-prev prompt-carousel-button-left" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span className="carousel-control-prev-icon prompt-carousel-icons-black" aria-hidden="true"></span>
            <span className="visually-hidden">Previous</span>
          </button>
          <button className="carousel-control-next prompt-carousel-button-right" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span className="carousel-control-next-icon prompt-carousel-icons-black" aria-hidden="true"></span>
            <span className="visually-hidden">Next</span>
          </button>
        </div>

        <div class="banner">
          <div class="banner-centered">
            <i>Click a prompt to add it to the prompt builder</i>
          </div>
        </div>

        <div class="after-banner">
          <div class="after-banner-centered">
            <p>Try chaining different prompts together to get precisely the prompt you need</p>
          </div>
        </div>

        <div class="three-boxes-div">
          <div class="prompt-builder">
            <div class="select-box-items" id="original">
              {list2.map((item) => (
                item.status === 1 ? (
                  <ExpandedListItem
                    index={item.id}
                    item={item}
                    bool={2}
                    onClick={toggleItemStatus2} />
                ) : (
                  <ListItem index={item.id} item={item} bool={2} onClick={toggleItemStatus2} />
                )
              ))}
            </div>
            <textarea id="editTextBox" style={{ display: "none" }}></textarea>
            <div class="copy-to-clipboard" onClick={() => copyToClipboard()}><i class="bi bi-copy"></i></div>
            <div class="edit-prompt" onClick={() => handleEditButtonClick()}><i class="bi bi-pencil-square"></i></div>
          </div>
        </div>


      </Flipper>
    </>
  );
};



