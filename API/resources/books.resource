*** Settings ***
Documentation    Cadastro de livros
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    String
Resource    ../config/config.resource

*** Variables ***
${BASE_URL}       https://fakerestapi.azurewebsites.net
${ENDPOINT}       /api/v1/Books

*** Keywords ***
Adicionar um livro com sucesso
    Create Session    livraria    ${BASE_URL}     verify=False

      ${payload}=    Create Dictionary
    ...    id=77
    ...    title=O Hobbit
    ...    description=Livro clássico da fantasia
    ...    pageCount=310
    ...    excerpt=Era uma vez um hobbit...
    ...    publishDate=2025-05-18T00:00:00

        ${response}=    POST On Session    livraria    ${ENDPOINT}    json=${payload}    expected_status=200
        Log    ${response.status_code}

Buscar um livro por ID

    Create Session    livaria    ${BASE_URL}     verify=False
     ${id}=    Set Variable    77
    ${response}=    GET On Session    livraria    ${ENDPOINT}/${id}

    Log    ${response.status_code}
    Log    ${response.json()}

    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    id
    Should Be Equal As Integers      ${response.json()["id"]}    ${id}

Listar todos os livros

     Create Session    livaria    ${BASE_URL}     verify=False
     ${response}=    GET On Session    livraria    ${ENDPOINT}/      expected_status=200

      Log    ${response.status_code}
      Log    ${response.json()}