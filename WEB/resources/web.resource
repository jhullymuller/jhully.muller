*** Settings ***
Library    SeleniumLibrary
Resource    ../config/config.resource


*** Variables ***
${TEXTO ESPERADO}    Ofertas en Outlet

*** Keywords ***
Acessar a pagina web
   Open Browser     ${URL}       chrome
    Maximize Browser Window
    Capture Page Screenshot

Validar que e pagina correta
    Click Button    id=sp-cc-accept
    Wait Until Page Contains Element    xpath://*[contains(text(),'${TEXTO ESPERADO}')]    timeout= 5s
    Capture Page Screenshot
