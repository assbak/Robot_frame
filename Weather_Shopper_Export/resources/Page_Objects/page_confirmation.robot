*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SUCCESS_MSG}        xpath://p[@class='text-justify']

*** Keywords ***
Verify Success Message
    [Arguments]        ${Expected_Success_Msg}
    Wait Until Page Contains    PAYMENT SUCCESS
    Element Should Contain    ${SUCCESS_MSG}    ${Expected_Success_Msg}