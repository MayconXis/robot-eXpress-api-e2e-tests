*** Settings ***
Documentation     Online API
Library           Browser
Library           FakerLibrary
Resource          ../resources/base.resource 
Resource          ../tests/online.robot
Test Setup        Start Session
Test Teardown     Take Screenshot

*** Variables ***
${name}        Maycon Douglas
${email}       fulano@qa.com
${password}    teste123

*** Test Cases ***

 Cadastar Usuario preenchendo os campos
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    state=visible    timeout=5000ms
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    id=name    Maycon Douglas
    Fill Text    id=email    fulano@hotmail.com
    Fill Text    id=password    123456
    
 Cadastar Usuario utilizando CSS com faker Library "somente clicar no botao"
   ${name}=    FakerLibrary.name
   ${email}=    FakerLibrary.email
   ${password}=    Set Variable    123456
    Remove user from database     ${email}
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    state=visible    timeout=5000ms
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    css=#name        ${name}
    Fill Text    css=#email       ${email}
    Fill Text    css=#password    ${password}
    Click    id=buttonSignup
    

 Cadastar Usuario com sucesso utilizando CSS
   ${name}=    Set Variable    Maycon Douglas
   ${email}=    Set Variable    fulano@qa.com
   ${password}=    Set Variable    teste123
   Remove user from database     ${email}
   Go To signup page
   Submit signup form    ${name}   ${email}    ${password}
   Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.
   
    
 
 Cadastar Usuario com email duplicado 
   ${user}    Create Dictionary
   ...    name=Maycon Douglas
   ...    email=fulano@qa.com
   ...    password=teste123
   Remove user from database    ${user}[email]
   insert user from database    ${user}
   Go To signup page
   Submit signup form    ${name}   ${email}    ${password}
   Notice should be    Oops! Já existe uma conta com o e-mail informado.
    
  
Cadastar Usuario com email duplicado independete 
  ${name}    Set Variable    Maycon Douglas
  ${email}    Set Variable    fulano@qa.com
  ${password}  Set Variable   teste123
  ${user}    Create Dictionary    name=${name}    email=${email}    password=${password}
  Remove user from database    ${email}
  insert user from database    ${user}
   Go To signup page
   Submit signup form    ${name}   ${email}    ${password}
   Notice should be       Oops! Já existe uma conta com o e-mail informado.
    

 Cadastar Usuario com sucesso com super variavel
    ${users}     Create Dictionary    
    ...     name=Maycon Douglas       
    ...     email=fulano@qa.com
    ...     password=teste123
   Remove user from database     ${users}[email]
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    state=visible  
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    css=#name        ${users}[name]
    Fill Text    css=#email       ${users}[email]
    Fill Text    css=#password    ${users}[password]
    Click    id=buttonSignup
    Wait For Elements State    css=.notice p    state=visible   
    Get Text     css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.
    
Verificar Campos obrigatorios vazios no formulario de cadastro
   Campos obrigatorios vazio
    ALert should be     Informe seu nome completo    
    ALert should be     Informe seu e-email   
    ALert should be     Informe uma senha com pelo menos 6 digitos  

Verificar Cadastro com email incorreto 
   Go To signup page
   Submit signup form    Maycon Douglas   fulanoqa.com.br    teste123
   ALert should be     Digite um e-mail válido
Verificar senha com menos de 6 digitos com Template
   [Template]    Verificar cadastro com senha menos de 6 digitos
   1
   12
   123
   1234
   12345
 
 Verificar senha com menos de 6 digitos com backup
   Não deve Cadastrar com senha muito curta utilizando for

