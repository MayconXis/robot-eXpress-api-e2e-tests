*** Settings ***
Documentation   Cenarios de cadastro de tarefas
Library          Browser
Library          JSONLibrary
Library          String
Resource          ../resources/base.resource 
Test Setup      Start Session
Test Teardown   Take Screenshot




*** Test Cases ***


Deve poder cadastrar uma tarefa com sucesso
    ${data}    Get fixture    tasks    create
    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]
    ${user}    Set Variable    ${data}[user]
    Submit login form  ${data}[user]
    User should be logged in   ${data}[user][name]   
    Go to task From 
    Submit task form    ${data}[task]
    Task should be registered    ${data}[task][name]

Não deve cadastrar uma tarefa duplicada
    ${data}    Get fixture    tasks    duplicate
    # Dado que eu ja tenho um usuario cadastrado
    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]
    #E que esse usuario tenha uma tarefa cadastrada

    # Post user session    ${data}[user]
    # POST a new task    ${data}[task]
    
    #E que estou logado na aplicação web
    Submit login form  ${data}[user]
    User should be logged in   ${data}[user][name]   
    Go to task From
    Submit task form    ${data}[task]
    Sleep    2

    #Quando faço o cadastro dessa mesma tarefa
    Go to task From
    Sleep    1 
    Submit task form    ${data}[task]
    Sleep   1

    #Então devo ver a mensagem de erro "Tarefa duplicada"
    Notice should be    Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de Tags
    ${data}    Get fixture    tasks    tags_limit
    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]

    Submit login form  ${data}[user]
    User should be logged in   ${data}[user][name]   

    Go to task From 
    Submit task form    ${data}[task]
    Sleep    1
    Notice should be    Oops! Limite de tags atingido. 
    



   
