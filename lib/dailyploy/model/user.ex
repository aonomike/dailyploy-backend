defmodule Dailyploy.Model.User do
  alias Dailyploy.Repo
  alias Dailyploy.Schema.User
  alias Dailyploy.Schema.Member
  alias Dailyploy.Schema.Workspace
  alias Auth.Guardian
  import Ecto.Query
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @spec list_users :: any
  def list_users() do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user!(id, preloads), do: Repo.get!(User, id) |> Repo.preload(preloads)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
         do: verify_password(password, user)
  end

  def get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Email does not match"}

      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

  def get_current_workspace(user) do
    query = from member in Member,
      join: workspace in Workspace,
      on: member.workspace_id == workspace.id,
      where: member.user_id == ^user.id and workspace.type == "individual"
    members = Repo.all(query) |> Repo.preload(:workspace)
    member = List.first members
    case member do
      nil -> nil
      _ -> member.workspace
    end
  end
end
