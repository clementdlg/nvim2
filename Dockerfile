FROM alpine:3.22.2
ARG REPO="https://github.com/clementdlg/nvim2"
ARG USER="krem"
ARG HOME="/home/${USER}"

RUN apk update && apk add neovim \
	git \
	gcc \
	musl-dev \
	npm \
	go \
	shellcheck \
	ansible-core \
	&& rm -rf /var/cache/apk/*

RUN npm -g i \
	@ansible/ansible-language-server \
	bash-language-server

# RUN go install github.com/docker/docker-language-server/cmd/docker-language-server@07d5add

RUN adduser -h $HOME -D $USER
USER $USER
WORKDIR ${HOME}/.config/nvim
RUN git clone --depth 1 ${REPO} ${HOME}/.config/nvim && \
	nvim -l ~/.config/nvim/init.lua

WORKDIR ${HOME}/cwd
ENV LC_ALL="en_US.UTF-8"
ENTRYPOINT ["nvim"]
