*** Settings ***
Documentation   Cenarios de cadastro de tarefas
Library          Browser
Library    ../../.venv/Lib/site-packages/FakerLibrary/__init__.py

*** Keywords ***
Task should be registered
    [Arguments]    ${task_name}
    Wait For Elements State    css=.task-todo    visible    5000ms
    Get Text    css=.task-todo    equal    ${task_name}

Mask task as completed 
  [Arguments]    ${task_name}
  ${element}     Set Variable   
  ...        xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]
  Wait For Elements State    ${element}    visible
  Sleep    1
  Click    ${element}


Task should be completed
    [Arguments]    ${task_name}
    ${element}=  Set Variable    css=.task-done >> text=${task_name}

    Wait For Elements State    ${element}     visible    5000ms
    Get Style    ${element}    text-decoration-line    equal    line-through
   
Request removal
  [Arguments]    ${task_name}
  ${element}=  Set Variable   
  ...        xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]
      Wait For Elements State    ${element}    visible    5000ms
    Sleep    1
    Click    ${element}

Task should not exist
    [Arguments]    ${task_name}
    Wait For Elements State    css=.task-todo >> text=${task_name}    detached    5000ms
