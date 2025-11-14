//// Example application demonstrating the wx_gleam library.
////
//// This example creates a simple wxWidgets window with a button and demonstrates
//// the basic usage of the wx_gleam API including:
//// - Initializing a wx application
//// - Creating a frame (window)
//// - Adding a button to the frame
//// - Handling close events
//// - Cleaning up resources

import gleam/dynamic
import gleam/dynamic/decode
import gleam/io
import gleam/string
import wx_gleam

/// Entry point for the example application.
///
/// Creates a simple wxWidgets window with a "Click Me!" button and waits
/// for the user to close the window.
pub fn main() {
  use wx_app: wx_gleam.WxApp <- wx_gleam.with_app()

  let assert Ok(wx_frame) = wx_gleam.create_frame(wx_app, "Gleam WxApp")
  let assert Ok(_button) = wx_gleam.create_button(wx_frame, "Click Me!")

  wx_gleam.show_frame(wx_frame)

  wx_gleam.connect_close_event(wx_frame)
  wx_gleam.await_close_message(message_handler)
}

/// Handles close messages from the wx application.
///
/// This function is called when the window receives a close event. It attempts
/// to decode the message as a string and prints it to the console. If decoding
/// fails, it prints the error to stderr.
///
/// ## Parameters
///
/// - `message` - The dynamic message received from the close event
fn message_handler(message: dynamic.Dynamic) -> Nil {
  case decode.run(message, decode.string) {
    Ok(message_str) -> io.println(message_str)
    Error(err) ->
      err
      |> string.inspect()
      |> io.println_error()
  }
}
