require IEx
defmodule Kbt.Deployment do
  def template do
    read("lib/templates/deployment.yml")
  end

  def data do
    read("test/templates/dep.yml")["app"]
  end

  def parse(_file) do
    deployments = data["deployments"]
    # volumes = data["volumes"]
    # IEx.pry
    template
    |> append(data, List.first(deployments))
  end

  def append(template, data, dep) do
    template
    |> Map.merge(
      %{
        "metadata" => %{
          "name" => dep["name"],
          "labels" => dep["labels"]
        },
        "spec" => %{
          "replicas" => (dep["replicas"] || 1),
          "template" => %{
            "metadata" => %{
              "labels" => dep["labels"]
            },
            "spec" => %{
              "containers" => data["containers"],
              "volumes" => data["volumes"]
            }
          }
        }
      }
    )
  end

  def read(file) do
    Path.expand(file, File.cwd!)
    |> File.read!()
    |> YamlElixir.read_from_string()
  end
end
