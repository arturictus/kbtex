defmodule Kbt.DeploymentTest do
  use ExUnit.Case, async: true
  import Kbt.Deployment

  test "template" do
    assert %{"kind" => "Deployment"} = template
  end

  test "parse" do
    assert %{"spec" => %{ "replicas" => 5 }} = parse(nil)
    assert %{"spec" =>
              %{ "template" =>
                %{
                   "spec" =>
                     %{"containers" =>
                        [%{"name" => "twitter-web"}]}
      } }} = parse(nil)
  end
end
