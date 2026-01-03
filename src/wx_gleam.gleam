import gleam/string
import gleam/io
import gleam/option.{type Option, None, Some}
import gleam/erlang/atom
import gleam/dynamic

pub type WxObject {
  WxEvtHandler(inner: WxEvtHandler)
}

pub type WxEvtHandler {
  WxWindow(inner: WxWindow)
  WxAppConsole(inner: WxAppConsole)
}

pub type WxAppConsole {
  WxApp()
}

pub type WxWindow {
  WxNonOwnedWindow(inner: WxNonOwnedWindow)
}

pub type WxNonOwnedWindow {
  WxTopLevelWindow(inner: WxFrame)
}

pub type WxFrame {
  WxPreviewFrame
}

@external(erlang, "application", "ensure_all_started")
fn ensure_all_started(app: atom.Atom) -> Result(List(atom.Atom), dynamic.Dynamic)

pub type NewOption {
  Debug(Level)
  SilentStart
}

pub type Level {
  None
  Verbose
  Trace
  Driver
  Integer(inner: Int)
}

@external(erlang, "wx", "new")
fn external_new_with(options: List(NewOption)) -> WxObject

@external(erlang, "wx", "new")
fn external_new() -> WxObject

fn new(options: List(NewOption)) -> WxObject {
  case options {
    [] -> external_new()
    v -> external_new_with(v)
  }
}

@external(erlang, "wx", "destroy")
fn destroy() -> Nil

pub fn start() -> Result(List(atom.Atom), dynamic.Dynamic) {
  case ensure_all_started("wx" |> atom.create()) {
    Ok(v) -> Ok(v)
    Error(err) -> Error(err)
  }
}

pub type FrameOption {
  Pos(x: Int, y: Int)
  Size(w: Int, h: Int)
  Style(inner: Int)
}

@external(erlang, "wxFrame", "new")
fn new_frame(parent: Option(WxWindow), id: Int, title: String, options: List(FrameOption)) -> WxFrame

pub fn handle_frame(parent: Option(WxWindow), id: Int, title: String, options: List(FrameOption), mainloop: fn (WxFrame) -> Nil) -> Nil {
  let wx_frame: WxFrame = new_frame(parent, id, title, options)
  mainloop(wx_frame)
  destroy()
}
