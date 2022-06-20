from __future__ import (absolute_import, division, print_function)
from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    default, normal, bold, reverse,
    dim, BRIGHT, default_colors,
)
class Default(ColorScheme):
    progress_bar_color = 35
    def use(self, context):
        fg, bg, attr = default_colors
        if context.reset:
            return default_colors
        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 160
                bg = default
            if context.border:
                fg = 35
            if context.media:
                if context.image:
                    fg = 202
                else:
                    fg = 39
            if context.container:
                fg = 36
            if context.directory:
                attr |= bold
                fg = 28
                fg += BRIGHT
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr |= bold
                fg = 28
                fg += BRIGHT
            if context.socket:
                attr |= bold
                fg = 39
                fg += BRIGHT
            if context.fifo or context.device:
                fg = 221
                if context.device:
                    attr |= bold
                    fg += BRIGHT
            if context.link:
                fg = 29 if context.good else 39
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (160, 39):
                    fg = 254
                else:
                    fg = 160
                fg += BRIGHT
            if not context.selected and (context.cut or context.copied):
                attr |= bold
                fg = 235
                fg += BRIGHT
                if BRIGHT == 0:
                    attr |= dim
                    fg = 254
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = 221
            if context.badinfo:
                if attr & reverse:
                    bg = 39
                else:
                    fg = 39
            if context.inactive_pane:
                fg = 29
        elif context.in_titlebar:
            if context.hostname:
                fg = 35 if context.bad else 29
            elif context.directory:
                fg = 242
            elif context.tab:
                if context.good:
                    bg = 35
            elif context.link:
                fg = 29
            attr |= normal
            fg += BRIGHT
        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 29
                elif context.bad:
                    fg = 160
            if context.marked:
                attr |= bold | reverse
                fg = 221
                fg += BRIGHT
            if context.frozen:
                attr |= bold | reverse
                fg = 29
                fg += BRIGHT
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 160
                    fg += BRIGHT
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 26
                attr &= ~bold
            if context.vcscommit:
               fg = 221
                attr &= ~bold
            if context.vcsdate:
                fg = 29
                attr &= ~bold
        if context.text:
            if context.highlight:
                attr |= reverse
        if context.in_taskview:
            if context.title:
                fg = 26
            if context.selected:
                attr |= reverse
            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color
        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = 39
            elif context.vcsuntracked:
                fg = 29
            elif context.vcschanged:
                fg = 160
            elif context.vcsunknown:
                fg = 160
            elif context.vcsstaged:
                fg = 35
            elif context.vcssync:
                fg = 35
            elif context.vcsignored:
                fg = default
        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync or context.vcsnone:
                fg = 35
            elif context.vcsbehind:
                fg = 160
            elif context.vcsahead:
                fg = 26
            elif context.vcsdiverged:
                fg = 39
            elif context.vcsunknown:
                fg = 160
        return fg, bg, attr 
