# coding: utf-8
require 'rubygems'
require 'weechat'

# Setting
DELAY = 15  # delay time (second)
IMGPATH = "/home/miyamiya/WallPapers" # Directory path with wallpaper

# Starting time (Global)
$now = Time.now

def weechat_init
  Weechat.register("change_wallpaper", "miyamiya <rai.caver@gmail.com>",
    "0.0.1", "GPL3", "Wallpaper will be changed if signal is received.",
    "", "")
  # Setup hook
  Weechat.hook_signal("weechat_highlight", "do_event", "")
  Weechat.hook_signal("weechat_pv", "do_event", "")
  return Weechat::WEECHAT_RC_OK
end

def do_event(data, signal, message)
  diff = (Time.now - $now).divmod(24*60*60)
  change_wallpicture if diff[1] > DELAY
  return Weechat::WEECHAT_RC_OK
end

def gen_picture_uri
  files = []
  Dir::glob(IMGPATH + "/*.{jpg,jpeg,png}").each {|f|
    files << f if File.file?(f)
  }
  return files.sample
end

def change_wallpicture
  path = gen_picture_uri
  spawn("GSETTINGS_BACKEND=dconf /usr/bin/gsettings set org.gnome.desktop.background picture-uri 'file://#{path}'", STDERR=>STDOUT) if FileTest.exists?(path)
  return Weechat::WEECHAT_RC_OK
end
