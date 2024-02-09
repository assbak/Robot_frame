*** Settings ***
Library    SeleniumLibrary
Library    String
*** Variables ***
${Price_P1}           xpath://tbody/tr[1]/td[2]
${Price_P2}           xpath://tbody/tr[2]/td[2]
${Total}              id:total
${Pay_With_Card}      xpath://span[contains(text(), 'Pay with Card')]
${Email_Field}        id:email
${Card_Num_Field}     id:card_number
${CC_EXP_Field}       id:cc-exp
${CC_SCC_Field}       id:cc-csc
${ZIPCODE_Field}      id:billing-zip

*** Keywords ***
Click Pay With Card
    Wait Until Element Is Visible    ${Pay_With_Card}
    Click Element    ${Pay_With_Card}

Fill Payement Form
    [Arguments]    ${EMAIL}    ${CARD_NUM}    ${CC_EXP}    ${CC_SCC}    ${ZIPCODE}

    Select Frame     stripe_checkout_app

    Wait Until Element Is Visible    ${Email_Field}

    Input Text    ${Email_Field}       ${EMAIL}
    Press Keys    ${Card_Num_Field}    ${CARD_NUM}
    Press Keys    ${CC_EXP_Field}      ${CC_EXP}
    Input Text    ${CC_SCC_Field}      ${CC_SCC} 
    Input Text    ${ZIPCODE_Field}     ${ZIPCODE}

    Submit Form

    Unselect Frame

Verify Total

    ${Prix1}    Get Text    ${Price_P1}
    ${Prix1}    Convert To Integer    ${Prix1}
    ${Prix2}    Get Text    ${Price_P2}
    ${Prix2}    Convert To Integer    ${Prix2}

    ${T}        Evaluate    ${Prix1}+${Prix2}

    ${Total_}   Get Text    ${Total}    # 'Total: Rupees 343'
    ${Total_}   Split String    ${Total_}    # ['Total:', 'Rupees', '343']
    ${Total_}=    Evaluate    ${Total_[-1]}    # '343'
    ${Total_}=    Convert To Integer    ${Total_}

    Should Be Equal    ${T}    ${Total_}