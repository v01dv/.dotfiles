#!/usr/bin/env sh

promptspeed() {
  for i in $(seq 1 10); do time zsh -i -c exit; done
}

ports2() {
  sudo ss -tulpn | grep LISTEN | fzf;
}
