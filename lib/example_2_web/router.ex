defmodule Example2Web.Router do
  use Example2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Example2Web do
    pipe_through :browser

    get "/", PageController, :index
    live "/feed", FeedLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", Example2Web do
  #   pipe_through :api
  # end
end
