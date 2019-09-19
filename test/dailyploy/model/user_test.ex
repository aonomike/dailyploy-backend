defmodule Dailyploy.Test.Model.UserTest do
  @moduledoc """
  Contains tests on the User model
  """
  use Dailyploy.DataCase
  alias Dailyploy.Model.User, as: UserModel
  alias Dailyploy.Model.Company
  alias Dailyploy.Model.Workspace, as: WorkspaceModel
  alias Dailyploy.Helper.User, as: UserHelper
  alias Dailyploy.Schema.User
  alias Dailyploy.Schema.Workspace


  @workspace_params %{name: "Awesome Workspace", type: 0}
  @user_params %{
    name: "Awesome User",
    email: "awesome@email.com",
    password: "password",
    password_confirmation: "password",
    workspaces: [@workspace_params]
  }
  @doc """
  list_users/0 returns a list of all  users in the database

  ##Examples
  iex> Dailyploy.Model.User.list_users()
  [%Dailyploy.Model.User{}]
  """
  test "list_users/0" do
    {:ok, user} = UserModel.create_user(@user_params)
    assert length(UserModel.list_users()) == 1
  end

  @doc """
  create_user/1 returns a Struct of the created user
  """
  test "create_user/1" do
    assert {:ok, user = %User{}} = UserModel.create_user(@user_params)
    assert user.name == "Awesome User"
    assert user.email == "awesome@email.com"
    assert [%Workspace{} = workspace] = user.workspaces
    assert workspace.name == "Awesome Workspace"
  end
end
