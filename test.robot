*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}       http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}    Android
${DEVICE_NAME}      emulator-5554
${APP_PACKAGE}      com.example.yeshasprabhakar.todo
${APP_ACTIVITY}     com.example.yeshasprabhakar.todo.MainActivity
${AUTOMATION_NAME}  UiAutomator2
${TASK_NAME}        My First Task
${TASK_LOCATOR}     xpath=//android.widget.TextView[@text='${TASK_NAME}']
${THEME_BUTTON}     id=com.example.yeshasprabhakar.todo:id/themeActionButton

*** Test Cases ***
Open To-Do App
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    automationName=${AUTOMATION_NAME}
    Capture Page Screenshot
    [Teardown]    Close Application

Add a New Task to To-Do List
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    automationName=${AUTOMATION_NAME}

    Sleep    2s
    Click Element    id=com.example.yeshasprabhakar.todo:id/fab   # Click on "+" button
    Sleep    2s
    Input Text    id=com.example.yeshasprabhakar.todo:id/edit_title    ${TASK_NAME}   # Enter task title
    Sleep    2s
    Click Element    id=android:id/button1   # Click "Done" button
    Sleep    3s

    # Verify if task appears in the list
    Element Should Be Visible    ${TASK_LOCATOR}    

    Capture Page Screenshot
    [Teardown]    Close Application


Cancel Adding a Task
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    automationName=${AUTOMATION_NAME}

    Sleep    2s
    Click Element    id=com.example.yeshasprabhakar.todo:id/fab   # Click on "+" button
    Sleep    2s
    Input Text    id=com.example.yeshasprabhakar.todo:id/edit_title    ${TASK_NAME}   # Enter task title
    Sleep    2s
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button2"]    # Click "Cancel" button
    Sleep    3s

    # Verify no task was added
    Element Should Be Visible    xpath=//android.widget.TextView[contains(@text, "What do you want to do today?")]

    Capture Page Screenshot
    [Teardown]    Close Application

Adding a Task Without a Title
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    automationName=${AUTOMATION_NAME}

    Sleep    2s
    Click Element    id=com.example.yeshasprabhakar.todo:id/fab   # Click on "+" button
    Sleep    2s
    Click Element    id=android:id/button1   # Click "Done" without entering a title
    Sleep    2s

    # Capture the page source and verify the toast message
    ${page_source}    Get Page Source
    Should Contain    ${page_source}    Oops, Cannot set an empty ToDo!!!

    Capture Page Screenshot
    [Teardown]    Close Application



Delete Added Task
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    automationName=${AUTOMATION_NAME}

    Sleep    2s
    Click Element    id=com.example.yeshasprabhakar.todo:id/fab   # Click "+" button
    Sleep    2s
    Input Text    id=com.example.yeshasprabhakar.todo:id/edit_title    Test   # Enter "Test"
    Sleep    2s
    Click Element    id=android:id/button1   # Click "Done" button
    Sleep    3s

    # Verify task appears
    Element Should Be Visible    xpath=//android.widget.TextView[@text="Test"]

    Sleep    2s
    Click Element    id=com.example.yeshasprabhakar.todo:id/delete   # Click delete button

    # Capture page source
    Sleep    1s
    ${page_source} =    Get Source
    Log    ${page_source}

    # Wait for toast message
    Wait Until Page Contains    Deleted Successfully    timeout=3s

    # Verify task is removed
    Page Should Not Contain Element    xpath=//android.widget.TextView[@text="Test"]

    Capture Page Screenshot
    [Teardown]    Close Application

Switch Theme Mode
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    automationName=${AUTOMATION_NAME}

    Sleep    2s

    # Click on theme toggle button (Light -> Dark)
    Click Element    ${THEME_BUTTON}
    Sleep    2s
    
    # Capture screenshot to confirm dark mode
    Capture Page Screenshot

    # Click on theme toggle button (Dark -> Light)
    Click Element    ${THEME_BUTTON}
    Sleep    2s
    
    # Capture screenshot to confirm light mode
    Capture Page Screenshot

    [Teardown]    Close Application



