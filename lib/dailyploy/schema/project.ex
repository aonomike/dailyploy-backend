defmodule Dailyploy.Schema.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :name, :string
    field :start_date, :date
    field :description, :string
    field :color_code, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :start_date, :description])
    |> validate_required([:name, :start_date])
    |> unique_constraint(:name)
  end
end
