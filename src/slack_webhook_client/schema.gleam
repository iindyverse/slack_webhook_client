import gleam/dynamic/decode
import gleam/json
import gleam/option.{type Option, None}
import oas/generator/utils

pub type Accessory {
  Accessory(
    alt_text: Option(String),
    image_url: Option(String),
    type_: Option(String),
  )
}

pub type Block {
  Block(
    accessory: Option(Accessory),
    block_id: Option(String),
    fields: Option(List(TextObject)),
    text: Option(TextObject),
    type_: String,
  )
}

pub type SlackMessage {
  SlackMessage(blocks: Option(List(Block)), text: Option(String))
}

pub type TextObject {
  TextObject(text: Option(String), type_: Option(String))
}

pub fn text_object_decoder() {
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(decode.string),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(decode.string),
  )
  decode.success(TextObject(text: text, type_: type_))
}

pub fn text_object_encode(data: TextObject) {
  utils.object([
    #("text", json.nullable(data.text, json.string)),
    #("type", json.nullable(data.type_, json.string)),
  ])
}

pub fn slack_message_decoder() {
  use blocks <- decode.optional_field(
    "blocks",
    None,
    decode.optional(decode.list(block_decoder())),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(decode.string),
  )
  decode.success(SlackMessage(blocks: blocks, text: text))
}

pub fn slack_message_encode(data: SlackMessage) {
  utils.object([
    #("blocks", json.nullable(data.blocks, json.array(_, block_encode))),
    #("text", json.nullable(data.text, json.string)),
  ])
}

pub fn block_decoder() {
  use accessory <- decode.optional_field(
    "accessory",
    None,
    decode.optional(accessory_decoder()),
  )
  use block_id <- decode.optional_field(
    "block_id",
    None,
    decode.optional(decode.string),
  )
  use fields <- decode.optional_field(
    "fields",
    None,
    decode.optional(decode.list(text_object_decoder())),
  )
  use text <- decode.optional_field(
    "text",
    None,
    decode.optional(text_object_decoder()),
  )
  use type_ <- decode.field("type", decode.string)
  decode.success(Block(
    accessory: accessory,
    block_id: block_id,
    fields: fields,
    text: text,
    type_: type_,
  ))
}

pub fn block_encode(data: Block) {
  utils.object([
    #("accessory", json.nullable(data.accessory, accessory_encode)),
    #("block_id", json.nullable(data.block_id, json.string)),
    #("fields", json.nullable(data.fields, json.array(_, text_object_encode))),
    #("text", json.nullable(data.text, text_object_encode)),
    #("type", json.string(data.type_)),
  ])
}

pub fn accessory_decoder() {
  use alt_text <- decode.optional_field(
    "alt_text",
    None,
    decode.optional(decode.string),
  )
  use image_url <- decode.optional_field(
    "image_url",
    None,
    decode.optional(decode.string),
  )
  use type_ <- decode.optional_field(
    "type",
    None,
    decode.optional(decode.string),
  )
  decode.success(Accessory(
    alt_text: alt_text,
    image_url: image_url,
    type_: type_,
  ))
}

pub fn accessory_encode(data: Accessory) {
  utils.object([
    #("alt_text", json.nullable(data.alt_text, json.string)),
    #("image_url", json.nullable(data.image_url, json.string)),
    #("type", json.nullable(data.type_, json.string)),
  ])
}
