<div align="center">
  <h1>respiro-tty</h1>
  <p><strong>Meditation from your terminal — because touching grass isn't POSIX-compliant.</strong></p>
</div>

---

**respiro-tty** is a zero-bloat, distraction-free ASCII breathing and meditation guide for Linux TTY consoles and ANSI terminal emulators. Written in **Rust** with only `libc` as a dependency — **no GTK, no X11/Wayland, no audio server, no TUI framework**.

Looking for the native **GTK4 / Libadwaita GNOME desktop app** with organic vector geometry and real-time brown noise synthesis? Check out [**diegoveraniego/respiro**](https://github.com/diegoveraniego/respiro).

```text
                respiro

            . . . . . . . .
        . .                 . .
      .       - - - - - -       .
     .      :             :      .
    .      :       +       :      .
     .      :             :      .
      .       - - - - - -       .
        . .                 . .
            . . . . . . . .

                Inhale
        [=============o.......]
     space pause | r reset | q quit
```

## ✨ Features

- **Zero numerical stress**: Shows only the current phase and smooth visual progress — no countdown numbers, ticking seconds, or productivity metrics.
- **Two ASCII geometries**:
  - `orb` (default): An ASCII circle that expands smoothly on inhale, holds steady, and contracts on exhale.
  - `path`: Traces `@` along a 2-phase lens, 3-phase triangle, or 4-phase box depending on how many phases are active in your pattern.
- **Subtle ANSI phase colors**: Highlights the active breath trajectory and phase label by phase (cyan inhale, blue hold, green exhale, yellow pause) while dimming background guides. Respects `--no-color` and the `NO_COLOR` standard.
- **Live keyboard switching**: Toggle between `orb` and `path` on the fly with <kbd>a</kbd> / <kbd>Tab</kbd>, or switch breathing patterns live with <kbd>p</kbd> or <kbd>1</kbd>–<kbd>4</kbd>.
- **Optional terminal bell (`--bell` / `-b`)**: Emits `\a` (`BEL`) on phase transitions so you can breathe with your eyes closed if your terminal supports audible or visual bell.
- **Configurable Zen auto-hide (`config.conf`)**: Optionally auto-hide the bottom controls hint after inactivity via `~/.config/respiro-tty/config.conf` (or `--auto-hide`).
- **Inline `--compact` mode**: Renders a 3-line breathing bar directly inside your current terminal prompt without switching to the alternate screen.
- **Static `--snapshot` mode**: Outputs a pure ASCII frame (zero ANSI escape codes) for **Fastfetch** logos or piping.
- **English by default, Spanish configurable**: Runs in English out of the box (`Inhale`, `Hold`, `Exhale`, `Rest`); pass `--lang es` (or `-l es`, or set `RESPIRO_LANG=es`) for Spanish (`Inhala`, `Manten`, `Exhala`, `Descansa`).
- **Clean TTY hygiene**: Restores raw mode, cursor visibility, and alternate screen buffer cleanly on `q`, `Esc`, `Ctrl+C`, `SIGINT`, `SIGTERM`, and `SIGHUP`.

## 🚀 Installation

### Quick install (`~/.local/bin/respiro-tty`)

```bash
./scripts/install.sh
# Make sure ~/.local/bin is in your PATH
respiro-tty
```

### Build with Cargo

```bash
cargo build --release
./target/release/respiro-tty
```

## ⌨️ Usage & Examples

```bash
# Default gentle box breathing (5-5-5-5) with expanding orb
respiro-tty

# 4-7-8 relaxation pattern following the perimeter path
respiro-tty --pattern 4-7-8 --animation path

# Coherent breathing (5-5) inline inside the current terminal for 3 cycles
respiro-tty --pattern coherent --compact --cycles 3

# Custom durations (inhale-hold-exhale-rest; 0 skips a hold)
respiro-tty --pattern 4-0-6-0
respiro-tty --pattern 2.5,1,5,0

# Spanish translation + phase bell + monochrome mode
respiro-tty --lang es --pattern relax --bell --no-color

# List built-in patterns or show help
respiro-tty --list-patterns
respiro-tty --help
```

### Interactive Controls

| Key | Action |
| :--- | :--- |
| <kbd>Space</kbd> | Pause / Resume session |
| <kbd>r</kbd> | Reset current cycle |
| <kbd>a</kbd> / <kbd>Tab</kbd> | Toggle animation (`orb` ↔ `path`) live |
| <kbd>p</kbd> / <kbd>1</kbd>–<kbd>4</kbd> | Cycle or select preset pattern (`5-5-5-5`, `4-4-4-4`, `4-7-8`, `5-5`) |
| <kbd>q</kbd> / <kbd>Esc</kbd> / <kbd>Ctrl+C</kbd> | Quit and restore terminal |

## ⚙️ Configuration File (`~/.config/respiro-tty/config.conf`)

All settings are optional (CLI flags always take precedence):

```ini
# Auto-hide the bottom controls hint during active sessions (default: false)
auto_hide = true
auto_hide_secs = 3.5

# Default session preferences
pattern = 5-5-5-5
animation = orb
lang = en
color = true
bell = false
```

## ⚡ Fastfetch Integration

`--snapshot` prints a single static ASCII frame without ANSI control codes and exits immediately:

```bash
fastfetch --logo-type command-raw --logo 'respiro-tty --snapshot --animation path --pattern 4-7-8'
```

Or in your Fastfetch JSONC configuration:

```jsonc
"logo": {
  "type": "command-raw",
  "source": "respiro-tty --snapshot --animation path --pattern 4-7-8"
}
```

Want a quick 3-cycle breathing pause right after Fastfetch prints your system info?

```bash
fastfetch && respiro-tty --compact --cycles 3
```

## 🧪 Tests

```bash
cargo test
cargo build
python3 tests/cli_pty.py
```

## 📄 License

Distributed under the **MIT** License.
