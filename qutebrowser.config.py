config.load_autoconfig(False)

c.url.start_pages = ["https://bing.com"]

c.url.searchengines = {
    "DEFAULT": "https://bing.com/search/?text={}",
    # "DEFAULT": "https://yandex.ru/search/?text={}",
    "y": "https://yandex.com/search/?text={}",
    "g": "https://www.google.com/search?q={}",
    "b": "https://www.bing.com/search?q={}"
}



config.unbind("h")
config.unbind("j")
config.unbind("k")
config.unbind("l")
config.bind("<Ctrl-b>", "scroll left")
config.bind("<Ctrl-f>", "scroll right")
config.bind("<Ctrl-p>", "scroll up")
config.bind("<Ctrl-n>", "scroll down")

config.unbind("H")
config.unbind("L")
config.bind("<Alt-left>", "back")
config.bind("<Alt-right>", "forward")

config.unbind("J")
config.unbind("K")
config.bind("<Ctrl-w>", "tab-close")
config.bind("<Ctrl-c>b", "tab-next")
config.bind("<Ctrl-c><Ctrl-b>", "tab-prev")
config.bind("<Ctrl-c><Ctrl-c>", "quit")


config.unbind("O")
config.bind("<Ctrl-s>", "set-cmd-text :open ")
config.bind("<Ctrl-r>", "set-cmd-text :open -t ")


config.bind("<Alt-w>", "yank")
config.bind("<Ctrl-y>", "paste")
