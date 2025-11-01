#!/bin/sh
set -e

# Description : Compile Neovim latest stable version for Alpine Linux
# Author : DE LA GENIERE Clément
# Credits : Heavily inspired from Alpine's neovim package

NVIM_REPO="https://github.com/neovim/neovim.git"
TS_REPO="https://github.com/neovim/tree-sitter-vimdoc.git"

if [ -z "$BRANCH" ]; then
	BRANCH="stable"
fi

# https://gitlab.alpinelinux.org/alpine/aports/-/blob/master/community/neovim/APKBUILD
makedepends="
	cmake
	gettext-dev
	gperf
	libtermkey-dev
	libuv-dev
	libvterm-dev
	lua-luv-dev
	lua5.1-mpack
	msgpack-c-dev
	samurai
	tree-sitter-dev
	unibilium-dev
	utf8proc-dev
	"

## DEPENDENCIES INSTALL ##
apk update
apk add $makedepends git lua5.1-lpeg luajit-dev build-base
rm -rf /var/cache/apk/*

## REPO CLONE ##
git clone --branch "$BRANCH" --depth 1 $NVIM_REPO neovim
cd neovim

## BUILD ##
cmake -B build -G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/build/usr \
	-DUSE_BUNDLED_TS=ON

cmake --build build
cmake --install build

## COPY LIB OVER ##
solibs="/lib/ld-musl-aarch64.so*
/usr/lib/libluv.so*
/usr/lib/lua/5.1/lpeg.so*
/usr/lib/libtree-sitter.so*
/usr/lib/libunibilium.so*
/usr/lib/libutf8proc.so*
/usr/lib/libintl.so*
/usr/lib/libluajit-5.1.so*
/usr/lib/libuv.so*
/lib/ld-musl-aarch64.so*
/usr/lib/libgcc_s.so*"

solibs=`echo $solibs | tr "\n" " "`

for lib in $solibs; do
	cp $lib /build/usr/lib
done
