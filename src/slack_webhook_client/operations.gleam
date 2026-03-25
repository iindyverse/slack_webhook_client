import gleam/bit_array
import gleam/http.{Post}
import gleam/http/request
import gleam/http/response
import gleam/json

pub type BadURL {
  BadURL(String)
}

/// Generate a POST request
/// 
/// The request can be passed to
/// 
///     httpc.send_bits()
pub fn post_webhook_request(
  webhook_url: String,
  payload: json.Json,
) -> Result(request.Request(BitArray), BadURL) {
  case request.to(webhook_url) {
    Ok(req) -> {
      let body = payload |> json.to_string() |> bit_array.from_string()
      req
      |> request.set_method(Post)
      |> request.set_header("content-type", "application/json")
      |> request.set_body(body)
      |> Ok
    }
    Error(Nil) -> Error(BadURL(webhook_url))
  }
}

/// Verify the response
/// 
/// Workflow:
/// 
///     webhook_url
///     |> post_webhook_request()
///     |> result.then(httpc.send_bits)
///     |> result.then(post_webhook_response)
pub fn post_webhook_response(
  response: response.Response(BitArray),
) -> Result(Int, response.Response(BitArray)) {
  case response {
    response.Response(status:, ..) if status >= 200 && status <= 204 ->
      Ok(status)
    _ -> Error(response)
  }
}
