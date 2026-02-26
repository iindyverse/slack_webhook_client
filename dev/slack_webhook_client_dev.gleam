import argv
import gleam/io
import oas/generator
import snag

pub fn main() {
  let args = argv.load()

  case args.arguments {
    [] -> io.println("Path to open API spec required")
    [path] -> {
      case generator.build(path, ".", "slack_webhook_client", []) {
        Ok(_) -> Nil
        Error(reason) -> io.println_error(snag.pretty_print(reason))
      }
    }
    _ -> {
      io.println("Unknown command. Received: ")
    }
  }
}
