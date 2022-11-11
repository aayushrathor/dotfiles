# :cartwheeling: arch bspwm dotfiles

<p >
 <img  src="https://visitor-badge.glitch.me/badge?page_id=aayushrathor/dotfiles.visitor-badge" >  
 <img  alt="" src="https://img.shields.io/github/repo-size/aayushrathor/dotfiles?style=flat&label=repo-size&color=fb9199&labelColor=1d212a"/>
</p>

<!-- INFORMATION -->
## :herb: <samp>INFORMATION</samp> <img alt="" align="right" src="https://badges.pufler.dev/visits/janleigh/dotfiles?style=for-the-badge&color=A7D9B2&logoColor=white&labelColor=1C2325"/>

   <img src="https://raw.githubusercontent.com/aayushrathor/dotfiles/main/showcase.png" alt="Rice Showcase" align="right" width="400px">

   Thanks for dropping by! This is my personal repository of my dotfiles.

   The [setup section](#-setup) will guide you through a step-by-step installation process.
   
   Here are more information about my setup:

   - **Window Manager:** [bspwm](https://github.com/baskerville/bspwm)
   - **Terminal:** [kitty](https://github.com/kovidgoyal/kitty)
   - **Shell:** [zsh](https://www.zsh.org/)
   - **Bars:** [polybar](https://github.com/polybar/polybar)
   - **Compositor:** [picom](https://github.com/yshui/picom)
   - **Editor:** [neovim](https://github.com/neovim/neovim)
   - **Notification Daemon:** [dunst](https://github.com/dunst-project/dunst)
   - **File Manager:** [thunar](https://github.com/xfce-mirror/thunar)
   - **Browser:** [firefox]()
   - **Application Launcher:** [rofi](https://github.com/davatorium/rofi)

<!-- SETUP -->
## :wrench: <samp>SETUP</samp>

Dotfiles are managed with <kbd>stow</kbd> make sure to have [stow](https://github.com/aspiers/stow).<br>
<kbd>fs</kbd>
```sh
$ pwd
/
└ home
  └ aayush
    └ dotfiles
      └ configs
```

Clone the repository with
```sh
git clone https://github.com/aayushrathor/dotfiles.git dotfiles
```
For installation run stow to symlink everything
```sh
cd ~/dotfiles && stow */ -t ~
```
For any particular config file
```sh
stow <package_name> -t ~
```

## :keyboard: <samp>Keybindings</samp>

| Keys | Action |
| --- | --- |
| <kbd>super + Return</kbd> | Open terminal (kitty) |
| <kbd>super + shift + Return</kbd> | Open terminal (alacritty with tabbed) |
| <kbd>super + e</kbd> | thunar(file manager) |
| <kbd>super + {t,shift + t,s,f}</kbd> | set the window stat |
| <kbd>super + space</kbd> | rofi application menu |
| <kbd>super + shift + R</kbd> | centred floating terminal |
| <kbd>super + {w,shift + w}</kbd> | kill active window |
| <kbd>super + d</kbd> | eww widgets |
| <kbd>super + x</kbd> | Run powermenu |
| <kbd>super + shift + S</kbd> | flameshot |
| <kbd>super + r</kbd> | screen recorder |
| <kbd>super + {1,2,3,4,5,6,7,8}</kbd> | Change workspace/tag from 1 to 9 |
| <kbd>ctrl + shift + L</kbd> | Run lockscreen |
| <kbd>alt + shift + {h,j,k,l}</kbd> | open scratchpads |
| <kbd>super + shift + D</kbd> | floating bottom scratchpad |
| <kbd>super + semicolon</kbd> | open left floating scratchpad |
| <kbd>super + apostrophe</kbd> | open right floating scratchpad |
| <kbd>super + h</kbd> | Change focus to the left container |
| <kbd>super + l</kbd> | Change focus to the right container |
| <kbd>super + k</kbd> | Change focus to the upper container |
| <kbd>super + j</kbd> | Change focus to the lower container |
| <kbd>super + shift + h</kbd> | Move container to the left side |
| <kbd>super + shift + l</kbd> | Move container to the right side |
| <kbd>super + shift + k</kbd> | Move container to the upper side |
| <kbd>super + shift + j</kbd> | Move container to the lower side |
| <kbd>super + shift + {1,2,3,4,5,6,7,8}</kbd> | Move active container to repective workspace/tag |
| <kbd>super + escape</kbd> | Reload Keybinds(sxhkd) |
| <kbd>super + alt + r</kbd> | Reload bspwm |
| <kbd>super + alt + q</kbd> | kill bspwm |

all keybinds are available in <kbd>sxhdrc</kbd> config file

<details>
 <summary><kbd>:ghost: <samp>Appearance</samp></kbd></summary>
 <div>
 
Install the following <kbd>theme</kbd>, <kbd>icon pack</kbd>, <kbd>cursor</kbd> and <kbd>fonts</kbd> for overall appearance.

- GTK Theme : [Qogir theme](https://github.com/vinceliuice/Qogir-theme)
- Icon Theme : [Papirus icon theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- Cursor Theme : [Oreo cursor theme](https://github.com/varlesh/oreo-cursors)
- Fonts : JetBrains Nerd Fonts, Fira Code, and CaskaydiaCove Nerd Fonts

 </div>
</details>


<details>
 <summary><kbd>:computer: <samp>Program list</samp></kbd></summary>
 <div>
 
| Program | Name |
| --- | --- |
| Window Manger | [bspwm](https://github.com/baskerville/bspwm) |
| Bar | [polybar](https://github.com/polybar/polybar) |
| Compositor | [picom-jonaburg-fix](https://github.com/jonaburg/picom) |
| Launcher | [rofi](https://github.com/davatorium/rofi) |
| Wallpaper manager | [feh](https://feh.finalrewind.org/) |
| Music Visualizer | [cava](https://github.com/karlstav/cava) |
| Lockscreen | [i3lock-color](https://github.com/Raymo111/i3lock-color) |
| Terminal Emulator | [Alacritty](https://github.com/alacritty/alacritty) |
| Shell | [zsh](https://www.zsh.org) |
| Notification daemon | [dunst](https://dunst-project.org/) |
| Scratch pad | [tdrop](https://github.com/noctuid/tdrop) |

list of all programs I use can be found here [program-list](https://github.com/aayushrathor/dotfiles/blob/main/packages)<br>

 </div>
</details>

<p align="center">
   <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/dev/assets/footers/gray0_ctp_on_line.svg?sanitize=true"/>
</p>
