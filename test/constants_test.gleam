import wx_gleam

// Unit test that verifies exported constants have the expected values.
// This is a pure, side-effect-free check.
pub fn id_any_constant_test() {
  assert wx_gleam.id_any == -1
}
