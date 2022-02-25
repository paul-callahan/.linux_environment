#!/usr/bin/env sh

cp "${HOME}"/.zshenv "${HOME}"/".zshenv.bak-$(gdate --iso-8601=seconds)"
ln -s "${HOME}"/.linux_environment/zsh/.zshenv "${HOME}"/.zshenv || true
