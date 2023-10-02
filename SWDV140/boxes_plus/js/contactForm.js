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
    
    $("#submit_1").addEventListener("click", () => {
        const email = $("#email");
        const name = $("#name");
        const message = $("#message");

        let errorMessage = "";

        if (email.value == "") { 
            email.nextElementSibling.textContent = "First email is required.";
            errorMessage = "error";
        } else {
            email.nextElementSibling.textContent = "*";
        }

        if (name.value == "") { 
            name.nextElementSibling.textContent = "First email is required.";
            errorMessage = "error";
        } else {
            name.nextElementSibling.textContent = "*";
        }

        if (message.value == "") { 
            message.nextElementSibling.textContent = "First email is required.";
            errorMessage = "error";
        } else {
            message.nextElementSibling.textContent = "*";
        }

        if (errorMessage == "") {
            $("#contact_form").submit();
        }
    });

    $("#clear_form_1").addEventListener("click", () => {
        $("#email").value = "";
        $("#name").value = "";
        $("#message").value = "";

        $("#email_error").textContent = "*";
        $("#name_error").textContent = "*";
        $("#message_error").textContent = "*";

        $("#email").focus();
    });
});