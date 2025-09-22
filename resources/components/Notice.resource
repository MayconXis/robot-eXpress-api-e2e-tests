*** Settings ***
Library           Browser
Documentation    Componente de Notice

*** Keywords ***
Notice should be 
    [Arguments]   ${expectend_text}
     ${element}  Set Variable    css=.notice p
     Wait For Elements State    ${element}    
     ...        state=visible   
     ...        timeout=5000ms
     Get Text    ${element}   equal    ${expectend_text}