*** Settings ***
Documentation  Dummy test
Library  SeleniumLibrary
Library  XvfbRobot
Library  Libraries/SeleniumLibraryHelper.py
Test Setup  ${DISPLAY}
Test Teardown  close all browsers

#robot \
#--variable DISPLAY:'Begin web test on virtual display' \
#--listener 'allure_robotframework;./results/allure' \
#--outputdir results \
#dummy.robot

#docker run --rm -i -e DBUS_SESSION_BUS_ADDRESS=/dev/null \
#      --shm-size  512M \
#      --user $( id -u $USER ):$( id -g $USER ) \
#      --volume $(pwd):/test/:rw \
#      --workdir /test/ konstantinxv/robotframework-docker-project \
#      robot \
#      --variable DISPLAY:'Begin web test on virtual display' \
#      --outputdir results \
#      --listener 'allure_robotframework;./results/allure' \
#      /test/dummy.robot

# Generate Allure: allure serve results/allure

*** Variables ***
${BROWSER}          chrome
${WIDTH}            1920
${HEIGHT}           1080
${START_URL}        https://www.google.com/
${DISPLAY}          Begin web test on local display

*** Test Cases ***
Demo Test
    go to  ${START_URL}
    wait until page contains element  css=input[name="q"]
    capture page screenshot


*** Keywords ***
Begin web test on local display
    open browser  about:blank  ${BROWSER}
    set window size  ${WIDTH}  ${HEIGHT}

Begin web test on virtual display
    start virtual display  ${WIDTH}  ${HEIGHT}
    ${chrome options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    call method    ${chrome options}   add_argument    no-sandbox
    call method    ${chrome options}   add_argument    disable-gpu
    create webdriver    Chrome    chrome_options=${chrome options}
    set window size  ${WIDTH}  ${HEIGHT}