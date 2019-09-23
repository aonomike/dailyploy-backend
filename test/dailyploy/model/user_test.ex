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

  @user_params_2 %{
    name: "Awesome User",
    email: "dailyploy@email.com",
    password: "password",
    password_confirmation: "password",
    workspaces: [@workspace_params]
  }

  @update_params %{
    name: "Dailyploy",
    email: "dailyploy@email.com"
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
  get_user/1 returns a user struct with the same id as the user requested
  ## Parameters

  ## Examples
  iex> UserModel.get_user!(2)
  %User{}
  """
  test "get_user/1 for existing" do
    {:ok, user} = UserModel.create_user(@user_params)
    user_received  = UserModel.get_user!(user.id)
    assert user_received = %User{}
    assert user.id == user_received.id
  end
  @doc """
  get_user/1 fails for a users that's not in the database
  """
  test "get_user/1 for missing id" do
    assert_raise Ecto.NoResultsError, fn ->
      user_received  = UserModel.get_user!(9999999)
    end
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

  @doc """
  update_user/2 returns a Struct for the updated user
  """

  test "update_user/2" do
    {:ok, user = %User{}} = UserModel.create_user(@user_params)
    assert {:ok, updated_user = %User{}} = UserModel.update_user(user, @update_params)
    assert updated_user.name == "Dailyploy"
    assert updated_user.email == "dailyploy@email.com"
  end

  @doc """
  delete_user takes a user as a parameter and deletes it from the database
  """
  test "delete_user/1" do
    {:ok, user = %User{}} = UserModel.create_user(@user_params)
    UserModel.delete_user(user)
    assert length(UserModel.list_users()) == 0
  end

  @doc """
  list_users/1 takes workspace_id as paramter and filters users belonging to that workspace
  """
  test "list_users/1" do
    {:ok, user = %User{workspaces: workspaces}} = UserModel.create_user(@user_params)
    {:ok, user_2 = %User{workspaces: workspaces2}} = UserModel.create_user(@user_params_2)
    workspace_id = List.first(workspaces).id
    workspace2_id = List.first(workspaces2).id
    assert length(UserModel.list_users(workspace_id)) == 1
    assert length(UserModel.list_users(workspace2_id)) == 1
  end

  @doc """
  get_current_workspace/1 takes user
  """
  test "get_current_workspace/1 returns a workspace when user has a workspace" do
    {:ok, user = %User{}} = UserModel.create_user(@user_params)
    workspaces = user.workspaces
    current_workspace = UserModel.get_current_workspace(user)
    assert current_workspace == List.first(workspaces)
  end
end
