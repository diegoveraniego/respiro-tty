#!/bin/sh
set -eu
project_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
prefix=${RESPIRO_PREFIX:-"$HOME/.local"}

cargo build --release --manifest-path "$project_dir/Cargo.toml"
install -Dm755 "$project_dir/target/release/respiro-tty" "$prefix/bin/.respiro-tty-install-$$"
mv -f "$prefix/bin/.respiro-tty-install-$$" "$prefix/bin/respiro-tty"
printf 'respiro-tty installed at %s/bin/respiro-tty\n' "$prefix"
