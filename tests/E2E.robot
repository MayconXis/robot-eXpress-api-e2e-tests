*** Settings ***
Documentation  teste end to end completo da API   
Resource     ../resources/base.resource
Resource     ../resources/env.resource
Resource     ../resources/E2Ekeyword.resource
Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***

Cenário 01:Teste de Disponibilidade - Verificar se a API está online
    Verificar se API está Online  

Cenário 02: Teste de Interface - Verificar a Página Cadastrar Usuário (XPath)
    Verificar a Pagina Cadastar Usuario usando xpath

Cenário 03: Teste de Interface (Validar Elemento) Verificar a Página Cadastrar Usuário (CSS)
    Verificar a Pagina Cadastar Usuario utilizando CSS


Cenário 04: Teste de Funcionalidade - Cadastrar Usuário somente preenchendo os campos    
     Cadastar Usuario preenchendo os campos

Cenário 05:Teste de Funcionalidade - Cadastrar Usuário (somente clicar no botão)
     Cadastar Usuario utilizando CSS com faker Library "somente clicar no botao"

Cenário 06:Teste de Funcionalidade - Cadastrar Usuário com sucesso (CSS)
     Cadastar Usuario com sucesso utilizando CSS

Cenário 07:Teste de Negócio (Regras) - Cadastrar Usuário com email duplicado
    Cadastar Usuario com email duplicado 

Cenário 08: Teste de Negócio (Regras) - Cadastrar Usuário com email duplicado (independente)   
    Cadastar Usuario com email duplicado independete 
Cenário 09:Teste de Funcionalidade ( Variáveis) - Cadastrar Usuário com sucesso
     Cadastar Usuario com sucesso com super variavel

Cenário 10:Teste de Validação de Formulário - Verificar campos obrigatórios vazios
    Verificar Campos obrigatorios vazios no formulario de cadastro

Cenário 11:Teste de Validação de Formulário - Verificar Cadastro com email incorreto
    Verificar Cadastro com email incorreto 
Cenário 12: Teste de Validação de Formulário - Verificar senha com menos de 6 dígitos (Template)
   [Template]    Verificar cadastro com senha menos de 6 digitos
   1
   12
   123
   1234
   12345

Cenário 13:Teste de Validação de Formulário - Verificar senha com menos de 6 dígitos (Backup)
     Verificar senha com menos de 6 digitos com backup
Cenário 14:Teste de Login - Deve poder logar com um usuário pré-cadastrado
    Deve poder logar com um usuario pré cadastrado 

Cenário 15:Teste de Login - Não deve logar com senha inválida    
    Não deve logar com senha invalida

Cenário 16:Teste de CRUD - Deve poder cadastrar uma tarefa com sucesso
    Deve poder cadastrar uma tarefa com sucesso

Cenário 17:Teste de CRUD - Não deve cadastrar uma tarefa duplicada
    Não deve cadastrar uma tarefa duplicada

Cenário 18: Teste de CRUD -Não deve cadastrar uma nova tarefa quando atinge o limite de Tags
    Não deve cadastrar uma nova tarefa quando atinge o limite de Tags

Cenário 19: Teste de CRUD - Deve poder apagar uma tarefa indesejada
    Deve poder apagar uma tarefa indesejada

Cenário 20: Teste de CRUD - Deve poder marcar uma tarefa como concluída
    Deve poder marcar uma tarefa como concluída
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