*** Settings ***
Library    SeleniumLibrary
Library    String
*** Variables ***
${URL}            https://weathershopper.pythonanywhere.com/
${Browser}            edge
${month}          11
${year}           27
${expiration_date}    1127
${email_address}    test@test.com
${sleep}          20s
*** Test Cases ***
TC1 - verification du lien
    Open Browser    ${URL}    ${Browser}
    Fermer navigateur    ${sleep}

TC2 - Bout en bout achat de produit
    Open Browser    ${URL}    ${Browser}
    Click Element    //a[@href="/moisturizer"]
    Page Should Contain    text=Moisturizers
    Click Element    xpath:/html/body/div[1]/div[3]/div[2]/button
    Click Element    xpath:/html/body/div[1]/div[2]/div[1]/button
    Click Element    //*[@id="cart"]
    verification du montant
    Click Element    xpath:/html/body/div[1]/div[3]/form/button/span

    # Wait for the Stripe Checkout iframe to load
    Wait Until Element Is Visible    xpath=//iframe[contains(@src, 'https://checkout.stripe.com/v3/oivkx0oP8BgueCG8QFpDfA.html')]

    # Switch to the Stripe Checkout iframe
    Select Frame    xpath=//iframe[contains(@src, 'https://checkout.stripe.com/v3/oivkx0oP8BgueCG8QFpDfA.html')]
    #Page Should Contain    text=Stripe.com
    Wait Until Element Is Visible    //*[@id="email"]
    Input Text    xpath=//*[@id="email"]    ${email_address}
    #Input Text    locator=//*[@id="card_number"]    text=4242 4242 4242 4242
  # Define the card number and the delay between each character
    carte number
    Input Text    locator=//*[@id="cc-csc"]    text=123
    date expiration

    Input Text    locator=//*[@id="billing-zip"]    text=12345
    Click Element    //*[@id="submitButton"]/span/span
    Unselect Frame
    Sleep    10s
    verifier    xpath=/html/body/div[1]/div[1]/h2    PAYMENT SUCCESS
    Fermer navigateur    ${sleep}
*** Keywords ***
verifier
    [Arguments]    ${path}    ${message}
    Wait Until Element Is Visible    locator=${path}    timeout=10s
    Page Should Contain    text=${message}
verification du montant
    # Retrieve the text from the first cell
    ${amount1} =    Get Text    xpath:/html/body/div[1]/div[2]/table/tbody/tr[1]/td[2]

    # Retrieve the text from the second cell
    ${amount2} =    Get Text    xpath:/html/body/div[1]/div[2]/table/tbody/tr[2]/td[2]

    # Convert the retrieved texts to numbers
    ${number1} =    Convert To Number    ${amount1}
    ${number2} =    Convert To Number    ${amount2}

    # Calculate the sum
    ${sum} =    Evaluate    ${number1} + ${number2}

    # Retrieve the total amount from the page
    ${total_text} =    Get Text    css=.justify-content-center.h4.top-space-20#total

    # Extract the numeric part of the total text
    ${total_number} =    Fetch From Right    ${total_text}    Rupees
    ${total_number} =    Convert To Number    ${total_number}
    Should Be Equal As Numbers    ${sum}    ${total_number}
carte number
    ${card_number} =    Set Variable    4242 4242 4242 4242

    
    FOR    ${i}    IN RANGE    4 
        Input Text    locator=//*[@id="card_number"]    text=4242    clear=${False}
    END
date expiration
    Input Text    id=cc-exp    ${month}    clear=${False}
    Input Text    id=cc-exp    ${year}    clear=${False}

    
Fermer navigateur
    [Arguments]    ${sleep}
    Sleep        ${sleep}
    Close Browser