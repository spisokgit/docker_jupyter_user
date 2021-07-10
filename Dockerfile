###############
# BUILD IMAGE #
###############
# FROM nvidia/cuda:11.0-cudnn8-runtime-ubuntu18.04
FROM python:3.7.8-slim-buster AS build

# virtualenv
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV TZ Asia/Seoul

# add and install requirements
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

#################
# RUNTIME IMAGE #
#################
FROM python:3.7.8-slim-buster AS runtime

# setup user and group ids
ARG USER=sin
ARG USER_ID=1000
ARG GROUP_ID=1000
ENV USER_ID $USER_ID
ENV GROUP_ID $GROUP_ID

# add non-root user and give permissions to workdir
RUN groupadd --gid $GROUP_ID $USER && \
          adduser $USER --ingroup $USER --gecos '' --disabled-password --uid $USER_ID && \
          mkdir -p /usr/src && \
          chown -R $USER:$USER /usr/src

# copy from build image
COPY --chown=$USER:$USER --from=build /opt/venv /opt/venv

# set working directory
WORKDIR /usr/src

# switch to non-root user
USER $USER

# disables lag in stdout/stderr output
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
# Path
ENV PATH="/opt/venv/bin:$PATH"

# Run 
CMD ["jupyter", "notebook", "--notebook-dir=/usr/src", "--port", "7777", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--debug"]