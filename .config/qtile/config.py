#===========================================================
#      ____    __    _   __          _    __  _   ______
#     / __ \  / /_  (_) / / ___     | |  / / (_) / ____/
#    / / / / / __/ / / / / / _ \    | | / / / / / /     
#   / /_/ / / /_  / / / / /  __/    | |/ / / / / /___   
#   \___\_\ \__/ /_/ /_/  \___/     |___/ /_/  \____/   
#  
#       ~/.config/qtile/config.py file
#
#       Víctor Pérez Cano
#       GitHub: https://github.com/vpcano
#
#===========================================================

from libqtile.config import Key, Screen, Group, Drag, Click
#from libqtile.command_client import CommandClient
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from operator import itemgetter
from typing import List 
from os import listdir
from os import path
import subprocess
import json


##  VARIABLES ##

qtile_path = path.join(path.expanduser("~"), ".config", "qtile")
theme = "victor-custom" # only if available in ~/.config/qtile/themes
mod = "mod4"
term = "alacritty"
termi = 'alacritty'
#c = CommandClient()

##  THEME  ##

theme_path = path.join(qtile_path, "themes", theme)

# map color name to hex values
with open(path.join(theme_path, "colors.json")) as f:
    colors = json.load(f)

img = {}
wallpaper = {}

# map image name to its path
img_path = path.join(theme_path, "img")
wallpaper_path = path.join(qtile_path, "wallpapers")
for i in listdir(img_path):
    img[i.split(".")[0]] = path.join(img_path, i)
for i in listdir(wallpaper_path):
    wallpaper[i.split(".")[0]] = path.join(wallpaper_path, i)
##  KEYS  ##

keys = [

    # Move between different groups
    Key([mod], "Page_Up", lazy.screen.next_group()),
    Key([mod], "Page_Down", lazy.screen.prev_group()),
	
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),	
	
    # Switch focus between windows 
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod], "space", lazy.layout.next()),
    
    # Swap windows
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Increasse/Decrease ratio
    Key([mod], "u", lazy.layout.increase_ratio()),
    Key([mod], "y", lazy.layout.decrease_ratio()),

    #  Window toggle floating
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    
    # Growing/shrinking/reset window size
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "o", lazy.layout.shrink()),
    Key([mod], "p", lazy.layout.normalize()),
    
    # Killing a window and maximize/minimize it
    Key([mod], "x", lazy.window.kill()),
    Key([mod], "m", lazy.layout.maximize()),

    # Qtile restart and shutdown
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    
    # Application shortcuts and Rofi
    Key([mod], "Return", lazy.spawn(term)),
    Key([mod], "r", lazy.spawn("rofi -show")),
    Key([mod], "e", lazy.spawn("dolphin")),
    Key([mod], "w", lazy.spawn("google-chrome-stable")),
    Key([mod], "v", lazy.spawn("alacritty -e nvim"))
]


##  GROUPS ##

group_names = [("NAV", {'layout': 'floating'}),
               ("DEV", {'layout': 'monadtall'}),
               ("TERM", {'layout': 'monadtall'}),
               ("DOC", {'layout': 'monadtall'}),
               ("CHAT", {'layout': 'floating'}),
               ("MED", {'layout': 'floating'})
]
groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group
    
    
##  LAYOUTS  ##

layout_theme = {"border_width": 2,
                "margin": 13,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Matrix(columns=3, **layout_theme),
    layout.Max(**layout_theme),   
    layout.Stack(num_stacks=2)
]


##  WIDGETS  ##

def base(fg='light', bg='dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


separator = {
    **base(),
    'linewidth': 0,
    'padding': 5,
}

group_box = {
    **base(),
    'font': 'Ubuntu Bold',
    'fontsize': 10,
    'margin_y': 3,
    'margin_x': 0,
    'padding_y': 5,
    'padding_x': 5,
    'borderwidth': 3,
    'active': colors['light'],
    'inactive': colors['light'],
    'rounded': False,
    'highlight_method': 'line',
    'this_current_screen_border': colors['primary'],
    'this_screen_border': colors['grey'],
    'other_current_screen_border': colors['dark'],
    'other_screen_border': colors['dark']
}

task_list = {
    **base(fg='primary'),
    'font': 'Ubuntu Bold',
    'fontsize': 13,
    'icon_size': 0,
    'padding': 5,
    'margin_y': -3,
    'highlight_method': 'block',
    'max_title_width': 150, 
    'rounded' : False
}

systray = {
    'background': colors['systray'],
    'padding': 4
}

text_box = {
    'font': 'Ubuntu Mono',
    'fontsize': 15,
    'padding': 5
}

pacman = {
    'execute': termi,
    'update_interval': 1800
}

current_layout_icon = {
	'custom_icon_paths': path.join(qtile_path, "icons"),
    'scale': 0.65
}

current_layout = {
    'padding': 5
}

clock = {
    'format': '%d/%m/%Y - %H:%M '
}


def workspaces():
    return [
        widget.Sep(**separator),
        widget.GroupBox(**group_box),
        widget.Sep(**separator),
        widget.TaskList(**task_list)
    ]


def powerline_base():
    return [
        widget.Sep(
            linewidth=0,
            padding=0,
            background=colors['primary']
        ),
        widget.CurrentLayoutIcon(
            **base(bg='primary'),
            **current_layout_icon
        ),
        widget.CurrentLayout(
            **base(bg='primary'),
            **current_layout
        ),
        widget.Sep(
            linewidth=0,
            padding=5,
            background=colors['primary']
        ),
        widget.Image(
            filename=img['primary-to-green']
        ),
        widget.TextBox(
            **base(bg='green'),
            **text_box,
            text='Vol.'
        ),
        widget.Volume(
            **base(bg='green'),
            font='Ubuntu Mono',
            fontsize=15
        ),
        widget.Sep(
            linewidth=0,
            padding=5,
            background=colors['green']
        ),
        widget.Image(
            filename=img['green-to-orange']
        ),
        widget.TextBox(
            **base(bg='orange'),
            **text_box,
            text='Bat.'
        ),
        widget.Battery(
            **base(bg='orange'),
            font='Ubuntu Mono',
            fontsize=15,
            format='{percent:2.0%}'
        ),
        widget.Sep(
            linewidth=0,
            padding=5,
            background=colors['orange']
        ),
        widget.Image(
            filename=img['orange-to-secondary']
        ),
        widget.Sep(
            linewidth=0,
            padding=5,
            background=colors['secondary']
        ),
        widget.Clock(
            **base(bg='secondary'),
            **clock
        ),
        widget.Image(
            filename=img['secondary-to-systray']
        ),
        widget.Systray(
            **systray
        ),
        widget.TextBox(
            **base(bg='systray', fg='dark'),
            font='Ubuntu Mono Bold',
            fontsize=20,
            padding=4,
            text='|'
        ),
        widget.QuickExit(
            **base(bg='systray'),
            font='Ubuntu Mono',
            fontsize=15,
            padding=1,
            default_text='[logout]'
        ),
        widget.Sep(
            linewidth=0,
            padding=8,
            background=colors['systray']
        )
    ]


widget_list = [
    *workspaces(),

    widget.Sep(
        **separator
    ),
    widget.Sep(
        **separator
    ),
    widget.Notify(
        **base(bg='dark'),
        **text_box
    ),
    widget.Sep(
        linewidth=0,
        padding=5,
        background=colors['dark']
    ),
    widget.Image(
        filename=img['bg-to-blue']
    ),
    widget.TextBox(
        **base(bg='blue'),
        **text_box,
        text='📋'
    ),
    widget.Clipboard(
        **base(bg='blue'),
        **text_box,
        max_width=6
    ),
    widget.Image(
        filename=img['blue-to-primary']
    ),
    widget.Sep(
        linewidth=0,
        padding=5,
        background=colors['primary']
    ),
    widget.MemoryGraph(
        background=colors['primary'],
        type='box',
        graph_color=colors['green'],
        samples=60,
        border_color=colors['dark'],
        line_width=3
    ),
    widget.Sep(
        linewidth=0,
        padding=5,
        background=colors['primary']
    ),
    widget.Image(
        filename=img['primary-to-blue']
    ),
    widget.TextBox(
        **base(bg='blue'),
        **text_box,
        text=' ⟳'
    ),
    widget.Pacman(
        **base(bg='blue'),
        **pacman
    ),
    widget.Sep(
        linewidth=0,
        padding=5,
        background=colors['blue']
    ),
    widget.Image(
        filename=img['blue-to-primary']
    ),
    *powerline_base()
 ]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


##  SCREENS  ##
screens = [
    Screen(top=bar.Bar(widget_list, 24, opacity=0.95))
]

##  MOUSE  ##
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]


##  OTHER THINGS  ##
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = True 
cursor_warp = False


## FLOATING WINDOWS  ##
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True 
focus_on_window_activation = "smart"

def set_wallpaper(qtile):
    group = qtile.currentGroup.name    
    if group=='DEV' or group=='TERM':
        subprocess.call(["wal", "-i", wallpaper['pattern']])
    else:
        subprocess.call(["wal", "-i", wallpaper['landscape']])

##  AUTOSTART  ##
@hook.subscribe.startup_once
def autostart():
    script = path.join(qtile_path, "autostart.sh")
    subprocess.call([script])

@hook.subscribe.client_new
def float_poweroff_dialog(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("cairo-dock", "Cairo-dock") and w_name == "cairo-dock-dialog":
        window.floating = True

@hook.subscribe.client_new
def float_firefox(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("Places", "firefox") and w_name == "Catálogo":
        window.floating = True

@hook.subscribe.client_new
def float_code(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class==("code", "Code") and (w_name=="Open File" or w_name=="Open Folder"):
        window.floating = True

@hook.subscribe.changegroup
def call_group_setWallpaper():
    lazy.function(set_wallpaper)

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
