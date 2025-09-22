*** Settings ***
Documentation     Cenarios de autenticação
Library           Browser 
Library           String
Resource          ../resources/base.resource          

*** Keywords ***
Submit login form
     [Arguments]   ${user}  
     Fill Text    css=input[placeholder$=mail]  ${user}[email]
     Fill Text    css=input[placeholder=Senha]  ${user}[password]
     Click     css=button >> text=Entrar      #xpath=//button[text()="Entrar"]      # id=buttonLogin
     


