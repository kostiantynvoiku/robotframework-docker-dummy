# Acceptance testing using Robotframework + Docker + Allure

This is the short guide how to run Robotframework in 2 ways: inside Docker and locally.

## Running tests inside Docker container
### Requirements:
- [Docker desktop client](https://www.docker.com/products/docker-desktop);
- [Allure 2.7.0](https://docs.qameta.io/allure/#_installing_a_commandline)

### Running steps:
1. Clone [my project](https://github.com/KonstantinxVx/robotframework-docker-dummy.git);
2. Run Docker desktop client;
3. Pull my [Docker image](https://hub.docker.com/r/konstantinxv/robotframework-docker-project/)
4. Run Docker inside the project's directory:

```
$ docker run --rm -i -e DBUS_SESSION_BUS_ADDRESS=/dev/null \
      --shm-size  512M \
      --user $( id -u $USER ):$( id -g $USER ) \
      --volume $(pwd):/test/:rw \
      --workdir /test/ konstantinxv/robotframework-docker-project \
      robot \
      --include webdriver-test \
      --outputdir results \
      --listener 'allure_robotframework;./results/allure' \
      /test/dummy.robot
```

5. Generate Allure report:

```
$ allure serve results/allure
```

6. Enjoy! 

## Running tests on local environment
### Requirements:
- Python 3.X.X;
- [Selenium 3.14.1](https://pypi.org/project/selenium/)
- [Robotframework 3.0.4](https://pypi.org/project/robotframework/);
- [SeleniumLibrary 3.2.0](https://pypi.org/project/robotframework-seleniumlibrary/);
- [XVFB 1.2.2](https://pypi.org/project/robotframework-xvfb/)
- [Allure-robotframework 2.5.2](https://pypi.org/project/allure-robotframework/)
- [Allure 2.7.0](https://docs.qameta.io/allure/#_installing_a_commandline)

### Running steps:
1. Clone [my project](https://github.com/KonstantinxVx/robotframework-docker-dummy.git);
2. Run test inside the project's directory:

```
robot \
--include local-test \
--listener 'allure_robotframework;./results/allure' \
--outputdir results \
dummy.robot
```

3. Generate Allure report:

```
$ allure serve results/allure
```

4. Enjoy! 

