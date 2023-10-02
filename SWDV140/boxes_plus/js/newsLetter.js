/*********************************************************************
***
*Original Author:                                   Hunter Evans
*Date Created:                                      17 September 2023
*Version:                                           3
*Date Last Modified:                                01 October 2023
*Modified by:                                       Hunter Evans
*Modification log:                                  3

    Version 2 - 17 September 2023 - Updated site.
    Version 3 - 01 October 2023 - Updated site.
***
******************************************************************** */


"use strict";

const $ = selector => document.querySelector(selector);

document.addEventListener("DOMContentLoaded", () => {
    
    $("#join_list").addEventListener("click", () => {
        // get values user entered in textboxes
        const email1 = $("#email_1");
        const email2 = $("#email_2");
        const firstName = $("#first_name");

        // create an error message and set it to an empty string
        let errorMessage = "";

        // check user entries - add text to error message if invalid
        
        if (email1.value == "") { 
            email1.nextElementSibling.textContent = "First email is required.";
            errorMessage = "error";
        } else {
            email1.nextElementSibling.textContent = "*";
        }

        if (email2.value == "") { 
            email2.nextElementSibling.textContent = "Second email is required.";
            errorMessage = "error";
        } else {
            email2.nextElementSibling.textContent = "*";
        }

        if (email1.value != email2.value) { 
            email1.nextElementSibling.textContent = "Both emails must match.";
            errorMessage = "error";
        } else if (email1.value != "") {
            email1.nextElementSibling.textContent = "*";
        }

        if (firstName.value == "") {
            firstName.nextElementSibling.textContent = "First name is required.";
            errorMessage = "error";
        } else {
            firstName.nextElementSibling.textContent = "*";
        }

        // submit the form if error message is an empty string
        if (errorMessage == "") {
            $("#email_form").submit();
        }
    });

    // this clears the form
    $("#clear_form_2").addEventListener("click", () => {
        $("#email_1").value = "";
        $("#email_2").value = "";
        $("#first_name").value = "";

        $("#email_1_error").textContent = "*";
        $("#email_2_error").textContent = "*";
        $("#first_name_error").textContent = "*";

        $("#email_1").focus();
    });

    $("#email_1").focus();
});