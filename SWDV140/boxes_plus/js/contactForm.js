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

    // handle click on Submit button
    $("#submit").click( evt => {
        let isValid = true;

        // validate the first email address
        const emailPattern = 
            /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/;
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
        
        // validate the first name entry 
        const firstName = $("#first_name").val().trim(); 
        if (firstName == "") {
            $("#first_name").next().text("This field is required.");
            isValid = false;
        } else {
            $("#first_name").next().text("");
        }
        $("#first_name").val(firstName);

        // validate the message entry
        const message = $("#message").val().trim();
        if (message == "") {
            $("#message").next().text("This field is required.");
            isValid = false;
        } else {
            $("#message").next().text("");
        }
        $("#message").val(message);

		// prevent the default action of submitting the form if any entries are invalid 
		if (isValid == false) {
            evt.preventDefault();
		}
        
    });

    // handle click on Reset Form button
    $("#reset").click( () => {
        // clear text boxes
        $("#email_1").val("");
        $("#first_name").val("");
        $("#message").val("");

        // reset span elements
        $("#email_1").next().text("*");
        $("#first_name").next().text("*");
        $("#message").next().text("*");
        
        $("#email_1").focus();
    });

    // move focus to first text box
    $("#email_1").focus();
});