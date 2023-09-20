FROM dromni/nerfstudio:0.3.3

USER root

RUN apt-get update
RUN apt-get install -y vim net-tools

RUN apt-get clean

USER user

WORKDIR /home/user
RUN mkdir bin
RUN mkdir src

# For vastai deployments
RUN pip install vastai

RUN pip install am_imaging


# TODO ensure .profile is executed when user logs in