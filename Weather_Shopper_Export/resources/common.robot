*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://weathershopper.pythonanywhere.com/
${BROWSER}            Edge

*** Keywords ***
Setup Test
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Teardown
    Close Browser