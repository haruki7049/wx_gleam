import gleam/dynamic
import gleam/io
import gleam/result
import wx_gleam/events
import wx_gleam/internals

pub type WxApp =
  internals.WxApp

pub type WxFrame =
  internals.WxFrame

pub type WxButton =
  internals.WxButton

pub type WxTextCtrl =
  internals.WxTextCtrl

pub type WxCheckBox =
  internals.WxCheckBox

pub const id_any = -1


pub fn init_wx() -> Result(WxApp, dynamic.Dynamic) {
  internals.init_wx()
}

pub fn with_app(mainloop: fn(WxApp) -> Nil) -> Nil {
  let assert Ok(app): Result(WxApp, dynamic.Dynamic) = init_wx()

  // Then run mainloop which is defined by User
  mainloop(app)

  // When all processes are done, run destroy()
  destroy()
}

pub fn with_frame(
  app: WxApp,
  title: String,
  mainloop: fn(WxFrame) -> Nil,
) -> Nil {
  let assert Ok(frame): Result(WxFrame, Nil) = create_frame(app, title)

  // Run mainloop which is defined by User
  mainloop(frame)
}

pub fn with_button(
  frame: WxFrame,
  label: String,
  mainloop: fn(WxButton) -> Nil,
) -> Nil {
  let assert Ok(button): Result(WxButton, Nil) = create_button(frame, label)

  // Run mainloop which is defined by User
  mainloop(button)
}

pub fn with_text_ctrl(
  frame: WxFrame,
  value: String,
  mainloop: fn(WxTextCtrl) -> Nil,
) -> Nil {
  let assert Ok(text_ctrl): Result(WxTextCtrl, Nil) =
    create_text_ctrl(frame, value)

  // Run mainloop which is defined by User
  mainloop(text_ctrl)
}

pub fn with_checkbox(
  frame: WxFrame,
  label: String,
  mainloop: fn(WxCheckBox) -> Nil,
) -> Nil {
  let assert Ok(checkbox): Result(WxCheckBox, Nil) =
    create_checkbox(frame, label)

  // Run mainloop which is defined by User
  mainloop(checkbox)
}

pub fn create_frame(app: WxApp, title: String) -> Result(WxFrame, Nil) {
  internals.create_frame(app, title)
  |> result.map_error(fn(_) { Nil })
}

pub fn show_frame(frame: WxFrame) -> WxFrame {
  internals.show_frame(frame)
  frame
}

pub fn create_button(frame: WxFrame, label: String) -> Result(WxButton, Nil) {
  internals.create_button(frame, id_any, label)
  |> result.map_error(fn(_) { Nil })
}

pub fn create_text_ctrl(
  frame: WxFrame,
  value: String,
) -> Result(WxTextCtrl, Nil) {
  internals.create_text_ctrl(frame, id_any, value)
  |> result.map_error(fn(_) { Nil })
}

pub fn create_checkbox(frame: WxFrame, label: String) -> Result(WxCheckBox, Nil) {
  internals.create_checkbox(frame, id_any, label)
  |> result.map_error(fn(_) { Nil })
}

pub fn connect_close_event(frame: WxFrame) -> WxFrame {
  internals.connect_close_event(frame)
  frame
}

pub fn await_close_event(handler: fn(events.CloseEvent) -> Nil) -> Nil {
  // Create an adapter that converts dynamic messages to typed CloseEvent
  let adapter = fn(msg: dynamic.Dynamic) -> Nil {
    case events.decode_close_event(msg) {
      Ok(event) -> handler(event)
      Error(err_str) -> {
        // Log the error for debugging
        io.println_error(err_str)
        // Call handler with Unknown so user can observe the failure
        handler(events.Unknown(err_str))
      }
    }
  }

  internals.await_close_message(adapter)
}

pub fn destroy() -> Nil {
  internals.destroy()
}
