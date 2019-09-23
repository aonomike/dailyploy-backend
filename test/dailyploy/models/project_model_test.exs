defmodule Dailyploy.Test.Model.ProjectTest do
  @moduledoc """
  Contains test for the project model
  """
  use Dailyploy.DataCase
  alias Dailyploy.Schema.Project
  alias Dailyploy.Model.Project, as: ProjectModel

  @project_params %{
    name: "dailyploy",
    start_date: ~D[2019-08-09],
    end_date: ~D[2019-10-10],
    description: "Awesome",
    color_code: "red"
  }

  @doc """
  list_projects/0 returns a list of all projects in the database

  ## Examples
  iex> ProjectModel.list_projects()
  [%Project{}]
  
  """
  test "list_projects/0" do
    {:ok, project} = ProjectModel.create_project(@project_params)
    assert length(ProjectModel.list_projects()) == 1
  end

  @doc """
  create_project/1 receives a map and creates a project

  ## Parameters
  A map %{}

  ##Examples
  iex> ProjectModel.create_project(project)
  {:ok, %Project{}}
  """
  test "create_project/1 receives a map and creates a project" do
    {:ok, project} = ProjectModel.create_project(@project_params)
  end
end
