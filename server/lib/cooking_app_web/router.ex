defmodule CookingAppWeb.Router do
  use CookingAppWeb, :router

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

  scope "/", CookingAppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api/v1", CookingAppWeb do
    pipe_through :api

    resources "/session", SessionController, only: [:create]
    resources "/users", UserController, except: [:new, :edit]
    resources "/ingredients", IngredientController, except: [:delete, :update]
    resources "/owned-ingredients", OwnedIngredientController, except: [:update]
    post "/ingredients-search", ApiController, :searchResult
    get "/recipes-by-ingredients", ApiController, :getRecipeByIngredients
    post "/recipe-by-id", ApiController, :recipeInfo
    post "/ingredient-by-id", ApiController, :ingredientInfo
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookingAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CookingAppWeb.Telemetry
    end
  end
end
