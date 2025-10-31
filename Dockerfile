ARG USER="krem"
ARG HOME="/home/${USER}"

ARG CFG_SRC="https://github.com/clementdlg/nvim2.git"
ARG LAZY_SRC="https://github.com/folke/lazy.nvim.git"

ARG CFG_DEST="/home/${USER}/.config"
ARG LAZY_DEST="${HOME}/.local/share/nvim/lazy"

# - - - - - - - - - -
FROM alpine:3.22 AS build
ARG BUILD_CMD="lua require('build')"
ARG USER
ARG HOME
ARG NVIM_SRC="https://github.com/neovim/neovim.git"
ARG CFG_SRC
ARG LAZY_SRC
ARG CFG_DEST
ARG LAZY_DEST

RUN apk update && apk add neovim git gcc musl-dev npm \
	&& rm -rf /var/cache/apk/*

RUN adduser -h $HOME -D $USER
USER $USER
WORKDIR $HOME
RUN mkdir -p $CFG_DEST && mkdir -p $LAZY_DEST

RUN git clone --depth 1 --branch=docker-main $CFG_SRC "${CFG_DEST}/nvim" & \
	git clone --depth 1 $LAZY_SRC "${LAZY_DEST}/lazy.nvim" & \
	wait && \
	nvim --headless -c "$BUILD_CMD" +qa && \
	rm -r "${LAZY_DEST}/{lazy.nvim,mason.nvim}" 

# - - - - - - - - - -
FROM alpine:3.22
ARG USER
ARG HOME
ARG NVIM_DEST="/usr/bin/nvim"
ARG CFG_DEST
ARG LAZY_DEST
ARG MASON_DEST="${HOME}/.local/share/nvim/mason"

COPY --chown=${USER}:${USER} --from=build $CFG_DEST   $CFG_DEST
COPY --chown=${USER}:${USER} --from=build $NVIM_DEST  $NVIM_DEST
COPY --chown=${USER}:${USER} --from=build $LAZY_DEST  $LAZY_DEST
COPY --chown=${USER}:${USER} --from=build $MASON_DEST $MASON_DEST

WORKDIR "${HOME}/cwd"
ENTRYPOINT ["nvim"]
