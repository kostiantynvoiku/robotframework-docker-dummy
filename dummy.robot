*** Settings ***
Documentation  Dummy test
Library  SeleniumLibrary
Library  XvfbRobot

#robot \
#--include local-test \
#--listener 'allure_robotframework;./results/allure' \
#--outputdir results \
#dummy.robot

# Generate Allure: allure serve results/allure

*** Variables ***
@{BROWSER} =  firefox  chrome  safari
${WIDTH} =  1920
${HEIGHT} =  1080

*** Test Cases ***
Demo Test in Local Browser
    [Tags]  local-test
    Open Browser  about:blank  @{BROWSER}[0]
    Set Window Size  ${WIDTH}  ${HEIGHT}
    Go To    https://www.google.com/
    Wait Until Page Contains Element  id=lst-ib
    Capture Page Screenshot
    Close Browser

Demo Test on Virtual Display
    [Tags]  webdriver-test
    Start Virtual Display  ${WIDTH}  ${HEIGHT}
    ${chrome options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome options}   add_argument    no-sandbox
    Call Method    ${chrome options}   add_argument    disable-gpu
    Create Webdriver    Chrome    chrome_options=${chrome options}
    Set Window Size  ${WIDTH}  ${HEIGHT}
    Go To    https://www.google.com/
    Wait Until Page Contains Element  id=lst-ib
    Capture Page Screenshot
    Close Browser