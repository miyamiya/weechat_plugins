# coding: utf-8
require 'rubygems'
require 'weechat'

# Setting
DELAY = 15  # delay time (second)

# Starting time (Global)
$now = Time.now

def weechat_init
  Weechat.register(
    "send_notify",
    "miyamiya <rai.caver@gmail.com>",
    "0.0.1",
    "GPL3",
    "Send 'notify' if signal is received.",
    "",
    ""
  )
  setup
  return Weechat::WEECHAT_RC_OK
end

def setup
  Weechat.hook_signal("weechat_highlight,weechat_pv", "show_highlight", "")
  return Weechat::WEECHAT_RC_OK
end

def show_highlight(data, signal, message)
  diff = (Time.now - $now).divmod(24*60*60)
  notify message if diff[1] > DELAY
end

def notify message
  spawn("/usr/bin/notify-send", message)
end

