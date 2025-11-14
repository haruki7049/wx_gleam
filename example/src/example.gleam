import gleam/dynamic
import gleam/dynamic/decode
import gleam/io
import gleam/string
import wx_gleam

pub fn main() {
  use wx_app: wx_gleam.WxApp <- wx_gleam.with_app()

  let assert Ok(wx_frame) = wx_gleam.create_frame(wx_app, "Gleam WxApp")
  let assert Ok(_button) = wx_gleam.create_button(wx_frame, "Click Me!")

  wx_gleam.show_frame(wx_frame)

  wx_gleam.connect_close_event(wx_frame)
  wx_gleam.await_close_message(message_handler)
}

fn message_handler(message: dynamic.Dynamic) -> Nil {
  case decode.run(message, decode.string) {
    Ok(message_str) -> io.println(message_str)
    Error(err) ->
      err
      |> string.inspect()
      |> io.println_error()
  }
}
