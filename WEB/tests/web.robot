*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/web.resource
Library    XML

*** Variables ***


*** Test Cases ***
Acessar pagina web
    Acessar a pagina web
    Validar que e pagina correta
