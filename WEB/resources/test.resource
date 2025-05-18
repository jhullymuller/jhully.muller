*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                  https://www.amazon.es/

*** Keywords ***


Acessar a home page do site amazon.es
    Go To    url=${URL}