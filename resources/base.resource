*** Settings ***
Documentation   resources
Library        ../libs/database.py
Library        Browser
Library        JSONLibrary
Resource       ../resources/env.resource
Resource       ../resources/components/Alert.resource
Resource       ../resources/components/Notice.resource
Resource       ../resources/components/Header.resource
Resource       ../resources/pages/loginPage.resource
Resource       ../resources/fixtures/tasks.json
Resource       ../resources/env.resource
Resource       ../resources/pages/TaskCreatePage.resource
Resource        ../resources/pages/TaskPage.resource
Resource       ../resources/components/Header.resource
Resource       ../backup/Signup.resource
Resource       ../tests/login.robot 
Resource       ../tests/online.robot
Resource       ../tests/PaginaCadastrar.robot
Resource       ../tests/tasks/create.robot
Resource       ../tests/tasks/delete.robot
Resource       ../tests/tasks/update.robot
Resource       ../resources/pages/services.resource
Resource       ../resources/E2Ekeyword.resource
Library         database.py




*** Keywords ***
Start Session 
    New Browser    browser=chromium    headless=False
    New Page    ${BASE_URL}


Get fixture
    [Arguments]    ${file_name}    ${scenario}
    ${file_path}=    Set Variable    ${CURDIR}/fixtures/${file_name}.json
    ${data}=    Load JSON From File    ${file_path}
    RETURN    ${data}[${scenario}]
