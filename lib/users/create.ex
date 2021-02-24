defmodule Rocketpay.Users.Create do
  @doc """
  Let's create some users!
  """

  alias Rocketpay.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
