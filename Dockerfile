ARG USER="krem"
ARG HOME="/home/${USER}"
ARG PLUGIN_BRANCH="lazy"
ARG LSP_BRANCH="mason"

ARG CFG_REPO="https://github.com/clementdlg/nvim2.git"
ARG NVIM_CFG="/home/${USER}/.config/nvim"
ARG LOCAL_BIN="/home/${USER}/.local/bin"

# - - - - - - - - - -
FROM alpine:3.22 AS base-alpine
ARG USER
ARG HOME
RUN adduser -h $HOME -D $USER
USER $USER

# - - - - - - - - - -
FROM base-alpine AS plugin-build
ARG CFG_REPO
ARG NVIM_CFG
RUN apk update && apk add neovim git gcc musl-dev \
	&& rm -rf /var/cache/apk/*

RUN git clone $CFG_REPO $NVIM_CFG 
WORKDIR $NVIM_CFG
RUN git checkout $PLUGIN_BRANCH
RUN nvim --headless -c "qa"

# - - - - - - - - - -

FROM base-alpine AS lsp-build
RUN apk add npm go && rm -rf /var/cache/apk/*
# Installer mason et mason-tool-installer
# installer tous les lsp avec mason

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
