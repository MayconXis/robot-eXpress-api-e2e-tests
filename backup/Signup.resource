*** Settings ***
Documentation   Elemntos e ações da pagina de cadastro
Library        Browser
Resource       ../resources/env.resource
Resource       ../resources/base.resource
Resource      ../tests/Paginacadastrar.robot
Resource       ../resources/components/Alert.resource
Resource       ../resources/components/Notice.resource




*** Keywords ***
Verificar cadastro com senha menos de 6 digitos
   [Arguments]    ${senha}
   Go To signup page
   Submit signup form    Maycon Douglas   fulano@qa.com    ${senha}
   ALert should be      Informe uma senha com pelo menos 6 digitos

 
Go To signup page    
    Go to     ${BASE_URL}/signup
    Wait For Elements State    css=h1    state=visible    timeout=5000ms
    Get Text     css=h1    equal    Faça seu cadastro 
    
Submit signup form    
  [arguments]     ${name}    ${email}    ${password}
    Get Text     css=h1    equal    Faça seu cadastro 
    Fill Text    css=input[name=name]        ${name}
    Fill Text    css=input[name=email]       ${email}
    Fill Text    css=input[name=password]    ${password}
    Click    css=button[type=submit] >> text=Cadastrar

Campos obrigatorios vazio  
    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY} 
    Go To signup page
    Submit signup form    ${user}[name]   ${user}[email]    ${user}[password]

    

Não deve Cadastrar com senha muito curta utilizando for
   @{senha_list}    Create List    1    12    123    1234    12345
   FOR    ${senha}    IN    @{senha_list}
      ${user}    Create Dictionary
      ...    name=Maycon Douglas        
      ...    email=fulano@gmail.com
      ...     password=${senha}
      Go To signup page
      Submit signup form    ${user}[name]   ${user}[email]    ${user}[password]
          
   END    

  
  
