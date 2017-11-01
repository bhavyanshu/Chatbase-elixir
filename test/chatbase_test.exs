defmodule ChatbaseTest do
  use ExUnit.Case
  doctest Chatbase

  test "post user message to chatbase" do
    cb = Chatbase.user_message("123", "alexa", "some message", "some-intent")
    assert cb["status"] == 200
  end

  test "post agent message to chatbase" do
    cb = Chatbase.agent_message("123", "alexa", "some message", "some-intent")
    assert cb["status"] == 200
  end

  test "post multiple messages to chatbase" do
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

    assert cb["all_succeeded"] == true
  end
end
