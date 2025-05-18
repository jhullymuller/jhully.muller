*** Settings ***
Documentation    Essa suite testa o site da Amazon.es
Library    SeleniumLibrary


*** Variables ***
${URL}         https://www.amazon.es/
${USERNAME}    testuser@getnada.com
${PASSWORD}    Test_123



*** Test Cases ***

Login com sucesso
    Open Browser    ${URL}    chrome
    Input Text    username-fiel   ${USERNAME}
    Input Text    password-fiel   ${PASSWORD}
    Click Button      login_button    
    Page Should Contain    Bem vindo
    Close Browser    
