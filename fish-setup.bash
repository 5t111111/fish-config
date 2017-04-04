#!/usr/bin/env bash

pushd "$(dirname $0)" > /dev/null
script_path="$(pwd -P)"


cat << EOS

================================================================================
Setup XDG Base Directory
================================================================================
EOS

if [ ! -d "${XDG_CONFIG_HOME:=$HOME/.config}" ]; then
  mkdir -p "${XDG_CONFIG_HOME}"
else
  echo "XDC Base directory: [${XDG_CONFIG_HOME}] already exists"
fi


cat << EOS

================================================================================
Creating symlink to fish config
================================================================================
EOS

fish_config_dir="${XDG_CONFIG_HOME}/fish"

if [ ! -L "${fish_config_dir}" ] && [ ! -e "${fish_config_dir}" ]; then
  ln -s "${script_path}/fish" "${fish_config_dir}"
  echo "Symlink: [${fish_config_dir}] is created."
else
  echo "Symlink: [${fish_config_dir}] already exists."
fi


cat << EOS

================================================================================
Installation completed!
================================================================================
EOS

popd > /dev/null
