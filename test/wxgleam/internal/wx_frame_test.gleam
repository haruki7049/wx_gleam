import gleam/erlang/atom
import gleeunit/should
import wxgleam/internal/wx
import wxgleam/internal/wx_frame

pub fn default_test() {
  let _new_object: wx.WxObject = wx.new([])
  let default_frame: wx.WxObject = wx_frame.default()

  wx.destroy()
}
