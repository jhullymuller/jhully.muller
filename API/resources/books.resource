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
    ...    title= Harry Potter
    ...    description="Harry Potter é uma série de sete romances de fantasia.
    ...    pageCount=310
    ...    excerpt=Era uma vez um...
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

 Atualizar um livro por ID

    Create Session    livraria    ${BASE_URL}    verify=False

    ${id}=    Set Variable    18005

    ${payload}=    Create Dictionary
    ...    id=${id}
    ...    title=O Harry Potter foi Atualizado
    ...    description=Versão revisada do clássico
    ...    pageCount=320
    ...    excerpt=Era uma vez um ... e depois mais...
    ...    publishDate=2025-05-18T00:00:00

    ${response}=    PUT On Session    livraria    ${ENDPOINT}/${id}    json=${payload}    expected_status=200

    Log    ${response.status_code}
    Log    ${response.json()}

    # Verificações básicas
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()["title"]}    O Harry Potter foi Atualizado


Gerar numero versao do Livro
    # Aqui vamos gerar aleartóriamnete um número entre 1 e 7 e logar esse valor.
        ${numero}=    Evaluate    random.randint(1, 7)    modules=random    
        Log    Número aleatório de livro HP: ${numero}
    # (Opcional) Verifica se está realmente entre 1 e 7
        Should Be True    ${numero} >= 1 and ${numero} <= 7
        # Exibe no log qual número foi escolhido
        Log    Número gerado da versao do livro HP: ${numero}

     # Verifica (opcional) se está entre 1 e 7
        Should Be True    ${numero} >= 1 and ${numero} <= 7

    # Cria uma string unindo “Harry Potter” + número
        ${titulo_com_numero}=    Set Variable    Harry Potter ${numero}

    # Exibe no log o título do livro completo com o número da versão
        Log    Livro gerado com número: ${titulo_com_numero}