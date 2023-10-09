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

    const slider = $("#image_list");      // slider = ul element

    // the click event handler for the right button
    $("#right_button").click( () => { 

        // get value of current left property
        const leftProperty = parseInt(slider.css("left"));
        
        // determine new value of left property
        let newLeftProperty = 0;
        if (leftProperty - 100 > -540) {
            newLeftProperty = leftProperty - 100;
        }
        else {
            newLeftProperty = -40;
        }
        
        // use the animate function to change the left property
        slider.animate({left: newLeftProperty}, 1000);    
    }); 
    
    // the click event handler for the left button
    $("#left_button").click( () => {
    
        // get value of current left property
        const leftProperty = parseInt(slider.css("left"));
        
        // determine new value of left property
        let newLeftProperty = 0;
        if (leftProperty < -40) {
            newLeftProperty = leftProperty + 100;
        }
        else {
            newLeftProperty = -440;
        }
        
        // use the animate function to change the left property
        slider.animate({left: newLeftProperty}, 1000);
    });

});