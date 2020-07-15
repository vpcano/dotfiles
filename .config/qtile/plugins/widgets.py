# IMPORTS
import subprocess
from os import path
from os import environ
from libqtile import widget
from . import arcobattery
from . import contrastcolor

# VARIABLES
qtile_path = path.join(path.expanduser("~"), ".config", "qtile")
icons_path = path.join(qtile_path, "icons")
term = environ["TERM"]
if term == '': term = 'xterm'


# MOUSE CALLBACKS
def OpenCalendar(qtile):
    qtile.cmd_spawn(term + " -g 100x36 -e calcurse")

def OpenPowermenu(qtile):
    qtile.cmd_spawn("powermenu")

def OpenTogglesmenu(qtile):
    qtile.cmd_spawn("togglesmenu")

def ToggleNightmode(qtile):
    qtile.cmd_spawn("nightmode")

def OpenNotcenter(qtile):
    qtile.cmd_spawn("notcenter")

def OpenWeather(qtile):
    qtile.cmd_spawn(term + " -g 126x42 -e weather")

def OpenUpdate(qtile):
    qtile.cmd_spawn("update")

def OpenMail(qtile):
    qtile.cmd_spawn(term + " -e neomutt")

def GetNewMails():
    cmd1 = ['xgetres', 'qtile.mailbox']
    cmd2 = ['getunreadmails']
    mailbox = subprocess.run(cmd1, stdout=subprocess.PIPE).stdout.decode('utf-8')
    if mailbox == '':
        return 0
    cmd2.append(mailbox)
    return subprocess.run(cmd2, stdout=subprocess.PIPE).stdout.decode('utf-8')


class WidgetList:
    def __init__(self, font, colors):
        self.font = font
        self.colors = colors


    # WIDGET COMMON SETTINGS
    def base(self, fg='', bg='background'):
        # Use a foreground color according to the background color (See contrastcolor plugin)
        if fg == '':
            color = contrastcolor.ContrastColor(self.colors[bg][0])
        else:
            color = fg
        return {
            'foreground': self.colors[color],
            'background': self.colors[bg]
            }

    def text_box(self):
        return {
            'font': self.font,
            'fontsize': 13
        }


    # SEPARATORS AND SPACER
    def powerline_sep(self, prev='background', to='foreground'):
        return widget.TextBox(
            foreground=self.colors[to],
            background=self.colors[prev],
            font='Hack Nerd Font Mono',
            fontsize=18,
            padding=0.9,
            text=''
            )

    def slash_sep(self, prev='background', to='foreground'):
        return widget.TextBox(
            foreground=self.colors[prev],
            background=self.colors[to],
            font='Hack Nerd Font Mono',
            fontsize=25,
            padding=-2,
            text=' '
            )

    def pipe_sep(self, color='foreground'):
        return widget.TextBox(
            background=self.colors[color],
            **self.text_box(),
            text='|'
            )

    def separator(self, sep, prev, to):
        if sep=='powerline':
            return self.powerline_sep(prev, to)
        if sep=='slash':
            return self.slash_sep(prev, to)
        return self.pipe_sep(to)

    def spacer(self, color):
        return widget.Sep(
            linewidth=0,
            padding=5,
            background=self.colors[color]
            )


    # PARENT WIDGET
    def parent(self, sep, prev, color):
        return [
            self.spacer(prev),
            self.separator(sep, prev, color),
            self.spacer(color)
        ]


    def Layout(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.CurrentLayoutIcon(
                **self.base(bg=color),
                custom_icon_paths=[path.expanduser(path.join(icons_path, "layout"))],
                scale=0.65
                ),
            widget.CurrentLayout(
                **self.base(bg='color1'),
                **self.text_box(),
                padding=5
                ),
            self.spacer(color)
            ]

    def Updates(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.Pacman(
                **self.base(bg=color),
                **self.text_box(),
                execute='update',
                update_interval=500,
                mouse_callbacks={
                    'Button1': OpenUpdate
                    }
                )
        ]

    def Battery(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            arcobattery.BatteryIcon(
                padding=0,
                scale=0.66,
                y_poss=-1.5,
                theme_path=str(path.join(icons_path, "battery")),
                update_interval = 5,
                background = self.colors[color]
                ),
            widget.Battery(
                **self.base(bg=color),
                **self.text_box(),
                format='{percent:2.0%} - {hour:d}:{min:02d}'
                )
            ]

    def Mail(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.TextBox(
                **self.base(bg=color),
                **self.text_box(),
                text='📧'
                ),
            widget.GenPollText(
                **self.base(bg=color),
                **self.text_box(),
                func=GetNewMails,
                mouse_callbacks={
                    'Button1': OpenMail
                    }
                ),
        ]

    def Volume(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.Volume(
                **self.base(bg=color),
                **self.text_box(),
                padding=3,
                emoji=True,
                ),
            widget.Volume(
                **self.base(bg=color),
                **self.text_box(),
                padding=2,
                )
        ]

    def Brightness(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.TextBox(
                **self.base(bg=color),
                **self.text_box(),
                text='🔆'
                ),
            widget.Backlight(
                **self.base(bg=color),
                **self.text_box(),
                backlight_name='intel_backlight',
                format='{percent:2.0%}'
                )
        ]

    def Nightmode(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.TextBox(
                **self.base(bg=color),
                **self.text_box(),
                text='🌙',
                mouse_callbacks={
                    'Button1': ToggleNightmode
                    }
                )
        ]

    def Weather(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.YahooWeather(
                **self.base(bg=color),
                **self.text_box(),
                padding=5,
                location='Madrid',
                format='{current_observation_condition_symbol} {current_observation_condition_temperature}°{units_temperature} |',
                mouse_callbacks={
                    'Button1': OpenWeather
                    }
                )
        ]

    def Date(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.Clock(
                **self.base(bg=color),
                **self.text_box(),
                padding=5,
                format='📅 %d/%m',
                mouse_callbacks={
                    'Button1': OpenCalendar
                    }
                )
        ]

    def Time(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.Clock(
                **self.base(bg=color),
                **self.text_box(),
                padding=5,
                format='🕗 %H:%M ',
                mouse_callbacks={
                    'Button1': OpenCalendar
                    }
                )
        ]

    def Systray(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.Systray(
                **self.base(bg=color),
                padding=5
                )
        ]

    def Menutray(self, sep, prev, color):
        return self.parent(sep, prev, color) + [
            widget.TextBox(
                **self.base(bg=color),
                **self.text_box(),
                padding=5,
                text=' ',
                mouse_callbacks={
                    'Button1': OpenNotcenter
                    }
                ),
            widget.TextBox(
                **self.base(bg=color),
                **self.text_box(),
                padding=5,
                text='漣 ',
                mouse_callbacks={
                    'Button1': OpenTogglesmenu
                    }
                ),
            widget.TextBox(
                **self.base(bg=color),
                **self.text_box(),
                padding=5,
                text='⏻',
                mouse_callbacks={
                    'Button1': OpenPowermenu
                    }
                ),
            widget.Sep(
                linewidth=0,
                padding=16,
                background=self.colors[color]
                )
        ]
