*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${Cart_BTN}           xpath://button[contains(@onclick, 'goToCart()')]


*** Keywords ***
Add Least Expensive Product
    [Arguments]    @{produits}
    
    FOR  ${i}  IN  @{produits}
        
        # Ajouter les produits les moins cher
        ${Liste_prix}    Create List    # []
        
        @{Liste_WE}    Get WebElements    //p[contains(translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'), '${i}')]/following-sibling::p
        
        FOR  ${we}  IN  @{Liste_WE}
            ${prix}    Get Text    ${we}    # 'Price Rs. 353'
            ${prix}    Split String    ${prix}    # ['Price', 'RS.', '353']
            Append to list    ${Liste_prix}    ${prix}[-1]
        END

        ${prix_min}    Evaluate    min(${Liste_prix})
        Click Element    //button[contains(@onclick, ${prix_min})]
    END

Add Most Expensive Product
    [Arguments]    @{produits}
    
    FOR  ${i}  IN  @{produits}
        
        # Ajouter les produits les moins cher
        ${Liste_prix}    Create List    # []
        
        @{Liste_WE}    Get WebElements    //p[contains(translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'), '${i}')]/following-sibling::p
        
        FOR  ${we}  IN  @{Liste_WE}
            ${prix}    Get Text    ${we}    # 'Price Rs. 353'
            ${prix}    Split String    ${prix}    # ['Price', 'RS.', '353']
            Append to list    ${Liste_prix}    ${prix}[-1]
        END

        ${prix_min}    Evaluate    max(${Liste_prix})
        Click Element    //button[contains(@onclick, ${prix_min})]
    END

Click Cart Button
    Click Element    ${Cart_BTN}