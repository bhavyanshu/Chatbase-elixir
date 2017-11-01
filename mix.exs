defmodule Chatbase.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chatbase,
      version: "0.0.1",
      description: description(),
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/bhavyanshu/chatbase-elixir",
      docs: [
        extras: ["README.md"]
      ]
    ]
  end

  defp description do
    """
    Elixir based client that provides helper methods to log data to Chatbase Bot Analytics API.
    Note: This is not an official Google product.
    """
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:tesla, "~> 0.9"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.18.1", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "config", "mix.exs", "README*", "LICENSE*",],
      maintainers: ["Bhavyanshu Parasher"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/bhavyanshu/chatbase-elixir"}
    ]
  end

end
