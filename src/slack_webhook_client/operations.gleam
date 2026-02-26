import gleam/http
import gleam/http/response
import oas/generator/utils
import slack_webhook_client/schema

pub fn post_webhook_request(base, team_id, channel_id, token_, data) {
  let method = http.Post
  let path = "/services/" <> team_id <> "/" <> channel_id <> "/" <> token_
  let query = []
  let body = utils.json_to_bits(schema.slack_message_encode(data))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn post_webhook_response(response) {
  let response.Response(status:, ..) = response
  case status {
    200 -> Ok(Ok(Nil))
    _ -> Ok(Error(response))
  }
}
