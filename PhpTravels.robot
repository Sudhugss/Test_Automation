*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary
Variables         VaraibleFile_PhpTravels.py

*** Test Cases ***
User_Creation
    [Documentation]    1. Goto the PHPTravels application
    ...    2. Click on "User icon" and Click on "Sign Up" button
    ...    3. Enter all the mandatory details and click on "Sign Up" button
    User_Creation
    [Teardown]

*** Keywords ***
User_Creation
    Open Browser    &{OR}[PhpTravels_Url]    gc
    Maximize Browser Window
    Click Element    &{OR}[My_Account_Dropdown]
    Wait Until Element Is Visible    &{OR}[Sign_Up_Link]
