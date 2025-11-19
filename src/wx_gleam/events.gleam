//// Event types and decoders for wx_gleam.
////
//// This module provides type-safe event handling for wxWidgets events by
//// defining event types and decoders that convert dynamic Erlang messages
//// into strongly-typed Gleam values.
////
//// ## Event Types
////
//// Currently supports:
//// - `CloseEvent` - Events related to window close actions
////
//// ## Usage
////
//// The event types and decoders in this module are primarily used internally
//// by the main wx_gleam module to provide type-safe event handlers to users.
//// However, you can also use them directly if you need custom event handling.

import gleam/dynamic
import gleam/dynamic/decode
import gleam/string

/// Represents a close window event.
///
/// This type captures events that occur when a user attempts to close a window,
/// such as clicking the close button or pressing Alt+F4.
///
/// ## Variants
///
/// - `Close(message)` - A successfully decoded close event with the message content
/// - `Unknown(raw)` - A fallback for when decoding fails, containing the raw string
///   representation of the message for debugging purposes
pub type CloseEvent {
  /// A successfully decoded close event.
  ///
  /// The `message` field contains the decoded string content from the wx event.
  Close(message: String)
  /// A fallback event used when decoding fails.
  ///
  /// The `raw` field contains a string representation of the dynamic value that
  /// could not be decoded, useful for debugging and logging purposes.
  Unknown(raw: String)
}

/// Decodes a dynamic message into a CloseEvent.
///
/// This function attempts to decode an incoming dynamic Erlang message into a
/// typed `CloseEvent`. It first tries to decode the message as a String. If
/// successful, it returns `Ok(Close(message))`. If decoding fails, it returns
/// an `Error` with a description of the failure.
///
/// ## Parameters
///
/// - `msg` - The dynamic message received from the wx event system, typically
///   from the Erlang message queue
///
/// ## Returns
///
/// - `Ok(Close(message))` - When the message is successfully decoded as a String
/// - `Error(error_description)` - When decoding fails, with a description of the
///   error including the inspected raw value
///
/// ## Example
///
/// ```gleam
/// case decode_close_event(dynamic_msg) {
///   Ok(event) -> handle_event(event)
///   Error(err) -> io.println_error("Failed to decode: " <> err)
/// }
/// ```
///
/// ## Note
///
/// Most users will not call this function directly. Instead, use the
/// `await_close_event` function in the main wx_gleam module, which handles
/// decoding automatically and provides a typed handler interface.
pub fn decode_close_event(msg: dynamic.Dynamic) -> Result(CloseEvent, String) {
  case decode.run(msg, decode.string) {
    Ok(message) -> Ok(Close(message))
    Error(_decode_errors) -> {
      // When decoding fails, provide a helpful error message with the raw value
      let raw = string.inspect(msg)
      Error("Failed to decode close event. Raw value: " <> raw)
    }
  }
}
