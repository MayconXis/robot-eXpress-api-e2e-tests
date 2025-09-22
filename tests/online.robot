*** Settings ***
Documentation     Online API
Library           Browser
Library           FakerLibrary
Resource          ../resources/base.resource 
Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***

Verificar se API está Online  
    Get Title    equal    Mark85 by QAx

Verificar a Pagina Cadastar Usuario usando xpath
    Go To    ${BASE_URL}/signup
    Wait For Elements State    xpath=//h1    state=visible    timeout=5000ms
    Get Text     xpath=//h1    equal    Faça seu cadastro    
    

Verificar a Pagina Cadastar Usuario utilizando CSS
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    state=visible    timeout=5000ms
    Get Text     css=h1    equal    Faça seu cadastro 
    