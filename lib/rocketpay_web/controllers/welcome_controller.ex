defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  def index(conn, %{"filename" => filename}) do
    text(conn, "Welcome to the Rocketpay API")
  end
end
