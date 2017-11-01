defmodule Chatbase do
  @moduledoc """
  Provides helper methods to log data to Chatbase Bot Analytics API
  """

  @base_url "https://chatbase.com/api/"
  @api_key Config.get(:chatbase, :api_key, System.get_env("CHATBASE_API_KEY"))

  # Helper method to get time in milli seconds
  defp milli_seconds do
    :os.system_time(:milli_seconds)
  end

  # Encodes the map into JSON data
  defp encode_body(data) do
    Poison.encode!(data)
  end

  # Method to send single encoded message to Chatbase
  defp send(encoded_data) do
    request_post("message", encoded_data)
  end

  # Method to send multiple encoded messages to Chatbase
  defp send_all(encoded_data) do
    request_post("messages", encoded_data)
  end

  # This method is responsible for sending data to the specified
  # endpoint. It then passes the result to the decoder to retrieve
  # body in the form of map.
  defp request_post(endpoint, data) do
    Tesla.post(@base_url <> endpoint, data)
    |> decode_body()
  end

  # Just returns the body for now
  defp decode_body(%{body: body}) do
    Poison.decode!(body)
  end

  @doc """
  Log data sent by User to the Bot

  ## Parameters

    - user_id: String used as user identifier
    - platform: String used to denote platform, like, facebook, slack, alexa
    - message: String sent by the User to the Bot
    - intent: String classifying intent of the message
    - not_handled: Boolean type, if request handled by agent or not
    - feedback: Boolean type, if feedback to agent or not

  ## Examples

  ```
  cb = Chatbase.user_message("123", "alexa", "some message", "some-intent")
  ```
  """
  def user_message(user_id, platform, message \\ "", intent \\ "", not_handled \\ false, feedback \\ false) do
    data = %{
      "api_key" => @api_key,
      "type" => "user",
      "user_id" => user_id,
      "time_stamp" => milli_seconds(),
      "platform" => platform,
      "message" => message,
      "intent" => intent,
      "not_handled" => not_handled,
      "feedback" => feedback
    }

    send(encode_body(data))
  end

  @doc """
  Log data sent by Bot to the User

  ## Parameters

    - user_id: String used as user identifier
    - platform: String used to denote platform, like, facebook, slack, alexa
    - message: String sent by the Bot to the User
    - intent: String classifying intent of the message
    - not_handled: Boolean type, if request handled by agent or not

  ## Examples

  ```
  cb = Chatbase.agent_message("123", "alexa", "some message", "some-intent")
  ```
  """
  def agent_message(user_id, platform, message \\ "", intent \\ "", not_handled \\ false) do
    data = %{
      "api_key" => @api_key,
      "type" => "agent",
      "user_id" => user_id,
      "time_stamp" => milli_seconds(),
      "platform" => platform,
      "message" => message,
      "intent" => intent,
      "not_handled" => not_handled,
    }

    send(encode_body(data))
  end

  @doc """
  Log multiple messages at once, can be used in queue

  ## Parameters

    - list_of_maps: A list containing maps

  ## Examples
  ```
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
  """
  def multiple_messages(list_of_maps) do
    private_data = %{
      "api_key" => @api_key,
      "time_stamp" => milli_seconds()
    }
    data = Enum.map(list_of_maps, fn (x) -> Map.merge(x, private_data) end)
    send_all(encode_body(%{"messages" => data}))
  end

end
