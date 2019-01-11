FROM ubuntu:bionic
RUN apt-get update && apt-get install -y \
        ack \
        autojump \
        curl \
        git \
        locales \
        sudo \
        tmux \
        vim \
        wget \
        zsh
#
# SET LOCALE
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
#
# USER MANAGEMENT
ENV DOCKER_USER geographica
RUN adduser --disabled-password --gecos '' "$DOCKER_USER"
# # Give root priviledges
RUN adduser "$DOCKER_USER" sudo
# Give passwordless sudo. This is only acceptable as it is a private
# development environment not exposed to the outside world. Do NOT do this on
# your host machine or otherwise.
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8
# The sudo message is annoying, so skip it
RUN touch ~/.sudo_as_admin_successful#

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
#
# ZSH CONFIG
RUN git clone https://github.com/vehrka/dotzsh.git "$HOME/.config/dotzsh"
RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"; exit 0;
RUN rm "$HOME/.zshrc"
RUN ln -s "$HOME/.config/dotzsh/default.zshrc" "$HOME/.zshrc"
