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

    // handle click on Join List button
    $("#join_list").click( evt => {
        let isValid = true;

        // validate the first email address
        const emailPattern = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/;
        const email1 = $("#email_1").val().trim();
        if (email1 == "") { 
            $("#email_1").next().text("This field is required.");
            isValid = false;
        } else if ( !emailPattern.test(email1) ) {
            $("#email_1").next().text("Must be a valid email address.");
            isValid = false;
        } else {
            $("#email_1").next().text("");
        }
        $("#email_1").val(email1);

        // validate the second email address
        const email2 = $("#email_2").val().trim();
        if (email2 == "") { 
            $("#email_2").next().text("This field is required.");
            isValid = false; 
        } else if (email1 != email2) { 
            $("#email_2").next().text("The email addresses must match.");
            isValid = false;
        } else {
            $("#email_2").next().text("");
        }
        $("#email_2").val(email2);
        
        // validate the first name entry 
        const firstName = $("#first_name").val().trim(); 
        if (firstName == "") {
            $("#first_name").next().text("This field is required.");
            isValid = false;
        } else {
            $("#first_name").next().text("");
        }
        $("#first_name").val(firstName);

		// prevent the default action of submitting the form if any entries are invalid 
		if (isValid == false) {
            evt.preventDefault();
		}
        
    });

    // handle click on Reset Form button
    $("#reset").click( () => {
        // clear text boxes
        $("#email_1").val("");
        $("#email_2").val("");
        $("#first_name").val("");

        // reset span elements
        $("#email_1").next().text("*");
        $("#email_2").next().text("*");
        $("#first_name").next().text("*");
        
        $("#email_1").focus();
    });

    // move focus to first text box
    $("#email_1").focus();
});
