*** Settings ***
Documentation     Online API
Library           Browser
Library           FakerLibrary
Library          Browser
Library          JSONLibrary
Library          String
Library           Collections
Resource          ../resources/base.resource 
Resource          ../tests/online.robot


*** Variables ***
${name}        Maycon Douglas
${email}       fulano@qa.com
${password}    teste123

*** Keywords ***


Verificar se API está Online  
    Get Title    equal    Mark85 by QAx
     Sleep    1

Verificar a Pagina Cadastar Usuario usando xpath
    Go To    ${BASE_URL}/signup
    Wait For Elements State    xpath=//h1    visible    timeout=5s
    Get Text     xpath=//h1    equal    Faça seu cadastro    
    

Verificar a Pagina Cadastar Usuario utilizando CSS
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    visible    timeout=5s
    Sleep    1
    Get Text     css=h1    equal    Faça seu cadastro 


 Cadastar Usuario preenchendo os campos
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    visible    timeout=5s
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    id=name    Maycon Douglas
     Sleep    1
    Fill Text    id=email    fulano@hotmail.com
     Sleep    1
    Fill Text    id=password    123456
     Sleep    1
    
 Cadastar Usuario utilizando CSS com faker Library "somente clicar no botao"
   ${name}=    FakerLibrary.name
   ${email}=    FakerLibrary.email
   ${password}=    Set Variable    123456
    Remove user from database     ${email}
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    visible    timeout=5s
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    css=#name        ${name}
     Sleep    1
    Fill Text    css=#email       ${email}
    Sleep    1
    Fill Text    css=#password    ${password}
     Sleep    1
    Click    id=buttonSignup
    

 Cadastar Usuario com sucesso utilizando CSS
   ${name}=    Set Variable    Maycon Douglas
   ${email}=    Set Variable    fulano@qa.com
   ${password}=    Set Variable    teste123
   Remove user from database     ${email}
   Go To signup page
    Sleep    1
   Submit signup form    ${name}   ${email}    ${password}
    Sleep    1
   Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.
   
    
 
 Cadastar Usuario com email duplicado 
   ${user}    Create Dictionary
   ...    name=Maycon Douglas
   ...    email=fulano@qa.com
   ...    password=teste123
   Remove user from database    ${user}[email]
   insert user from database    ${user}
    Sleep    1
   Go To signup page
    Sleep    1
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
    Sleep    1
   Submit signup form    ${name}   ${email}    ${password}
    Sleep    1
   Notice should be       Oops! Já existe uma conta com o e-mail informado.
    

 Cadastar Usuario com sucesso com super variavel
    ${users}     Create Dictionary    
    ...     name=Maycon Douglas       
    ...     email=fulano@qa.com
    ...     password=teste123
   Remove user from database     ${users}[email]
    Go To    ${BASE_URL}/signup
    Wait For Elements State    css=h1    visible
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    css=#name        ${users}[name]
    Fill Text    css=#email       ${users}[email]
    Fill Text    css=#password    ${users}[password]
     Sleep    1
    Click    id=buttonSignup
    Wait For Elements State    css=.notice p    visible
    Get Text     css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.
    
Verificar Campos obrigatorios vazios no formulario de cadastro
   Campos obrigatorios vazio
    Sleep    1
    ALert should be     Informe seu nome completo    
    ALert should be     Informe seu e-email   
    ALert should be     Informe uma senha com pelo menos 6 digitos  

Verificar Cadastro com email incorreto 
   Go To signup page
   Submit signup form    Maycon Douglas   fulanoqa.com.br    teste123
   Sleep    1
   ALert should be     Digite um e-mail válido

 
Verificar senha com menos de 6 digitos com backup

   Não deve Cadastrar com senha muito curta utilizando for
   Sleep    1


Deve poder logar com um usuario pré cadastrado 
     ${user}    Create Dictionary  
    ...     name=Maycon
     ...    email=fulano@msn.com    
     ...    password=teste123
     Remove user from database    ${user}[email]
     insert user from database    ${user}
     Sleep    1
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
     Sleep    1
     submit login form  ${user}
     Notice should be  Ocorreu um erro ao fazer login, verifique suas credenciais.   
     Sleep   1

Deve poder cadastrar uma tarefa com sucesso
    ${data}    Get fixture    tasks    create
    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]
    ${user}    Set Variable    ${data}[user]
    Submit login form  ${data}[user]
    User should be logged in   ${data}[user][name] 
    Sleep    1  
    Go to task From 
    Submit task form    ${data}[task]
    Sleep    1
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
    Sleep    1
    Go to task From 
    Submit task form    ${data}[task]
    Sleep    1
    Notice should be    Oops! Limite de tags atingido. 

    
Deve poder marcar uma tarefa como concluída
    ${data}    Get fixture    tasks    done
    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user] 

    Post user session    ${data}[user]
    POST a new task    ${data}[task]

    Submit login form    ${data}[user]
    Sleep    1
    User should be logged in   ${data}[user][name]
    Mask task as completed    ${data}[task][name]
    Task should be completed    ${data}[task][name]

    Sleep    1


Deve poder apagar uma tarefa indesejada
    ${data}    Get fixture    tasks    delete
    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user] 

    Post user session    ${data}[user]
    POST a new task    ${data}[task]

    Submit login form    ${data}[user]
    User should be logged in   ${data}[user][name]
    Sleep    1
    Request removal    ${data}[task][name]
    Task should not exist    ${data}[task][name]


    Sleep    1


