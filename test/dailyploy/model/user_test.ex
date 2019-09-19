defmodule Dailyploy.Test.Model.UserTest do
  @moduledoc """
  Contains tests on the User model
  """
  use Dailyploy.DataCase
  alias Dailyploy.Model.User
  alias Dailyploy.Model.Company
  alias Dailyploy.Model.Workspace
  alias Dailyploy.Helper.User, as: UserHelper

  @doc """
  list_users/0 returns a list of all  users in the database
  """
  test "list_users/0" do
    workspace_params = %{name: "Awesome Workspace", type: 0}
    {:ok, workspace} = Workspace.create_workspace(workspace_params)

    user_params = %{
      name: "Awesome User",
      email: "awesome@email.com",
      password: "password",
      password_confirmation: "password",
      workspaces: [workspace_params]
    }

    {:ok, user} = User.create_user(user_params)
    assert length(User.list_users()) == 1
  end
end
