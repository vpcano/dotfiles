def ContrastColor(colorCode):
    colorCode = colorCode.lstrip('#')
    red   = int(colorCode[0:2],16)
    green = int(colorCode[2:4],16)
    blue  = int(colorCode[4:6],16)
    # Counting the perceptive luminance - human eye favors green color...
    luminance = (0.299*red + 0.587*green + 0.114*blue)/255;

    if luminance > 0.5:
        # bright colors - black font
        return 'color0'
    else:
        # dark colors - white font
        return 'color15'
