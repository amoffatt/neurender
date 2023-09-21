FROM airstudio/airstudio-cli:latest

ARG VAST_AI_KEY
ARG USER=air
# RUN mkdir ${HOME}/bin
# RUN cd $HOME/bin && wget https://raw.githubusercontent.com/vast-ai/vast-python/master/vast.py; chmod +x vast.py;

USER root

# for JSON parsing in vastai control scripts
RUN apt-get install -y jq


USER $USER

SHELL [ "/bin/bash", "-c" ]
RUN pip install vastai
RUN vastai set api-key ${VAST_AI_KEY}

COPY --chown=$USER:$USER bin/* /home/air/bin
