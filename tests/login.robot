*** Settings ***
Documentation     Cenarios de autenticação
Library           Browser
Library           FakerLibrary
Library           Collections
Resource          ../resources/base.resource 
Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***

Deve poder logar com um usuario pré cadastrado 
     ${user}    Create Dictionary  
    ...     name=Maycon
     ...    email=fulano@msn.com    
     ...    password=teste123
     Remove user from database    ${user}[email]
     insert user from database    ${user}
     Submit login form  ${user}
     User should be logged in   ${user}[name]

Não deve logar com senha invalida
    ${user}    Create Dictionary  
    ...     name=Susu
    ...     email=surprise@apple.com
    ...     password=susu123
     remove user from database    ${user}[email]
     insert user from database    ${user}
     Set To Dictionary   ${user}     password=abc123
     submit login form  ${user}
     Notice should be  Ocorreu um erro ao fazer login, verifique suas credenciais.   
     Sleep    5
