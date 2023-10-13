/*********************************************************************
***
*Original Author:                                   Hunter Evans
*Date Created:                                      17 September 2023
*Version:                                           5
*Date Last Modified:                                13 October 2023
*Modified by:                                       Hunter Evans
*Modification log:                                  5

    Version 2 - 17 September 2023 - Updated site.
    Version 3 - 01 October 2023 - Updated site.
    Version 4 - 08 October 2023 - Added jQuery to FAQ, contact, and News Letter pages. Also added some content
                                  to the paragraph tags.
    Version 5 - 13 October 2023 - Fixed centering issues. Added time and date feature to newsLetterSent.html 
                                  and contactSent.html.
***
******************************************************************** */


"use strict";
$(document).ready( () => {
    let date = new Date();
    alert("Date sent: " + date);
});