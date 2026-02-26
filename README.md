# slack_webhook_client

Minimal Gleam client for posting data to a [Slack incoming webhook][1]

[![Package Version](https://img.shields.io/hexpm/v/slack_webhook_client)](https://hex.pm/packages/slack_webhook_client)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/slack_webhook_client/)

```sh
gleam add slack_webhook_client@1
```
```gleam
import slack_webhook_client/operations.{post_webhook_request}

pub fn main() -> Nil {
  post_webhook_request(...)
  |> http()
}
```

Further documentation can be found at <https://hexdocs.pm/slack_webhook_client>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```


[1]: https://docs.slack.dev/messaging/sending-messages-using-incoming-webhooks/