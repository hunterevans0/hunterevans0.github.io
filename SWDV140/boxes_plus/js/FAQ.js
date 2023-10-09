/*********************************************************************
***
*Original Author:                                   Hunter Evans
*Date Created:                                      17 September 2023
*Version:                                           4
*Date Last Modified:                                08 October 2023
*Modified by:                                       Hunter Evans
*Modification log:                                  4

    Version 2 - 17 September 2023 - Updated site.
    Version 3 - 01 October 2023 - Updated site.
    Version 4 - 08 October 2023 - Added jQuery to FAQ, contact, and News Letter pages. Also added some content
                                  to the paragraph tags.
***
******************************************************************** */


"use strict";
$(document).ready( () => {
	
	// runs when an h2 heading is clicked
    $("#faqs h2").click( evt => {
		const h2 = evt.currentTarget;

		$(h2).toggleClass("minus");

		if ($(h2).attr("class") != "minus") {
		   	$(h2).next().slideUp(1000);
	   	}
	   	else {
	        $(h2).next().slideDown(1000);
		   }
		   
		evt.preventDefault();
    }); // end click
    
}); // end ready















// the event handler for the click event of each h2 element
// const toggle = evt => {
//     const aElement = evt.currentTarget;                 // get the clicked a element
//     const divElement = aElement.parentNode.nextElementSibling;     // get a's parent node's sibling element div

//     aElement.classList.toggle("minus");

//     divElement.classList.toggle("open");

//     evt.preventDefault();   // cancel default action of h2 tag's <a> tag
// };

// document.addEventListener("DOMContentLoaded", () => {
//     // get the h2 tags
//     const aElements = faqs.querySelectorAll("h2 a");
    
//     // attach event handler for each a tag	    
//     for (let aElement of aElements) {
//         aElement.addEventListener("click", toggle);
//     }
//     // set focus on first h2 tag's <a> tag
//     aElements[0].focus();       
// });