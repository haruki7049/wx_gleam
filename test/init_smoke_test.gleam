import wx_gleam

// Smoke test that calls init_wx and ensures it does not crash.
// On a system with wx installed this should return Ok(_), but in CI or when wx is not available
// it may return Error(_). The important property for this test is that the function can be
// called safely (does not raise an exception), so both Ok and Error are ignored.
pub fn init_wx_smoke_test() {
  let _ = wx_gleam.init_wx()
}
