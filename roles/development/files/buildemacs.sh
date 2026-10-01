#!/usr/bin/bash

emacs_version='31.1'

sudo apt install \
  libx11-dev libxpm-dev libjpeg-dev libpng-dev libtiff-dev libgif-dev libxaw7-dev \
  libcairo2-dev libharfbuzz-dev libgnutls28-dev mailutils libmailutils-dev \
  libgccjit-14-dev gcc libjansson-dev libmagickcore-dev libmagickwand-dev \
  libtree-sitter-dev libxi-dev libgmp-dev libncurses-dev


tmp_dir="$(mktemp -d -t build-emacs-${emacs_version}-XXXXXXX)"
mkdir "${tmp_dir}/src"

wget -P "$tmp_dir" "http://gnu.c3sl.ufpr.br/ftp//emacs/emacs-${emacs_version}.tar.xz"
tar xJf "${tmp_dir}/emacs-${emacs_version}.tar.xz" -C "${tmp_dir}/src"

(
cd "${tmp_dir}/src/emacs-${emacs_version}"

./autogen.sh

CFLAGS='-march=native -O3' ./configure \
  --with-x-toolkit=lucid \
  --with-cairo \
  --with-harfbuzz \
  --with-modules \
  --prefix="$HOME/.local/opt/emacs/" \
  --bindir="$HOME/.local/bin/" \
  --with-gnutls \
  --with-mailutils \
  --with-native-compilation=aot \
  --with-imagemagick \
  --with-tree-sitter \
  --with-xinput2

make -j5

make install
)