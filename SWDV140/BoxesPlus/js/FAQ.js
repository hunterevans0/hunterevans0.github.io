/*********************************************************************
***
*Original Author:                                   Hunter Evans
*Date Created:                                      17 September 2023
*Version:                                           2
*Date Last Modified:                                17 September 2023
*Modified by:                                       Hunter Evans
*Modification log:                                  2

    Version 2 - 17 September 2023 - Updated site.
***
******************************************************************** */


"use strict";

// the event handler for the click event of each h2 element
const toggle = evt => {
    const aElement = evt.currentTarget;                 // get the clicked a element
    const divElement = aElement.parentNode.nextElementSibling;     // get a's parent node's sibling element div

    aElement.classList.toggle("minus");

    divElement.classList.toggle("open");

    evt.preventDefault();   // cancel default action of h2 tag's <a> tag
};

document.addEventListener("DOMContentLoaded", () => {
    // get the h2 tags
    const aElements = faqs.querySelectorAll("h2 a");
    
    // attach event handler for each a tag	    
    for (let aElement of aElements) {
        aElement.addEventListener("click", toggle);
    }
    // set focus on first h2 tag's <a> tag
    aElements[0].focus();       
});