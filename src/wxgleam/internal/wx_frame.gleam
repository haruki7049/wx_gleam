import wxgleam/internal/wx

pub type NewOption

@external(erlang, "wxFrame", "new")
pub fn default() -> wx.WxObject

@external(erlang, "wxFrame", "new")
pub fn new(parent: wx.WxObject, id: Int, title: BitArray, options: List(NewOption)) -> wx.WxObject
