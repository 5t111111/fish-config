#!/usr/bin/env bash

pushd "$(dirname $0)" > /dev/null
script_path="$(pwd -P)"

# ==============================================================================

cat << EOS

================================================================================
Checking fish installation
================================================================================
EOS

if type fish > /dev/null 2>&1 ; then
  echo OK
else
  cat << EOS
fish is not found.

Please install fish before executing this setup script.
See https://fishshell.com for further details.
EOS
  exit 1
fi

# ==============================================================================

cat << EOS

================================================================================
Setting up XDG Base Directory
================================================================================
EOS

if [ ! -d "${XDG_CONFIG_HOME:=$HOME/.config}" ]; then
  mkdir -p "${XDG_CONFIG_HOME}"
else
  echo "XDC Base directory: [${XDG_CONFIG_HOME}] already exists"
fi

# ==============================================================================

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
  read -p "Do you really want to remove and re-create [${fish_config_dir}]? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm "${fish_config_dir}"
    ln -s "${script_path}/fish" "${fish_config_dir}"
    echo "Symlink: [${fish_config_dir}] is created."
  fi
fi

# ==============================================================================

cat << EOS

================================================================================
Installing fisherman
================================================================================
EOS

fish -c 'fisher -v' > /dev/null 2>&1
rc=$?

if [ $rc = 0 ]; then
  echo "fisherman is already installed"
else
  fisherman_install_path="${HOME}/.config/fish/functions/fisher.fish"

  curl -f -Lo ${fisherman_install_path} --create-dirs git.io/fisher > /dev/null 2>&1

  rc=$?

  if [ $rc != 0 ]; then
    echo "Failed to install fisherman [$rc]"
    exit $rc
  fi

  echo "fisherman is successfully installed to [${fisherman_install_path}]."
fi

# ==============================================================================

cat << EOS

================================================================================
Installing plugins
================================================================================
EOS

fish -c 'fisher'

# ==============================================================================

cat << EOS

================================================================================
Installation completed!
================================================================================
Recommended way to configure your local specific configuration is
adding settings in [${fish_config_dir}/config.local.fish]
instead of [${fish_config_dir}/config.fish].

EOS

popd > /dev/null
