from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Default(ColorScheme):
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
				bg = red
			if context.border:
				attr |= bold
				fg = green
			#if context.media:
			#	if context.image:
			#		fg = green
			#	else:
			#		fg = green
			if context.container:
				attr |= bold
				fg = red
			if context.directory:
				attr |= bold
				fg = blue
			#elif context.executable and not \
			#		any((context.media, context.container,
			#			context.fifo, context.socket)):
			#	attr |= bold
			#	fg = green
			if context.socket:
				fg = red
			if context.fifo or context.device:
				fg = green
				if context.device:
					attr |= bold
			if context.link:
				fg = context.good and green or red
			if context.tag_marker and not context.selected:
				attr |= bold
				if fg in (red, red):
					fg = white
				else:
					fg = red
			if not context.selected and (context.cut or context.copied):
				fg = green
				attr |= bold
			if context.main_column:
				if context.selected:
					attr |= normal
				if context.marked:
					attr |= bold
					fg = green
			if context.badinfo:
				if attr & reverse:
					bg = red
				else:
					fg = red

		elif context.in_titlebar:
			attr |= bold
			if context.hostname:
				attr |= bold
				fg = context.bad and green or green 
			elif context.directory:
				fg = green
			elif context.tab:
				if context.good:
					bg = green
			elif context.link:
				fg = green

		elif context.in_statusbar:
			if context.permissions:
				if context.good:
					fg = green
				elif context.bad:
					fg = red
			if context.marked:
				attr |= bold | reverse
				fg = green
			if context.message:
				if context.bad:
					attr |= bold
					fg = red

		if context.text:
			if context.highlight:
				attr |= reverse

		if context.in_taskview:
			if context.title:
				fg = blue

			if context.selected:
				attr |= reverse

		return fg, bg, attr
