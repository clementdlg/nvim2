ARG USER="krem"
ARG HOME="/home/${USER}"
ARG CFG_REPO="https://github.com/clementdlg/nvim2.git"
ARG NVIM_CFG="/home/${USER}/.config/nvim"

# - - - - - - - - - -
FROM alpine:3.22 AS nvim
RUN apk update && apk add neovim
# - - - - - - - - - -
FROM nvim AS tools
ARG BRANCH="lazy"
ARG USER
ARG HOME
ARG CFG_REPO
ARG NVIM_CFG

RUN apk update && apk add neovim git gcc musl-dev npm \
	&& rm -rf /var/cache/apk/*
RUN adduser -h $HOME -D $USER
USER $USER

WORKDIR $NVIM_CFG
RUN git clone --branch=$BRANCH $CFG_REPO $NVIM_CFG
# - - - - - - - - - -
FROM tools AS plugin-build
ARG BRANCH="lazy"
ARG CFG_REPO
ARG NVIM_CFG
WORKDIR $NVIM_CFG
RUN git checkout $BRANCH && git pull \
	&& nvim --headless -c "qa"
# - - - - - - - - - -
FROM tools AS lsp-build
ARG BRANCH="mason"
ARG NVIM_CFG
WORKDIR $NVIM_CFG
RUN git checkout $BRANCH && git pull \
	&& nvim --headless -c "MasonToolsInstallSync" -c "qa"
# - - - - - - - - - -
FROM nvim
ARG BRANCH="docker-main"
ARG MASON_PATH".local/share/nvim/mason"
ARG LAZY_PATH".local/share/nvim/lazy"
ARG HOME
ARG CFG_REPO
ARG NVIM_CFG
COPY --from=plugin-build $LAZY_PATH $LAZY_PATH
COPY --from=lsp-build $MASON_PATH $MASON_PATH

RUN git clone --depth 1 --branch=$BRANCH $CFG_REPO $NVIM_CFG
WORKDIR $HOME/cwd
ENV LC_ALL="en_US.UTF-8"
ENTRYPOINT ["nvim"]
