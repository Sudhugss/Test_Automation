*** Settings ***
Library           OperatingSystem
Library           DateTime
Library           String
Library           Process
Library           Collections
Library           ExcelLibrary
Library           SeleniumLibrary
Variables         ../VariablesFile.py
Library           autoit

*** Variables ***
${enter_key}      \\13
${task_id}        xpath=//div[@class='ag-cell ag-cell-not-inline-editing ag-cell-with-height ag-cell-no-focus ag-cell-value']//span[contains(text(),'AEM-00002')]
${Task_id_1}      xpath=//div[@class='ag-cell ag-cell-not-inline-editing ag-cell-with-height ag-cell-no-focus ag-cell-value']//span[contains(text(),'AEM-00001')]
${part_number}    160
${Delta_import1}    "Downloads\\AEM_SYS_000.900.055.A_006.vec"
${prt_num}        3B0_972_705
${separation_point}    TSVL
${Delta_import2}    "Downloads\\AEM_SYS_9Y0.900.095_006"
${pythonFile}     C:\\Users\\reddys\\Desktop\\VOBES NG\\Automation\\Demo.py
${Datafile}       C:\\Users\\reddys\\Desktop\\VOBES NG\\Automation\\Datafile.xls
${NewTaskCreated}    ${EMPTY}
${window_alias_1}    ${EMPTY}
${window_alias_2}    ${EMPTY}
${RowValue}       ${EMPTY}
${JPGfile1}       C:\\K2.0_automation\\Image1.JPEG
${JPGfile2}       C:\\K2.0_automation\\Image2.PNG
${JPGfile3}       C:\\K2.0_automation\\Image3.PNG
${successmsg}     //div[7]//nz-message-container/div/nz-message
${Errormsg}       //div[6]//nz-notification
${Jpgfile}        ${EMPTY}
${msg}            ${EMPTY}
${part_number2}    123
${Modularization_Title}    Modularisierung
${New_Task_Title}    Neue Änderungskonstruktion
${SYS_Data_File_VKON2-1319}    C://Users//sreers//Desktop//VoBES-NG//Test_Data_Files//AEM_SYS_9Y0.900.095_006.vec
${part_number_999_A}    999_A
${part_number_999_B}    999_B
${part_number_123}    123
${SYS_Data_File_VKON2-1943}    C:\\Users\\sreers\\Desktop\\VoBES-NG\\Test_Data_Files\\VKON2-1943\\AEM_SYS_000.900.052.A_002.vec

*** Test Cases ***
Test_Project_Harness_Selection_Docker
    [Documentation]    *Verify the Old and New values related to Pin Comments, Pin Potential, Potential Designations, Part Number and Control Criterion are getting displayed on SYS page, for newly created change construction by importing Delta SYS file*
    ...    - User logged into application using below link
    ...    \ \ \ http://vobes-ng03.david-bs.de:9095/vobescons/app/
    ...    - User should be able to select a particular harnesses/partnumber from dropdown list in Wiring Harness window
    ...    - Click on "Create change construction" icon displayed under "Part Number", such that Create Change Construction pop-up is displayed.
    ...    - Enter all the mandatory details such as "Title", "Description", "Payers", \ "Control Point BOM", "Editor", "Application Deadline" and click on "OK", such that new Task will get created with new Task ID.
    ...    - Click on "Import Delta SYS" icon displayed on "Change Design" window for the newly created Task and upload the SYS (AEM_SYS_760.900.064.F_001.vec)
    ...    - Click on "SYS" menu icon, columns such as "Pin Comment", "Pin Potential" and Potential Designation" should get displayed.
    ...    - Mouse hover on "Pin Comment", "Pin Potential", Potential Designation", "Part Number", "Vehicle Reference" and "Control Criterion", such that respective values should get displayed.
    ...    a. If Values is changed, then Old and New values should get displayed.
    ...    b. If values get changed, It should be displayed in "Blue" colour
    [Tags]    GUI
    Open k2.0 application
    Select different project from dropdown
    Select a particular value from dropdown    999_A
    Click on the open change process button
    [Teardown]    TestTeardown

*** Keywords ***
TestTeardown
    SeleniumLibrary.Close Browser

Open k2.0 application
    SeleniumLibrary.Open Browser    http://vobes-ng03.david-bs.de:9095/vobescons/app/    gc
    Maximize Browser Window
    Sleep    5s
    Reload Page
    Capture Page Screenshot

Validation of search field in change process screen
    [Arguments]    ${finalvalue}
    Input Text    &{OR}[Search_change_process]    ${finalvalue}
    Sleep    2s
    Press Key    &{OR}[Search_change_process]    ${enter_key}
    Sleep    5s
    Capture Page Screenshot

Verify whether search field is present in change process screen
    Wait Until Element Is Visible    &{OR}[Search_change_process]
    Element Should Be Visible    &{OR}[Search_change_process]
    Capture Page Screenshot

Verify whether dropdown element is present in change process screen
    Sleep    15s
    Wait Until Element Is Visible    &{OR}[dropdown_change_process]
    Element Should Be Visible    &{OR}[dropdown_change_process]
    Capture Page Screenshot

Verify the default UI elements in change process screen
    Sleep    3s
    Element Should Be Visible    &{OR}[table_of_tickets_space]
    Sleep    2s
    Page Should Not Contain Element    &{OR}[Tickets_details_body]
    Page Should Contain Element    &{OR}[Arrow_icon_home]
    Capture Page Screenshot

Click on the open change process button
    Wait Until Page Contains Element    &{OR}[open_change_process]
    Sleep    5s
    Capture Page Screenshot
    Click Element    &{OR}[open_change_process_button]
    Sleep    6s
    Capture Page Screenshot

Select a particular value from dropdown
    [Arguments]    ${part_number}
    Click Element    &{OR}[dropdown_change_process]
    Sleep    5s
    Input Text    &{OR}[dropdown_input_field]    ${part_number}
    sleep    5s
    Press Key    &{OR}[dropdown_input_field]    ${enter_key}
    Sleep    3s
    Press Key    &{OR}[dropdown_input_field]    \\09
    Wait Until Element Is Visible    &{OR}[Table_of_content_task_one]
    Capture Page Screenshot
    Click Element    //span[contains(text(),'AEM-00001')]
    Comment    Click Element    &{OR}[Table_of_content_task_one]
    Sleep    5s
    Capture Page Screenshot

View ELZ layout
    Wait Until Element Is Visible    &{OR}[Button_to_view_graph]
    Click Element    &{OR}[Button_to_view_graph]
    Sleep    20s
    Select Window    locator=NEW
    Capture Page Screenshot

Select vehicle project from dropdown
    Click Element    &{OR}[Vehicle_project_dropdown]
    Sleep    15s
    Click Element    &{OR}[Project_name_one]
    Sleep    10s
    Capture Page Screenshot
    Select partnumber to create new task    193_FA
    Wait Until Element Is Visible    &{OR}[Task_id_zero]
    Capture Page Screenshot
    Click Element    &{OR}[Task_id_zero]
    Click on the open change process button
    ${wire_list}    Get Locations
    ${surl}    Collections.Get From List    ${wire_list}    0
    Log    ${surl}
    Click Element    &{OR}[Home_icon]
    Sleep    15s
    Click Element    &{OR}[Vehicle_project_dropdown]
    Sleep    15s
    Click Element    &{OR}[Project_name_two]
    Sleep    10s
    Capture Page Screenshot

Update pin number in wire list view
    Sleep    30s
    Double Click Element    &{OR}[Pin_number_wireList]
    Sleep    5s
    Click Element    &{OR}[New_pin_value]
    Sleep    60s
    Comment    Reload Page
    Capture Page Screenshot

Validate the home page UI elements
    Page Should Contain Element    &{OR}[VOBESMigration_HOmepageTabOne]
    Page Should Contain Element    &{OR}[VOBESMigration_HOmepage_tabtwo]
    Capture Page Screenshot

Open ELZ graph by ELZ viewer button
    Wait Until Element Is Visible    &{OR}[Button_to_view_graph]
    Click Element    &{OR}[Button_to_view_graph]
    Sleep    20s
    Capture Page Screenshot

OpenK2.0_HeadlessBrowser
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    ${options}=    Call Method    ${chrome_options}    to_capabilities
    Open Browser    http://vobes-ng03.david-bs.de:9095/vobescons/app/    browser=chrome    desired_capabilities=${options}
    Maximize Browser Window
    Sleep    10s
    Capture Page Screenshot
