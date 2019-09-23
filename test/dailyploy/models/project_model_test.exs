defmodule Dailyploy.Test.Model.ProjectTest do
  @moduledoc """
  Contains test for the project model
  """
  use Dailyploy.Datacase
  alias Dailyploy.Schema.Project
  alias Dailyploy.Model.Project

  @project_params %{
    name: "dailyploy",
    start_date: "07-08-2019",
    end_date: "10-10-2019",
    description: "Awesome",
    color_code: "red"
  }
  test "list_projects/0" do
    {:ok, project} = UserModel.create_project(@project_params)
    assert length(UserModel.list_projects()) == 1
  end
end
