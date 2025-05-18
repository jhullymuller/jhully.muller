*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    JSONLibrary
Resource    ../resources/authors.resource

*** Variables ***

*** Test Cases ***
Adicionar um novo Autor   
    Adicionar um Autor com sucesso
    Buscar um Autor por ID
    Adicionar mais de um Autor por vez