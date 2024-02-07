*** Settings ***
Library    SeleniumLibrary
Library    String
*** Variables ***
${URL}            https://weathershopper.pythonanywhere.com/
${Browser}            chrome
${month}          11
${year}           27
${expiration_date}    1127
${email_address}    test@test.com
${sleep}          20s
${task_path}    xpath://span[contains(@class, 'octicon-info') and @data-toggle='popover']
*** Test Cases ***
TC1 - verification du lien
    Open Browser    ${URL}    ${Browser}
    Click Element    xpath:/html/body/div[1]/div[1]/span
    Sleep    5s
    verifier    ${task_path}    Your task
    temperature and task
    Fermer navigateur    ${sleep}

TC2 - Bout en bout achat de produit
    Open Browser    ${URL}    ${Browser}
    Click Element    xpath:/html/body/div[1]/div[1]/span
    Sleep    5s
    verifier    ${task_path}    Your task
    temperature and task
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
    Sleep    5s
    Input Text    locator=//*[@id="cc-csc"]    text=123
    date expiration
    Input Text    locator=//*[@id="billing-zip"]    text=12345
    Click Element    //*[@id="submitButton"]/span/span
    Unselect Frame
    Sleep    10s
    verifier    xpath=/html/body/div[1]/div[1]/h2    PAYMENT SUCCESS
    Fermer navigateur    ${sleep}
*** Keywords ***
temperature and task
    ${temperature_text}=    Get Text    //*[@id="temperature"]
    ${cleaned_text}=    Get Substring    ${temperature_text}     0    2
    Log    le nombre est ${temperature_text} et est devenu ${cleaned_text}
    ${temperature_number}=    Convert To Number    ${cleaned_text}
    IF    ${temperature_number} <19
        Click Element    //a[@href="/moisturizer"]
        Page Should Contain    text=Moisturizers
    ELSE IF    ${temperature_number} >34
        Click Element    //a[@href="/sunscreen"]
        Page Should Contain    text=Sunscreens
    END
    
    
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
    # ${card_number} =    Set Variable    4242 4242 4242 4242
    # ${cc}=    Split String    ${card_number}
    # FOR    ${i}    IN RANGE    4 
    #     Input Text    locator=//*[@id="card_number"]    text=4242    clear=${False}
    #     Sleep    1s
    # END
    FOR    ${i}    IN RANGE    4  
        Press Keys    //*[@id="card_number"]    \\4\\2\\4\\2
        Sleep    1s
    END
date expiration
    Input Text    id=cc-exp    ${month}    clear=${False}
    Input Text    id=cc-exp    ${year}    clear=${False}

    
Fermer navigateur
    [Arguments]    ${sleep}
    Sleep        ${sleep}
    Close Browser