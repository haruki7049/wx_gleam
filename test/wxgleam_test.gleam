//// Test suite for the wxgleam library.
////
//// This module contains the test runner for the wxgleam project using gleeunit.

import gleam/option.{None}
import gleeunit
import gleeunit/should
import wx_gleam

/// Entry point for running the test suite.
///
/// This function initializes and runs all tests defined in the test directory.
pub fn main() {
  gleeunit.main()
}

pub fn start_test() {
  let assert Ok(_) = wx_gleam.start()
}

pub fn handle_app_test() {
  let assert Ok(_) = wx_gleam.start()
  use _frame: wx_gleam.WxFrame <- wx_gleam.handle_frame(None, 0, "HOGE", [])

  //let _expected: wx_gleam.WxFrame = wx_gleam.WxPreviewFrame

  Nil

  //frame
  //|> should.equal(expected)
}
