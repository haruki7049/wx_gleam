//// Test suite for the wxgleam library.
////
//// This module contains the test runner for the wxgleam project using gleeunit.

import gleam/option.{None}
import gleeunit
import gleeunit/should
import wxgleam

/// Entry point for running the test suite.
///
/// This function initializes and runs all tests defined in the test directory.
pub fn main() {
  gleeunit.main()
}

pub fn start_test() {
  let assert Ok(_) = wxgleam.start()
}

pub fn handle_app_test() {
  let assert Ok(_) = wxgleam.start()
  use _frame: wxgleam.WxFrame <- wxgleam.handle_frame(None, 0, "HOGE", [])

  //let _expected: wxgleam.WxFrame = wxgleam.WxPreviewFrame

  Nil

  //frame
  //|> should.equal(expected)
}
