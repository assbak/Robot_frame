*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

Resource    ../resources/common.robot
Resource    ../resources/Page_Objects/page_accueil.robot
Resource    ../resources/Page_Objects/page_produits.robot
Resource    ../resources/Page_Objects/page_panier.robot
Resource    ../resources/Page_Objects/page_confirmation.robot

*** Variables ***
# Variables Jeux de données
${EMAIL}       test@test.com
${CARD_NUM}    4242424242424242
${CC_EXP}      12/24
${CC_SCC}      123
${ZIPCODE}     75001

${Expected_Success_Msg}    Your payment was successful. You should receive a follow-up call from our sales team.


*** Test Cases ***
TC1 - Test de bout en bout achat des 2 produits les moins chers
    common.Setup Test

    @{produit}    page_accueil.Go To Product Page

    page_produits.Add Least Expensive Product    @{produit}

    page_produits.Click Cart Button

    page_panier.Click Pay With Card

    page_panier.Verify Total

    page_panier.Fill Payement Form    ${EMAIL}    ${CARD_NUM}    ${CC_EXP}    ${CC_SCC}    ${ZIPCODE}

    page_confirmation.Verify Success Message    ${Expected_Success_Msg}

    common.Teardown


TC2 - Test de bout en bout achat des 2 produits les plus chers
    common.Setup Test

    @{produit}    page_accueil.Go To Product Page

    page_produits.Add Most Expensive Product    @{produit}

    page_produits.Click Cart Button

    page_panier.Click Pay With Card

    page_panier.Verify Total

    page_panier.Fill Payement Form    ${EMAIL}    ${CARD_NUM}    ${CC_EXP}    ${CC_SCC}    ${ZIPCODE}

    page_confirmation.Verify Success Message    ${Expected_Success_Msg}

    common.Teardown