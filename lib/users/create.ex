defmodule Rocketpay.Users.Create do
  @moduledoc """
  Let's create some users!
  """

  alias Ecto.Multi
  alias Rocketpay.{Account, Repo, User}

  def call(params) do
    Multi.new()
      |> Multi.insert(:create_user, User.changeset(params))
      |> Multi.run(:create_acocunt, fn repo, %{create_user: user} -> insert_account(repo, user) end)
      |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, blance: "0.00"}
    Account.changeset(params)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{create_account: account}} -> IO.inspect(account)
    end
  end
end
