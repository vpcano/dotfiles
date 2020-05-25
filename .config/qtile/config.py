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
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from operator import itemgetter
from typing import List 
from os import listdir
from os import path
import psutil
import subprocess
import json


##  VARIABLES ##

qtile_path = path.join(path.expanduser("~"), ".config", "qtile")
mod = "mod4"

term = "alacritty"
termi = 'alacritty'
browser = "waterfox-current"

# map color name to hex values
with open(path.join(qtile_path, "colors.json")) as f:
    colors = json.load(f)

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
    Key([mod], "n", lazy.spawn("notcenter")),
    Key([mod], "r", lazy.spawn("rofi -show drun")),
    Key([mod], "comma", lazy.spawn("rofi -show run")),
    Key([mod], "space", lazy.spawn("rofi -show window")),
    Key([mod], "p", lazy.spawn("powermenu")),
    Key([mod], "e", lazy.spawn(term + " -e vifm")),
    Key([mod], "w", lazy.spawn(browser)),
    Key([mod], "v", lazy.spawn(term + " -d 198 53 -e nvim")),
    Key([mod], "s", lazy.spawn(term + " -d 100 36 -e spoty")),
    Key([mod], "m", lazy.spawn(term + " -e fish -c mutt")),
    Key([mod], "c", lazy.spawn(term + " -d 100 36 -e calcurse")),
    Key([mod], "a", lazy.spawn(term + " -d 126 42 -e fish -C \"curl wttr.in\""))
]


##  GROUPS ##

group_names = [("NAV", {'layout': 'max'}),
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
                "margin": 4,
                "border_focus": "e1acff",
                "border_normal": "1D2330"
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Matrix(columns=2, **layout_theme),
    layout.Max(**layout_theme),   
    layout.Stack(num_stacks=2)
]


##  WIDGETS  ##

def base(fg='grey', bg='dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }

def powerline_sep(prev='dark', to='light_grey'):
    return {
        'foreground': colors[to],
        'background': colors[prev],
        'font': 'Hack Nerd Font Mono',
        'fontsize': 18,
        'padding': 0.9,
        'text': ''
    }

separator = {
    'linewidth': 0,
    'padding': 5,
}

group_box = {
    **base(fg='light'),
    'font': 'Ubuntu Bold',
    'fontsize': 9,
    'margin_y': 3,
    'margin_x': 0,
    'padding_y': 5,
    'padding_x': 5,
    'borderwidth': 3,
    'active': colors['light'],
    'inactive': colors['light'],
    'rounded': False,
    'highlight_method': 'line',
    'this_current_screen_border': colors['red'],
    'this_screen_border': colors['grey'],
    'other_current_screen_border': colors['dark'],
    'other_screen_border': colors['dark']
}

task_list = {
    **base(fg='red'),
    'font': 'Ubuntu Light',
    'fontsize': 13,
    'icon_size': 17,
    'padding_x': 3,
    'padding_y': 2,
    'highlight_method': 'block',
    'max_title_width': 250, 
    'rounded' : False,
    'txt_floating' : '🗗 ',
    'txt_maximized' : '🗖 ',
    'txt_minimized' : '🗕 '
}

systray = {
    'background': colors['grey'],
    'foreground': colors['light_grey'],
    'padding': 4
}

text_box = {
    'font': 'Iosevka Nerd Font',
    'fontsize': 13,
}

pacman = {
    'execute': termi,
    'update_interval': 1000
}

current_layout_icon = {
    'custom_icon_paths': [path.expanduser(path.join(qtile_path, "icons", "layout"))],
    'scale': 0.65
}

clock = {
    'format': '📅 %d/%m/%Y | 🕗 %H:%M '
}


def workspaces():
    return [
        widget.Sep(**base(), **separator),
        widget.GroupBox(**group_box),
        widget.Sep(**base(), **separator),
        widget.TaskList(**task_list)
    ]


def powerline_base():
    return [
        widget.Sep(
            **separator,
            background=colors['red']
        ),
        widget.CurrentLayoutIcon(
            **base(bg='red', fg='grey'),
            **current_layout_icon
        ),
        widget.CurrentLayout(
            **base(bg='red'),
            **text_box,
            padding=5
        ),
        widget.Sep(
            **separator,
            background=colors['red']
        ),
        widget.TextBox(
            **powerline_sep(prev='red', to='blue')
        ),
        widget.TextBox(
            **base(bg='blue'),
            **text_box,
            text='🔊'
        ),
        widget.Volume(
            **base(bg='blue'),
            **text_box,
        ),
        widget.Sep(
            **separator,
            background=colors['blue']
        ),
        widget.TextBox(
            **powerline_sep(prev='blue', to='orange')
        ),
        widget.TextBox(
            **base(bg='orange'),
            **text_box,
            text='🔋'
        ),
        widget.Battery(
            **base(bg='orange'),
            **text_box,
            format='{percent:2.0%}'
        ),
        widget.Sep(
            **separator,
            background=colors['orange']
        ),
        widget.TextBox(
            **powerline_sep(prev='orange', to='light_grey')
        ),
        widget.Sep(
            **separator,
            background=colors['light_grey']
        ),
        widget.Clock(
            **base(bg='light_grey'),
            **clock,
            **text_box,
            padding=5,
        ),
        widget.TextBox(
            **powerline_sep(prev='light_grey', to='grey')
        ),
        widget.Sep(
            **separator,
            background=colors['grey']
        ),
        widget.Systray(
            **systray
        ),
        widget.TextBox(
            **systray,
            **text_box,
            text='|'
        ),
        widget.QuickExit(
            **systray,
            **text_box,
            default_text='[logout]'
        ),
        widget.Sep(
            linewidth=0,
            padding=8,
            background=colors['grey']
        )
    ]


widget_list = [
    *workspaces(),

    widget.Sep(
        **base(),
        **separator
    ),
    widget.Sep(
        **base(),
        **separator
    ),
    widget.TextBox(
        **powerline_sep(prev='dark', to='green')
    ),
    widget.TextBox(
        **base(bg='green'),
        **text_box,
        text='📋'
    ),
    widget.Clipboard(
        **base(bg='green'),
        **text_box,
        padding=5,
        max_width=10
    ),
    widget.TextBox(
        **powerline_sep(prev='green', to='red')
    ),
    widget.Sep(
        **separator,
        background=colors['red']
    ),
    widget.MemoryGraph(
        background=colors['red'],
        type='box',
        graph_color=colors['blue'],
        samples=60,
        border_color=colors['dark'],
        line_width=3
    ),
    widget.Sep(
        **separator,
        background=colors['red']
    ),
    widget.TextBox(
        **powerline_sep(prev='red', to='green')
    ),
    widget.TextBox(
        **base(bg='green'),
        **text_box,
        padding=5,
        text=' ⟳'
    ),
    widget.Pacman(
        **base(bg='green'),
        **pacman,
        **text_box
    ),
    widget.Sep(
        **separator,
        background=colors['green']
    ),
    widget.TextBox(
        **powerline_sep(prev='green', to='red')
    ),
    *powerline_base()
 ]

widget_defaults = dict(
    **base(),
    **text_box,
    padding=3
)
extension_defaults = widget_defaults.copy()


##  SCREENS  ##
screens = [
    Screen(top=bar.Bar(widget_list, 23, opacity=1))
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
follow_mouse_focus = False
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

##  AUTOSTART  ##
@hook.subscribe.startup_once
def autostart():
    script = path.join(qtile_path, "autostart.sh")
    subprocess.call([script])

@hook.subscribe.client_new
def float_firefox(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("Places", "firefox") and w_name == "Catálogo":
        window.floating = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
