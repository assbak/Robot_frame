*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://practice.expandtesting.com/login
${Browser}            chrome
${username1}          practice
${password1}          SuperSecretPassword!
${username2}          asspoei
${password2}          SuperSecretPassword
${sleep}              10s
*** Test Cases ***
TC1 - login avec identifiants valide
    Open Browser    ${URL}    ${Browser}
    saisir identifiants et connecter    ${username1}    ${password1}
    #Element Text Should Be    //*[@id="flash"]    You logged into a secure area!
    #deconnexion  
    Fermer navigateur    ${sleep}

TC2 - identifiants invalide 
    Open Browser    ${URL}    ${Browser}

    saisir identifiants et connecter    ${username2}    ${password2}
    Page Should Contain Element   locator=//*[@id="flash"]    message=Your username is invalid!
    Fermer navigateur    ${sleep}

TC3 - identifiants invalide username invalide 
    Open Browser    ${URL}    ${Browser}

    saisir identifiants et connecter    ${username2}    ${password1}
    Page Should Contain Element   locator=//*[@id="flash"]    message=Your username is invalid!
    Fermer navigateur    ${sleep}
TC4 - identifiants invalide password invalide 
    Open Browser    ${URL}    ${Browser}

    saisir identifiants et connecter    ${username1}    ${password2}
    Page Should Contain Element   locator=//*[@id="flash"]    message=Your username is invalid!
    Fermer navigateur    ${sleep}
*** Keywords ***
saisir identifiants et connecter
    [Arguments]    ${username}    ${password}
    Input Text    locator=//*[@id="username"]    text=${username}
    Input Password    locator=//*[@id="password"]    password=${password}
    Click Element    //*[@id="login"]/button
deconnexion
    Click Element    //a[@href='/logout']
    
Fermer navigateur
    [Arguments]    ${sleep}
    Sleep        ${sleep}
    Close Browser

