import gleam/dynamic
import gleam/erlang/atom

pub type WxObject

@external(erlang, "application", "ensure_all_started")
fn ensure_all_started(
  app: atom.Atom,
) -> Result(List(atom.Atom), dynamic.Dynamic)

pub type NewOption

@external(erlang, "wx", "new")
pub fn new(options: List(NewOption)) -> WxObject

@external(erlang, "wx", "null")
pub fn null() -> WxObject

@external(erlang, "wx", "is_null")
pub fn is_null(object: WxObject) -> Bool

@external(erlang, "wx", "equal")
pub fn equal(left: WxObject, right: WxObject) -> Bool

@external(erlang, "wx", "getObjectType")
pub fn get_object_type(object: WxObject) -> atom.Atom
