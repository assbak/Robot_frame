*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${Temperature}        id:temperature
${Sunscreen_btn}      xpath://button[text()='Buy sunscreens']
${Moisturizer_btn}    xpath://button[text()='Buy moisturizers']


*** Keywords ***

Get temperature
    # Récupérer la température
    ${T}=    Get Text    ${Temperature}    # '46 °C'
    @{T}=    Split String    ${T}     # ['46', '°C']
    RETURN    ${T}[0]

Go To Product Page

    ${T}    Get temperature

    IF  ${T} < 19
        @{produit}    Create List    ALOE    ALMOND    # ['ALOE', 'ALMOND']
        Click Element    ${Moisturizer_btn}
    ELSE IF    ${T} > 34
        @{produit}    Create List    SPF-30    SPF-50    # ['SPF-50', 'SPF-30']
        Click Element    ${Sunscreen_btn}
    END

    RETURN    @{produit}