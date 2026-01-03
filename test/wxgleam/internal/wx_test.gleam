import gleam/erlang/atom
import gleeunit/should
import wxgleam/internal/wx

pub fn null_test() {
  let wx_null_object: wx.WxObject = wx.null()

  wx_null_object |> wx.is_null() |> should.be_true()
  wx_null_object |> wx.equal(wx.null()) |> should.be_true()
  wx_null_object
  |> wx.get_object_type()
  |> should.equal(atom.create("wx"))
}

pub fn new_test() {
  let wx_new_object: wx.WxObject = wx.new([])

  wx_new_object |> wx.is_null() |> should.be_true()
  wx_new_object |> wx.equal(wx.null()) |> should.be_true()
  wx_new_object
  |> wx.get_object_type()
  |> should.equal(atom.create("wx"))
}

pub fn destroy_test() {
  wx.destroy()
}
