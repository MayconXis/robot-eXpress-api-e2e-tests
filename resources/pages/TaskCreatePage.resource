*** Settings ***
Documentation   Cenarios de cadastro de tarefas
Library          Browser
Library          JSONLibrary
Library          String
Resource          ../resources/base.resource 

*** Keywords ***
Submit task form 
    [Arguments]    ${task}
    Fill Text    css=input[placeholder$=tarefa]    ${task}[name]
    ${tags_elements}=  Set Variable     css=input[name=tags]
    
    FOR     ${tag}       IN        @{task}[tags]
        Fill Text    ${tags_elements}    ${tag}
        Sleep    1
        Press Keys    ${tags_elements}    Enter
    END 
    Click     css=button >> text=Cadastrar
    