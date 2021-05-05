import subprocess
import json
import warnings
from os import path
from .widgets import WidgetList

class QtileRC:
    def __init__(self):
        self.cmd = ['xgetres']
        self.font = str()
        self.colorMode = str()
        self.colors = dict()
        self.widget_list = list()
        self.__configure__()

    def __configure__(self):
        self.loadFont()
        self.loadColorMode()
        self.loadColors()
        self.loadWidgets()


    def loadFont(self):
        command = self.cmd.copy()
        check_cmd = ['fc-list']
        arg = 'qtile.font'
        command.append(arg)
        res = subprocess.run(command, stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip()
        check = subprocess.run(check_cmd, stdout=subprocess.PIPE).stdout.decode('utf-8')
        if not res in check:
            warnings.warn("xresource qtile.font empty or not valid, using default one", ResourceWarning)
            self.font = 'Iosevka Nerd Font'
        else:
            self.font = res
        return self.font


    def loadColorMode(self):
        command = self.cmd.copy()
        arg = 'qtile.colormode'
        command.append(arg)
        res = subprocess.run(command, stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip()
        if res != 'normal' and res != 'gradient':
            warnings.warn("xresource qtile.colormode empty or not valid, using default one", ResourceWarning)
            self.colorMode = 'normal'
        else:
            self.colorMode = res
        return self.colorMode


    def appendColor(self, key):
        command = self.cmd.copy()
        arg = 'qtile.' + key
        command.append(arg)
        res = subprocess.run(command, stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip()
        self.colors[key] = [res, res]
        return self.checkColorCode(res)

    def appendGradient(self, num):
        command1 = self.cmd.copy()
        command2 = self.cmd.copy()
        key1 = 'color' + str(num)
        key2 = 'color' + str(num + 8)
        arg1 = 'qtile.' + key1
        arg2 = 'qtile.' + key2
        command1.append(arg1)
        command2.append(arg2)
        res1 = subprocess.run(command1, stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip()
        res2 = subprocess.run(command2, stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip()
        self.colors[key1] = [res1, res2]
        self.colors[key2] = [res2, res1]
        return self.checkColorCode(res1) and self.checkColorCode(res2)

    def checkColorCode(self, code):
        try:
            int(code.lstrip('#'), 16)
        except ValueError:
            warnings.warn("invalid colorcode " + code, ResourceWarning)
            return False
        return True

    def loadColors(self):
        flag = True
        if self.colorMode == 'gradient':
            for i in range(8):
                flag = flag and self.appendGradient(i)
        else:
            for i in range(16):
                flag = flag and self.appendColor('color' + str(i))
        flag = flag and self.appendColor('background')
        flag = flag and self.appendColor('foreground')
        if not flag:
             warnings.warn("qtile colors xresource empty or not valid, using colors.json", ResourceWarning)
             self.colors = json.load(open(path.join(path.dirname(__file__), 'colors.json')))
        return self.colors


    def loadWidgets(self):
        all_widgets = WidgetList(self.font, self.colors)
        self.widget_list.append(all_widgets.Layout('slash', 'background', 'color1'))
        #  self.widget_list.append(all_widgets.Updates('powerline', 'color1', 'color2'))
        self.widget_list.append(all_widgets.Battery('powerline', 'color2', 'color3'))
        self.widget_list.append(all_widgets.Volume('powerline', 'color3', 'color4'))
        self.widget_list.append(all_widgets.Brightness('pipe', 'color3', 'color3'))
        self.widget_list.append(all_widgets.Nightmode('pipe', 'color3', 'color3'))
        self.widget_list.append(all_widgets.Weather('powerline', 'color3', 'color8'))
        self.widget_list.append(all_widgets.Date('pipe', 'color8', 'color8'))
        self.widget_list.append(all_widgets.Time('pipe', 'color8', 'color8'))
        self.widget_list.append(all_widgets.Systray('powerline', 'color8', 'color0'))
        self.widget_list.append(all_widgets.Menutray('pipe', 'color0', 'color0'))
