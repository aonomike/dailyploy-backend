defmodule DailyployWeb.ProjectView do
  use DailyployWeb, :view
  alias DailyployWeb.ProjectView
  alias DailyployWeb.ErrorHelpers

  def render("index.json", %{projects: projects}) do
    %{projects: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{project: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id, name: project.name, start_date: project.start_date, description: project.description}
  end

  def render("changeset_error.json", %{errors: errors}) do
    %{errors: ErrorHelpers.changeset_error_to_map(errors)}
  end
end
