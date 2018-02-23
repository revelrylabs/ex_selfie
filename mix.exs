defmodule Selfie.Mixfile do
  use Mix.Project

  def project do
    [
      app: :selfie,
      version: "1.0.0",
      elixir: "~> 1.5",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Provides a single way to access both a struct's fields
    and its associated module's functions.
    """
  end

  defp package do
    [
      maintainers: ["Joel Wietelmann"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/revelrylabs/ex_selfie"}
    ]
  end
end
