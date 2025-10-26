ARG USER="krem"
ARG HOME="/home/${USER}"
ARG CFG_REPO="https://github.com/clementdlg/nvim2.git"
ARG NVIM_CFG="/home/${USER}/.config/nvim"

ARG LAZY_REPO="https://github.com/folke/lazy.nvim.git"
ARG LAZY="/home/${USER}/.local/share/nvim/lazy"

FROM alpine:3.22 AS builder-plugins
ARG USER
ARG HOME
ARG CFG_REPO
ARG NVIM_CFG

ARG LAZY_REPO
ARG LAZY

RUN apk update && apk add neovim git && rm -rf /var/cache/apk/*

RUN adduser -h $HOME -D $USER
USER $USER

WORKDIR $NVIM_CFG
RUN git clone --depth 1 --branch=lazy $CFG_REPO $NVIM_CFG 

WORKDIR $LAZY_REPO
RUN git clone --depth 1 --branch=stable --filter=blob:none $LAZY_REPO $LAZY 

# RUN nvim --headless -c "qa"

WORKDIR $HOME
ENV LC_ALL="en_US.UTF-8"
ENTRYPOINT ["nvim"]





















# RUN npm -g i \
# 	@ansible/ansible-language-server \
# 	bash-language-server

# RUN go install github.com/docker/docker-language-server/cmd/docker-language-server@07d5add

# RUN adduser -h $HOME -D $USER
# USER $USER
# WORKDIR ${HOME}/.config/nvim
# RUN git clone --depth 1 ${REPO} ${HOME}/.config/nvim && \
# 	nvim -l ~/.config/nvim/init.lua

# FROM SCRATCH
# COPY --from=builder-plugins /home/krem/ /home/krem
# COPY --from=builder-treesitter /home/krem/ /home/krem
# COPY --from=builder-lsp /home/krem/ /home/krem
