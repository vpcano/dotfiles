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


##  IMPORTS  ##
from typing import List
from os import path, environ
import re
import socket
import json
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click, Rule
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from plugins import arcobattery 


##  VARIABLES ##
qtile_path = path.join(path.expanduser("~"), ".config", "qtile")
colors_path = path.join(qtile_path, "colors.json")
icons_path = path.join(qtile_path, "icons")
scripts_path = path.join(qtile_path, "scripts")
mod = "mod4"

# map color name to hex values
def init_colors():
    with open(colors_path) as f:
        colors = json.load(f)
    return colors
colors = init_colors()

term = environ["TERM"]
browser = environ["BROWSER"]
editor = environ["EDITOR"]

mailbox1 = '.local/share/mail/gmail'
mailbox2 = '.local/share/mail/uam'


##  FUNCTIONS  ##
def OpenCalendar(qtile):
    qtile.cmd_spawn(term + " -d 100 36 -e calcurse")

def OpenPowermenu(qtile):
    qtile.cmd_spawn(str(path.join(scripts_path, "powermenu")))

def ToggleNightmode(qtile):
    qtile.cmd_spawn(str(path.join(scripts_path, "nightmode")))

def OpenNotcenter(qtile):
    qtile.cmd_spawn(str(path.join(scripts_path, "notcenter")))

def OpenVolumepanel(qtile):
    qtile.cmd_spawn(term + " -d 126 42 -e alsamixer")

def OpenWeather(qtile):
    qtile.cmd_spawn(term + " -d 126 42 -e fish -C \"curl wttr.in\"")

def OpenUpdate(qtile):
    qtile.cmd_spawn("update")

def GetNewMails(mailbox):
    cmd = [str(path.join(scripts_path, "getunreadmails"))]
    inp = mailbox.encode('utf-8')
    res = subprocess.run(cmd, stdout=subprocess.PIPE, input=inp) 
    return int(res.stdout.decode('utf-8'))

def GetNewMails1():
    new = GetNewMails(mailbox1)
    return '📧 ' + str(new)

def GetNewMails2():
    new = GetNewMails(mailbox2)
    return '📧 ' + str(new)

def OpenMail1(qtile):
    qtile.cmd_spawn(term + " -e neomutt")

def OpenMail2(qtile):
    qtile.cmd_spawn(term + " -e neomutt -e \"source /home/victor/.config/mutt/accounts/2-uam.muttrc\"")


##  KEYS  ##
keys = [

    # Move between different groups
    Key([mod], "Page_Up", lazy.screen.next_group()),
    Key([mod], "Page_Down", lazy.screen.prev_group()),
	
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),	
	
    # Switch focus between windows 
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "space", lazy.layout.next()),
    
    # Swap and move windows
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Resize windows
    Key([mod, "control"], "h",
        lazy.layout.grow_right(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key([mod, "control"], "l",
        lazy.layout.grow_left(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    # Increasse/Decrease ratio (monadtall)
    Key([mod], "i", lazy.layout.increase_ratio()),
    Key([mod], "o", lazy.layout.decrease_ratio()),
    Key([mod], "u", lazy.layout.normalize()),

    #  Window toggle floating and toggle fullscreen
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    
    # Killing a window and maximize/minimize it
    Key([mod], "x", lazy.window.kill()),

    # Qtile restart and shutdown
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    
    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn(str(path.join(scripts_path, "setvol dec")))),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(str(path.join(scripts_path, "setvol inc")))),
    Key([], "XF86AudioMute", lazy.spawn(str(path.join(scripts_path, "setvol mute")))),

    #Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn(str(path.join(scripts_path, "setcontrast inc")))),
    Key([], "XF86MonBrightnessDown", lazy.spawn(str(path.join(scripts_path, "setcontrast dec")))),

    # Application shortcuts and Rofi
    Key([mod], "Return", lazy.spawn(term)),
    Key([mod], "t", lazy.spawn("st")),
    Key([mod], "n", lazy.spawn(str(path.join(scripts_path, "notcenter")))),
    Key([mod], "r", lazy.spawn("rofi -show drun")),
    Key([mod], "comma", lazy.spawn("rofi -show run")),
    Key([mod], "period", lazy.spawn("rofi -show window")),
    Key([mod], "p", lazy.spawn(str(path.join(scripts_path, "powermenu")))),
    Key([mod], "e", lazy.spawn(term + " -e vifm")),
    Key([mod], "w", lazy.spawn(browser)),
    Key([mod], "v", lazy.spawn("st -g 198x53 -e " + editor)),
    Key([mod], "s", lazy.spawn(term + " -d 100 36 -e spoty")),
    Key([mod], "m", lazy.spawn(term + " -e neomutt")),
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
def init_layout_theme():
    return {"border_width": 2,
            "margin": 4,
            "border_focus": "e1acff",
            "border_normal": "1D2330"
            }
layout_theme = init_layout_theme()

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

text_box = {
    'font': 'Iosevka Nerd Font',
    'fontsize': 13,
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

def init_widget_defaults():
    return dict(
        **base(),
        **text_box,
        padding=3
        )
widget_defaults = init_widget_defaults()

def init_widget_list():
    widget_list = [
        # WORKSPACES
        widget.Sep(**base(), **separator),
        widget.GroupBox(**group_box),
        widget.Sep(**base(), **separator),
        widget.TaskList(**task_list),

        # POWERLINE
        widget.Sep(**base(), **separator),
        widget.Sep(**base(), **separator),
        widget.TextBox(**powerline_sep(prev='dark', to='green')),
        widget.TextBox(
            **base(bg='green'),
            **text_box,
            padding=5,
            text=' ⟳'
        ),
        widget.Pacman(
            **base(bg='green'),
            **text_box,
            execute='update',
            update_interval=1000,
            mouse_callbacks={
                'Button1': OpenUpdate
            }
        ),
        widget.Sep(**separator, background=colors['green']),
        widget.TextBox(**powerline_sep(prev='green', to='red')),
        widget.Sep(**separator, background=colors['red']),
        widget.CurrentLayoutIcon(
            **base(bg='red', fg='grey'),
            custom_icon_paths=[path.expanduser(path.join(icons_path, "layout"))],
            scale=0.65
        ),
        widget.CurrentLayout(
            **base(bg='red'),
            **text_box,
            padding=5
        ),
        widget.Sep(**separator, background=colors['red']),
        widget.TextBox(**powerline_sep(prev='red', to='green')),
        widget.Sep(**separator, background=colors['green']),
        widget.GenPollText(
            **base(bg='green'),
            **text_box,
            func=GetNewMails1,
            mouse_callbacks={
                'Button1': OpenMail1
            }
        ),
        widget.TextBox(
            **base(bg='green'),
            **text_box,
            text='|'
        ),
        widget.GenPollText(
            **base(bg='green'),
            **text_box,
            func=GetNewMails2,
            mouse_callbacks={
                'Button1': OpenMail2
            }
        ), 
        widget.Sep(**separator, background=colors['green']),
        widget.TextBox(**powerline_sep(prev='green', to='orange')),
        widget.Sep(**separator, background=colors['orange']),
        arcobattery.BatteryIcon(
            padding=0,
            scale=0.66,
            y_poss=-1.5,
            theme_path=str(path.join(icons_path, "battery")),
            update_interval = 5,
            background = colors['orange']
        ),
        widget.Battery(
            **base(bg='orange'),
            **text_box,
            format='{percent:2.0%} - {hour:d}:{min:02d}'
        ),
        widget.Sep(**separator, background=colors['orange']),
        widget.TextBox(**powerline_sep(prev='orange', to='blue')),
        widget.Volume(
            **base(bg='blue'),
            **text_box,
            padding=3,
            emoji=True,
        ),
        widget.Volume(
            **base(bg='blue'),
            **text_box,
            padding=2,
        ),
        widget.TextBox(
            **base(bg='blue'),
            **text_box,
            text='| 🔆'
        ),
        widget.Backlight(
            **base(bg='blue'),
            **text_box,
            backlight_name='intel_backlight',
            format='{percent:2.0%}'
        ),
        widget.TextBox(
            **base(bg='blue'),
            **text_box,
            text='| 🌙',
            mouse_callbacks={
                'Button1': ToggleNightmode
            }
        ),
        widget.Sep(**separator, background=colors['blue']),
        widget.TextBox(**powerline_sep(prev='blue', to='light_grey')),
        widget.YahooWeather(
            **base(bg='light_grey'),
            **text_box,
            padding=5,
            location='Madrid',
            format='{current_observation_condition_symbol} {current_observation_condition_temperature}°{units_temperature} |',
            mouse_callbacks={
                'Button1': OpenWeather
            }
        ),
        widget.Clock(
            **base(bg='light_grey'),
            **text_box,
            padding=5,
            format='📅 %d/%m | 🕗 %H:%M ',
            mouse_callbacks={
                'Button1': OpenCalendar
            }
        ),
        widget.TextBox(**powerline_sep(prev='light_grey', to='grey')),
        widget.Sep(**separator, background=colors['grey']),
        widget.Systray(
            **base(bg='grey', fg='light'),
            padding=5
        ),
        widget.TextBox(
            **base(bg='grey', fg='light'),
            **text_box,
            padding=5,
            text='|'
        ),
        widget.TextBox(
            **base(bg='grey', fg='light'),
            **text_box,
            padding=5,
            text='➕',
            mouse_callbacks={
                'Button1': OpenNotcenter
            }
        ),
        widget.TextBox(
            **base(bg='grey', fg='light'),
            **text_box,
            padding=5,
            text='⏻',
            mouse_callbacks={
                'Button1': OpenPowermenu
            }
        ),
        widget.Sep(
            linewidth=0,
            padding=16,
            background=colors['grey']
        )
    ]
    return widget_list

widgets_list = init_widget_list()

def init_widgets_screen():
    widgets_screen = init_widget_list()
    return widgets_screen

widgets_screen = init_widgets_screen()

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen(), size=23))]
screens = init_screens()

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
    script = path.join(scripts_path, "autostart.sh")
    subprocess.call([script])

#  @hook.subscribe.startup
#  def start_always():
    # Set the cursor to something sane in X
    #  subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

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
