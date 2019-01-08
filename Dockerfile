ARG UBUNTU_RELEASE=bionic
FROM ubuntu:${UBUNTU_RELEASE}
ARG UBUNTU_RELEASE
ENV UBUNTU_RELEASE=${UBUNTU_RELEASE}
RUN apt-get update && apt-get install -y bash-completion \
 build-essential \
 curl \
 git \
 man-db \
 openssh-client \
 sudo \
 tmux \
 vim
#
# USER MANAGEMENT
ENV DOCKER_USER geographica
RUN adduser --disabled-password --gecos '' "$DOCKER_USER"
RUN adduser "$DOCKER_USER" sudo
# THIS LINE IS A SECURITY ISSUE IN OTHER THAN DEV ENV
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"
RUN touch ~/.sudo_as_admin_successful
#
# VIM CONFIG
RUN mkdir -p "$HOME/.config/"
RUN git clone https://github.com/vehrka/dotvim.git "$HOME/.config/dotvim"
RUN ln -s "$HOME/.config/dotvim/default.vimrc.conf" "$HOME/.vimrc"
RUN mkdir -p "$HOME/.vim/colors"
RUN git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
#
# TMUX CONFIG
RUN git clone https://github.com/vehrka/dottmux.git "$HOME/.config/dottmux"
RUN ln -s "$HOME/.config/dottmux/default.tmux.conf" "$HOME/.tmux.conf"
