*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    JSONLibrary
Resource    ../resources/books.resource

*** Variables ***


*** Test Cases ***
Adicionar um novo livro
    Adicionar um livro com sucesso
    Buscar um livro por ID
    Listar todos os livros
    Atualizar um livro por ID
