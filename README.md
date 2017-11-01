# Chatbase

Elixir based client that provides helper methods to log data to Chatbase Bot Analytics API

> Note: This is not an official Google product.

For more information, read [official documentation](https://chatbase.com/documentation/generic)

## Installation

Add `chatbase` to your list of dependencies in `mix.exs`. Then run,

```
mix deps.get
```

## Configuration

You can get `api_key` from chatbase and set it in your `config/config.exs` file:

```elixir
config :chatbase, api_key: "CHATBASE_API_KEY"
```

## Examples

- Logging request from user to the agent/bot

  Parameters

      user_id: String used as user identifier
      platform: String used to denote platform, like, facebook, slack, alexa
      message: String sent by the User to the Bot
      intent: String classifying intent of the message
      not_handled: Boolean type, if request handled by agent or not
      feedback: Boolean type, if feedback to agent or not

  Examples

  ```elixir
  cb = Chatbase.user_message("123", "alexa", "some message", "some-intent")
  ```

- Logging response from Agent/bot to the user

  Parameters

      user_id: String used as user identifier
      platform: String used to denote platform, like, facebook, slack, alexa
      message: String sent by the Bot to the User
      intent: String classifying intent of the message
      not_handled: Boolean type, if request handled by agent or not

  Examples

  ```elixir
  cb = Chatbase.agent_message("123", "alexa", "some message", "some-intent")
  ```

- Logging multiple messages at once

  Parameters

      list_of_maps: A list containing maps

  Examples

  ```elixir
  user_data = %{
    "type" => "user",
    "user_id" => "123",
    "platform" => "alexa",
    "message" => "user message",
    "intent" => "some-intent"
  }
  agent_data = %{
    "type" => "agent",
    "user_id" => "123",
    "platform" => "alexa",
    "message" => "agent message",
    "intent" => "some-intent"
  }

  list_of_maps = [user_data, agent_data]
  cb = Chatbase.multiple_messages(list_of_maps)
  ```
