import gleam/erlang/atom
import gleam/dynamic

pub type WxObject {
  WxEvtHandler(inner: WxEvtHandler)
}

pub type WxEvtHandler {
  WxWindow()
  WxAppConsole(inner: WxAppConsole)
}

pub type WxAppConsole {
  WxApp()
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

pub fn new_with(options: List(NewOption)) -> WxObject {
  external_new_with(options)
}

pub fn new() -> WxObject {
  external_new()
}
