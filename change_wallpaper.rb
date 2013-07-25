# coding: utf-8
require 'rubygems'
require 'weechat'

# Setting
DELAY = 15  # delay time (second)
PATH = "/home/miyamiya/WallPapers" # Directory path with wallpaper

# Starting time (Global)
$now = Time.now


def weechat_init
  Weechat.register(
    "change_wallpaper",
    "miyamiya <rai.caver@gmail.com>",
    "0.0.1",
    "GPL3",
    "Wallpaper will be changed if signal is received.",
    "",
    ""
  )
end

def setup
  Weechat.hook_signal("weechat_highlight,weechat_pv", "change_wallpicture", "")
  return Weechat::WEECHAT_RC_OK
end

def gen_picture_uri
  files = []
  Dir::glob(PATH + "/*.{jpg,jpeg,png}").each {|f|
    files << f if File.file?(f)
  }
  return files.sample
end

def change_wallpicture
  path = gen_picture_uri
  spawn("GSETTINGS_BACKEND=dconf /usr/bin/gsettings set org.gnome.desktop.background picture-uri 'file://#{path}'", STDERR=>STDOUT)
end
