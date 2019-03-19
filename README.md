# NAME

docker-ds - Docker Image for Data Science

# VERSION

Version 0.0.1

# LICENCE AND COPYRIGHT

Copyright (c) 2019 Matthias Nott (mnott (at) mnsoft.org).

Licensed under WTFPL.

The project is based on

(http://www.science.smith.edu/dftwiki/index.php/Tutorial:_Docker_Anaconda_Python_--_4)


# INTRODUCTION

            This docker file gives a working environment for
            data science projects.

# SYNOPSIS

## RUN AS A DOCKER IMAGE

Running the docker image is very easy. You typically need
to install only two things:

1\. Install \[Git\](https://git-scm.com/download)

2\. Install \[Docker for Mac\] (https://docs.docker.com/docker-for-mac/install/), or
   Install \[Docker for Win\] (https://docs.docker.com/docker-for-windows/install/)

Note: On Linux, use your distribution's preferred way to install
docker. For the subsequent commands, also install docker-compose,
which is, for example, a separate package on Ubuntu.

Very important: If you are working on a Windows system, make sure
to configure Git, when it installs, to \*not automatically\* convert
Line Ends ("CR/LF"). Shouly you have configured it wrongly, you can
do this on the command line:

    git config --global core.autocrlf false

Also, if you are using a proxy, you would want to set the proxy for git.
For example:

    git config --global http.proxy proxy.wdf.sap.corp:8080

To remove a proxy configuration, you might do:

    git config --unset --global http.proxy

Then, before continuing, make sure that you have switched on
Virtualization in your BIOS (the feature is often under either
Configuration or Security, and is often called Intel Virtualization
Technology and VT-d Feature: Enable both). If you fail to do this,
the image may not start up.

Finally, you open a command line, e.g. on your Desktop, and do this:

    git clone https://github.com/mnott/docker-ds
    cd docker-ds
    docker-compose up

The last process will typically take about 5 - 10 minutes.

You should then be able to open
\[the web application\](http://localhost:8888/).

The password is root.

There also is a shell script that can help you with managing your
docker environment. Just call it like so:

    ./d

