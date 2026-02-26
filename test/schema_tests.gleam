import gleam/bit_array
import gleam/json
import gleam/option
import gleam/result
import gleam/string
import simplifile.{read}
import slack_webhook_client/schema

pub fn slack_message_decoder_test() {
  let assert Ok(message) = read_fixture("1-star-review")

  let assert Ok(review) =
    json.parse_bits(message, schema.slack_message_decoder())

  assert string.starts_with(option.unwrap(review.text, ""), "Danny")
}

fn read_fixture(name: String) {
  let path = "./test/fixtures/" <> name <> ".json"

  path
  |> read()
  |> result.map(bit_array.from_string)
}
