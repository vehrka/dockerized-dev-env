FROM python:alpine3.8
RUN apk add --update git tmux vim
#
# USER MANAGEMENT
ENV DOCKER_USER geographica
RUN adduser --disabled-password --gecos '' "$DOCKER_USER"
# # THIS LINE IS A SECURITY ISSUE IN OTHER THAN DEV ENV
USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"
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
