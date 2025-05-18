*** Settings ***
Documentation    Cadastro de Autores
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    String
Resource    ../config/config.resource


*** Variables ***
@{ID}    38    25    36    85    45
@{IDBOOK}    83    96    55    33    87
@{FIRSTNAME}    Max    Conie    Billy    Joyce    Marcio
@{LASTNAME}    Lucado    Menezes    Gram    Meyer    Valadão
${ID_UNICO}    13
${LIST_ID}
${LIST_IDBOOK}
${LIST_FIRSTNAME}
${LIST_LASTNAME}


*** Keywords ***
Adicionar um Autor com sucesso
    ${AUTHORS_JSON}=    Load Json From File   livraria/API/config/payload/authors.json

    ${LIST_ID}=    Evaluate    random.choice(@{ID})
    Set To Dictionary    ${AUTHORS_JSON}    id=${LIST_ID}

    ${LIST_IDBOOK}=    Evaluate    random.choice(@{IDBOOK})
    Set To Dictionary    ${AUTHORS_JSON}    idBook=${LIST_IDBOOK}

    ${INDEX}=    Evaluate    random.randint(0, len(${FIRSTNAME}) -1)
    ${LIST_FIRSTNAME}=    Set Variable    ${FIRSTNAME[${INDEX}]}
    ${LIST_LASTNAME}=    Set Variable    ${LASTNAME[${INDEX}]}

    Set To Dictionary    ${AUTHORS_JSON}    firstName=${LIST_FIRSTNAME}
    Set To Dictionary    ${AUTHORS_JSON}    lastName=${LIST_LASTNAME}

    ${HEADERS}=    Create Dictionary    Content-type=application/json

    ${RESPONSE}=    POST      ${URL}api/v1/Authors    json=${AUTHORS_JSON}    headers=${HEADERS}    expected_status=200

Adicionar mais de um Autor por vez
    ${LISTA_AUTHORS}=    Get Length    ${FIRSTNAME}    
    FOR    ${INDEX}    IN RANGE    0    ${LISTA_AUTHORS}   
           ${AUTHORS_JSON}=    Load Json From File    livraria/API/config/payload/authors.json
        
        ${CURRENT_ID}=    Set Variable    ${ID}[${INDEX}]
        ${CURRENT_IDBOOK}=    Set Variable    ${IDBOOK}[${INDEX}]
        ${CURRENT_FIRSTNAME}=    Set Variable    ${FIRSTNAME}[${INDEX}]
        ${CURRENT_LASTNAME}=    Set Variable    ${LASTNAME}[${INDEX}]

        Set To Dictionary    ${AUTHORS_JSON}    id=${CURRENT_ID}
        Set To Dictionary    ${AUTHORS_JSON}    idBook=${CURRENT_IDBOOK}
        Set To Dictionary    ${AUTHORS_JSON}    firstName=${CURRENT_FIRSTNAME}
        Set To Dictionary    ${AUTHORS_JSON}    lastName=${CURRENT_LASTNAME}

        ${HEADERS}=    Create Dictionary    Content-type=application/json
        ${RESPONSE}=    POST      ${URL}api/v1/Authors    json=${AUTHORS_JSON}    headers=${HEADERS}    expected_status=200

    END

Buscar um Autor por ID randomico de 1 a 99
    ${HEADERS}=    Create Dictionary    Content-type=application/json
    ${LISTA_NUMERICA}=    Generate Random String    2    123456789
    Set Global Variable    ${LISTA_NUMERICA}
    ${RESPONSE}=    GET    ${URL}api/v1/Authors/${LISTA_NUMERICA}    headers=${HEADERS}    expected_status=200

Buscar um Autor por ID randomico de uma lista
    ${HEADERS}=    Create Dictionary    Content-type=application/json
    ${LIST_ID}=    Evaluate    random.choice(@{ID})
    ${RESPONSE}=    GET    ${URL}api/v1/Authors/${LIST_ID}   headers=${HEADERS}    expected_status=200

Buscar um Autor por ID 
    ${HEADERS}=    Create Dictionary    Content-type=application/json
    ${RESPONSE}=    GET    ${URL}api/v1/Authors/${ID_UNICO}    headers=${HEADERS}    expected_status=200