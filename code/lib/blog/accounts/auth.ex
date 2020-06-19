defmodule Blog.Accounts.Auth do
  alias Blog.Accounts.{Encryption, User}

  def login(params, repo) do
    user = repo.get_by(User, username: String.downcase(params["username"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp authenticate(user, password) do
    if user do
      authenticated_user = case Encryption.validate_password(user, password) do
        {:ok, validated_user} -> validated_user.username == user.username
        {:error, _} -> false
      end
    else
      nil
    end
  end

  def signed_in?(conn) do
    conn.assigns[:current_user]
  end
end
