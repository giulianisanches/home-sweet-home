#!/usr/bin/bash

emacs_version='31.1'

$log_file="$(mktemp -t build_emacs_${emacs_version//./_}.log_XXXXXXX)"

echo "Installing build dependencies" | tee -a $log_file
sudo apt-get install -qq -y \
  libx11-dev libxpm-dev libjpeg-dev libpng-dev libtiff-dev libgif-dev libxaw7-dev \
  libcairo2-dev libharfbuzz-dev libgnutls28-dev mailutils libmailutils-dev \
  libgccjit-14-dev gcc libjansson-dev libmagickcore-dev libmagickwand-dev \
  libtree-sitter-dev libxi-dev libgmp-dev libncurses-dev

echo "Cleanup prefioux emacs installation" | tee -a $log_file
rm -rf "$HOME/.local/opt/emacs"
rm -f "$HOME/.local/bin/emacs*"
rm -f "$HOME/.local/bin/etags"
rm -f "$HOME/.local/bin/ebrowse"

echo "Creating temporary build directory" | tee -a $log_file
tmp_dir="$(mktemp -d -t build_emacs_${emacs_version//./_}_XXXXXXX)"
echo "Temporary build directory created at $tmp_dir"

mkdir "${tmp_dir}/src"

echo "Download emacs $emacs_version to $tmp_dir"  | tee -a $log_file
wget -q -P "$tmp_dir" "http://gnu.c3sl.ufpr.br/ftp//emacs/emacs-${emacs_version}.tar.xz"

echo "Extract emacs package to ${tmp_dir}/src"  | tee -a $log_file
tar xJf "${tmp_dir}/emacs-${emacs_version}.tar.xz" -C "${tmp_dir}/src"

echo "Build and install emacs... (check $log_file for progress)"  | tee -a $log_file
(
cd "${tmp_dir}/src/emacs-${emacs_version}"

./autogen.sh

echo "./configure" >> "$log_file"
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
  --with-xinput2 \
  >> "$log_file" 2>&1

echo echo "$(printf '=%.0s' {1..80})" >> "$log_file"
echo "make -j5" >> "$log_file"
make -j5 >> "$log_file" 2>&1

echo echo "$(printf '=%.0s' {1..80})" >> "$log_file"
echo "make install" >> "$log_file"
make install >> "$log_file" 2>&1
)

echo "Copy desktop file" | tee -a $log_file
cp -f "$HOME/.local/opt/emacs/share/applications/emacs.desktop" "$HOME/.local/share/applications/"

echo "Build and installation completed!" | tee -a $log_file
