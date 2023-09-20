FROM airstudio/nerfstudio:latest

ENV BUILD_DIR=/home/user/gaussian-splatting-build
ENV HOME=/home/user


WORKDIR ${HOME}

COPY ./gaussian-splatting-build ${BUILD_DIR}

WORKDIR ${BUILD_DIR}

RUN pip install -r requirements.txt

WORKDIR ${HOME}

# Note: not --recursive because we aren't building the dependencies in this step
RUN git clone https://github.com/graphdeco-inria/gaussian-splatting 

